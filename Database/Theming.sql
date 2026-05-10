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

-- update GreatWorks set GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_GROWTH' where GreatWorkType in
-- 	(
-- 	select
-- 		a.GreatWorkType
-- 	from
-- 		GreatWorks_ImprovementType a
-- 		inner join HDMonopolyResourceEffects b on a.ResourceType = b.ResourceType
-- 	where
-- 		b.Category = 'GROWTH'
-- 	);

-- update GreatWorks set GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_FAITH' where GreatWorkType in
-- 	(
-- 	select
-- 		a.GreatWorkType
-- 	from
-- 		GreatWorks_ImprovementType a
-- 		inner join HDMonopolyResourceEffects b on a.ResourceType = b.ResourceType
-- 	where
-- 		b.Category = 'FAITH'
-- 	);

-- update GreatWorks set GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_GPP' where GreatWorkType in
-- 	(
-- 	select
-- 		a.GreatWorkType
-- 	from
-- 		GreatWorks_ImprovementType a
-- 		inner join HDMonopolyResourceEffects b on a.ResourceType = b.ResourceType
-- 	where
-- 		b.Category = 'GPP'
-- 	);

-- update GreatWorks set GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_TRADER' where GreatWorkType in
-- 	(
-- 	select
-- 		a.GreatWorkType
-- 	from
-- 		GreatWorks_ImprovementType a
-- 		inner join HDMonopolyResourceEffects b on a.ResourceType = b.ResourceType
-- 	where
-- 		b.Category = 'TRADER'
-- 	);

-- update GreatWorks set GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_FOOD' where GreatWorkType in
-- 	(
-- 	select
-- 		a.GreatWorkType
-- 	from
-- 		GreatWorks_ImprovementType a
-- 		inner join HDMonopolyResourceEffects b on a.ResourceType = b.ResourceType
-- 	where
-- 		b.Category = 'FOOD'
-- 	);

-- update GreatWorks set GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_AMENITY' where GreatWorkType in
-- 	(
-- 	select
-- 		a.GreatWorkType
-- 	from
-- 		GreatWorks_ImprovementType a
-- 		inner join HDMonopolyResourceEffects b on a.ResourceType = b.ResourceType
-- 	where
-- 		b.Category = 'AMENITY'
-- 	);

-- update GreatWorks set GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_WONDER' where GreatWorkType in
-- 	(
-- 	select
-- 		a.GreatWorkType
-- 	from
-- 		GreatWorks_ImprovementType a
-- 		inner join HDMonopolyResourceEffects b on a.ResourceType = b.ResourceType
-- 	where
-- 		b.Category = 'WONDER'
-- 	);

-- update GreatWorks set GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_TOURISM' where GreatWorkType in
-- 	(
-- 	select
-- 		a.GreatWorkType
-- 	from
-- 		GreatWorks_ImprovementType a
-- 		inner join HDMonopolyResourceEffects b on a.ResourceType = b.ResourceType
-- 	where
-- 		b.Category = 'TOURISM'
-- 	);

-- update GreatWorks set GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_FISHERY' where GreatWorkType in
-- 	(
-- 	select
-- 		a.GreatWorkType
-- 	from
-- 		GreatWorks_ImprovementType a
-- 		inner join HDMonopolyResourceEffects b on a.ResourceType = b.ResourceType
-- 	where
-- 		b.Category = 'FISHERY'
-- 	);

-- -- Rsc2 Adapt
-- update GreatWorks set GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_ENTERTAINMENT' where GreatWorkType in
-- 	(
-- 	select
-- 		a.GreatWorkType
-- 	from
-- 		GreatWorks_ImprovementType a
-- 		inner join HDMonopolyResourceEffects b on a.ResourceType = b.ResourceType
-- 	where
-- 		b.Category = 'ENTERTAINMENT'
-- 	);

