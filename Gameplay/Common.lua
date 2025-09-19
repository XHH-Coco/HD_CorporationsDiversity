-- 阶级斗争尤里卡
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

-- Initialize
function initialize()
  Events.ImprovementAddedToMap.Add(ClassStruggleBoostImprovementCreated);
end
Events.LoadGameViewStateDone.Add(initialize);