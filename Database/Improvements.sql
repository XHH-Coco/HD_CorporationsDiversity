-- =====================================================================================================================================
-- 删除垄断加成
-- =====================================================================================================================================
insert or replace into GlobalParameters (Name, Value) values 
	('MONOPOLY_REQUIRED_RESOURCE_CONTROL_PERCENTAGE',			201),
	('MONOPOLY_REQUIRED_RESOURCE_CONTROL_PERCENTAGE_MED',	201),
	('MONOPOLY_REQUIRED_RESOURCE_CONTROL_PERCENTAGE_MAX',	201);

-- =====================================================================================================================================
-- 行业公司产出
-- =====================================================================================================================================
update Improvement_YieldChanges set YieldChange = 5
	where ImprovementType = 'IMPROVEMENT_INDUSTRY' and YieldType = 'YIELD_FOOD';
update Improvement_YieldChanges set YieldChange = 6
	where ImprovementType = 'IMPROVEMENT_INDUSTRY' and YieldType = 'YIELD_PRODUCTION';
update Improvement_YieldChanges set YieldChange = 6
	where ImprovementType = 'IMPROVEMENT_INDUSTRY' and YieldType = 'YIELD_GOLD';

update Improvement_YieldChanges set YieldChange = 6
	where ImprovementType = 'IMPROVEMENT_CORPORATION' and YieldType = 'YIELD_FOOD';
update Improvement_YieldChanges set YieldChange = 8
	where ImprovementType = 'IMPROVEMENT_CORPORATION' and YieldType = 'YIELD_PRODUCTION';
update Improvement_YieldChanges set YieldChange = 8
	where ImprovementType = 'IMPROVEMENT_CORPORATION' and YieldType = 'YIELD_GOLD';
update Improvements set Removable = 0 where ImprovementType = 'IMPROVEMENT_CORPORATION';

-- =====================================================================================================================================
-- 行业公司特效
-- =====================================================================================================================================
-- 删除旧特效
delete from ImprovementModifiers where ImprovementType = 'IMPROVEMENT_INDUSTRY';
delete from ImprovementModifiers where ImprovementType = 'IMPROVEMENT_CORPORATION';

-- =========================
-- 通用特效
-- =========================
insert or ignore into ImprovementModifiers (ImprovementType, ModifierId) values
	('IMPROVEMENT_CORPORATION',	'IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_1'),
	('IMPROVEMENT_CORPORATION',	'IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_2'),
	('IMPROVEMENT_CORPORATION',	'IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_3'),
	('IMPROVEMENT_CORPORATION',	'IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_4'),
	('IMPROVEMENT_CORPORATION',	'IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_1'),
	('IMPROVEMENT_CORPORATION',	'IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_2'),
	('IMPROVEMENT_CORPORATION',	'IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_3');

