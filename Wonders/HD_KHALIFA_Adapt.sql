-- =====================================================================================================================================
-- 特效
-- =====================================================================================================================================
update Buildings set Description = 'LOC_BUILDING_BURJ_KHALIFA_DESCRIPTION_CORP' where BuildingType = 'BUILDING_BURJ_KHALIFA';
update Buildings set Description = 'LOC_BUILDING_BURJ_KHALIFA_DESCRIPTION_CORP_JNR' where BuildingType = 'BUILDING_BURJ_KHALIFA'
	and exists (select BuildingType from Buildings where BuildingType = 'BUILDING_JNR_GRAND_HOTEL');

insert or replace into BuildingModifiers (BuildingType, ModifierId) select
	'BUILDING_BURJ_KHALIFA', 'KHALIFA_PRODUCT_TOURISM'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_JNR_GRAND_HOTEL');

insert or replace into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) select
	'KHALIFA_PRODUCT_TOURISM', 'MODIFIER_PLAYER_CITIES_ADJUST_TOURISM', 'CITY_HAS_BUILDING_JNR_GRAND_HOTEL_REQUIREMENTS'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_JNR_GRAND_HOTEL');

insert or replace into ModifierArguments (ModifierId, Name, Value) select
	'KHALIFA_PRODUCT_TOURISM', 'GreatWorkObjectType', 'GREATWORKOBJECT_PRODUCT'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_JNR_GRAND_HOTEL');

insert or replace into ModifierArguments (ModifierId, Name, Value) select
	'KHALIFA_PRODUCT_TOURISM', 'ScalingFactor', 300
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_JNR_GRAND_HOTEL');

-- =====================================================================================================================================
-- 项目定义
-- =====================================================================================================================================
insert or ignore into Types (Type, Kind) values
	('PROJECT_CREATE_PRODUCT_KHALIFA',	'KIND_PROJECT'),
	('RESOURCE_KHALIFA',								'KIND_RESOURCE');

insert or ignore into Resources (ResourceType, Name, ResourceClassType) values
	('RESOURCE_KHALIFA', 'LOC_RESOURCE_KHALIFA_NAME', 'RESOURCECLASS_LUXURY');

insert or ignore into Projects (ProjectType, Name, ShortName, Description, Cost, AdvisorType, MaxPlayerInstances) values
(
	'PROJECT_CREATE_PRODUCT_KHALIFA', 
	'LOC_PROJECT_CREATE_PRODUCT_KHALIFA_NAME',
	'LOC_PROJECT_CREATE_PRODUCT_KHALIFA_SHORT_NAME',
	'LOC_PROJECT_CREATE_PRODUCT_KHALIFA_DESCRIPTION',
	400,
	'ADVISOR_GENERIC',
	8
);

insert or ignore into Projects_XP2 (ProjectType, RequiredBuilding) values
	('PROJECT_CREATE_PRODUCT_KHALIFA', 'BUILDING_BURJ_KHALIFA');

insert or replace into ProjectCompletionModifiers (ProjectType, ModifierId) values
	('PROJECT_CREATE_PRODUCT_KHALIFA', 'PROJECT_COMPLETE_CREATE_KHALIFA_PRODUCT');

insert or replace into Modifiers (ModifierId, ModifierType) values
	('PROJECT_COMPLETE_CREATE_KHALIFA_PRODUCT', 'MODIFIER_PLAYER_GRANT_RANDOM_RESOURCE_PRODUCT');

insert or replace into ModifierArguments (ModifierId, Name, Value) values
	('PROJECT_COMPLETE_CREATE_KHALIFA_PRODUCT', 'ResourceType', 'RESOURCE_KHALIFA');

-- =====================================================================================================================================
-- 产品定义
-- =====================================================================================================================================
CREATE TEMPORARY TABLE HD_KHALIFA_Products (Num TEXT);
insert or replace into HD_KHALIFA_Products (Num) values
	('1'),('2'),('3'),('4'),('5'),('6'),('7'),('8');

insert or ignore into Types (Type, Kind) select
	'GREATWORK_PRODUCT_KHALIFA_' || Num, 'KIND_GREATWORK'
from HD_KHALIFA_Products;

insert or ignore into GreatWorks (GreatWorkType, GreatWorkObjectType, Tourism, Name) select
	'GREATWORK_PRODUCT_KHALIFA_' || Num, 'GREATWORKOBJECT_PRODUCT', 36, 'LOC_GREATWORK_PRODUCT_KHALIFA_' || Num || '_NAME'
