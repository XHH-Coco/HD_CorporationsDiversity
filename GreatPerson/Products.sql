-- 项目
insert or ignore into Types
	(Type,											Kind)
values
	('PROJECT_CREATE_PRODUCT_TOYS',				    'KIND_PROJECT'),
	('PROJECT_CREATE_PRODUCT_COSMETICS',			'KIND_PROJECT'),
	('PROJECT_CREATE_PRODUCT_JEANS',				'KIND_PROJECT'),
	('PROJECT_CREATE_PRODUCT_PERFUME',				'KIND_PROJECT');

insert or replace into Projects
	(ProjectType,Name,ShortName,Description,Cost,AdvisorType)
values
	(
	'PROJECT_CREATE_PRODUCT_TOYS', 
	'LOC_PROJECT_CREATE_PRODUCT_TOYS_NAME',
	'LOC_PROJECT_CREATE_PRODUCT_TOYS_SHORT_NAME',
	'LOC_PROJECT_CREATE_PRODUCT_TOYS_DESCRIPTION',
	160,
	'ADVISOR_GENERIC'
	),
    (
	'PROJECT_CREATE_PRODUCT_COSMETICS', 
	'LOC_PROJECT_CREATE_PRODUCT_COSMETICS_NAME',
	'LOC_PROJECT_CREATE_PRODUCT_COSMETICS_SHORT_NAME',
	'LOC_PROJECT_CREATE_PRODUCT_COSMETICS_DESCRIPTION',
	280,
	'ADVISOR_GENERIC'
	),
    (
	'PROJECT_CREATE_PRODUCT_JEANS', 
	'LOC_PROJECT_CREATE_PRODUCT_JEANS_NAME',
	'LOC_PROJECT_CREATE_PRODUCT_JEANS_SHORT_NAME',
	'LOC_PROJECT_CREATE_PRODUCT_JEANS_DESCRIPTION',
	280,
	'ADVISOR_GENERIC'
	),
    (
	'PROJECT_CREATE_PRODUCT_PERFUME', 
	'LOC_PROJECT_CREATE_PRODUCT_PERFUME_NAME',
	'LOC_PROJECT_CREATE_PRODUCT_PERFUME_SHORT_NAME',
	'LOC_PROJECT_CREATE_PRODUCT_PERFUME_DESCRIPTION',
	340,
	'ADVISOR_GENERIC'
	);

insert or replace into ProjectCompletionModifiers
	(ProjectType,										ModifierId)
values
	('PROJECT_CREATE_PRODUCT_TOYS',				        'PROJECT_COMPLETE_CREATE_TOYS_PRODUCT'),
	('PROJECT_CREATE_PRODUCT_COSMETICS',				'PROJECT_COMPLETE_CREATE_COSMETICS_PRODUCT'),
	('PROJECT_CREATE_PRODUCT_JEANS',				    'PROJECT_COMPLETE_CREATE_JEANS_PRODUCT'),
	('PROJECT_CREATE_PRODUCT_PERFUME',				    'PROJECT_COMPLETE_CREATE_PERFUME_PRODUCT');

insert or replace into Modifiers
	(ModifierId,										ModifierType)
values
	('PROJECT_COMPLETE_CREATE_TOYS_PRODUCT',		    'MODIFIER_PLAYER_GRANT_RANDOM_RESOURCE_PRODUCT'),
	('PROJECT_COMPLETE_CREATE_COSMETICS_PRODUCT',		'MODIFIER_PLAYER_GRANT_RANDOM_RESOURCE_PRODUCT'),
	('PROJECT_COMPLETE_CREATE_JEANS_PRODUCT',		    'MODIFIER_PLAYER_GRANT_RANDOM_RESOURCE_PRODUCT'),
	('PROJECT_COMPLETE_CREATE_PERFUME_PRODUCT',		    'MODIFIER_PLAYER_GRANT_RANDOM_RESOURCE_PRODUCT');

insert or replace into ModifierArguments
	(ModifierId,										Name,			Value)
values
	('PROJECT_COMPLETE_CREATE_TOYS_PRODUCT',		    'ResourceType',	'RESOURCE_TOYS'),
	('PROJECT_COMPLETE_CREATE_COSMETICS_PRODUCT',		'ResourceType',	'RESOURCE_COSMETICS'),
	('PROJECT_COMPLETE_CREATE_JEANS_PRODUCT',		    'ResourceType',	'RESOURCE_JEANS'),
	('PROJECT_COMPLETE_CREATE_PERFUME_PRODUCT',		    'ResourceType',	'RESOURCE_PERFUME');

insert or replace into Projects_MODE
	(ProjectType,										ResourceType)
values
	('PROJECT_CREATE_PRODUCT_TOYS',	                    'RESOURCE_TOYS'),
	('PROJECT_CREATE_PRODUCT_COSMETICS',	            'RESOURCE_COSMETICS'),
	('PROJECT_CREATE_PRODUCT_JEANS',	                'RESOURCE_JEANS'),
	('PROJECT_CREATE_PRODUCT_PERFUME',	                'RESOURCE_PERFUME');

-- 玩具公司
insert or replace into Types
	(Type,									Kind)
select
	'GREATWORK_PRODUCT_TOYS_'|| Count, 	    'KIND_GREATWORK'
from HDCounter where Count < 6;

insert or replace into GreatWorks
	(GreatWorkType,							GreatWorkObjectType,		Tourism,	Name)
select
	'GREATWORK_PRODUCT_TOYS_'|| Count, 	    'GREATWORKOBJECT_PRODUCT',	24,			'LOC_GREATWORK_PRODUCT_TOYS_'|| Count || '_NAME'
from HDCounter where Count < 6;

insert or replace into GreatWorks_ImprovementType
	(GreatWorkType,						    ResourceType)
