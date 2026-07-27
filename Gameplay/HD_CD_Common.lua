ExposedMembers.DLHD = ExposedMembers.DLHD or {};
ExposedMembers.DLHD.Utils = ExposedMembers.DLHD.Utils or {};
Utils = ExposedMembers.DLHD.Utils;

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
-- Initialize
-- ============================================================================================================================================================
function initialize()
  Events.ImprovementAddedToMap.Add(ClassStruggleBoostImprovementCreated);
end
Events.LoadGameViewStateDone.Add(initialize);