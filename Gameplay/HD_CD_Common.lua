ExposedMembers.DLHD = ExposedMembers.DLHD or {};
ExposedMembers.DLHD.Utils = ExposedMembers.DLHD.Utils or {};
Utils = ExposedMembers.DLHD.Utils;

local CORPORATION_INDEX = GameInfo.Improvements['IMPROVEMENT_CORPORATION'].Index;
local CORPORATION_BONUS_INDEX = GameInfo.Improvements['IMPROVEMENT_CORPORATION_BONUS'].Index;
local CORPORATION_STRATEGIC_INDEX = GameInfo.Improvements['IMPROVEMENT_CORPORATION_STRATEGIC'].Index;

-- ============================================================================================================================================================
-- 阶级斗争尤里卡
-- ============================================================================================================================================================
local CLASS_STRUGGLE_INDEX = GameInfo.Civics['CIVIC_CLASS_STRUGGLE'].Index;
local CLASS_STRUGGLE_BOOST_TAG = 'HD_ClassStruggleBoost'
function ClassStruggleBoostImprovementCreated(iX, iY, iImprovementType, iOwner)
  if GlobalParameters.HD_CLASS_STRUGGLE_BOOST_WAREHOUSE ~= 1 then
    return
  end

	if iImprovementType == GameInfo.Improvements["IMPROVEMENT_LEU_WAREHOUSE"].Index
    or iImprovementType == GameInfo.Improvements["IMPROVEMENT_LEU_CONTAINER_PORT"].Index then
    local player = Players[iOwner];
    if player:GetProperty(CLASS_STRUGGLE_BOOST_TAG) == nil then
      player:SetProperty(CLASS_STRUGGLE_BOOST_TAG, 1)
    elseif player:GetProperty(CLASS_STRUGGLE_BOOST_TAG) < 2 then
      local num = player:GetProperty(CLASS_STRUGGLE_BOOST_TAG)
      player:SetProperty(CLASS_STRUGGLE_BOOST_TAG, num + 1)
    end

    if (player:GetProperty(CLASS_STRUGGLE_BOOST_TAG) ~= nil
        and player:GetProperty(CLASS_STRUGGLE_BOOST_TAG) >= 2) then
      if not player:GetCulture():HasBoostBeenTriggered(CLASS_STRUGGLE_INDEX) then
        player:GetCulture():TriggerBoost(CLASS_STRUGGLE_INDEX);
      end
    end

	end
end

-- ============================================================================================================================================================
-- 鲁尔山谷
-- ============================================================================================================================================================
local CORPORATION_BONUS_INDEX = GameInfo.Improvements['IMPROVEMENT_CORPORATION_BONUS'].Index;
local CORPORATION_STRATEGIC_INDEX = GameInfo.Improvements['IMPROVEMENT_CORPORATION_STRATEGIC'].Index;
local BUILD_STRATEGIC_CORPORATION_CONSUME_RESOURCE_AMOUNT = GlobalParameters.HD_BUILD_STRATEGIC_CORPORATION_CONSUME_RESOURCE_AMOUNT or 0;
function BuildStrategicCorporation(playerId, unitId)
  local player = Players[playerId];
  if not player then return; end

  local unit = UnitManager.GetUnit(playerId, unitId);
	if not unit then return; end

	local plot = Map.GetPlot(unit:GetX(), unit:GetY());
  if not plot then return; end

  local unitInfo = GameInfo.Units[unit:GetType()];
	if not unitInfo then return true; end

  ImprovementBuilder.SetImprovementType(plot, CORPORATION_STRATEGIC_INDEX, playerId);

  -- 消耗战略资源
  local resourceId = plot:GetResourceType();
  local resourceInfo = GameInfo.Resources[resourceId];
  if BUILD_STRATEGIC_CORPORATION_CONSUME_RESOURCE_AMOUNT > 0 and resourceInfo and resourceInfo.ResourceClassType == 'RESOURCECLASS_STRATEGIC' then
    player:GetResources():ChangeResourceAmount(resourceInfo.Index, -BUILD_STRATEGIC_CORPORATION_CONSUME_RESOURCE_AMOUNT);
  end

  -- 扣除劳动次数/删除单位
  local movesRemaining = Utils.GetUnitMovesRemaining(playerId, unitId);
  unit:ChangeMovesRemaining(-movesRemaining);
  Utils.ConsumeUnitBuildCharges(playerId, unitId, 1);