insert or ignore into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) values
	('IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_1',	'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'CITY_HAS_DISTRICT_COMMERCIAL_HUB_TIER_1_BUILDING_REQUIREMENTS'),
	('IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_2',	'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'CITY_HAS_DISTRICT_COMMERCIAL_HUB_TIER_2_BUILDING_REQUIREMENTS'),
	('IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_3',	'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'CITY_HAS_DISTRICT_COMMERCIAL_HUB_TIER_3_BUILDING_REQUIREMENTS'),
	('IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_4',	'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'CITY_HAS_DISTRICT_COMMERCIAL_HUB_TIER_4_BUILDING_REQUIREMENTS'),
	('IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_1',					'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'CITY_HAS_DISTRICT_HARBOR_TIER_1_BUILDING_REQUIREMENTS'),
	('IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_2',					'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'CITY_HAS_DISTRICT_HARBOR_TIER_2_BUILDING_REQUIREMENTS'),
	('IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_3',					'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'CITY_HAS_DISTRICT_HARBOR_TIER_3_BUILDING_REQUIREMENTS');

insert or ignore into ModifierArguments (ModifierId, Name, Value) values
	('IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_1',	'YieldType',	'YIELD_GOLD'),
	('IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_1',	'Amount',			3),
	('IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_2',	'YieldType',	'YIELD_GOLD'),
	('IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_2',	'Amount',			3),
	('IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_3',	'YieldType',	'YIELD_GOLD'),
	('IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_3',	'Amount',			3),
	('IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_4',	'YieldType',	'YIELD_GOLD'),
	('IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_4',	'Amount',			3),
	('IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_1',					'YieldType',	'YIELD_GOLD'),
	('IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_1',					'Amount',			3),
	('IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_2',					'YieldType',	'YIELD_GOLD'),
	('IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_2',					'Amount',			3),
	('IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_3',					'YieldType',	'YIELD_GOLD'),
	('IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_3',					'Amount',			3);

-- =========================
-- 行业特效
-- =========================
-- insert or ignore into HD_IndustryModifiers (Category, ModifierId) values
-- 	('',			''),
-- 	('',			'');

insert or ignore into ImprovementModifiers (ImprovementType, ModifierId) select
	'IMPROVEMENT_INDUSTRY', ModifierId
from HD_IndustryModifiers;

-- insert or ignore into Modifiers (ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) values
-- 	('',		'',		'',		''),
-- 	('',		'',		'',		'');

-- insert or ignore into ModifierArguments (ModifierId, Name, Value) values
-- 	('',		'YieldType',	'YIELD_FOOD'),
-- 	('',  	'Amount',			1);

-- =========================
-- 公司效果
-- =========================
-- insert or ignore into HD_CorporationModifiers (Category, ModifierId) values
-- 	('',			''),
-- 	('',			'');

insert or ignore into ImprovementModifiers (ImprovementType, ModifierId) select
	'IMPROVEMENT_CORPORATION', ModifierId
from HD_IndustryModifiers;

insert or ignore into ImprovementModifiers (ImprovementType, ModifierId) select
	'IMPROVEMENT_CORPORATION', ModifierId
from HD_CorporationModifiers;

-- insert or ignore into Modifiers (ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) values
-- 	('',		'',		'',		''),
-- 	('',		'',		'',		'');

-- insert or ignore into ModifierArguments (ModifierId, Name, Value) values
-- 	('',		'YieldType',	'YIELD_FOOD'),
-- 	('',  	'Amount',			1);

-- =====================================================================================================================================
-- 行业公司文本描述
-- =====================================================================================================================================
delete from ResourceIndustries;
delete from ResourceCorporations;

insert or ignore into ResourceIndustries (ResourceType, ResourceEffect, ResourceEffectTExt) select
	ResourceType,
	IndustryEffect,
	'LOC_' || IndustryEffect || '_DESCRIPTION'
from HD_Monopoly_Resource_Categories a inner join HD_Monopoly_Categories b on a.Category = b.Category;

insert or ignore into ResourceCorporations (ResourceType,  ResourceEffect, ResourceEffectTExt) select
	ResourceType,
	CorporationEffect,
	'LOC_' || CorporationEffect || '_DESCRIPTION'
from HD_Monopoly_Resource_Categories a inner join HD_Monopoly_Categories b on a.Category = b.Category;

-- =====================================================================================================================================
-- 仓库和集装箱码头
-- =====================================================================================================================================
update Improvements set
	PrereqTech = 'TECH_INDUSTRIALIZATION',
	RequiresAdjacentBonusOrLuxury = 1,
	RequiresAdjacentLuxury = 0,
	Removable = 1,
	OnlyOpenBorders = 0,
	OnePerCity = 1,
	Capturable = 1
where ImprovementType in ('IMPROVEMENT_LEU_WAREHOUSE', 'IMPROVEMENT_LEU_CONTAINER_PORT');

delete from TraitModifiers where ModifierId in (
	'LEU_WAREHOUSE_TRADE_GOLD',
	'LEU_WAREHOUSE_TRADE_PRODUCTION',
	'LEU_CONTAINER_PORT_TRADE_GOLD',
	'LEU_CONTAINER_PORT_TRADE_PRODUCTION'
) and TraitType = 'TRAIT_LEADER_MAJOR_CIV';

delete from ImprovementModifiers where ModifierId in (
	'LEU_WAREHOUSE_CORPORATION_TRADE_GOLD',
	'LEU_WAREHOUSE_CORPORATION_TRADE_PRODUCTION',
	'LEU_CONTAINER_PORT_CORPORATION_TRADE_GOLD',
	'LEU_CONTAINER_PORT_CORPORATION_TRADE_PRODUCTION'
) and ImprovementType = 'IMPROVEMENT_CORPORATION';

insert or replace into Improvement_ValidFeatures (ImprovementType, FeatureType) select
	'IMPROVEMENT_LEU_WAREHOUSE', FeatureType
from Features where FeatureType in (
	'FEATURE_JUNGLE', 'FEATURE_FOREST', 'FEATURE_JNR_SAVANNAH'
);

insert or replace into Improvement_ValidFeatures (ImprovementType, FeatureType) select
	'IMPROVEMENT_LEU_CONTAINER_PORT', FeatureType
from Features where FeatureType in (
	'FEATURE_REEF', 'FEATURE_SUK_KELP'
);

delete from ImprovementModifiers where ModifierId like 'LEU_INVESTOR_CORPORATION_BOOST_%';

update Improvement_ValidBuildUnits set UnitType = 'UNIT_LEU_TYCOON' where
	ImprovementType in ('IMPROVEMENT_LEU_WAREHOUSE', 'IMPROVEMENT_LEU_CONTAINER_PORT');

update Improvement_YieldChanges set YieldChange = 6 where YieldType = 'YIELD_PRODUCTION' and
	ImprovementType in ('IMPROVEMENT_LEU_WAREHOUSE', 'IMPROVEMENT_LEU_CONTAINER_PORT');
update Improvement_YieldChanges set YieldChange = 6 where YieldType = 'YIELD_GOLD' and
	ImprovementType in ('IMPROVEMENT_LEU_WAREHOUSE', 'IMPROVEMENT_LEU_CONTAINER_PORT');

delete from Improvement_BonusYieldChanges where ImprovementType in ('IMPROVEMENT_LEU_WAREHOUSE', 'IMPROVEMENT_LEU_CONTAINER_PORT');

insert or replace into Improvement_YieldChanges (ImprovementType, YieldType, YieldChange) values
	('IMPROVEMENT_LEU_WAREHOUSE',					'YIELD_FOOD',		0),
	('IMPROVEMENT_LEU_CONTAINER_PORT',		'YIELD_FOOD',		0);

insert or replace into Improvement_Adjacencies (ImprovementType, YieldChangeId) values
	('IMPROVEMENT_LEU_WAREHOUSE',		'HD_WAREHOUSE_BONUS_FOOD'),
	('IMPROVEMENT_LEU_WAREHOUSE',		'HD_WAREHOUSE_LUXURY_GOLD'),
	('IMPROVEMENT_LEU_WAREHOUSE',		'HD_WAREHOUSE_STRATEGIC_PRODUCTION'),
	('IMPROVEMENT_LEU_WAREHOUSE',		'HD_WAREHOUSE_CANAL_GOLD'),
	('IMPROVEMENT_LEU_WAREHOUSE',		'HD_WAREHOUSE_AERODROME_PRODUCTION'),
	('IMPROVEMENT_LEU_WAREHOUSE',		'HD_WAREHOUSE_MOUNTAIN_TUNNEL_GOLD'),
	('IMPROVEMENT_LEU_WAREHOUSE',		'HD_WAREHOUSE_INDUSTRY_PRODUCTION'),
	('IMPROVEMENT_LEU_WAREHOUSE',		'HD_WAREHOUSE_CORPORATION_GOLD'),
	('IMPROVEMENT_LEU_WAREHOUSE',		'HD_WAREHOUSE_STATION_PRODUCTION'),

	('IMPROVEMENT_LEU_CONTAINER_PORT',		'HD_CONTAINER_PORT_BONUS_FOOD'),
	('IMPROVEMENT_LEU_CONTAINER_PORT',		'HD_CONTAINER_PORT_LUXURY_GOLD'),
	('IMPROVEMENT_LEU_CONTAINER_PORT',		'HD_CONTAINER_PORT_STRATEGIC_PRODUCTION'),
	('IMPROVEMENT_LEU_CONTAINER_PORT',		'HD_CONTAINER_PORT_CANAL_GOLD'),
	('IMPROVEMENT_LEU_CONTAINER_PORT',		'HD_CONTAINER_PORT_AERODROME_PRODUCTION'),
	('IMPROVEMENT_LEU_CONTAINER_PORT',		'HD_CONTAINER_PORT_MOUNTAIN_TUNNEL_GOLD'),
	('IMPROVEMENT_LEU_CONTAINER_PORT',		'HD_CONTAINER_PORT_INDUSTRY_PRODUCTION'),
	('IMPROVEMENT_LEU_CONTAINER_PORT',		'HD_CONTAINER_PORT_CORPORATION_GOLD'),
	('IMPROVEMENT_LEU_CONTAINER_PORT',		'HD_CONTAINER_PORT_STATION_PRODUCTION');

insert or replace into Adjacency_YieldChanges (ID, Description, YieldType, YieldChange, AdjacentResourceClass) values
	('HD_WAREHOUSE_BONUS_FOOD', 								'Placeholder',	'YIELD_FOOD',				2,						'RESOURCECLASS_BONUS'),
	('HD_CONTAINER_PORT_BONUS_FOOD',  					'Placeholder',	'YIELD_FOOD',				2,						'RESOURCECLASS_BONUS'),
	('HD_WAREHOUSE_LUXURY_GOLD', 								'Placeholder',	'YIELD_GOLD',				3,						'RESOURCECLASS_LUXURY'),
	('HD_CONTAINER_PORT_LUXURY_GOLD', 					'Placeholder',	'YIELD_GOLD',				3,						'RESOURCECLASS_LUXURY'),
	('HD_WAREHOUSE_STRATEGIC_PRODUCTION', 			'Placeholder',	'YIELD_PRODUCTION',	2,						'RESOURCECLASS_STRATEGIC'),
	('HD_CONTAINER_PORT_STRATEGIC_PRODUCTION', 	'Placeholder',	'YIELD_PRODUCTION',	2,						'RESOURCECLASS_STRATEGIC');

insert or replace into Adjacency_YieldChanges (ID, Description, YieldType, YieldChange, AdjacentDistrict) values
	('HD_WAREHOUSE_CANAL_GOLD',									'Placeholder',	'YIELD_GOLD',					3,						'DISTRICT_CANAL'),
	('HD_CONTAINER_PORT_CANAL_GOLD',						'Placeholder',	'YIELD_GOLD',					3,						'DISTRICT_CANAL'),
	('HD_WAREHOUSE_AERODROME_PRODUCTION',				'Placeholder',	'YIELD_PRODUCTION',		2,						'DISTRICT_AERODROME'),
	('HD_CONTAINER_PORT_AERODROME_PRODUCTION',	'Placeholder',	'YIELD_PRODUCTION',		2,						'DISTRICT_AERODROME');

insert or replace into Adjacency_YieldChanges (ID, Description, YieldType, YieldChange, AdjacentImprovement) values
	('HD_WAREHOUSE_MOUNTAIN_TUNNEL_GOLD',					'Placeholder',	'YIELD_GOLD',				3,						'IMPROVEMENT_MOUNTAIN_TUNNEL'),
	('HD_CONTAINER_PORT_MOUNTAIN_TUNNEL_GOLD',		'Placeholder',	'YIELD_GOLD',				3,						'IMPROVEMENT_MOUNTAIN_TUNNEL'),
	('HD_WAREHOUSE_INDUSTRY_PRODUCTION',					'Placeholder',	'YIELD_PRODUCTION',	1,						'IMPROVEMENT_INDUSTRY'),
	('HD_CONTAINER_PORT_INDUSTRY_PRODUCTION',			'Placeholder',	'YIELD_PRODUCTION',	1,						'IMPROVEMENT_INDUSTRY'),
	('HD_WAREHOUSE_CORPORATION_GOLD',    					'Placeholder',	'YIELD_GOLD',				3,						'IMPROVEMENT_CORPORATION'),
	('HD_CONTAINER_PORT_CORPORATION_GOLD',    		'Placeholder',	'YIELD_GOLD',				3,						'IMPROVEMENT_CORPORATION'),
	('HD_WAREHOUSE_STATION_PRODUCTION',						'Placeholder',	'YIELD_PRODUCTION',	2,						'IMPROVEMENT_LEU_STATION'),
	('HD_CONTAINER_PORT_STATION_PRODUCTION',			'Placeholder',	'YIELD_PRODUCTION',	2,						'IMPROVEMENT_LEU_STATION');
	
insert or replace into ImprovementModifiers (ImprovementType, ModifierId) values
	('IMPROVEMENT_LEU_WAREHOUSE',					'HD_WAREHOUSE_TRADE_BONUS'),
	('IMPROVEMENT_LEU_WAREHOUSE',					'HD_WAREHOUSE_PRODUCT_TOURISM'),
	('IMPROVEMENT_LEU_WAREHOUSE',					'HD_WAREHOUSE_PLOT_YIELD_BONUS'),
	('IMPROVEMENT_LEU_CONTAINER_PORT',		'HD_CONTAINER_PORT_TRADE_BONUS'),
	('IMPROVEMENT_LEU_CONTAINER_PORT',		'HD_WAREHOUSE_PRODUCT_TOURISM'),
	('IMPROVEMENT_LEU_CONTAINER_PORT',		'HD_CONTAINER_PORT_PLOT_YIELD_BONUS');

insert or replace into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) values
	('HD_WAREHOUSE_TRADE_BONUS',							'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD',		null),
	('HD_CONTAINER_PORT_TRADE_BONUS',					'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD',		null),
	('HD_WAREHOUSE_PRODUCT_TOURISM',					'MODIFIER_SINGLE_CITY_ADJUST_TOURISM',				null),
	('HD_WAREHOUSE_PLOT_YIELD_BONUS',					'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',					'HD_PLOT_HAS_INDUSTRY_OR_CORPORATION_REQUIRMENTS'),
	('HD_CONTAINER_PORT_PLOT_YIELD_BONUS',		'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',					'HD_PLOT_HAS_INDUSTRY_OR_CORPORATION_REQUIRMENTS');

insert or replace into ModifierArguments (ModifierId, Name, Value) values
	('HD_WAREHOUSE_TRADE_BONUS',						'YieldType',						'YIELD_PRODUCTION'),
	('HD_WAREHOUSE_TRADE_BONUS',						'Amount',								1),
	('HD_CONTAINER_PORT_TRADE_BONUS',				'YieldType',						'YIELD_GOLD'),
	('HD_CONTAINER_PORT_TRADE_BONUS',				'Amount',								3),
	('HD_WAREHOUSE_PRODUCT_TOURISM',				'GreatWorkObjectType',	'GREATWORKOBJECT_PRODUCT'),
	('HD_WAREHOUSE_PRODUCT_TOURISM',				'ScalingFactor',				150),
	('HD_WAREHOUSE_PLOT_YIELD_BONUS',				'YieldType',						'YIELD_PRODUCTION'),
	('HD_WAREHOUSE_PLOT_YIELD_BONUS',				'Amount',								1),
	('HD_CONTAINER_PORT_PLOT_YIELD_BONUS',	'YieldType',						'YIELD_GOLD'),
	('HD_CONTAINER_PORT_PLOT_YIELD_BONUS',	'Amount',								3);

-- =====================================================================================================================================
-- 尤里卡
-- =====================================================================================================================================
-- 阶级斗争
update Boosts set BoostClass = 'BOOST_TRIGGER_NONE_LATE_GAME_CRITICAL_TECH', BuildingType = null, NumItems = 0,
	TriggerDescription = 'LOC_BOOST_TRIGGER_CLASS_STRUGGLE_HD_MONO', TriggerLongDescription = 'LOC_BOOST_TRIGGER_LONGDESC_CLASS_STRUGGLE_HD_MONO'
where CivicType = 'CIVIC_CLASS_STRUGGLE';

insert or replace into GlobalParameters (Name, Value) values
	('HD_CLASS_STRUGGLE_BOOST_WAREHOUSE',  1);

-- 宏观调控
update Boosts set BoostClass = 'BOOST_TRIGGER_HAVE_X_IMPROVEMENTS', BuildingType = null, TriggerDescription = 'LOC_BOOST_TRIGGER_CAPITALISM_HD', NumItems = 1,
	TriggerLongDescription = 'LOC_BOOST_TRIGGER_LONGDESC_CAPITALISM_HD', ImprovementType = 'IMPROVEMENT_CORPORATION'
where CivicType = 'CIVIC_CAPITALISM';

-- =====================================================================================================================================
-- 城堡庄园 TODO
-- =====================================================================================================================================
update Improvements set PrereqCivic = 'CIVIC_FEUDALISM',
	Housing = 1,
	SameAdjacentValid = 1,
	Description = 'LOC_IMPROVEMENT_CHATEAU_DESCRIPTION_MONOPOLIES'
where ImprovementType = 'IMPROVEMENT_CHATEAU';

-- create temporary table HD_ChateauResourceModifiers (
-- 	ResourceType text not null,
-- 	IndustryModifierId text not null,
-- 	ChateauAttachModifierId text,
-- 	PlantationAttachModifierId text,
-- 	primary key (ResourceType, IndustryModifierId)
-- );

-- insert or replace into HD_ChateauResourceModifiers
-- 	(ResourceType,		IndustryModifierId)
-- select
-- 	ResourceType,		ModifierId
-- from (HDMonopolyResourceEffects m inner join HD_IndustryModifiers i on m.Category = i.Category)
-- where ResourceType in (select ResourceType from Improvement_ValidResources where ImprovementType in ('IMPROVEMENT_PLANTATION', 'IMPROVEMENT_FARM', 'IMPROVEMENT_LUMBER_MILL'));

-- update HD_ChateauResourceModifiers set ChateauAttachModifierId = ResourceType || '_' || IndustryModifierId || '_CHATEAU_ATTACH';
-- update HD_ChateauResourceModifiers set PlantationAttachModifierId = ResourceType || '_' || IndustryModifierId || '_PLANTATION_ATTACH';

-- insert or replace into ImprovementModifiers (ImprovementType, ModifierId)
-- 	select 'IMPROVEMENT_CHATEAU', ChateauAttachModifierId from HD_ChateauResourceModifiers;

-- insert or replace into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId, SubjectStackLimit)
-- 	select ChateauAttachModifierId, 'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER', 'HD_PLOT_HAS_' || ResourceType || '_ADJACENT', 1
-- from HD_ChateauResourceModifiers;

-- insert or replace into ModifierArguments (ModifierId, Name, Value)
-- 	select ChateauAttachModifierId, 'ModifierId',	PlantationAttachModifierId
-- from HD_ChateauResourceModifiers;

-- insert or replace into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId, SubjectStackLimit) select
-- 	PlantationAttachModifierId,
-- 	'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER',
-- 	'PLOT_HAS_IMPROVEMENT_CHATEAU_AND_ADJACENT_TO_OWNER_REQUIREMENTS',
-- 	1
-- from HD_ChateauResourceModifiers;

-- insert or replace into ModifierArguments (ModifierId, Name, Value)
-- 	select PlantationAttachModifierId, 'ModifierId', IndustryModifierId
-- from HD_ChateauResourceModifiers;