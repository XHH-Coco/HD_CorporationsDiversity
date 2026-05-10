-- =====================================================================================================================================
-- 产品定义
-- =====================================================================================================================================
insert or ignore into Types (Type, Kind) select distinct
	'GREATWORK_PRODUCT_' || substr(a.ResourceType, 10) || '_' || b.Count, 'KIND_GREATWORK'
from HD_Monopoly_Resource_Categories a, HDCounter b where b.Count < 7;

insert or ignore into GreatWorks (GreatWorkType, GreatWorkObjectType, Name) select distinct
	'GREATWORK_PRODUCT_' || substr(a.ResourceType, 10) || '_' || b.Count, 'GREATWORKOBJECT_PRODUCT', 'LOC_GREATWORK_PRODUCT_' || substr(a.ResourceType, 10) || '_' || b.Count || '_NAME'
from HD_Monopoly_Resource_Categories a, HDCounter b where b.Count < 7;

insert or ignore into GreatWorks_ImprovementType (GreatWorkType, ResourceType) select distinct
	'GREATWORK_PRODUCT_' || substr(a.ResourceType, 10) || '_' || b.Count, a.ResourceType
from HD_Monopoly_Resource_Categories a, HDCounter b where b.Count < 7;

-- =====================================================================================================================================
-- 产品业绩
-- =====================================================================================================================================
update GreatWorks set Tourism = 18 where GreatWorkType in
  (select 'GREATWORK_PRODUCT_' || substr(a.ResourceType, 10) || '_' || b.Count from HD_Monopoly_Resource_Categories a, HDCounter b where b.Count < 7);

insert or ignore into HD_ProductTourism (ResourceType, Amount) values
	('TOYS',			24),
	('COSMETICS',	30),
	('JEANS',			30),
	('PERFUME',		36);

update GreatWorks set Tourism = (select Amount from HD_ProductTourism where HD_ProductTourism.ResourceType = substr(GreatWorks.GreatWorkType, 19, length(GreatWorks.GreatWorkType) - 20))
  where GreatWorkType in (select 'GREATWORK_PRODUCT_' || a.ResourceType || '_' || b.Count from HD_ProductTourism a, HDCounter b where b.Count < 7);

-- =====================================================================================================================================
-- 项目定义
-- =====================================================================================================================================
insert or ignore into Types (Type, Kind) select distinct
	'PROJECT_CREATE_CORPORATION_PRODUCT_' || substr(ResourceType, 10),	'KIND_PROJECT'
from HD_Monopoly_Resource_Categories;

insert or ignore into Projects (ProjectType, Name, ShortName, Description, Cost, AdvisorType) select distinct
	'PROJECT_CREATE_CORPORATION_PRODUCT_' || substr(ResourceType, 10), 
	'LOC_PROJECT_CREATE_CORPORATION_PRODUCT_' || substr(ResourceType, 10) || '_NAME',
	'LOC_PROJECT_CREATE_CORPORATION_PRODUCT_' || substr(ResourceType, 10) || '_SHORT_NAME',
	'LOC_PROJECT_CREATE_CORPORATION_PRODUCT_' || substr(ResourceType, 10) || '_DESCRIPTION',
	160,
	'ADVISOR_GENERIC'
from HD_Monopoly_Resource_Categories;

update Projects set Cost = 160 where ProjectType like 'PROJECT_CREATE_CORPORATION_PRODUCT_%';

delete from Projects_XP2 where ProjectType like 'PROJECT_CREATE_CORPORATION_PRODUCT_%';

insert or ignore into Projects_MODE (ProjectType, ResourceType) select distinct
	'PROJECT_CREATE_CORPORATION_PRODUCT_' || substr(ResourceType, 10), ResourceType
from HD_Monopoly_Resource_Categories;

insert or ignore into ProjectCompletionModifiers (ProjectType, ModifierId) select distinct
	'PROJECT_CREATE_CORPORATION_PRODUCT_' || substr(ResourceType, 10), 'PROJECT_COMPLETION_CREATE_CORPORATION_PRODUCT_' || substr(ResourceType, 10)
from HD_Monopoly_Resource_Categories;

