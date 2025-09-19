--------------------------
-- Resourceful 2 by xhh --
--------------------------

-- Basic
CREATE TEMPORARY TABLE "HDResourceful2"(
	"ResourceType"  TEXT
);
insert or replace into HDResourceful2
	(ResourceType)
values
	('RESOURCE_SPONGE'),('RESOURCE_CASHMERE'),('RESOURCE_SANDALWOOD'),('RESOURCE_EBONY'),('RESOURCE_STRAWBERRY'),('RESOURCE_SALMON'),
	('RESOURCE_BAMBOO'),('RESOURCE_ALABASTER'),('RESOURCE_QUARTZ'),('RESOURCE_LAPIS'),('RESOURCE_RUBY'),('RESOURCE_PLATINUM'),('RESOURCE_SORGHUM'),
	('RESOURCE_SEA_URCHIN'),('RESOURCE_COD'),('RESOURCE_WOLF'),('RESOURCE_TIGER'),('RESOURCE_SAKURA'),('RESOURCE_POPPIES'),('RESOURCE_ORCA'),
	('RESOURCE_LION'),('RESOURCE_TRAVERTINE'),('RESOURCE_TOXINS'),('RESOURCE_SAFFRON'),('RESOURCE_ALOE'),('RESOURCE_MEDIHERBS'),('RESOURCE_SEASHELLS'),
	('RESOURCE_HAM');

insert or replace into Improvement_ValidResources
	(ImprovementType,				ResourceType)
select
	'IMPROVEMENT_INDUSTRY',			ResourceType
from HDResourceful2;

insert or replace into Improvement_ValidResources
	(ImprovementType,				ResourceType)
select
	'IMPROVEMENT_CORPORATION',		ResourceType
from HDResourceful2;

update Improvement_ValidResources set MustRemoveFeature = 0 where ImprovementType = 'IMPROVEMENT_INDUSTRY';
update Improvement_ValidResources set MustRemoveFeature = 0 where ImprovementType = 'IMPROVEMENT_CORPORATION';

-- Resource Effects
	-- 行业
insert or replace into Modifiers
	(ModifierId,                       					ModifierType,                                         SubjectRequirementSetId)
values
	('INDUSTRY_HD_MEDICINE_BONUS_SCIENCE',			'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',				'PLOT_DOES_NOT_HAVE_INCOMPLETE_WONDER'),
	('INDUSTRY_HD_MEDICINE_BONUS_FAITH',				'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',				'PLOT_DOES_NOT_HAVE_INCOMPLETE_WONDER');
insert or replace into ModifierArguments
	(ModifierId,                       		 			Name,          Value)
values
	('INDUSTRY_HD_MEDICINE_BONUS_SCIENCE',			'YieldType',	 'YIELD_SCIENCE'),
	('INDUSTRY_HD_MEDICINE_BONUS_SCIENCE',			'Amount',	     1),
	('INDUSTRY_HD_MEDICINE_BONUS_FAITH',				'YieldType',	 'YIELD_FAITH'),
	('INDUSTRY_HD_MEDICINE_BONUS_FAITH',				'Amount',	     2);

-- 娱乐观赏行业
	-- 迷人
insert or ignore into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
	select 'INDUSTRY_HD_ENTERTAINMENT_BONUS_1_' || DistrictType, 'MODIFIER_CITY_DISTRICTS_ATTACH_MODIFIER', 'DISTRICT_IS_' || DistrictType || '_REQUIREMENTS'
from DistrictCorrespondingYieldType_HD;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'INDUSTRY_HD_ENTERTAINMENT_BONUS_1_' || DistrictType, 'ModifierId', 'INDUSTRY_HD_ENTERTAINMENT_BONUS_1_' || DistrictType || '_MODIFIER'
from DistrictCorrespondingYieldType_HD;

insert or ignore into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
	select 'INDUSTRY_HD_ENTERTAINMENT_BONUS_1_' || DistrictType || '_MODIFIER', 'MODIFIER_PLAYER_DISTRICT_ADJUST_YIELD_CHANGE', 'PLOT_CHARMING_APPEAL'
