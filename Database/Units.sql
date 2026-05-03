update Technologies set Description = NULL where TechnologyType = 'TECH_CURRENCY';

-- 造价
update Units set Cost = 190, CostProgressionParam1 = 10, MustPurchase = 0, PrereqTech = 'TECH_APPRENTICESHIP' where UnitType = 'UNIT_LEU_TYCOON';
update Units set Cost = 500, CostProgressionParam1 = 20, MustPurchase = 0 where UnitType = 'UNIT_LEU_INVESTOR';

-- 文本
update Units set Description = 'LOC_UNIT_LEU_TYCOON_JNR_DESCRIPTION' where UnitType = 'UNIT_LEU_TYCOON' 
	and exists (select BuildingType from Buildings where BuildingType = 'BUILDING_JNR_MERCHANT_QUARTER');
update Units set Description = 'LOC_UNIT_LEU_INVESTOR_JNR_DESCRIPTION' where UnitType = 'UNIT_LEU_INVESTOR' 
	and exists (select BuildingType from Buildings where BuildingType = 'BUILDING_JNR_MERCHANT_QUARTER');

-- 前置建筑
delete from Unit_BuildingPrereqs where Unit = 'UNIT_LEU_TYCOON';
delete from Unit_BuildingPrereqs where Unit = 'UNIT_LEU_INVESTOR';

insert or ignore into Unit_BuildingPrereqs (Unit, PrereqBuilding) select
  'UNIT_LEU_TYCOON', BuildingType
from HD_BuildingTiers where PrereqDistrict = 'DISTRICT_COMMERCIAL_HUB' and Tier = 2;

insert or ignore into Unit_BuildingPrereqs (Unit, PrereqBuilding) select
  'UNIT_LEU_TYCOON', BuildingType
from HD_BuildingTiers where PrereqDistrict = 'DISTRICT_HARBOR' and Tier = 1;

insert or ignore into Unit_BuildingPrereqs (Unit, PrereqBuilding) select
  'UNIT_LEU_INVESTOR', BuildingType
from HD_BuildingTiers where PrereqDistrict = 'DISTRICT_COMMERCIAL_HUB' and Tier = 3;

insert or ignore into Unit_BuildingPrereqs (Unit, PrereqBuilding) select
  'UNIT_LEU_INVESTOR', BuildingType
from HD_BuildingTiers where PrereqDistrict = 'DISTRICT_HARBOR' and Tier = 2;