insert or ignore into Modifiers (ModifierId, ModifierType) select distinct
	'PROJECT_COMPLETION_CREATE_CORPORATION_PRODUCT_' || substr(ResourceType, 10), 'MODIFIER_PLAYER_GRANT_RANDOM_RESOURCE_PRODUCT'
from HD_Monopoly_Resource_Categories;

insert or ignore into ModifierArguments (ModifierId, Name, Value) select distinct
	'PROJECT_COMPLETION_CREATE_CORPORATION_PRODUCT_' || substr(ResourceType, 10), 'ResourceType', ResourceType
from HD_Monopoly_Resource_Categories;

-- =====================================================================================================================================
-- 产品产出
-- =====================================================================================================================================
insert or ignore into HD_ProductYields (Category, YieldType, YieldChange) values
  ('CROPS',           'YIELD_FOOD',				8),
  ('AGRICULTURE',     'YIELD_FOOD',				6),
  ('AGRICULTURE',     'YIELD_SCIENCE',		2),
  ('CUISINE',         'YIELD_FOOD',				2),
  ('CUISINE',         'YIELD_GOLD',				18),
  ('FRUIT',           'YIELD_FOOD',				4),
  ('FRUIT',           'YIELD_GOLD',				12),
  ('BREWING',         'YIELD_FOOD',				4),
  ('BREWING',         'YIELD_CULTURE',		4),
  ('BEVERAGE',        'YIELD_FOOD',				6),
  ('BEVERAGE',        'YIELD_CULTURE',		2),
  ('OIL',             'YIELD_PRODUCTION',	6),
  ('OIL',             'YIELD_GOLD',				6),
  ('LEATHER',         'YIELD_PRODUCTION',	2),
  ('LEATHER',         'YIELD_GOLD',				18),
  ('CLOTH',           'YIELD_CULTURE',		2),
  ('CLOTH',           'YIELD_GOLD',				18),
  ('CONSTRUCTION',    'YIELD_PRODUCTION',	8),
  ('FUEL',            'YIELD_PRODUCTION',	4),
  ('FUEL',            'YIELD_GOLD',				12),
  ('CHEMISTRY',       'YIELD_PRODUCTION',	2),
  ('CHEMISTRY',       'YIELD_SCIENCE',		6),
  ('METALLURGY',      'YIELD_PRODUCTION',	4),
  ('METALLURGY',      'YIELD_SCIENCE',		4),
  ('MINTING',         'YIELD_GOLD',				24),
  ('TRANSIT',         'YIELD_PRODUCTION',	3),
  ('TRANSIT',         'YIELD_GOLD',				15),
  ('SEASONING',       'YIELD_FOOD',				6),
  ('SEASONING',       'YIELD_GOLD',				6),
  ('SEAFOOD',         'YIELD_FOOD',				8),
  ('MARINE_PRODUCTS', 'YIELD_PRODUCTION',	8),
  ('SEA_BEAST',       'YIELD_SCIENCE',		4),
  ('SEA_BEAST',       'YIELD_CULTURE',		4),
  ('CELEBRATION',     'YIELD_FAITH',			12),
  ('MEDICINE',        'YIELD_SCIENCE',		8),
  ('STATIONERY',      'YIELD_SCIENCE',		4),
  ('STATIONERY',      'YIELD_CULTURE',		4),
  ('ART',             'YIELD_CULTURE',		8),
  ('DECORATION',      'YIELD_CULTURE',		4),
  ('DECORATION',      'YIELD_GOLD',				12),
  ('ORNAMENTAL',      'YIELD_SCIENCE',		6),
  ('ORNAMENTAL',      'YIELD_CULTURE',		2),
  ('BEAST',           'YIELD_SCIENCE',		3),
  ('BEAST',           'YIELD_CULTURE',		3),
  ('BEAST',           'YIELD_FAITH',			3),
  ('HOUSEHOLD',       'YIELD_PRODUCTION',	4),
  ('HOUSEHOLD',       'YIELD_CULTURE',		4),

  ('TOYS',       			'YIELD_SCIENCE',		8),
  ('TOYS',       			'YIELD_GOLD',				24),
  ('COSMETICS',       'YIELD_CULTURE',		8),
  ('COSMETICS',       'YIELD_GOLD',				24),
  ('JEANS',       		'YIELD_PRODUCTION',	8),
  ('JEANS',       		'YIELD_FAITH',			12),
  ('PERFUME',      		'YIELD_SCIENCE',		8),
  ('PERFUME',      		'YIELD_CULTURE',		8),
  ('PERFUME',      		'YIELD_GOLD',				24);