from DistrictCorrespondingYieldType_HD;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'INDUSTRY_HD_ENTERTAINMENT_BONUS_1_' || DistrictType || '_MODIFIER', 'YieldType', YieldType
from DistrictCorrespondingYieldType_HD;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'INDUSTRY_HD_ENTERTAINMENT_BONUS_1_' || DistrictType || '_MODIFIER', 'Amount', Amount * 2
from DistrictCorrespondingYieldType_HD;

	-- 惊艳
insert or ignore into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
	select 'INDUSTRY_HD_ENTERTAINMENT_BONUS_2_' || DistrictType, 'MODIFIER_CITY_DISTRICTS_ATTACH_MODIFIER', 'DISTRICT_IS_' || DistrictType || '_REQUIREMENTS'
from DistrictCorrespondingYieldType_HD;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'INDUSTRY_HD_ENTERTAINMENT_BONUS_2_' || DistrictType, 'ModifierId', 'INDUSTRY_HD_ENTERTAINMENT_BONUS_2_' || DistrictType || '_MODIFIER'
from DistrictCorrespondingYieldType_HD;

insert or ignore into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
	select 'INDUSTRY_HD_ENTERTAINMENT_BONUS_2_' || DistrictType || '_MODIFIER', 'MODIFIER_PLAYER_DISTRICT_ADJUST_YIELD_CHANGE', 'PLOT_BREATHTAKING_APPEAL'
from DistrictCorrespondingYieldType_HD;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'INDUSTRY_HD_ENTERTAINMENT_BONUS_2_' || DistrictType || '_MODIFIER', 'YieldType', YieldType
from DistrictCorrespondingYieldType_HD;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'INDUSTRY_HD_ENTERTAINMENT_BONUS_2_' || DistrictType || '_MODIFIER', 'Amount', Amount * 2
from DistrictCorrespondingYieldType_HD;

	-- 公司
insert or replace into Modifiers
	(ModifierId,                       							ModifierType,                                               SubjectRequirementSetId)
values
	('CORPORATION_HD_ENTERTAINMENT_BONUS_IMPROVEMENT_ATTACH',	'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',					Null),
	('CORPORATION_HD_ENTERTAINMENT_BONUS_IMPROVEMENT',			'MODIFIER_SINGLE_CITY_ADJUST_IMPROVEMENT_TOURISM',			Null),
	('CORPORATION_HD_ENTERTAINMENT_BONUS_WONDER_ATTACH',		'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER',					Null),
	('CORPORATION_HD_ENTERTAINMENT_BONUS_WONDER',				'MODIFIER_SINGLE_CITY_ADJUST_TOURISM',						Null),
	('CORPORATION_HD_ENTERTAINMENT_BONUS_NATIONALPARK',			'MODIFIER_PLAYER_CITIES_ADJUST_NATIONAL_PARK_TOURISM',		Null),
	('CORPORATION_HD_MEDICINE_BONUS_EUREKA',					'MODIFIER_PLAYER_ADJUST_TECHNOLOGY_BOOST',					Null),
	('CORPORATION_HD_MEDICINE_BONUS_EUREKA_RECORD',					'MODIFIER_PLAYER_ADJUST_PROPERTY',					Null);

insert or replace into ModifierArguments
	(ModifierId,                       		 					Name,           	Value)
values
	('CORPORATION_HD_ENTERTAINMENT_BONUS_IMPROVEMENT_ATTACH',	'ModifierId',		'CORPORATION_HD_ENTERTAINMENT_BONUS_IMPROVEMENT'),
	('CORPORATION_HD_ENTERTAINMENT_BONUS_IMPROVEMENT',			'Amount',			50),
	('CORPORATION_HD_ENTERTAINMENT_BONUS_WONDER_ATTACH',		'ModifierId',		'CORPORATION_HD_ENTERTAINMENT_BONUS_WONDER'),
	('CORPORATION_HD_ENTERTAINMENT_BONUS_WONDER',				'BoostsWonders',	1),
	('CORPORATION_HD_ENTERTAINMENT_BONUS_WONDER',				'ScalingFactor',	150),
	('CORPORATION_HD_ENTERTAINMENT_BONUS_NATIONALPARK',			'Amount',			50),
	('CORPORATION_HD_MEDICINE_BONUS_EUREKA',					'Amount',			2),
	('CORPORATION_HD_MEDICINE_BONUS_EUREKA_RECORD',					'Key',			'HD_Player_Extra_Tech_Boost'),
	('CORPORATION_HD_MEDICINE_BONUS_EUREKA_RECORD',					'Amount',			2);