from HD_KHALIFA_Products;

insert or ignore into GreatWorks_ImprovementType (GreatWorkType, ResourceType) select
	'GREATWORK_PRODUCT_KHALIFA_' || Num, 'RESOURCE_KHALIFA'
from HD_KHALIFA_Products;

insert or ignore into GreatWork_YieldChanges (GreatWorkType, YieldType, YieldChange) values
	('GREATWORK_PRODUCT_KHALIFA_1',		'YIELD_FOOD',				8),
	('GREATWORK_PRODUCT_KHALIFA_1',		'YIELD_FAITH',			12),
	('GREATWORK_PRODUCT_KHALIFA_2',		'YIELD_FOOD',				8),
	('GREATWORK_PRODUCT_KHALIFA_2',		'YIELD_PRODUCTION', 8),
	('GREATWORK_PRODUCT_KHALIFA_3',		'YIELD_GOLD',				48),
	('GREATWORK_PRODUCT_KHALIFA_4',		'YIELD_CULTURE',		8),
	('GREATWORK_PRODUCT_KHALIFA_4',		'YIELD_SCIENCE',		8),
	('GREATWORK_PRODUCT_KHALIFA_5',		'YIELD_SCIENCE',		16),
	('GREATWORK_PRODUCT_KHALIFA_6',		'YIELD_FOOD',				8),
	('GREATWORK_PRODUCT_KHALIFA_6',		'YIELD_GOLD',				24),
	('GREATWORK_PRODUCT_KHALIFA_7',		'YIELD_CULTURE',		16),
	('GREATWORK_PRODUCT_KHALIFA_8',		'YIELD_CULTURE',		8),
	('GREATWORK_PRODUCT_KHALIFA_8',		'YIELD_GOLD',				24);

insert or replace into GreatWorkModifiers (GreatWorkType, ModifierId) values
	('GREATWORK_PRODUCT_KHALIFA_1',	'PRODUCT_KHALIFA_1_BONUS'),
	('GREATWORK_PRODUCT_KHALIFA_2',	'PRODUCT_KHALIFA_2_BONUS'),
	('GREATWORK_PRODUCT_KHALIFA_3',	'PRODUCT_KHALIFA_3_BONUS'),
	('GREATWORK_PRODUCT_KHALIFA_4',	'PRODUCT_KHALIFA_4_BONUS1'),
	('GREATWORK_PRODUCT_KHALIFA_4',	'PRODUCT_KHALIFA_4_BONUS2'),
	('GREATWORK_PRODUCT_KHALIFA_5',	'PRODUCT_KHALIFA_5_BONUS'),
	('GREATWORK_PRODUCT_KHALIFA_6',	'PRODUCT_KHALIFA_6_BONUS1'),
	('GREATWORK_PRODUCT_KHALIFA_6',	'PRODUCT_KHALIFA_6_BONUS2'),
	('GREATWORK_PRODUCT_KHALIFA_7',	'PRODUCT_KHALIFA_7_BONUS1'),
	('GREATWORK_PRODUCT_KHALIFA_7',	'PRODUCT_KHALIFA_7_BONUS2'),
	('GREATWORK_PRODUCT_KHALIFA_8',	'PRODUCT_KHALIFA_8_BONUS');

insert or replace into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) values
	('PRODUCT_KHALIFA_1_BONUS',			'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',					Null),
	('PRODUCT_KHALIFA_2_BONUS',			'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',		Null),
	('PRODUCT_KHALIFA_3_BONUS',			'MODIFIER_SINGLE_CITY_ADJUST_TRAIT_AMENITY',								Null),
	('PRODUCT_KHALIFA_4_BONUS1',		'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',		Null),
	('PRODUCT_KHALIFA_4_BONUS2',		'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',		Null),
	('PRODUCT_KHALIFA_5_BONUS',			'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_MODIFIER',						'DISTRICT_IS_CAMPUS'),
	('PRODUCT_KHALIFA_6_BONUS1',		'MODIFIER_SINGLE_CITY_ADJUST_TRADE_ROUTE_YIELD_TO_OTHERS',	Null),
	('PRODUCT_KHALIFA_6_BONUS2',		'MODIFIER_SINGLE_CITY_ADJUST_TRADE_ROUTE_YIELD_TO_OTHERS',	Null),
	('PRODUCT_KHALIFA_7_BONUS1',		'MODIFIER_SINGLE_CITY_ADJUST_TRADE_ROUTE_YIELD_TO_OTHERS',	Null),
	('PRODUCT_KHALIFA_7_BONUS2',		'MODIFIER_SINGLE_CITY_ADJUST_TRADE_ROUTE_YIELD_TO_OTHERS',	Null),
	('PRODUCT_KHALIFA_8_BONUS',			'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_MODIFIER',						'DISTRICT_IS_THEATER');

