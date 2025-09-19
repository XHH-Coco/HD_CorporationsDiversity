local greatPersonResourcesIndices = {};
for row in GameInfo.XXCAT_GreatPersonUniqueResources() do
    local greatPersonIndex = GameInfo.GreatPersonIndividuals[row.GreatPersonIndividualType].Index;
    local resourceIndex = GameInfo.Resources[row.ResourceType].Index;
    greatPersonResourcesIndices[greatPersonIndex] = resourceIndex;
end
local corporationIndex = GameInfo.Improvements["IMPROVEMENT_CORPORATION"].Index;

function OnGreatPersonActivated (unitOwner, unitId, greatPersonIndividualID)
    local resourceIndex = greatPersonResourcesIndices[greatPersonIndividualID];
    if resourceIndex ~= nil then
        local unit = UnitManager.GetUnit(unitOwner, unitId);
        local location = unit:GetLocation();
        local plot = Map.GetPlot(location.x, location.y);
        ResourceBuilder.SetResourceType(plot, resourceIndex, 1);
        ImprovementBuilder.SetImprovementType(plot, corporationIndex, unitOwner);
    end
end

GameEvents.GreatPersonHandleActivation.Add(OnGreatPersonActivated);