delete from GreatWork_YieldChanges where GreatWorkType in
  (select 'GREATWORK_PRODUCT_' || substr(a.ResourceType, 10) || '_' || b.Count from HD_Monopoly_Resource_Categories a, HDCounter b
  where a.Category in (select Category from HD_ProductYields) and b.Count < 7);

insert or replace into GreatWork_YieldChanges (GreatWorkType, YieldType, YieldChange) select distinct
	'GREATWORK_PRODUCT_' || substr(a.ResourceType, 10) || '_' || b.Count,
	c.YieldType,
	ifnull(
    (select sum(YieldChange) from HD_ProductYields d where
      d.Category in (select Category from HD_Monopoly_Resource_Categories e where e.ResourceType = a.ResourceType)
      and d.YieldType = c.YieldType),
    0
  )
from HD_Monopoly_Resource_Categories a, HDCounter b, Yields c
  where a.Category in (select Category from HD_ProductYields) and b.Count < 7;

delete from GreatWork_YieldChanges where YieldChange <= 0;

-- =====================================================================================================================================
-- 产品特效
-- =====================================================================================================================================
delete from GreatWorkModifiers where GreatWorkType in
  (select 'GREATWORK_PRODUCT_' || substr(a.ResourceType, 10) || '_' || b.Count from HD_Monopoly_Resource_Categories a, HDCounter b where b.Count < 7);
delete from GreatWorkModifiers where ModifierId like 'LEU_CORPORATION_PRODUCT_%';

insert or replace into GreatWorkModifiers (GreatWorkType, ModifierId) select
	'GREATWORK_PRODUCT_TOYS_'|| Count, 'HD_PRODUCT_CITY_AMENITY_1'
from HDCounter where Count < 7;

insert or replace into GreatWorkModifiers (GreatWorkType, ModifierId) select
	'GREATWORK_PRODUCT_COSMETICS_'|| Count, 'HD_PRODUCT_CITY_AMENITY_1'
from HDCounter where Count < 7;

insert or replace into GreatWorkModifiers (GreatWorkType, ModifierId) select
	'GREATWORK_PRODUCT_JEANS_'|| Count, 'HD_PRODUCT_CITY_AMENITY_1'
from HDCounter where Count < 7;

insert or replace into GreatWorkModifiers (GreatWorkType, ModifierId) select
	'GREATWORK_PRODUCT_PERFUME_'|| Count, 'HD_PRODUCT_CITY_AMENITY_2'
from HDCounter where Count < 7;

insert or ignore into Modifiers (ModifierId, ModifierType) values
	('HD_PRODUCT_CITY_AMENITY_1', 'MODIFIER_SINGLE_CITY_ADJUST_TRAIT_AMENITY'),
	('HD_PRODUCT_CITY_AMENITY_2', 'MODIFIER_SINGLE_CITY_ADJUST_TRAIT_AMENITY');

insert or ignore into ModifierArguments (ModifierId, Name, Value) values
	('HD_PRODUCT_CITY_AMENITY_1', 'Amount', 1),
	('HD_PRODUCT_CITY_AMENITY_2', 'Amount', 2);

-- 特效文本
insert or ignore into HD_GreatWork_Text (GreatWorkType, Description) select distinct
  'GREATWORK_PRODUCT_' || substr(a.ResourceType, 10) || '_' || b.Count,
  'LOC_PRODUCT_HD_' || substr(a.ResourceType, 10) || '_BONUS_DESCRIPTION'
from HD_Monopoly_Resource_Categories a, HDCounter b where b.Count < 7 and Category in ('TOYS', 'COSMETICS', 'JEANS', 'PERFUME');