select
	'GREATWORK_PRODUCT_TOYS_'|| Count,	    'RESOURCE_TOYS'
from HDCounter where Count < 6;

insert or replace into GreatWork_YieldChanges
	(GreatWorkType,                     YieldType,          YieldChange)
values
	('GREATWORK_PRODUCT_TOYS_1',        'YIELD_PRODUCTION', 10),
	('GREATWORK_PRODUCT_TOYS_2',        'YIELD_GOLD',       20),
	('GREATWORK_PRODUCT_TOYS_3',        'YIELD_FAITH',      10),
	('GREATWORK_PRODUCT_TOYS_4',        'YIELD_CULTURE',    10),
	('GREATWORK_PRODUCT_TOYS_5',        'YIELD_SCIENCE',    10);

-- 化妆品公司
insert or replace into Types
	(Type,									      Kind)
select
	'GREATWORK_PRODUCT_COSMETICS_'|| Count, 	  'KIND_GREATWORK'
from HDCounter where Count < 6;

insert or replace into GreatWorks
	(GreatWorkType,							      GreatWorkObjectType,		    Tourism,	Name)
select
	'GREATWORK_PRODUCT_COSMETICS_'|| Count, 	  'GREATWORKOBJECT_PRODUCT',	30,		    'LOC_GREATWORK_PRODUCT_COSMETICS_'|| Count || '_NAME'
from HDCounter where Count < 6;

insert or replace into GreatWorks_ImprovementType
	(GreatWorkType,						          ResourceType)
select
	'GREATWORK_PRODUCT_COSMETICS_'|| Count,	      'RESOURCE_COSMETICS'
from HDCounter where Count < 6;

insert or replace into GreatWork_YieldChanges
	(GreatWorkType,                               YieldType,          YieldChange)
select
	'GREATWORK_PRODUCT_COSMETICS_'|| Count,       'YIELD_CULTURE',    8
from HDCounter where Count < 6;

insert or replace into GreatWork_YieldChanges
	(GreatWorkType,                               YieldType,          YieldChange)
select
	'GREATWORK_PRODUCT_COSMETICS_'|| Count,       'YIELD_GOLD',       8
from HDCounter where Count < 6;

insert or replace into GreatWorkModifiers
	(GreatWorkType,						          ModifierId)
select
	'GREATWORK_PRODUCT_COSMETICS_'|| Count,      'HD_PRODUCT_CITY_AMENITY'
from HDCounter where Count < 6;

-- 牛仔裤公司
insert or replace into Types
	(Type,									      Kind)
select
	'GREATWORK_PRODUCT_JEANS_'|| Count, 	      'KIND_GREATWORK'
from HDCounter where Count < 6;

insert or replace into GreatWorks
	(GreatWorkType,							      GreatWorkObjectType,		    Tourism,	Name)
select
	'GREATWORK_PRODUCT_JEANS_'|| Count, 	      'GREATWORKOBJECT_PRODUCT',	30,		    'LOC_GREATWORK_PRODUCT_JEANS_'|| Count || '_NAME'
from HDCounter where Count < 6;

insert or replace into GreatWorks_ImprovementType
	(GreatWorkType,						          ResourceType)
select
	'GREATWORK_PRODUCT_JEANS_'|| Count,	          'RESOURCE_JEANS'
from HDCounter where Count < 6;

insert or replace into GreatWork_YieldChanges
	(GreatWorkType,                               YieldType,          YieldChange)
select
	'GREATWORK_PRODUCT_JEANS_'|| Count,           'YIELD_PRODUCTION', 8
from HDCounter where Count < 6;

insert or replace into GreatWork_YieldChanges
	(GreatWorkType,                               YieldType,          YieldChange)
select
	'GREATWORK_PRODUCT_JEANS_'|| Count,           'YIELD_FAITH',      4
from HDCounter where Count < 6;

insert or replace into GreatWorkModifiers
	(GreatWorkType,						          ModifierId)
select
	'GREATWORK_PRODUCT_JEANS_'|| Count,           'HD_PRODUCT_CITY_AMENITY'
from HDCounter where Count < 6;

-- 香水公司
insert or replace into Types
	(Type,									      Kind)
select
	'GREATWORK_PRODUCT_PERFUME_'|| Count, 	      'KIND_GREATWORK'
from HDCounter where Count < 6;

insert or replace into GreatWorks
	(GreatWorkType,							      GreatWorkObjectType,		    Tourism,	Name)
select
	'GREATWORK_PRODUCT_PERFUME_'|| Count, 	      'GREATWORKOBJECT_PRODUCT',	36,		    'LOC_GREATWORK_PRODUCT_PERFUME_'|| Count || '_NAME'
from HDCounter where Count < 6;

insert or replace into GreatWorks_ImprovementType
	(GreatWorkType,						          ResourceType)
select
	'GREATWORK_PRODUCT_PERFUME_'|| Count,	      'RESOURCE_PERFUME'
from HDCounter where Count < 6;

insert or replace into GreatWork_YieldChanges
	(GreatWorkType,                               YieldType,          YieldChange)
select
	'GREATWORK_PRODUCT_PERFUME_'|| Count,         'YIELD_CULTURE',    4
from HDCounter where Count < 6;

insert or replace into GreatWork_YieldChanges
	(GreatWorkType,                               YieldType,          YieldChange)
select
	'GREATWORK_PRODUCT_PERFUME_'|| Count,         'YIELD_GOLD',       20
from HDCounter where Count < 6;

insert or replace into GreatWorkModifiers
	(GreatWorkType,						          ModifierId)
select
	'GREATWORK_PRODUCT_PERFUME_'|| Count,         'HD_PRODUCT_CITY_AMENITY'
from HDCounter where Count < 6;