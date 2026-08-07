ExposedMembers.DLHD = ExposedMembers.DLHD or {};
ExposedMembers.DLHD.Utils = ExposedMembers.DLHD.Utils or {};
Utils = ExposedMembers.DLHD.Utils;

local INDUSTRY_INDEX = GameInfo.Improvements['IMPROVEMENT_INDUSTRY'].Index;
local INDUSTRY_BONUS_INDEX = GameInfo.Improvements['IMPROVEMENT_INDUSTRY_BONUS'].Index;
local INDUSTRY_STRATEGIC_INDEX = GameInfo.Improvements['IMPROVEMENT_INDUSTRY_STRATEGIC'].Index;
local CORPORATION_INDEX = GameInfo.Improvements['IMPROVEMENT_CORPORATION'].Index;
local CORPORATION_BONUS_INDEX = GameInfo.Improvements['IMPROVEMENT_CORPORATION_BONUS'].Index;
local CORPORATION_STRATEGIC_INDEX = GameInfo.Improvements['IMPROVEMENT_CORPORATION_STRATEGIC'].Index;
local LEU_TRANSNATIONAL_INDEX = GameInfo.Improvements['IMPROVEMENT_LEU_TRANSNATIONAL'].Index;
local LEU_TRANSNATIONAL_SEA_INDEX = GameInfo.Improvements['IMPROVEMENT_LEU_TRANSNATIONAL_SEA'].Index;

local BUILDING_OVERSEAS_INVESTOR_PREREQ_INDEX = GameInfo.Buildings['BUILDING_OVERSEAS_INVESTOR_PREREQ'].Index;

local BUILD_STRATEGIC_INDUSTRY_CONSUME_RESOURCE_AMOUNT = GlobalParameters.HD_BUILD_STRATEGIC_INDUSTRY_CONSUME_RESOURCE_AMOUNT or 0;

local MILITARY_ENGINEERING_BUILD_STRATEGIC_INDUSTRY_CONSUME_CHARGE_NUM = GlobalParameters.HD_MILITARY_ENGINEERING_BUILD_STRATEGIC_INDUSTRY_CONSUME_CHARGE_NUM or 0;
local BUILDER_BUILD_BONUS_INDUSTRY_CONSUME_CHARGE_NUM = GlobalParameters.HD_BUILDER_BUILD_BONUS_INDUSTRY_CONSUME_CHARGE_NUM or 0;

local CITY_ENABLE_UNIT_HD_OVERSEAS_INVESTOR_TAG = 'HD_CITY_ENABLE_UNIT_HD_OVERSEAS_INVESTOR';
local CITY_STATE_RESOURCE_TAG = 'HD_CITY_STATE_RESOURCE';
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

-- ============================================================================================================================================================
-- 瑞娜
-- ============================================================================================================================================================
-- 股份投资 建造海外投资人
function ReynaRefreshOverseasInvestorBuilding(playerId, cityId)
  local player = Players[playerId];
  if not player then return; end
  local city = CityManager.GetCity(playerId, cityId);
  if not city then return; end

  local allowed = city:GetProperty(CITY_ENABLE_UNIT_HD_OVERSEAS_INVESTOR_TAG) or 0;
  if allowed > 0 then
    if not city:GetBuildings():HasBuilding(BUILDING_OVERSEAS_INVESTOR_PREREQ_INDEX) then
      city:GetBuildQueue():CreateBuilding(BUILDING_OVERSEAS_INVESTOR_PREREQ_INDEX);
    end
  else
    if city:GetBuildings():HasBuilding(BUILDING_OVERSEAS_INVESTOR_PREREQ_INDEX) then
      city:GetBuildings():RemoveBuilding(BUILDING_OVERSEAS_INVESTOR_PREREQ_INDEX);
    end
  end
end

-- 海外投资人 选择城邦
function OverseasInvestorChooseCityState(playerId, unitId)
  print('海外投资人 选择城邦');

  local player = Players[playerId];
  if not player then return; end

  local unit = UnitManager.GetUnit(playerId, unitId);
	if not unit then return; end

  ReportingEvents.SendLuaEvent('HD_CallOverseasInvestorChooseCityStateEvent', {PlayerId = playerId, X = unit:GetX(), Y = unit:GetY(), UnitId = unitId});
end
GameEvents.HD_OverseasInvestorChooseCityState.Add(OverseasInvestorChooseCityState);

-- 海外投资人 建造特产商行
function OverseasInvestorBuildTransnational(playerId, param)
  print('海外投资人 建造特产商行');
  local scriptParam = param.ScriptParam or {};

  local player = Players[playerId];
  if not player then return; end
  
  if scriptParam.UnitId == nil then return; end
  local unit = UnitManager.GetUnit(playerId, scriptParam.UnitId);
	if not unit then return; end

  local plot = Map.GetPlot(param.X, param.Y);
  if not plot then return; end

  local cityStatePlayer = Players[param.CityStateId];
  if not cityStatePlayer then return; end
  local resourceType = cityStatePlayer:GetProperty(CITY_STATE_RESOURCE_TAG);
  if not resourceType then return; end
  local resourceInfo = GameInfo.Resources[resourceType];
  if not resourceInfo then return; end

  -- 设置虚拟资源
  if plot:GetResourceType() ~= -1 then
    ResourceBuilder.SetResourceType(plot, -1);
  end
  ResourceBuilder.SetResourceType(plot, resourceInfo.Index, 1);

  -- 建造特产商行或进口商埠
	if not plot:IsWater() then
    ImprovementBuilder.SetImprovementType(plot, LEU_TRANSNATIONAL_INDEX, playerId);
	else
    ImprovementBuilder.SetImprovementType(plot, LEU_TRANSNATIONAL_SEA_INDEX, playerId);
	end

  -- 扣除劳动次数/删除单位
  local movesRemaining = Utils.GetUnitMovesRemaining(playerId, scriptParam.UnitId);
  unit:ChangeMovesRemaining(-movesRemaining);
  Utils.ConsumeUnitBuildCharges(playerId, scriptParam.UnitId, 1);
end
GameEvents.HD_OverseasInvestorBuildTransnational.Add(OverseasInvestorBuildTransnational);

-- ============================================================================================================================================================
-- 总督刷新检测
-- ============================================================================================================================================================
-- 切换城市
function GovernorRefreshCitySelectionChanged(playerId, cityId)
  -- 瑞左二
  ReynaRefreshOverseasInvestorBuilding(playerId, cityId);
end
Events.CitySelectionChanged.Add(GovernorRefreshCitySelectionChanged);

-- 回合结束
function GovernorRefreshOnGameTurnEnded()
  for _, playerId in ipairs(PlayerManager.GetAliveMajorIDs()) do
    local player = Players[playerId];
    if player then
      for _, city in player:GetCities():Members() do
        -- 瑞左二
        ReynaRefreshOverseasInvestorBuilding(playerId, city:GetID());
      end
    end
	end
end
GameEvents.OnGameTurnEnded.Add(GovernorRefreshOnGameTurnEnded);