-- update GreatWorks set GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_MEDICINE' where GreatWorkType in
-- 	(
-- 	select
-- 		a.GreatWorkType
-- 	from
-- 		GreatWorks_ImprovementType a
-- 		inner join HDMonopolyResourceEffects b on a.ResourceType = b.ResourceType
-- 	where
-- 		b.Category = 'MEDICINE'
-- 	);

-- -- Wonders Adapt
-- update GreatWorks set GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_KHALIFA' where GreatWorkType in
-- 	(
-- 	select
-- 		a.GreatWorkType
-- 	from
-- 		GreatWorks_ImprovementType a
-- 		inner join HDMonopolyResourceEffects b on a.ResourceType = b.ResourceType
-- 	where
-- 		b.Category = 'KHALIFA'
-- 	);

-- update GreatWorks set GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_PORCELAIN' where GreatWorkType in
-- 	(
-- 	select
-- 		a.GreatWorkType
-- 	from
-- 		GreatWorks_ImprovementType a
-- 		inner join HDMonopolyResourceEffects b on a.ResourceType = b.ResourceType
-- 	where
-- 		b.Category = 'PORCELAIN'
-- 	);

-- update GreatWorks set GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_AIRPORT_FOOD' where GreatWorkType in
-- 	(
-- 	select
-- 		a.GreatWorkType
-- 	from
-- 		GreatWorks_ImprovementType a
-- 		inner join HDMonopolyResourceEffects b on a.ResourceType = b.ResourceType
-- 	where
-- 		b.Category = 'AIRPORT_FOOD'
-- 	);

-- update GreatWorks set GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_AIRPORT_DRINK' where GreatWorkType in
-- 	(
-- 	select
-- 		a.GreatWorkType
-- 	from
-- 		GreatWorks_ImprovementType a
-- 		inner join HDMonopolyResourceEffects b on a.ResourceType = b.ResourceType
-- 	where
-- 		b.Category = 'AIRPORT_DRINK'
-- 	);

-- update GreatWorks set GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_AIRPORT_USING' where GreatWorkType in
-- 	(
-- 	select
-- 		a.GreatWorkType
-- 	from
-- 		GreatWorks_ImprovementType a
-- 		inner join HDMonopolyResourceEffects b on a.ResourceType = b.ResourceType
-- 	where
-- 		b.Category = 'AIRPORT_USING'
-- 	);

-- -- Merchant Adapt
-- update GreatWorks set GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_TOYS' where GreatWorkType in
-- 	(
-- 	select
-- 		a.GreatWorkType
-- 	from
-- 		GreatWorks_ImprovementType a
-- 		inner join HDMonopolyResourceEffects b on a.ResourceType = b.ResourceType
-- 	where
-- 		b.Category = 'TOYS'
-- 	);

-- update GreatWorks set GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_COSMETICS' where GreatWorkType in
-- 	(
-- 	select
-- 		a.GreatWorkType
-- 	from
-- 		GreatWorks_ImprovementType a
-- 		inner join HDMonopolyResourceEffects b on a.ResourceType = b.ResourceType
-- 	where
-- 		b.Category = 'COSMETICS'
-- 	);

-- update GreatWorks set GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_JEANS' where GreatWorkType in
-- 	(
-- 	select
-- 		a.GreatWorkType
-- 	from
-- 		GreatWorks_ImprovementType a
-- 		inner join HDMonopolyResourceEffects b on a.ResourceType = b.ResourceType
-- 	where
-- 		b.Category = 'JEANS'
-- 	);

-- update GreatWorks set GreatPersonIndividualType = 'GREAT_PERSON_INDIVIDUAL_PERFUME' where GreatWorkType in
-- 	(
-- 	select
-- 		a.GreatWorkType
-- 	from
-- 		GreatWorks_ImprovementType a
-- 		inner join HDMonopolyResourceEffects b on a.ResourceType = b.ResourceType
-- 	where
-- 		b.Category = 'PERFUME'
-- 	);