end
GameEvents.HD_BuildStrategicCorporation.Add(BuildStrategicCorporation);

function BuildBonusCorporation(playerId, unitId)
  local player = Players[playerId];
  if not player then return; end

  local unit = UnitManager.GetUnit(playerId, unitId);
	if not unit then return; end

	local plot = Map.GetPlot(unit:GetX(), unit:GetY());
  if not plot then return; end

  local unitInfo = GameInfo.Units[unit:GetType()];
	if not unitInfo then return true; end

  ImprovementBuilder.SetImprovementType(plot, CORPORATION_BONUS_INDEX, playerId);

  -- 扣除劳动次数/删除单位
  local movesRemaining = Utils.GetUnitMovesRemaining(playerId, unitId);
  unit:ChangeMovesRemaining(-movesRemaining);
  Utils.ConsumeUnitBuildCharges(playerId, unitId, 1);
end
GameEvents.HD_BuildBonusCorporation.Add(BuildBonusCorporation);

-- ============================================================================================================================================================
-- 加成战略产品项目
-- ============================================================================================================================================================
function RefreshCityBonusStrategicProductProjects(playerId, cityId)
  local player = Players[playerId];
  if not player then return; end
  local city = CityManager.GetCity(playerId, cityId);
  if not city then return; end

  local resourceMap = {};

  local cityPlots = Utils.GetCityPlots(playerId, cityId);
  for _, plotId in pairs(cityPlots) do
    local plot = Map.GetPlotByIndex(plotId);
    if plot and (plot:GetImprovementType() == CORPORATION_BONUS_INDEX
      or plot:GetImprovementType() == CORPORATION_STRATEGIC_INDEX)
      and not plot:IsImprovementPillaged()
    then
      local resourceId = plot:GetResourceType();
      local resourceInfo = GameInfo.Resources[resourceId];
      if resourceInfo and (resourceInfo.ResourceClassType == 'RESOURCECLASS_BONUS' or resourceInfo.ResourceClassType == 'RESOURCECLASS_STRATEGIC') then
        resourceMap[resourceInfo.ResourceType] = true;
      end
    end
  end

  for row in GameInfo.Resources() do
    if row.ResourceClassType == 'RESOURCECLASS_BONUS' or row.ResourceClassType == 'RESOURCECLASS_STRATEGIC' then
      if resourceMap[row.ResourceType] == true then
        local buildingInfo = GameInfo.Buildings['BUILDING_CREATE_PRODUCT_' .. row.ResourceType];
        if buildingInfo and not city:GetBuildings():HasBuilding(buildingInfo.Index) then
          city:GetBuildQueue():CreateBuilding(buildingInfo.Index);
          -- print("建造" .. buildingInfo.BuildingType);
        end
      else
        local buildingInfo = GameInfo.Buildings['BUILDING_CREATE_PRODUCT_' .. row.ResourceType];
        if buildingInfo and city:GetBuildings():HasBuilding(buildingInfo.Index) then
          city:GetBuildings():RemoveBuilding(buildingInfo.Index);
          -- print("摧毁" .. buildingInfo.BuildingType);
        end
      end
    end
  end
end

function BonusStrategicProductProjectsCitySelectionChanged(playerId, cityId, i, j, k, selected, editable)
  RefreshCityBonusStrategicProductProjects(playerId, cityId);
end
Events.CitySelectionChanged.Add(BonusStrategicProductProjectsCitySelectionChanged);

function RefreshBonusStrategicProductProjectsOnGameTurnEnded()
  for _, playerId in ipairs(PlayerManager.GetAliveMajorIDs()) do
    local player = Players[playerId];
    if player then
      for _, city in player:GetCities():Members() do
        RefreshCityBonusStrategicProductProjects(playerId, city:GetID());
      end
    end
	end
end
GameEvents.OnGameTurnEnded.Add(RefreshBonusStrategicProductProjectsOnGameTurnEnded);

-- ============================================================================================================================================================
-- Initialize
-- ============================================================================================================================================================
function initialize()
  Events.ImprovementAddedToMap.Add(ClassStruggleBoostImprovementCreated);
end
Events.LoadGameViewStateDone.Add(initialize);