-- 娱乐观赏公司
insert or ignore into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
	select 'CORPORATION_HD_ENTERTAINMENT_BONUS_' || DistrictType || '_' || GreatPersonClassType, 'MODIFIER_PLAYER_DISTRICTS_ATTACH_MODIFIER', 'DISTRICT_IS_' || DistrictType || '_REQUIREMENTS'
from DistrictCorrespondingGPP_HD;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'CORPORATION_HD_ENTERTAINMENT_BONUS_' || DistrictType || '_' || GreatPersonClassType, 'ModifierId', 'CORPORATION_HD_ENTERTAINMENT_BONUS_' || DistrictType || '_' || GreatPersonClassType || '_MODIFIER'
from DistrictCorrespondingGPP_HD;

insert or ignore into Modifiers (ModifierId, ModifierType, OwnerRequirementSetId)
	select 'CORPORATION_HD_ENTERTAINMENT_BONUS_' || DistrictType || '_' || GreatPersonClassType || '_MODIFIER', 'MODIFIER_PLAYER_DISTRICT_ADJUST_GREAT_PERSON_POINTS', 'PLOT_BREATHTAKING_APPEAL'
from DistrictCorrespondingGPP_HD;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'CORPORATION_HD_ENTERTAINMENT_BONUS_' || DistrictType || '_' || GreatPersonClassType || '_MODIFIER', 'GreatPersonClassType', GreatPersonClassType
from DistrictCorrespondingGPP_HD;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'CORPORATION_HD_ENTERTAINMENT_BONUS_' || DistrictType || '_' || GreatPersonClassType || '_MODIFIER', 'Amount', 6
from DistrictCorrespondingGPP_HD;

-- 药材公司
insert or ignore into Modifiers (ModifierId, ModifierType)
	select 'CORPORATION_HD_MEDICINE_BONUS_' || BuildingType, 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE'
from Buildings where PrereqDistrict = 'DISTRICT_CAMPUS'
	and BuildingType not in (select BuildingType from HD_DUMMY_BUILDINGS)
	and BuildingType not in (select CivUniqueBuildingType from BuildingReplaces);

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'CORPORATION_HD_MEDICINE_BONUS_' || BuildingType, 'BuildingType', BuildingType
from Buildings where PrereqDistrict = 'DISTRICT_CAMPUS'
	and BuildingType not in (select BuildingType from HD_DUMMY_BUILDINGS)
	and BuildingType not in (select CivUniqueBuildingType from BuildingReplaces);

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'CORPORATION_HD_MEDICINE_BONUS_' || BuildingType, 'YieldType', 'YIELD_SCIENCE'
from Buildings where PrereqDistrict = 'DISTRICT_CAMPUS'
	and BuildingType not in (select BuildingType from HD_DUMMY_BUILDINGS)
	and BuildingType not in (select CivUniqueBuildingType from BuildingReplaces);

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'CORPORATION_HD_MEDICINE_BONUS_' || BuildingType, 'Amount', 2
from Buildings where PrereqDistrict = 'DISTRICT_CAMPUS'
	and BuildingType not in (select BuildingType from HD_DUMMY_BUILDINGS)
	and BuildingType not in (select CivUniqueBuildingType from BuildingReplaces);

-- Product
	-- Definition
insert or replace into Types
	(Type,																 Kind)
select
	'GREATWORK_PRODUCT_'|| substr(i.ResourceType, 10) || '_' || j.Count, 'KIND_GREATWORK'
from HDResourceful2 i, HDCounter j where Count < 6;

