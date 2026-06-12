-- 定义虚拟伟人
insert or ignore into Types (Type, Kind) values
  ('GREAT_PERSON_CLASS_PRODUCT',    'KIND_GREAT_PERSON_CLASS'),
  ('UNIT_PRODUCT',                  'KIND_UNIT'),
  ('PSEUDOYIELD_DUMMY_GPP_PRODUCT', 'KIND_PSEUDOYIELD');

insert or ignore into Types (Type, Kind) select distinct
  'GREAT_PERSON_INDIVIDUAL_PRODUCT_' || substr(ResourceType, 10), 'KIND_GREAT_PERSON_INDIVIDUAL'
from HD_Monopoly_Resource_Categories;

insert or ignore into PseudoYields (PseudoYieldType, DefaultValue) values
  ('PSEUDOYIELD_DUMMY_GPP_PRODUCT',   0.5);

insert or ignore into Units (UnitType, Name, BaseSightRange, BaseMoves, Domain, FormationClass, Cost, Description, CanCapture, CanRetreatWhenCaptured, CanTrain) values
  ('UNIT_PRODUCT', 'LOC_UNIT_PRODUCT_NAME', 1, 1, 'DOMAIN_LAND', 'FORMATION_CLASS_CIVILIAN', 1, 'LOC_UNIT_PRODUCT_DESCRIPTION', 0, 1, 0);

insert or ignore into GreatPersonClasses (GreatPersonClassType, Name, UnitType, DistrictType, PseudoYieldType, IconString, ActionIcon, AvailableInTimeline) values
  ('GREAT_PERSON_CLASS_PRODUCT', 'LOC_UNIT_PRODUCT_NAME', 'UNIT_PRODUCT', 'DISTRICT_COMMERCIAL_HUB', 'PSEUDOYIELD_DUMMY_GPP_PRODUCT', '[ICON_GreatMerchant]', 'ICON_UNITOPERATION_MERCHANT_ACTION', 0);

insert or ignore into GreatPersonIndividuals (GreatPersonIndividualType, Name, GreatPersonClassType, EraType, ActionCharges, ActionRequiresOwnedTile, Gender) select
  'GREAT_PERSON_INDIVIDUAL_PRODUCT_' || substr(ResourceType, 10), '{LOC_RESOURCE_' || substr(ResourceType, 10) || '_NAME}{LOC_HD_CORPORATION}', 'GREAT_PERSON_CLASS_PRODUCT', 'ERA_ANCIENT', 0, 1, 'M'
from HD_Monopoly_Resource_Categories;

-- 产品分类 虚拟伟人
update GreatWorks set GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_PRODUCT_' || substr(GreatWorkType, 19, length(GreatWorkType) - 20)
  where GreatWorkObjectType = 'GREATWORKOBJECT_PRODUCT';