----------------------------
-- Porcelain Adapt by xhh --
----------------------------

-------------
-- Effects --
-------------
update Buildings set Description = 'LOC_BUILDING_PORCELAIN_TOWER_DESCRIPTION_CORP' where BuildingType = 'BUILDING_PORCELAIN_TOWER';
delete from BuildingModifiers where BuildingType = 'BUILDING_PORCELAIN_TOWER' and ModifierId = 'PORCELAIN_TOWER_CITIES_FREE_PORCELAIN';

--------------
-- Projects --
--------------
update Resources set Happiness = 0 where ResourceType = 'RESOURCE_PORCELAIN';
insert or ignore into CivilopediaPageExcludes (SectionId, PageId)
	values ('RESOURCES', 'RESOURCE_PORCELAIN');

insert or ignore into Types
	(Type,											Kind)
values
	('PROJECT_CREATE_PRODUCT_PORCELAIN',			'KIND_PROJECT');

insert or replace into Projects
	(ProjectType,Name,ShortName,Description,Cost,AdvisorType,MaxPlayerInstances)
values
	(
	'PROJECT_CREATE_PRODUCT_PORCELAIN', 
	'LOC_PROJECT_CREATE_PRODUCT_PORCELAIN_NAME',
	'LOC_PROJECT_CREATE_PRODUCT_PORCELAIN_SHORT_NAME',
	'LOC_PROJECT_CREATE_PRODUCT_PORCELAIN_DESCRIPTION',
	160,
	'ADVISOR_GENERIC',
	6
	);

insert or ignore into Projects_XP2 (ProjectType, RequiredBuilding)
	values ('PROJECT_CREATE_PRODUCT_PORCELAIN', 'BUILDING_PORCELAIN_TOWER');

insert or replace into ProjectCompletionModifiers
	(ProjectType,										ModifierId)
values
	('PROJECT_CREATE_PRODUCT_PORCELAIN',				'PROJECT_COMPLETE_CREATE_PORCELAIN_PRODUCT');

insert or replace into Modifiers
	(ModifierId,										ModifierType)
values
	('PROJECT_COMPLETE_CREATE_PORCELAIN_PRODUCT',		'MODIFIER_PLAYER_GRANT_RANDOM_RESOURCE_PRODUCT');

insert or replace into ModifierArguments
	(ModifierId,										Name,			Value)
values
	('PROJECT_COMPLETE_CREATE_PORCELAIN_PRODUCT',		'ResourceType',	'RESOURCE_PORCELAIN');

--------------
-- Products --
--------------
CREATE TEMPORARY TABLE "HD_PORCELAIN_Products"(
    'Num'  TEXT
);
insert or replace into HD_PORCELAIN_Products (Num) values
	('1'),('2'),('3'),('4'),('5'),('6');

insert or replace into Types
	(Type,									Kind)
select
	'GREATWORK_PRODUCT_PORCELAIN_'|| Num, 	'KIND_GREATWORK'
from HD_PORCELAIN_Products;

insert or replace into GreatWorks
	(GreatWorkType,							GreatWorkObjectType,		Tourism,	Name)
select
	'GREATWORK_PRODUCT_PORCELAIN_'|| Num, 	'GREATWORKOBJECT_PRODUCT',	18,			'LOC_GREATWORK_PRODUCT_PORCELAIN_'|| Num || '_NAME'
from HD_PORCELAIN_Products;

insert or replace into GreatWorks_ImprovementType
	(GreatWorkType,							ResourceType)
select
	'GREATWORK_PRODUCT_PORCELAIN_'|| Num,	'RESOURCE_PORCELAIN'
from HD_PORCELAIN_Products;

insert or replace into GreatWork_YieldChanges
    (GreatWorkType,                     	YieldType,          YieldChange)
select
	'GREATWORK_PRODUCT_PORCELAIN_'|| Num,	'YIELD_PRODUCTION',	3
from HD_PORCELAIN_Products;

insert or replace into GreatWork_YieldChanges
    (GreatWorkType,                     	YieldType,          YieldChange)
select
	'GREATWORK_PRODUCT_PORCELAIN_'|| Num,	'YIELD_CULTURE',	3
from HD_PORCELAIN_Products;

insert or replace into GreatWork_YieldChanges
    (GreatWorkType,                     	YieldType,          YieldChange)
select
	'GREATWORK_PRODUCT_PORCELAIN_'|| Num,	'YIELD_GOLD',		8
from HD_PORCELAIN_Products;

-------------
-- Theming --
-------------
insert or replace into HDMonopolyResourceClasses (Category) values ('PORCELAIN');
insert or replace into HDMonopolyResourceEffects (ResourceType,Category,IndustryEffect,CorporationEffect)
	values ('RESOURCE_PORCELAIN','PORCELAIN','INDUSTRY_HD_PORCELAIN_BONUS','CORPORATION_HD_PORCELAIN_BONUS');