insert or replace into ModifierArguments (ModifierId, Name, Value) values
	('PRODUCT_KHALIFA_1_BONUS',     'YieldType',    'YIELD_FOOD'),
	('PRODUCT_KHALIFA_1_BONUS',     'Amount',       15),
	('PRODUCT_KHALIFA_2_BONUS',     'YieldType',    'YIELD_FOOD'),
	('PRODUCT_KHALIFA_2_BONUS',     'Amount',       0.5),
	('PRODUCT_KHALIFA_3_BONUS',     'Amount',       4),
	('PRODUCT_KHALIFA_4_BONUS1',    'YieldType',    'YIELD_CULTURE'),
	('PRODUCT_KHALIFA_4_BONUS1',    'Amount',       1),
	('PRODUCT_KHALIFA_4_BONUS2',    'YieldType',    'YIELD_SCIENCE'),
	('PRODUCT_KHALIFA_4_BONUS2',    'Amount',       1),
	('PRODUCT_KHALIFA_5_BONUS',     'YieldType',    'YIELD_SCIENCE'),
	('PRODUCT_KHALIFA_5_BONUS',     'Amount',       100),
	('PRODUCT_KHALIFA_6_BONUS1',  	'YieldType',    'YIELD_FOOD'),
	('PRODUCT_KHALIFA_6_BONUS1',  	'Amount',       1),
	('PRODUCT_KHALIFA_6_BONUS1',  	'Domestic',     1),
	('PRODUCT_KHALIFA_6_BONUS2',  	'YieldType',    'YIELD_PRODUCTION'),
	('PRODUCT_KHALIFA_6_BONUS2',  	'Amount',       1),
	('PRODUCT_KHALIFA_6_BONUS2',  	'Domestic',     1),
	('PRODUCT_KHALIFA_7_BONUS1',  	'YieldType',    'YIELD_SCIENCE'),
	('PRODUCT_KHALIFA_7_BONUS1',  	'Amount',       1),
	('PRODUCT_KHALIFA_7_BONUS1',  	'Domestic',     1),
	('PRODUCT_KHALIFA_7_BONUS2',  	'YieldType',    'YIELD_CULTURE'),
	('PRODUCT_KHALIFA_7_BONUS2',  	'Amount',       1),
	('PRODUCT_KHALIFA_7_BONUS2',  	'Domestic',     1),
	('PRODUCT_KHALIFA_8_BONUS',     'YieldType',    'YIELD_CULTURE'),
	('PRODUCT_KHALIFA_8_BONUS',     'Amount',       100);

-- 主题化
insert or ignore into HD_Monopoly_Categories (Category) values ('KHALIFA');
insert or ignore into HD_Monopoly_Resource_Categories (ResourceType, Category) values ('RESOURCE_KHALIFA','KHALIFA');

-- 文本描述
insert or ignore into HD_GreatWork_Text (GreatWorkType, Description) values
	('GREATWORK_PRODUCT_KHALIFA_1', 'LOC_PRODUCT_HD_KHALIFA_1_BONUS_DESCRIPTION'),
	('GREATWORK_PRODUCT_KHALIFA_2', 'LOC_PRODUCT_HD_KHALIFA_2_BONUS_DESCRIPTION'),
	('GREATWORK_PRODUCT_KHALIFA_3', 'LOC_PRODUCT_HD_KHALIFA_3_BONUS_DESCRIPTION'),
	('GREATWORK_PRODUCT_KHALIFA_4', 'LOC_PRODUCT_HD_KHALIFA_4_BONUS_DESCRIPTION'),
	('GREATWORK_PRODUCT_KHALIFA_5', 'LOC_PRODUCT_HD_KHALIFA_5_BONUS_DESCRIPTION'),
	('GREATWORK_PRODUCT_KHALIFA_6', 'LOC_PRODUCT_HD_KHALIFA_6_BONUS_DESCRIPTION'),
	('GREATWORK_PRODUCT_KHALIFA_7', 'LOC_PRODUCT_HD_KHALIFA_7_BONUS_DESCRIPTION'),
	('GREATWORK_PRODUCT_KHALIFA_8', 'LOC_PRODUCT_HD_KHALIFA_8_BONUS_DESCRIPTION');