insert or replace into GreatWorks
	(GreatWorkType,											 			 GreatWorkObjectType,		Name)
select
	'GREATWORK_PRODUCT_'|| substr(i.ResourceType, 10) || '_' || j.Count, 'GREATWORKOBJECT_PRODUCT', 'LOC_GREATWORK_PRODUCT_'|| substr(i.ResourceType, 10) || '_' || j.Count || '_NAME'
from HDResourceful2 i, HDCounter j where Count < 6;

insert or replace into GreatWorks_ImprovementType
	(GreatWorkType,														 ResourceType)
select
	'GREATWORK_PRODUCT_'|| substr(i.ResourceType, 10) || '_' || j.Count, i.ResourceType
from HDResourceful2 i, HDCounter j where Count < 6;
	
	-- YieldChanges
insert or replace into GreatWork_YieldChanges
	(GreatWorkType,                                                 	 YieldType,          YieldChange)
select
	'GREATWORK_PRODUCT_'|| substr(i.ResourceType, 10) || '_' || j.Count, 'YIELD_SCIENCE',    4
from HDMonopolyResourceEffects i, HDCounter j where Category = 'MEDICINE' and Count < 6;

insert or replace into GreatWork_YieldChanges
	(GreatWorkType,                                                 	 YieldType,          YieldChange)
select
	'GREATWORK_PRODUCT_'|| substr(i.ResourceType, 10) || '_' || j.Count, 'YIELD_FAITH',	     4
from HDMonopolyResourceEffects i, HDCounter j where Category = 'MEDICINE' and Count < 6;
	
insert or replace into GreatWork_YieldChanges
	(GreatWorkType,                                                 	 YieldType,          YieldChange)
select
	'GREATWORK_PRODUCT_'|| substr(i.ResourceType, 10) || '_' || j.Count, 'YIELD_GOLD',		 12
from HDMonopolyResourceEffects i, HDCounter j where Category = 'ENTERTAINMENT' and Count < 6;

-- Projects
insert or replace into Types
	(Type,																 Kind)
select
	'PROJECT_CREATE_CORPORATION_PRODUCT_' || substr(ResourceType,10),	'KIND_PROJECT'
from HDResourceful2;

insert or replace into Projects
	(ProjectType,Name,ShortName,Description,Cost,AdvisorType)
select
	'PROJECT_CREATE_CORPORATION_PRODUCT_' || substr(ResourceType,10), 
	'LOC_PROJECT_CREATE_CORPORATION_PRODUCT_' || substr(ResourceType,10) || '_NAME',
	'LOC_PROJECT_CREATE_CORPORATION_PRODUCT_' || substr(ResourceType,10) || '_SHORT_NAME',
	'LOC_PROJECT_CREATE_CORPORATION_PRODUCT_' || substr(ResourceType,10) || '_DESCRIPTION',
	500,'ADVISOR_GENERIC'
from HDResourceful2;

insert or replace into Projects_MODE
	(ProjectType,														ResourceType)
select
	'PROJECT_CREATE_CORPORATION_PRODUCT_' || substr(ResourceType,10),	ResourceType
from HDResourceful2;

insert or replace into ProjectCompletionModifiers
	(ProjectType,														ModifierId)
select
	'PROJECT_CREATE_CORPORATION_PRODUCT_' || substr(ResourceType,10),	'PROJECT_COMPLETION_CREATE_CORPORATION_PRODUCT_' || substr(ResourceType,10)
from HDResourceful2;

insert or replace into Modifiers
	(ModifierId,																	ModifierType)
select
	'PROJECT_COMPLETION_CREATE_CORPORATION_PRODUCT_' || substr(ResourceType,10),	'MODIFIER_PLAYER_GRANT_RANDOM_RESOURCE_PRODUCT'
from HDResourceful2;

insert or replace into ModifierArguments
	(ModifierId,																	Name,			Value)
select
	'PROJECT_COMPLETION_CREATE_CORPORATION_PRODUCT_' || substr(ResourceType,10),	'ResourceType',	ResourceType
from HDResourceful2;