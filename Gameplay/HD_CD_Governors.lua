ExposedMembers.DLHD = ExposedMembers.DLHD or {};
ExposedMembers.DLHD.Utils = ExposedMembers.DLHD.Utils or {};
Utils = ExposedMembers.DLHD.Utils;

local INDUSTRY_INDEX = GameInfo.Improvements['IMPROVEMENT_INDUSTRY'].Index;
local INDUSTRY_BONUS_INDEX = GameInfo.Improvements['IMPROVEMENT_INDUSTRY_BONUS'].Index;
local INDUSTRY_STRATEGIC_INDEX = GameInfo.Improvements['IMPROVEMENT_INDUSTRY_STRATEGIC'].Index;
local CORPORATION_INDEX = GameInfo.Improvements['IMPROVEMENT_CORPORATION'].Index;
local CORPORATION_BONUS_INDEX = GameInfo.Improvements['IMPROVEMENT_CORPORATION_BONUS'].Index;
local CORPORATION_STRATEGIC_INDEX = GameInfo.Improvements['IMPROVEMENT_CORPORATION_STRATEGIC'].Index;

local BUILD_STRATEGIC_INDUSTRY_CONSUME_RESOURCE_AMOUNT = GlobalParameters.HD_BUILD_STRATEGIC_INDUSTRY_CONSUME_RESOURCE_AMOUNT or 0;

local MILITARY_ENGINEERING_BUILD_STRATEGIC_INDUSTRY_CONSUME_CHARGE_NUM = GlobalParameters.HD_MILITARY_ENGINEERING_BUILD_STRATEGIC_INDUSTRY_CONSUME_CHARGE_NUM or 0;
local BUILDER_BUILD_BONUS_INDUSTRY_CONSUME_CHARGE_NUM = GlobalParameters.HD_BUILDER_BUILD_BONUS_INDUSTRY_CONSUME_CHARGE_NUM or 0;

-- ============================================================================================================================================================
-- 维克多
-- ============================================================================================================================================================
-- 军备研究部 建造战略行业
function BuildStrategicIndustry(playerId, unitId)
  local player = Players[playerId];
  if not player then return; end

  local unit = UnitManager.GetUnit(playerId, unitId);
	if not unit then return; end

	local plot = Map.GetPlot(unit:GetX(), unit:GetY());
  if not plot then return; end

  local unitInfo = GameInfo.Units[unit:GetType()];
	if not unitInfo then return true; end

  ImprovementBuilder.SetImprovementType(plot, INDUSTRY_STRATEGIC_INDEX, playerId);

  -- 消耗战略资源
  local resourceId = plot:GetResourceType();
  local resourceInfo = GameInfo.Resources[resourceId];
  if BUILD_STRATEGIC_INDUSTRY_CONSUME_RESOURCE_AMOUNT > 0 and resourceInfo and resourceInfo.ResourceClassType == 'RESOURCECLASS_STRATEGIC' then
    player:GetResources():ChangeResourceAmount(resourceInfo.Index, -BUILD_STRATEGIC_INDUSTRY_CONSUME_RESOURCE_AMOUNT);
  end

  -- 扣除劳动次数/删除单位
  local movesRemaining = Utils.GetUnitMovesRemaining(playerId, unitId);
  unit:ChangeMovesRemaining(-movesRemaining);

  if unitInfo.UnitType == 'UNIT_SAPPER' or unitInfo.UnitType == 'UNIT_MILITARY_ENGINEER' or unitInfo.UnitType == 'UNIT_ENGINEER_CORP' then
    Utils.ConsumeUnitBuildCharges(playerId, unitId, MILITARY_ENGINEERING_BUILD_STRATEGIC_INDUSTRY_CONSUME_CHARGE_NUM);
  else
    Utils.ConsumeUnitBuildCharges(playerId, unitId, 1);
  end
end
GameEvents.HD_BuildStrategicIndustry.Add(BuildStrategicIndustry);

-- ============================================================================================================================================================
-- 马格努斯
-- ============================================================================================================================================================
-- 实体产业 建造加成行业
function BuildBonusIndustry(playerId, unitId)
  local player = Players[playerId];
  if not player then return; end

  local unit = UnitManager.GetUnit(playerId, unitId);
	if not unit then return; end

	local plot = Map.GetPlot(unit:GetX(), unit:GetY());
  if not plot then return; end

  local unitInfo = GameInfo.Units[unit:GetType()];
	if not unitInfo then return true; end

  ImprovementBuilder.SetImprovementType(plot, INDUSTRY_BONUS_INDEX, playerId);

  -- 扣除劳动次数/删除单位
  local movesRemaining = Utils.GetUnitMovesRemaining(playerId, unitId);
  unit:ChangeMovesRemaining(-movesRemaining);

  if unitInfo.UnitType == 'UNIT_BUILDER' then
    Utils.ConsumeUnitBuildCharges(playerId, unitId, BUILDER_BUILD_BONUS_INDUSTRY_CONSUME_CHARGE_NUM);
  else
    Utils.ConsumeUnitBuildCharges(playerId, unitId, 1);
  end
end
GameEvents.HD_BuildBonusIndustry.Add(BuildBonusIndustry);

-- 横向一体化
function ManagerRefreshICProperty(playerId, cityId)
  if Utils.CityHasAssignedGovernorPromotion(playerId, cityId, 'GOVERNOR_PROMOTION_HD_MANAGER_LEFT_3') then
    local num = 0;
    local cityPlots = Utils.GetCityPlots(playerId, cityId);
    for _, plotId in pairs(cityPlots) do
      local plot = Map.GetPlotByIndex(plotId);
      if plot then
        local improvementId = plot:GetImprovementType();
        if improvementId == INDUSTRY_INDEX
          or improvementId == INDUSTRY_BONUS_INDEX
          or improvementId == INDUSTRY_STRATEGIC_INDEX
          or improvementId == CORPORATION_INDEX
          or improvementId == CORPORATION_BONUS_INDEX
          or improvementId == CORPORATION_STRATEGIC_INDEX
        then
          num = num + 1;
        end
      end
    end

    print("马格努斯 横向一体化 城市拥有行业公司数量：" .. num);

    local city = CityManager.GetCity(playerId, cityId);
    if not city then return; end
    local plot = Map.GetPlot(city:GetX(), city:GetY());
    if plot then
      Utils.BinaryCompress(num, plot, 'HD_PLOT_BINARY_COMPRESS_GOVERNOR_MANAGER_LEFT_3');
    end
  end
end

-- ============================================================================================================================================================
-- 总督刷新检测
-- ============================================================================================================================================================
-- 切换城市
function GovernorRefreshCitySelectionChanged(playerId, cityId)
  -- 马左三
  ManagerRefreshICProperty(playerId, cityId);
end
Events.CitySelectionChanged.Add(GovernorRefreshCitySelectionChanged);

-- 回合结束
function GovernorRefreshOnGameTurnEnded()
  for _, playerId in ipairs(PlayerManager.GetAliveMajorIDs()) do
    local player = Players[playerId];
    if player then
      for _, city in player:GetCities():Members() do
        -- 马左三
        ManagerRefreshICProperty(playerId, city:GetID());
      end
    end
	end
end
GameEvents.OnGameTurnEnded.Add(GovernorRefreshOnGameTurnEnded);