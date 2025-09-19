-------------------------------------
--	Monopoly Adjustment	--
-------------------------------------

insert or replace into GlobalParameters
	(Name,																								Value)
values 
	('MONOPOLY_REQUIRED_RESOURCE_CONTROL_PERCENTAGE',			201),
	('MONOPOLY_REQUIRED_RESOURCE_CONTROL_PERCENTAGE_MED',	201),
	('MONOPOLY_REQUIRED_RESOURCE_CONTROL_PERCENTAGE_MAX',	201);

-- Rewrite industry and corp effects
insert or replace into HDMonopolyResourceEffects
	(ResourceType,  Category,   IndustryEffect,				CorporationEffect)
select
	ResourceType,   'AMENITY',  'INDUSTRY_HD_AMENITY_BONUS',	'CORPORATION_HD_AMENITY_BONUS' -- Default
from Resources where ResourceClassType = 'RESOURCECLASS_LUXURY'
	and (Frequency != 0 or SeaFrequency != 0);

update HDMonopolyResourceEffects set Category = 'GROWTH',
	IndustryEffect = 'INDUSTRY_HD_GROWTH_BONUS',
	CorporationEffect = 'CORPORATION_HD_GROWTH_BONUS'
	where ResourceType = 'RESOURCE_SPICES'
	or ResourceType = 'RESOURCE_SALT'
	or ResourceType = 'RESOURCE_SUGAR'
	or ResourceType = 'RESOURCE_HONEY'
	or ResourceType = 'RESOURCE_LEU_P0K_QUINOA'
	or ResourceType = 'RESOURCE_P0K_MAPLE';
update HDMonopolyResourceEffects set Category = 'FAITH', 
	IndustryEffect = 'INDUSTRY_HD_FAITH_BONUS',
	CorporationEffect = 'CORPORATION_HD_FAITH_BONUS'
	where ResourceType = 'RESOURCE_INCENSE'
	or ResourceType = 'RESOURCE_TOBACCO'
	or ResourceType = 'RESOURCE_DYES'
	or ResourceType = 'RESOURCE_LEU_P0K_COCA'
	or ResourceType = 'RESOURCE_C_ZEBU';
update HDMonopolyResourceEffects set Category = 'GPP',
	IndustryEffect = 'INDUSTRY_HD_GPP_BONUS',
	CorporationEffect = 'CORPORATION_HD_GPP_BONUS'
	where ResourceType = 'RESOURCE_WINE'
	or ResourceType = 'RESOURCE_COCOA'
	or ResourceType = 'RESOURCE_COFFEE'
	or ResourceType = 'RESOURCE_TEA'
	or ResourceType = 'RESOURCE_LEU_P0K_YERBAMATE'
	or ResourceType = 'RESOURCE_P0K_PLUMS';
update HDMonopolyResourceEffects set Category = 'TRADER',
	IndustryEffect = 'INDUSTRY_HD_TRADER_BONUS',
	CorporationEffect = 'CORPORATION_HD_TRADER_BONUS'
	where ResourceType = 'RESOURCE_SILK'
	or ResourceType = 'RESOURCE_SILVER'
	or ResourceType = 'RESOURCE_GOLD'
	or ResourceType = 'RESOURCE_DIAMONDS';
update HDMonopolyResourceEffects set Category = 'FOOD',
	IndustryEffect = 'INDUSTRY_HD_FOOD_BONUS',
	CorporationEffect = 'CORPORATION_HD_FOOD_BONUS'
	where ResourceType = 'RESOURCE_CITRUS'
	or ResourceType = 'RESOURCE_TRUFFLES'
	or ResourceType = 'RESOURCE_CVS_POMEGRANATES'
	or ResourceType = 'RESOURCE_SUK_CHEESE'
	or ResourceType = 'RESOURCE_SUK_CAVIAR';
-- Default: Amenity, RESOURCE_COTTON, RESOURCE_FURS, RESOURCE_OLIVES
update HDMonopolyResourceEffects set Category = 'WONDER',
	IndustryEffect = 'INDUSTRY_HD_WONDER_BONUS',
	CorporationEffect = 'CORPORATION_HD_WONDER_BONUS'
	where ResourceType = 'RESOURCE_MARBLE'
	or ResourceType = 'RESOURCE_GYPSUM'
	or ResourceType = 'RESOURCE_MERCURY'
	or ResourceType = 'RESOURCE_SUK_CORAL'
	or ResourceType = 'RESOURCE_SUK_OBSIDIAN';
update HDMonopolyResourceEffects set Category = 'TOURISM',
	IndustryEffect = 'INDUSTRY_HD_TOURISM_BONUS',
	CorporationEffect = 'CORPORATION_HD_TOURISM_BONUS'
	where ResourceType = 'RESOURCE_IVORY'
	or ResourceType = 'RESOURCE_JADE'
	or ResourceType = 'RESOURCE_AMBER'
	or ResourceType = 'RESOURCE_P0K_OPAL';
update HDMonopolyResourceEffects set Category = 'FISHERY',
	IndustryEffect = 'INDUSTRY_HD_FISHERY_BONUS',
	CorporationEffect = 'CORPORATION_HD_FISHERY_BONUS'
	where ResourceType = 'RESOURCE_TURTLES'
	or ResourceType = 'RESOURCE_PEARLS'
	or ResourceType = 'RESOURCE_SUK_SHARK'
	or ResourceType = 'RESOURCE_SUK_LOBSTER'
	or ResourceType = 'RESOURCE_SUK_RAYS';

------------------- Resourceful2 -------------------
-- Resource categories
	-- 食品生产类
update HDMonopolyResourceEffects set Category = 'GROWTH',
	IndustryEffect = 'INDUSTRY_HD_GROWTH_BONUS',
	CorporationEffect = 'CORPORATION_HD_GROWTH_BONUS'
	where (ResourceType = 'RESOURCE_SORGHUM' or ResourceType = 'RESOURCE_HAM');
	-- 祭祀用品类
update HDMonopolyResourceEffects set Category = 'FAITH', 
	IndustryEffect = 'INDUSTRY_HD_FAITH_BONUS',
	CorporationEffect = 'CORPORATION_HD_FAITH_BONUS'
	where (ResourceType = 'RESOURCE_SANDALWOOD'
		or ResourceType = 'RESOURCE_EBONY'
		or ResourceType = 'RESOURCE_C_ZEBU');
	-- 通货类
update HDMonopolyResourceEffects set Category = 'TRADER', 
	IndustryEffect = 'INDUSTRY_HD_TRADER_BONUS',
	CorporationEffect = 'CORPORATION_HD_TRADER_BONUS'
	where (ResourceType = 'RESOURCE_SEASHELLS');
	-- 高档食品类
update HDMonopolyResourceEffects set Category = 'FOOD',
	IndustryEffect = 'INDUSTRY_HD_FOOD_BONUS',
	CorporationEffect = 'CORPORATION_HD_FOOD_BONUS'
	where (ResourceType = 'RESOURCE_STRAWBERRY'
		or ResourceType = 'RESOURCE_SUK_ABALONE');
	-- 建筑材料类
update HDMonopolyResourceEffects set Category = 'WONDER',
	IndustryEffect = 'INDUSTRY_HD_WONDER_BONUS',
	CorporationEffect = 'CORPORATION_HD_WONDER_BONUS'
	where (ResourceType = 'RESOURCE_BAMBOO'
		or ResourceType = 'RESOURCE_ALABASTER'
		or ResourceType = 'RESOURCE_QUARTZ');
	-- 首饰类
update HDMonopolyResourceEffects set Category = 'TOURISM',
	IndustryEffect = 'INDUSTRY_HD_TOURISM_BONUS',
	CorporationEffect = 'CORPORATION_HD_TOURISM_BONUS'
	where (ResourceType = 'RESOURCE_LAPIS'
		or ResourceType = 'RESOURCE_RUBY'
		or ResourceType = 'RESOURCE_PLATINUM' 
		or ResourceType = 'RESOURCE_PEARLS');
	-- 海产类
update HDMonopolyResourceEffects set Category = 'FISHERY',
	IndustryEffect = 'INDUSTRY_HD_FISHERY_BONUS',
	CorporationEffect = 'CORPORATION_HD_FISHERY_BONUS'
	where (ResourceType = 'RESOURCE_SEA_URCHIN'
		or ResourceType = 'RESOURCE_COD'
		or ResourceType = 'RESOURCE_SALMON');
	-- 娱乐观赏类
update HDMonopolyResourceEffects set Category = 'ENTERTAINMENT',
	IndustryEffect = 'INDUSTRY_HD_ENTERTAINMENT_BONUS',
	CorporationEffect = 'CORPORATION_HD_ENTERTAINMENT_BONUS'
	where (ResourceType = 'RESOURCE_WOLF'
		or ResourceType = 'RESOURCE_TIGER' 
		or ResourceType = 'RESOURCE_SAKURA'
		or ResourceType = 'RESOURCE_LEU_P0K_CAPYBARAS' 
		or ResourceType = 'RESOURCE_POPPIES' 
		or ResourceType = 'RESOURCE_ORCA' 
		or ResourceType = 'RESOURCE_LION' 
		or ResourceType = 'RESOURCE_P0K_PENGUINS'
		or ResourceType = 'RESOURCE_C_HEAVENLY_HORSE')
	and exists (select ResourceType from Resources where ResourceType = 'RESOURCE_GRANITE');
    -- 药材类
update HDMonopolyResourceEffects set Category = 'MEDICINE',
	IndustryEffect = 'INDUSTRY_HD_MEDICINE_BONUS',
	CorporationEffect = 'CORPORATION_HD_MEDICINE_BONUS'
	where (ResourceType = 'RESOURCE_TRAVERTINE'
		or ResourceType = 'RESOURCE_TOXINS' 
		or ResourceType = 'RESOURCE_SAFFRON' 
		or ResourceType = 'RESOURCE_ALOE' 
		or ResourceType = 'RESOURCE_MEDIHERBS'
		or ResourceType = 'RESOURCE_WHALES'
		or ResourceType = 'RESOURCE_LEU_P0K_COCA')
	and exists (select ResourceType from Resources where ResourceType = 'RESOURCE_GRANITE');
------------------- Resourceful2 -------------------

-- ====================
-- Requirements
-- ====================

insert or ignore into RequirementSetRequirements
	(RequirementSetId,																									RequirementId)
select
	'HD_CITY_HAS_IMPROVED_TRADER_ENTERTAINMENT_RESOURCE_REQUIRMENTS',		'REQUIRES_HD_CITY_HAS_IMPROVED_ENTERTAINMENT_RESOURCE'
where exists (select Category from HDMonopolyResourceClasses where Category = 'ENTERTAINMENT');

insert or replace into RequirementSets (RequirementSetId, RequirementSetType)
	select 'HD_' || Category || '_BONUS_REQUIREMENTS', 'REQUIREMENTSET_TEST_ANY' from HDMonopolyResourceClasses;
insert or replace into RequirementSetRequirements (RequirementSetId, RequirementId)
	select 'HD_' || Category || '_BONUS_REQUIREMENTS', 'REQUIRES_' || ResourceType || '_IN_PLOT' from HDMonopolyResourceEffects;

-- ====================
-- INDUSTRY and CORPORATION
-- ====================
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

insert or ignore into ImprovementModifiers
	(ImprovementType,           ModifierId)
values
	('IMPROVEMENT_CORPORATION',	'IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_1'),
	('IMPROVEMENT_CORPORATION',	'IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_2'),
	('IMPROVEMENT_CORPORATION',	'IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_3'),
	('IMPROVEMENT_CORPORATION',	'IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_1'),
	('IMPROVEMENT_CORPORATION',	'IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_2'),
	('IMPROVEMENT_CORPORATION',	'IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_3');

insert or ignore into Modifiers
	(ModifierId,                                            ModifierType,                               SubjectRequirementSetId)
values
	('IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_1',	'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'CITY_HAS_DISTRICT_COMMERCIAL_HUB_TIER_1_BUILDING_REQUIREMENTS'),
	('IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_2',	'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'CITY_HAS_DISTRICT_COMMERCIAL_HUB_TIER_2_BUILDING_REQUIREMENTS'),
	('IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_3',	'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'CITY_HAS_DISTRICT_COMMERCIAL_HUB_TIER_3_BUILDING_REQUIREMENTS'),
	('IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_1',					'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'HD_CITY_HAS_HARBOR_TIER_1_BUILDING_REQUIREMENTS'),
	('IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_2',					'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'HD_CITY_HAS_HARBOR_TIER_2_BUILDING_REQUIREMENTS'),
	('IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_3',					'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS',	'HD_CITY_HAS_HARBOR_TIER_3_BUILDING_REQUIREMENTS');

insert or ignore into ModifierArguments
	(ModifierId,                                            Name,         Value)
values
	('IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_1',	'YieldType',	'YIELD_GOLD'),
	('IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_1',	'Amount',			3),
	('IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_2',	'YieldType',	'YIELD_GOLD'),
	('IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_2',	'Amount',			3),
	('IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_3',	'YieldType',	'YIELD_GOLD'),
	('IMPROVEMENT_CORPORATION_GOLD_COMMERCIAL_HUB_TIER_3',	'Amount',			3),
	('IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_1',					'YieldType',	'YIELD_GOLD'),
	('IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_1',					'Amount',			3),
	('IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_2',					'YieldType',	'YIELD_GOLD'),
	('IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_2',					'Amount',			3),
	('IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_3',					'YieldType',	'YIELD_GOLD'),
	('IMPROVEMENT_CORPORATION_GOLD_HARBOR_TIER_3',					'Amount',			3);

insert or replace into Adjacency_YieldChanges
	(ID,										Description,								YieldType,			YieldChange,	TilesRequired,  AdjacentImprovement)
values
	('HD_INDUSTRY_INDUSTRIAL_PRODUCTION',	'LOC_HD_INDUSTRY_INDUSTRIAL_PRODUCTION',	'YIELD_PRODUCTION',	1,			1,			'IMPROVEMENT_INDUSTRY'),
	('HD_INDUSTRY_COMMERCIAL_GOLD',			'LOC_HD_INDUSTRY_COMMERCIAL_GOLD',		'YIELD_GOLD',			1,			1,			'IMPROVEMENT_INDUSTRY'),
	('HD_INDUSTRY_HARBOR_GOLD',				'LOC_HD_INDUSTRY_HARBOR_GOLD',			'YIELD_GOLD',			1,			1,			'IMPROVEMENT_INDUSTRY'),
	('HD_CORPORATION_INDUSTRIAL_PRODUCTION',	'LOC_HD_CORPORATION_INDUSTRIAL_PRODUCTION', 'YIELD_PRODUCTION',	2,			1,			'IMPROVEMENT_CORPORATION'),
	('HD_CORPORATION_COMMERCIAL_GOLD',		'LOC_HD_CORPORATION_COMMERCIAL_GOLD',	'YIELD_GOLD',			2,			1,			'IMPROVEMENT_CORPORATION'),
	('HD_CORPORATION_HARBOR_GOLD',			'LOC_HD_CORPORATION_HARBOR_GOLD',		'YIELD_GOLD',			2,			1,			'IMPROVEMENT_CORPORATION');

insert or replace into District_Adjacencies
	(DistrictType,				YieldChangeId)
values
	('DISTRICT_INDUSTRIAL_ZONE',	'HD_INDUSTRY_INDUSTRIAL_PRODUCTION'),
	('DISTRICT_HANSA',			'HD_INDUSTRY_INDUSTRIAL_PRODUCTION'),

	('DISTRICT_COMMERCIAL_HUB',	'HD_INDUSTRY_COMMERCIAL_GOLD'),
	('DISTRICT_SUGUBA',			'HD_INDUSTRY_COMMERCIAL_GOLD'),

	('DISTRICT_HARBOR',			'HD_INDUSTRY_HARBOR_GOLD'),
	('DISTRICT_ROYAL_NAVY_DOCKYARD','HD_INDUSTRY_HARBOR_GOLD'),
	('DISTRICT_COTHON',			'HD_INDUSTRY_HARBOR_GOLD'),

	('DISTRICT_INDUSTRIAL_ZONE',	'HD_CORPORATION_INDUSTRIAL_PRODUCTION'),
	('DISTRICT_HANSA',			'HD_CORPORATION_INDUSTRIAL_PRODUCTION'),

	('DISTRICT_COMMERCIAL_HUB',	'HD_CORPORATION_COMMERCIAL_GOLD'),
	('DISTRICT_SUGUBA',			'HD_CORPORATION_COMMERCIAL_GOLD'),

	('DISTRICT_HARBOR',			'HD_CORPORATION_HARBOR_GOLD'),
	('DISTRICT_ROYAL_NAVY_DOCKYARD','HD_CORPORATION_HARBOR_GOLD'),
	('DISTRICT_COTHON',			'HD_CORPORATION_HARBOR_GOLD');

insert or replace into District_Adjacencies
	(DistrictType,				YieldChangeId)
select
	DistrictType,				'HD_INDUSTRY_INDUSTRIAL_PRODUCTION'
from Districts
where DistrictType = 'DISTRICT_OPPIDUM';

insert or replace into District_Adjacencies
	(DistrictType,				YieldChangeId)
select
	DistrictType,				'HD_CORPORATION_INDUSTRIAL_PRODUCTION'
from Districts
where DistrictType = 'DISTRICT_OPPIDUM';

-- 行业效果
delete from ImprovementModifiers where
	ImprovementType = 'IMPROVEMENT_INDUSTRY' and ModifierID like 'INDUSTRY_%';
delete from ImprovementModifiers where
	ImprovementType = 'IMPROVEMENT_CORPORATION' and ModifierID like 'CORPORATION_%';

create table HD_IndustryModifiers (
	Category text not null,
	ModifierId text not null,
	primary key (Category, ModifierId)
);
insert or replace into HD_IndustryModifiers
	(Category,			ModifierId)
values
	('GROWTH',			'INDUSTRY_HD_GROWTH_BONUS_FOOD'),
	('GROWTH',			'INDUSTRY_HD_GROWTH_BONUS_POP_FOOD'),
	('FAITH',			'INDUSTRY_HD_FAITH_BONUS_FAITH'),
	('FAITH',			'INDUSTRY_HD_FAITH_BONUS_GOLD'),
	('GPP',				'INDUSTRY_HD_GPP_BONUS_POP_SCIENCE'),
	('GPP',				'INDUSTRY_HD_GPP_BONUS_POP_CULTURE'),
	('GPP',				'INDUSTRY_HD_GPP_BONUS_POP_SCIENCE_N'),
	('GPP',				'INDUSTRY_HD_GPP_BONUS_POP_CULTURE_N'),
	('TRADER',			'INDUSTRY_HD_TRADER_BONUS_CAPACITY'),
	('TRADER',			'INDUSTRY_HD_TRADER_BONUS_COMMERCIAL'),
	('TRADER',			'INDUSTRY_HD_TRADER_BONUS_HARBOR'),
	('FOOD',			'INDUSTRY_HD_FOOD_BONUS_FOOD'),
	('FOOD',			'INDUSTRY_HD_FOOD_BONUS_GOLD'),
	('AMENITY',			'INDUSTRY_HD_AMENITY_BONUS_PRODUCTION'),
	('AMENITY',			'INDUSTRY_HD_AMENITY_BONUS_POP_PRODUCTION'),
	('WONDER',			'INDUSTRY_HD_WONDER_BONUS'),
	('WONDER',			'INDUSTRY_HD_WONDER_BONUS_DISTRICT'),
	('TOURISM',			'INDUSTRY_HD_TOURISM_BONUS_CULTURE'),
	('TOURISM',			'INDUSTRY_HD_TOURISM_BONUS_GOLD'),
	('FISHERY',			'INDUSTRY_HD_FISHERY_BONUS'),
	('FISHERY',			'INDUSTRY_HD_FISHERY_BONUS_FOOD'),
	('FISHERY',			'INDUSTRY_HD_FISHERY_BONUS_PROD'),
	('MEDICINE',		'INDUSTRY_HD_MEDICINE_BONUS_SCIENCE'),
	('MEDICINE',		'INDUSTRY_HD_MEDICINE_BONUS_FAITH');

-- 娱乐观赏行业区域产出
insert or replace into HD_IndustryModifiers (Category, ModifierId)
	select 'ENTERTAINMENT', 'INDUSTRY_HD_ENTERTAINMENT_BONUS_1_' || DistrictType
from DistrictCorrespondingYieldType_HD;

insert or replace into HD_IndustryModifiers (Category, ModifierId)
	select 'ENTERTAINMENT', 'INDUSTRY_HD_ENTERTAINMENT_BONUS_2_' || DistrictType
from DistrictCorrespondingYieldType_HD;

-- 设置 plot property 记录城市行业类别
insert or replace into HD_IndustryModifiers (Category, ModifierId)
	select Category, 'INDUSTRY_HD_' || Category || '_SET_PROPERTY' from HDMonopolyResourceClasses;
insert or replace into Modifiers (ModifierId, ModifierType)
	select 'INDUSTRY_HD_' || Category || '_SET_PROPERTY', 'MODIFIER_SINGLE_CITY_ADJUST_PROPERTY' from HDMonopolyResourceClasses;
insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'INDUSTRY_HD_' || Category || '_SET_PROPERTY', 'Key', 'HD_CITY_HAS_' || Category || '_INDUSTRY' from HDMonopolyResourceClasses;
insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'INDUSTRY_HD_' || Category || '_SET_PROPERTY', 'Amount', 1 from HDMonopolyResourceClasses;

-- 删除不存在的类别的效果
delete from HD_IndustryModifiers where Category not in (select Category from HDMonopolyResourceEffects);

-- 给行业改良贴效果
insert or replace into ImprovementModifiers (ImprovementType, ModifierId)
	select 'IMPROVEMENT_INDUSTRY', ModifierId || '_ATTACH'
from HD_IndustryModifiers;

insert or replace into Modifiers (ModifierId, ModifierType, OwnerRequirementSetId)
	select ModifierId || '_ATTACH', 'MODIFIER_SINGLE_CITY_ATTACH_MODIFIER', 'HD_' || Category || '_BONUS_REQUIREMENTS'
from HD_IndustryModifiers;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select ModifierId || '_ATTACH', 'ModifierId', ModifierId
from HD_IndustryModifiers;

-- Modifers
insert or replace into Modifiers
	(ModifierId,								ModifierType,														SubjectRequirementSetId)
values
	('INDUSTRY_HD_GROWTH_BONUS_FOOD',		'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',		'PLOT_DOES_NOT_HAVE_INCOMPLETE_WONDER'),
	('INDUSTRY_HD_GROWTH_BONUS_POP_FOOD',		'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',		NULL),
	('INDUSTRY_HD_FAITH_BONUS_FAITH',			'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',		NULL),
	('INDUSTRY_HD_FAITH_BONUS_GOLD',			'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',		NULL),
	('INDUSTRY_HD_GPP_BONUS_POP_SCIENCE',		'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',		NULL),
	('INDUSTRY_HD_GPP_BONUS_POP_CULTURE',		'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',		NULL),
	('INDUSTRY_HD_GPP_BONUS_POP_SCIENCE_N',		'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',		'REQUIRES_CITY_HAS_DISTRICT_NEIGHBORHOOD_UDMET'),
	('INDUSTRY_HD_GPP_BONUS_POP_CULTURE_N',		'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',		'REQUIRES_CITY_HAS_DISTRICT_NEIGHBORHOOD_UDMET'),
	('INDUSTRY_HD_TRADER_BONUS_CAPACITY',		'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY',					null),
	('INDUSTRY_HD_TRADER_BONUS_COMMERCIAL',		'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_MODIFIER',				'REQUIRES_DISTRICT_IS_DISTRICT_COMMERCIAL_HUB_UDMET'),
	('INDUSTRY_HD_TRADER_BONUS_HARBOR',			'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_MODIFIER',				'REQUIRES_DISTRICT_IS_DISTRICT_HARBOR_UDMET'),
	('INDUSTRY_HD_FOOD_BONUS_FOOD',					'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',					Null),
	('INDUSTRY_HD_FOOD_BONUS_GOLD',					'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',					Null),
	('INDUSTRY_HD_AMENITY_BONUS_PRODUCTION',				'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',				'PLOT_DOES_NOT_HAVE_INCOMPLETE_WONDER'),
	('INDUSTRY_HD_AMENITY_BONUS_POP_PRODUCTION',				'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_PER_POPULATION',				NULL),
	('INDUSTRY_HD_WONDER_BONUS',				'MODIFIER_SINGLE_CITY_ADJUST_WONDER_PRODUCTION',				NULL),
	('INDUSTRY_HD_WONDER_BONUS_DISTRICT',				'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_MODIFIER',				'REQUIRES_DISTRICT_IS_DISTRICT_INDUSTRIAL_ZONE_UDMET'),
	('INDUSTRY_HD_TOURISM_BONUS_CULTURE',		'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',					'PLOT_DOES_NOT_HAVE_INCOMPLETE_WONDER'),
	('INDUSTRY_HD_TOURISM_BONUS_GOLD',			'MODIFIER_CITY_DISTRICTS_ADJUST_YIELD_CHANGE',					'PLOT_DOES_NOT_HAVE_INCOMPLETE_WONDER'),
	('INDUSTRY_HD_FISHERY_BONUS',				'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',					'PLOT_HAS_FISHINGBOATS_REQUIREMENTS'),
	('INDUSTRY_HD_FISHERY_BONUS_FOOD',			'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',					'PLOT_HAS_FISHINGBOATS_REQUIREMENTS'),
	('INDUSTRY_HD_FISHERY_BONUS_PROD',			'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',					'PLOT_HAS_FISHINGBOATS_REQUIREMENTS');
insert or replace into ModifierArguments
	(ModifierId,								Name,			Value)
values
	('INDUSTRY_HD_GROWTH_BONUS_FOOD',		'YieldType',	'YIELD_FOOD'),
	('INDUSTRY_HD_GROWTH_BONUS_FOOD',		'Amount',		1),
	('INDUSTRY_HD_GROWTH_BONUS_POP_FOOD',		'YieldType',	'YIELD_FOOD'),
	('INDUSTRY_HD_GROWTH_BONUS_POP_FOOD',		'Amount',		0.5),
	('INDUSTRY_HD_FAITH_BONUS_FAITH',			'YieldType',	'YIELD_FAITH'),
	('INDUSTRY_HD_FAITH_BONUS_FAITH',			'Amount',		1),
	('INDUSTRY_HD_FAITH_BONUS_GOLD',			'YieldType',	'YIELD_GOLD'),
	('INDUSTRY_HD_FAITH_BONUS_GOLD',			'Amount',		3),
	('INDUSTRY_HD_GPP_BONUS_POP_SCIENCE',		'YieldType',	'YIELD_SCIENCE'),
	('INDUSTRY_HD_GPP_BONUS_POP_SCIENCE',		'Amount',		0.5),
	('INDUSTRY_HD_GPP_BONUS_POP_CULTURE',		'YieldType',	'YIELD_CULTURE'),
	('INDUSTRY_HD_GPP_BONUS_POP_CULTURE',		'Amount',		0.5),
	('INDUSTRY_HD_GPP_BONUS_POP_SCIENCE_N',		'YieldType',	'YIELD_SCIENCE'),
	('INDUSTRY_HD_GPP_BONUS_POP_SCIENCE_N',		'Amount',		0.5),
	('INDUSTRY_HD_GPP_BONUS_POP_CULTURE_N',		'YieldType',	'YIELD_CULTURE'),
	('INDUSTRY_HD_GPP_BONUS_POP_CULTURE_N',		'Amount',		0.5),
	('INDUSTRY_HD_TRADER_BONUS_CAPACITY',		'Amount',		1),
	('INDUSTRY_HD_TRADER_BONUS_COMMERCIAL',		'YieldType',	'YIELD_GOLD'),
	('INDUSTRY_HD_TRADER_BONUS_COMMERCIAL', 	'Amount',  		100),
	('INDUSTRY_HD_TRADER_BONUS_HARBOR', 		'YieldType',	'YIELD_GOLD'),
	('INDUSTRY_HD_TRADER_BONUS_HARBOR', 		'Amount',  		100),
	('INDUSTRY_HD_FOOD_BONUS_FOOD',					'YieldType',	'YIELD_FOOD'),
	('INDUSTRY_HD_FOOD_BONUS_FOOD',					'Amount',		10),
	('INDUSTRY_HD_FOOD_BONUS_GOLD',					'YieldType',	'YIELD_GOLD'),
	('INDUSTRY_HD_FOOD_BONUS_GOLD',					'Amount',		10),
	('INDUSTRY_HD_AMENITY_BONUS_PRODUCTION',		'YieldType',	'YIELD_PRODUCTION'),
	('INDUSTRY_HD_AMENITY_BONUS_PRODUCTION',		'Amount',		1),
	('INDUSTRY_HD_AMENITY_BONUS_POP_PRODUCTION',		'YieldType',	'YIELD_PRODUCTION'),
	('INDUSTRY_HD_AMENITY_BONUS_POP_PRODUCTION',		'Amount',		0.5),
	('INDUSTRY_HD_WONDER_BONUS',				'Amount',		20),
	('INDUSTRY_HD_WONDER_BONUS_DISTRICT', 		'YieldType',   'YIELD_PRODUCTION'),
	('INDUSTRY_HD_WONDER_BONUS_DISTRICT', 		'Amount',		100),
	('INDUSTRY_HD_TOURISM_BONUS_CULTURE',  		'YieldType',	'YIELD_CULTURE'),
	('INDUSTRY_HD_TOURISM_BONUS_CULTURE',  		'Amount',		1),
	('INDUSTRY_HD_TOURISM_BONUS_GOLD',  		'YieldType',	'YIELD_GOLD'),
	('INDUSTRY_HD_TOURISM_BONUS_GOLD',  		'Amount',		3),
	('INDUSTRY_HD_FISHERY_BONUS',				'YieldType',	'YIELD_GOLD'),
	('INDUSTRY_HD_FISHERY_BONUS',				'Amount',		3),
	('INDUSTRY_HD_FISHERY_BONUS_FOOD',  		'YieldType',	'YIELD_FOOD'),
	('INDUSTRY_HD_FISHERY_BONUS_FOOD',  		'Amount',		1),
	('INDUSTRY_HD_FISHERY_BONUS_PROD',  		'YieldType',	'YIELD_PRODUCTION'),
	('INDUSTRY_HD_FISHERY_BONUS_PROD',  		'Amount',		1);

-- 公司效果
create table HD_CorporationModifiers (
	Category text not null,
	ModifierId text not null,
	primary key (Category, ModifierId)
);
insert or replace into HD_CorporationModifiers
	(Category,			ModifierId)
values
	('GROWTH',			'CORPORATION_HD_GROWTH_BONUS'),
	('GROWTH',			'CORPORATION_HD_GROWTH_BONUS_TRADE_FOOD'),
	('FAITH',			'CORPORATION_HD_FAITH_BONUS_HOLY_SITE'),
	('FAITH',			'CORPORATION_HD_FAITH_BONUS_TRADE_ROUTE'),
	('GPP',				'CORPORATION_HD_GPP_BONUS'),
	('TRADER',			'CORPORATION_HD_TRADER_BONUS'),
	('TRADER',			'CORPORATION_HD_TRADER_BONUS_GOLD'),
	('TRADER',			'CORPORATION_HD_TRADER_BONUS_GPP'),
	('FOOD',			'CORPORATION_HD_FOOD_BONUS_DISTRICT_FOOD'),
	('FOOD',			'CORPORATION_HD_FOOD_BONUS_DISTRICT_GOLD'),
	('AMENITY',			'CORPORATION_HD_AMENITY_BONUS_EXTRA_AMENITY1'),
	('AMENITY',			'CORPORATION_HD_AMENITY_BONUS_EXTRA_AMENITY2'),
	('AMENITY',			'CORPORATION_HD_AMENITY_BONUS_TRADE_PRODUCTION'),
	('WONDER',			'CORPORATION_HD_WONDER_BONUS'),
	('WONDER',			'CORPORATION_HD_WONDER_BONUS_DISTRICT'),
	('WONDER',			'CORPORATION_HD_WONDER_BONUS_GPP'),
	('FISHERY',			'CORPORATION_HD_FISHERY_BONUS'),
	('FISHERY',			'CORPORATION_HD_FISHERY_BONUS_AMENITY3'),
	('ENTERTAINMENT',	'CORPORATION_HD_ENTERTAINMENT_BONUS_IMPROVEMENT_ATTACH'),
	('ENTERTAINMENT',	'CORPORATION_HD_ENTERTAINMENT_BONUS_NATIONALPARK'),
	('ENTERTAINMENT',	'CORPORATION_HD_ENTERTAINMENT_BONUS_WONDER_ATTACH'),
	('MEDICINE',		'CORPORATION_HD_MEDICINE_BONUS_EUREKA'),
	('MEDICINE',		'CORPORATION_HD_MEDICINE_BONUS_EUREKA_RECORD');

-- 首饰公司巨作业绩
insert or replace into HD_CorporationModifiers (Category, ModifierId)
	select 'TOURISM', 'CORPORATION_HD_TOURISM_BONUS_' || GreatWorkObjectType
from GreatWorkObjectTypes;

-- 首饰公司建筑产出
insert or replace into HD_CorporationModifiers (Category, ModifierId)
	select 'TOURISM', 'CORPORATION_HD_TOURISM_BONUS_1_' || BuildingType
from Buildings where PrereqDistrict = 'DISTRICT_INDUSTRIAL_ZONE' and TraitType is null and BuildingType not like 'BUILDING_%_DUMMY%' and Cost != 0;

insert or replace into HD_CorporationModifiers (Category, ModifierId)
	select 'TOURISM', 'CORPORATION_HD_TOURISM_BONUS_2_' || BuildingType
from Buildings where PrereqDistrict = 'DISTRICT_INDUSTRIAL_ZONE' and TraitType is null and BuildingType not like 'BUILDING_%_DUMMY%' and Cost != 0;

-- 娱乐观赏公司区域伟人点
insert or replace into HD_CorporationModifiers (Category, ModifierId)
	select 'ENTERTAINMENT', 'CORPORATION_HD_ENTERTAINMENT_BONUS_' || DistrictType || '_' || GreatPersonClassType
from DistrictCorrespondingGPP_HD;

-- 药材公司建筑产出
insert or replace into HD_CorporationModifiers (Category, ModifierId)
	select 'MEDICINE', 'CORPORATION_HD_MEDICINE_BONUS_' || BuildingType
from Buildings where PrereqDistrict = 'DISTRICT_CAMPUS' and TraitType is null and BuildingType not like 'BUILDING_%_DUMMY%' and Cost != 0;

-- 删除不存在的类别的效果
delete from HD_CorporationModifiers where Category not in (select Category from HDMonopolyResourceEffects);

-- 给公司改良贴效果
insert or replace into ImprovementModifiers (ImprovementType, ModifierId)
	select 'IMPROVEMENT_CORPORATION', ModifierId || '_ATTACH'
from HD_IndustryModifiers;

insert or replace into ImprovementModifiers (ImprovementType, ModifierId)
	select 'IMPROVEMENT_CORPORATION', ModifierId || '_ATTACH'
from HD_CorporationModifiers;

insert or replace into Modifiers (ModifierId, ModifierType, OwnerRequirementSetId)
	select ModifierId || '_ATTACH', 'MODIFIER_SINGLE_CITY_ATTACH_MODIFIER', 'HD_' || Category || '_BONUS_REQUIREMENTS'
from HD_CorporationModifiers;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select ModifierId || '_ATTACH',	'ModifierId',	ModifierId
from HD_CorporationModifiers;

-- Modifers
insert or replace into Modifiers
	(ModifierId,							ModifierType,														SubjectRequirementSetId)
values
	('CORPORATION_HD_GROWTH_BONUS',					'MODIFIER_PLAYER_CITIES_ADJUST_CITY_GROWTH',					null),
	('CORPORATION_HD_GROWTH_BONUS_TRADE_FOOD',					'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_DOMESTIC',					null),
	('CORPORATION_HD_FAITH_BONUS_HOLY_SITE',		'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_MODIFIER',  			'DISTRICT_IS_DISTRICT_HOLY_SITE_REQUIREMENTS'),
	('CORPORATION_HD_FAITH_BONUS_TRADE_ROUTE',		'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD',  					null),
	('CORPORATION_HD_GPP_BONUS',					'MODIFIER_PLAYER_GOVERNMENT_FLAT_BONUS',						NULL),
	('CORPORATION_HD_TRADER_BONUS',					'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD',						NULL),
	('CORPORATION_HD_TRADER_BONUS_GOLD',					'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER',						NULL),
	('CORPORATION_HD_TRADER_BONUS_GPP',					'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS_PERCENT',						NULL),
	('CORPORATION_HD_FOOD_BONUS_DISTRICT_FOOD',					'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE',				'PLOT_IS_DISTRICT_ADJACENT_TO_RIVER_OR_ON_OR_ADJACENT_TO_COAST_REQUIREMENTS'),
	('CORPORATION_HD_FOOD_BONUS_DISTRICT_GOLD',					'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE',				'PLOT_IS_DISTRICT_ADJACENT_TO_RIVER_OR_ON_OR_ADJACENT_TO_COAST_REQUIREMENTS'),
	('CORPORATION_HD_AMENITY_BONUS_EXTRA_AMENITY1',		'MODIFIER_PLAYER_DISTRICTS_ADJUST_DISTRICT_AMENITY',					'REQUIRES_DISTRICT_IS_DISTRICT_ENTERTAINMENT_COMPLEX_UDMET'),
	('CORPORATION_HD_AMENITY_BONUS_EXTRA_AMENITY2',		'MODIFIER_PLAYER_DISTRICTS_ADJUST_DISTRICT_AMENITY',					'REQUIRES_DISTRICT_IS_DISTRICT_WATER_ENTERTAINMENT_COMPLEX_UDMET'),
	('CORPORATION_HD_AMENITY_BONUS_TRADE_PRODUCTION',		'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_DOMESTIC',					NULL),
	('CORPORATION_HD_WONDER_BONUS',					'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_PRODUCTION_MODIFIER',	NULL),
	('CORPORATION_HD_WONDER_BONUS_DISTRICT',  		'MODIFIER_PLAYER_CITIES_ADJUST_ALL_DISTRICTS_PRODUCTION',	NULL),
	('CORPORATION_HD_WONDER_BONUS_GPP',  		'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS_PERCENT',	NULL),
	('CORPORATION_HD_FISHERY_BONUS',				'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',							'HD_PLOT_FISHERY_CORP_REQUIREMENTS'),
	('CORPORATION_HD_FISHERY_BONUS_AMENITY3',		'MODIFIER_PLAYER_CITIES_ADJUST_TRAIT_AMENITY',					'HD_CITY_HAS_HARBOR_TIER_3_BUILDING_REQUIREMENTS');
insert or replace into ModifierArguments
	(ModifierId,									Name,			Value)
values
	('CORPORATION_HD_GROWTH_BONUS',					'Amount',		20),
	('CORPORATION_HD_GROWTH_BONUS_TRADE_FOOD',					'YieldType',		'YIELD_FOOD'),
	('CORPORATION_HD_GROWTH_BONUS_TRADE_FOOD',					'Amount',		4),
	('CORPORATION_HD_FAITH_BONUS_HOLY_SITE',		'YieldType',	'YIELD_FAITH'),
	('CORPORATION_HD_FAITH_BONUS_HOLY_SITE',		'Amount',		100),
	('CORPORATION_HD_FAITH_BONUS_TRADE_ROUTE',		'YieldType',	'YIELD_FAITH'),
	('CORPORATION_HD_FAITH_BONUS_TRADE_ROUTE',		'Amount',		4),
	('CORPORATION_HD_GPP_BONUS',					'BonusType',	'GOVERNMENTBONUS_GREAT_PEOPLE'),
	('CORPORATION_HD_GPP_BONUS',					'Amount',		50),
	('CORPORATION_HD_TRADER_BONUS',					'YieldType',	'YIELD_GOLD'),
	('CORPORATION_HD_TRADER_BONUS',					'Amount',		6),
	('CORPORATION_HD_TRADER_BONUS_GOLD',					'YieldType',	'YIELD_GOLD'),
	('CORPORATION_HD_TRADER_BONUS_GOLD',					'Amount',		10),
	('CORPORATION_HD_TRADER_BONUS_GPP',					'GreatPersonClassType',	'GREAT_PERSON_CLASS_MERCHANT'),
	('CORPORATION_HD_TRADER_BONUS_GPP',					'Amount',		50),
	('CORPORATION_HD_FOOD_BONUS_DISTRICT_FOOD',				'YieldType','YIELD_FOOD'),
	('CORPORATION_HD_FOOD_BONUS_DISTRICT_FOOD',				'Amount',		1),
	('CORPORATION_HD_FOOD_BONUS_DISTRICT_GOLD',				'YieldType','YIELD_GOLD'),
	('CORPORATION_HD_FOOD_BONUS_DISTRICT_GOLD',				'Amount',		3),
	('CORPORATION_HD_AMENITY_BONUS_EXTRA_AMENITY1',		'Amount',		1),
	('CORPORATION_HD_AMENITY_BONUS_EXTRA_AMENITY2',		'Amount',		1),
	('CORPORATION_HD_AMENITY_BONUS_TRADE_PRODUCTION',		'YieldType',		'YIELD_PRODUCTION'),
	('CORPORATION_HD_AMENITY_BONUS_TRADE_PRODUCTION',		'Amount',		4),
	('CORPORATION_HD_WONDER_BONUS',					'Amount',		10),
	('CORPORATION_HD_WONDER_BONUS_DISTRICT',			'Amount',		10),
	('CORPORATION_HD_WONDER_BONUS_GPP',			'GreatPersonClassType',		'GREAT_PERSON_CLASS_ENGINEER'),
	('CORPORATION_HD_WONDER_BONUS_GPP',			'Amount',		50),
	('CORPORATION_HD_FISHERY_BONUS',				'YieldType',	'YIELD_FOOD,YIELD_PRODUCTION'),
	('CORPORATION_HD_FISHERY_BONUS',				'Amount',		'1,1'),
	('CORPORATION_HD_FISHERY_BONUS_AMENITY3',		'Amount',		2);

-- 首饰公司巨作业绩
insert or replace into Modifiers (ModifierId, ModifierType)
	select 'CORPORATION_HD_TOURISM_BONUS_' || GreatWorkObjectType, 'MODIFIER_PLAYER_CITIES_ADJUST_TOURISM'
from GreatWorkObjectTypes;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'CORPORATION_HD_TOURISM_BONUS_' || GreatWorkObjectType, 'GreatWorkObjectType', GreatWorkObjectType
from GreatWorkObjectTypes;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'CORPORATION_HD_TOURISM_BONUS_' || GreatWorkObjectType, 'ScalingFactor', 150
from GreatWorkObjectTypes;

-- 首饰公司建筑产出
insert or ignore into Modifiers (ModifierId, ModifierType)
	select 'CORPORATION_HD_TOURISM_BONUS_1_' || BuildingType,	'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE'
from Buildings where PrereqDistrict = 'DISTRICT_INDUSTRIAL_ZONE' and TraitType is null and BuildingType not like 'BUILDING_%_DUMMY%' and Cost != 0;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'CORPORATION_HD_TOURISM_BONUS_1_' || BuildingType, 'BuildingType', BuildingType
from Buildings where PrereqDistrict = 'DISTRICT_INDUSTRIAL_ZONE' and TraitType is null and BuildingType not like 'BUILDING_%_DUMMY%' and Cost != 0;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'CORPORATION_HD_TOURISM_BONUS_1_' || BuildingType, 'YieldType', 'YIELD_CULTURE'
from Buildings where PrereqDistrict = 'DISTRICT_INDUSTRIAL_ZONE' and TraitType is null and BuildingType not like 'BUILDING_%_DUMMY%' and Cost != 0;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'CORPORATION_HD_TOURISM_BONUS_1_' || BuildingType, 'Amount', 2
from Buildings where PrereqDistrict = 'DISTRICT_INDUSTRIAL_ZONE' and TraitType is null and BuildingType not like 'BUILDING_%_DUMMY%' and Cost != 0;

insert or ignore into Modifiers (ModifierId, ModifierType)
	select 'CORPORATION_HD_TOURISM_BONUS_2_' || BuildingType,	'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE'
from Buildings where PrereqDistrict = 'DISTRICT_INDUSTRIAL_ZONE' and TraitType is null and BuildingType not like 'BUILDING_%_DUMMY%' and Cost != 0;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'CORPORATION_HD_TOURISM_BONUS_2_' || BuildingType, 'BuildingType', BuildingType
from Buildings where PrereqDistrict = 'DISTRICT_INDUSTRIAL_ZONE' and TraitType is null and BuildingType not like 'BUILDING_%_DUMMY%' and Cost != 0;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'CORPORATION_HD_TOURISM_BONUS_2_' || BuildingType, 'YieldType', 'YIELD_GOLD'
from Buildings where PrereqDistrict = 'DISTRICT_INDUSTRIAL_ZONE' and TraitType is null and BuildingType not like 'BUILDING_%_DUMMY%' and Cost != 0;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select 'CORPORATION_HD_TOURISM_BONUS_2_' || BuildingType, 'Amount', 6
from Buildings where PrereqDistrict = 'DISTRICT_INDUSTRIAL_ZONE' and TraitType is null and BuildingType not like 'BUILDING_%_DUMMY%' and Cost != 0;

----------------------------------------------------------------------------------------------------------------
-- 行业公司文本描述
delete from ResourceIndustries;
delete from ResourceCorporations;

create table 'HDResourceProducts'(
	'ResourceType' TEXT NOT NULL,
	'ResourceEffect' TEXT,
	'ResourceEffectTExt' TEXT,
	PRIMARY KEY(ResourceType)
	FOREIGN KEY(ResourceType) REFERENCES Resources(ResourceType) ON DELETE CASCADE ON UPDATE CASCADE
);
insert or replace into ResourceIndustries
	(ResourceType,  ResourceEffect, ResourceEffectTExt)
select
	ResourceType,   IndustryEffect, 'LOC_'||IndustryEffect||'_DESCRIPTION'
from HDMonopolyResourceEffects;
insert or replace into ResourceCorporations
	(ResourceType,  ResourceEffect, ResourceEffectTExt)
select
	ResourceType,   CorporationEffect,  'LOC_'||CorporationEffect||'_DESCRIPTION'
from HDMonopolyResourceEffects;
insert or replace into HDResourceProducts
	(ResourceType,  ResourceEffect, ResourceEffectTExt)
select
	ResourceType,   ProductEffect,  'LOC_'||ProductEffect||'_DESCRIPTION'
from HDMonopolyResourceEffects where ProductEffect != 'NULL';

-- ====================
-- Products
-- ====================
delete from GreatWorkModifiers where GreatWorkType like 'GREATWORK_PRODUCT_%' and GreatWorkType not like 'GREATWORK_PRODUCT_BAVARIA_%';-- and ModifierID like 'PRODUCT_%'

delete from GreatWork_YieldChanges where GreatWorkType like 'GREATWORK_PRODUCT_%' and GreatWorkType not like 'GREATWORK_PRODUCT_BAVARIA_%';

delete from Projects_XP2 where ProjectType like 'PROJECT_CREATE_CORPORATION_PRODUCT_%';

-- ====================
-- Leugi Monopoly ++
-- ====================
update Technologies set Description = NULL where
	TechnologyType = 'TECH_CURRENCY';
	-- TechnologyType = 'TECH_MASS_PRODUCTION';
	-- or TechnologyType = 'TECH_ECONOMICS';

-- update Improvements set PrereqTech = 'TECH_APPRENTICESHIP' where ImprovementType = 'IMPROVEMENT_INDUSTRY';
-- update Improvements set PrereqTech = 'TECH_ECONOMICS' where ImprovementType = 'IMPROVEMENT_CORPORATION';

update Units set Cost = 190, CostProgressionParam1 = 10, MustPurchase = 0, PrereqTech = 'TECH_APPRENTICESHIP' where UnitType = 'UNIT_LEU_TYCOON';
update Units set Cost = 500, CostProgressionParam1 = 20, MustPurchase = 0 where UnitType = 'UNIT_LEU_INVESTOR';

delete from Unit_BuildingPrereqs where Unit = 'UNIT_LEU_TYCOON';
insert or replace into Unit_BuildingPrereqs
		(Unit,				PrereqBuilding)
select  UnitType,			'BUILDING_MARKET'
from Units where UnitType = 'UNIT_LEU_TYCOON';

insert or replace into Unit_BuildingPrereqs
		(Unit,				PrereqBuilding)
select  'UNIT_LEU_TYCOON',		CivUniqueBuildingType
from BuildingReplaces where ReplacesBuildingType = 'BUILDING_MARKET'
and exists (select UnitType from Units where UnitType = 'UNIT_LEU_TYCOON');

	-- JNR Commerce Adapt
insert or replace into Unit_BuildingPrereqs
		(Unit,				PrereqBuilding)
select  UnitType,			'BUILDING_LIGHTHOUSE'
from Units where UnitType = 'UNIT_LEU_TYCOON' 
and exists (select BuildingType from Buildings where BuildingType = 'BUILDING_LIGHTHOUSE');

insert or replace into Unit_BuildingPrereqs
		(Unit,				PrereqBuilding)
select  UnitType,			'BUILDING_JNR_MINT'
from Units where UnitType = 'UNIT_LEU_TYCOON' 
and exists (select BuildingType from Buildings where BuildingType = 'BUILDING_JNR_MINT');

insert or replace into Unit_BuildingPrereqs
		(Unit,				PrereqBuilding)
select  UnitType,			'BUILDING_JNR_WAYSTATION'
from Units where UnitType = 'UNIT_LEU_TYCOON' 
and exists (select BuildingType from Buildings where BuildingType = 'BUILDING_JNR_WAYSTATION');

insert or replace into Unit_BuildingPrereqs
		(Unit,				PrereqBuilding)
select  UnitType,			'BUILDING_SUKIENNICE'
from Units where UnitType = 'UNIT_LEU_TYCOON' 
and exists (select BuildingType from Buildings where BuildingType = 'BUILDING_SUKIENNICE');

insert or replace into Unit_BuildingPrereqs
		(Unit,				PrereqBuilding)
select  UnitType,			'BUILDING_JNR_FISH_MARKET'
from Units where UnitType = 'UNIT_LEU_INVESTOR' 
and exists (select BuildingType from Buildings where BuildingType = 'BUILDING_JNR_FISH_MARKET');

insert or replace into Unit_BuildingPrereqs
		(Unit,				PrereqBuilding)
select  UnitType,			'BUILDING_SHIPYARD'
from Units where UnitType = 'UNIT_LEU_INVESTOR' 
and exists (select BuildingType from Buildings where BuildingType = 'BUILDING_SHIPYARD');

insert or replace into Unit_BuildingPrereqs
		(Unit,				PrereqBuilding)
select  UnitType,			'BUILDING_JNR_GUILDHALL'
from Units where UnitType = 'UNIT_LEU_INVESTOR' 
and exists (select BuildingType from Buildings where BuildingType = 'BUILDING_JNR_GUILDHALL');

insert or replace into Unit_BuildingPrereqs
		(Unit,				PrereqBuilding)
select  UnitType,			'BUILDING_JNR_MERCHANT_QUARTER'
from Units where UnitType = 'UNIT_LEU_INVESTOR' 
and exists (select BuildingType from Buildings where BuildingType = 'BUILDING_JNR_MERCHANT_QUARTER');

update Units set Description = 'LOC_UNIT_LEU_TYCOON_JNR_DESCRIPTION' where UnitType = 'UNIT_LEU_TYCOON' 
	and exists (select BuildingType from Buildings where BuildingType = 'BUILDING_JNR_MERCHANT_QUARTER');
update Units set Description = 'LOC_UNIT_LEU_INVESTOR_JNR_DESCRIPTION' where UnitType = 'UNIT_LEU_INVESTOR' 
	and exists (select BuildingType from Buildings where BuildingType = 'BUILDING_JNR_MERCHANT_QUARTER');

-- Warehouse & Container Port
-- 仓库和集装箱码头
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

insert or replace into Improvement_ValidFeatures
	(ImprovementType,            FeatureType)
select
	'IMPROVEMENT_LEU_WAREHOUSE', FeatureType
from Features where FeatureType in (
	'FEATURE_JUNGLE', 'FEATURE_FOREST', 'FEATURE_JNR_SAVANNAH'
);

insert or replace into Improvement_ValidFeatures
	(ImprovementType,            			FeatureType)
select
	'IMPROVEMENT_LEU_CONTAINER_PORT', FeatureType
from Features where FeatureType in (
	'FEATURE_REEF', 'FEATURE_SUK_KELP'
);

delete from ImprovementModifiers where ModifierId like 'LEU_INVESTOR_CORPORATION_BOOST_%';

-- update Improvements set PrereqTech = 'TECH_ECONOMICS', SameAdjacentValid = 0, OnePerCity = 0 where -- RequiresAdjacentLuxury = 0
-- 	(ImprovementType = 'IMPROVEMENT_LEU_WAREHOUSE') or (ImprovementType = 'IMPROVEMENT_LEU_CONTAINER_PORT');

update Improvement_ValidBuildUnits set UnitType = 'UNIT_LEU_TYCOON' where
	ImprovementType in ('IMPROVEMENT_LEU_WAREHOUSE', 'IMPROVEMENT_LEU_CONTAINER_PORT');

update Improvement_YieldChanges set YieldChange = 6 where YieldType = 'YIELD_PRODUCTION' and
	ImprovementType in ('IMPROVEMENT_LEU_WAREHOUSE', 'IMPROVEMENT_LEU_CONTAINER_PORT');
update Improvement_YieldChanges set YieldChange = 6 where YieldType = 'YIELD_GOLD' and
	ImprovementType in ('IMPROVEMENT_LEU_WAREHOUSE', 'IMPROVEMENT_LEU_CONTAINER_PORT');

delete from Improvement_BonusYieldChanges where ImprovementType in ('IMPROVEMENT_LEU_WAREHOUSE', 'IMPROVEMENT_LEU_CONTAINER_PORT');
-- update Improvement_BonusYieldChanges set PrereqTech = 'TECH_PLASTICS' where ImprovementType = 'IMPROVEMENT_LEU_WAREHOUSE' and PrereqTech = 'TECH_SYNTHETIC_MATERIALS';
-- update Improvement_BonusYieldChanges set PrereqTech = 'TECH_PLASTICS' where ImprovementType = 'IMPROVEMENT_LEU_CONTAINER_PORT' and PrereqTech = 'TECH_SYNTHETIC_MATERIALS';

-- update ModifierArguments set Value = 4 where ModifierId = 'LEU_WAREHOUSE_TRADE_GOLD' and Name = 'Amount';
-- update ModifierArguments set Value = 1 where ModifierId = 'LEU_WAREHOUSE_TRADE_PRODUCTION' and Name = 'Amount';
-- update ModifierArguments set Value = 4 where ModifierId = 'LEU_CONTAINER_PORT_TRADE_GOLD' and Name = 'Amount';
-- update ModifierArguments set Value = 1 where ModifierId = 'LEU_CONTAINER_PORT_TRADE_PRODUCTION' and Name = 'Amount';

-- update ModifierArguments set Value = 10 where ModifierId like 'LEU_INVESTOR_CORPORATION_BOOST_%' and Name = 'Amount';

insert or replace into Improvement_YieldChanges
	(ImprovementType,											YieldType,			YieldChange)
values
	('IMPROVEMENT_LEU_WAREHOUSE',					'YIELD_FOOD',		0),
	('IMPROVEMENT_LEU_CONTAINER_PORT',		'YIELD_FOOD',		0);

insert or replace into Improvement_Adjacencies
	(ImprovementType,								YieldChangeId)
values
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

insert or replace into Adjacency_YieldChanges
	(ID,																				Description,		YieldType,					YieldChange,	AdjacentResourceClass)
values
	('HD_WAREHOUSE_BONUS_FOOD', 								'Placeholder',	'YIELD_FOOD',				2,						'RESOURCECLASS_BONUS'),
	('HD_CONTAINER_PORT_BONUS_FOOD',  					'Placeholder',	'YIELD_FOOD',				2,						'RESOURCECLASS_BONUS'),
	('HD_WAREHOUSE_LUXURY_GOLD', 								'Placeholder',	'YIELD_GOLD',				3,						'RESOURCECLASS_LUXURY'),
	('HD_CONTAINER_PORT_LUXURY_GOLD', 					'Placeholder',	'YIELD_GOLD',				3,						'RESOURCECLASS_LUXURY'),
	('HD_WAREHOUSE_STRATEGIC_PRODUCTION', 			'Placeholder',	'YIELD_PRODUCTION',	2,						'RESOURCECLASS_STRATEGIC'),
	('HD_CONTAINER_PORT_STRATEGIC_PRODUCTION', 	'Placeholder',	'YIELD_PRODUCTION',	2,						'RESOURCECLASS_STRATEGIC');

insert or replace into Adjacency_YieldChanges
	(ID,																				Description,		YieldType,						YieldChange,	AdjacentDistrict)
values
	('HD_WAREHOUSE_CANAL_GOLD',									'Placeholder',	'YIELD_GOLD',					3,						'DISTRICT_CANAL'),
	('HD_CONTAINER_PORT_CANAL_GOLD',						'Placeholder',	'YIELD_GOLD',					3,						'DISTRICT_CANAL'),
	('HD_WAREHOUSE_AERODROME_PRODUCTION',				'Placeholder',	'YIELD_PRODUCTION',		2,						'DISTRICT_AERODROME'),
	('HD_CONTAINER_PORT_AERODROME_PRODUCTION',	'Placeholder',	'YIELD_PRODUCTION',		2,						'DISTRICT_AERODROME');

insert or replace into Adjacency_YieldChanges
	(ID,																					Description,		YieldType,					YieldChange,	AdjacentImprovement)
values
	('HD_WAREHOUSE_MOUNTAIN_TUNNEL_GOLD',					'Placeholder',	'YIELD_GOLD',				3,						'IMPROVEMENT_MOUNTAIN_TUNNEL'),
	('HD_CONTAINER_PORT_MOUNTAIN_TUNNEL_GOLD',		'Placeholder',	'YIELD_GOLD',				3,						'IMPROVEMENT_MOUNTAIN_TUNNEL'),
	('HD_WAREHOUSE_INDUSTRY_PRODUCTION',					'Placeholder',	'YIELD_PRODUCTION',	1,						'IMPROVEMENT_INDUSTRY'),
	('HD_CONTAINER_PORT_INDUSTRY_PRODUCTION',			'Placeholder',	'YIELD_PRODUCTION',	1,						'IMPROVEMENT_INDUSTRY'),
	('HD_WAREHOUSE_CORPORATION_GOLD',    					'Placeholder',	'YIELD_GOLD',				3,						'IMPROVEMENT_CORPORATION'),
	('HD_CONTAINER_PORT_CORPORATION_GOLD',    		'Placeholder',	'YIELD_GOLD',				3,						'IMPROVEMENT_CORPORATION'),
	('HD_WAREHOUSE_STATION_PRODUCTION',						'Placeholder',	'YIELD_PRODUCTION',	2,						'IMPROVEMENT_LEU_STATION'),
	('HD_CONTAINER_PORT_STATION_PRODUCTION',			'Placeholder',	'YIELD_PRODUCTION',	2,						'IMPROVEMENT_LEU_STATION');
	

insert or replace into ImprovementModifiers
	(ImprovementType,											ModifierId)
values
	('IMPROVEMENT_LEU_WAREHOUSE',					'HD_WAREHOUSE_TRADE_BONUS'),
	('IMPROVEMENT_LEU_WAREHOUSE',					'HD_WAREHOUSE_PRODUCT_TOURISM'),
	('IMPROVEMENT_LEU_WAREHOUSE',					'HD_WAREHOUSE_PLOT_YIELD_BONUS'),
	('IMPROVEMENT_LEU_CONTAINER_PORT',		'HD_CONTAINER_PORT_TRADE_BONUS'),
	('IMPROVEMENT_LEU_CONTAINER_PORT',		'HD_WAREHOUSE_PRODUCT_TOURISM'),
	('IMPROVEMENT_LEU_CONTAINER_PORT',		'HD_CONTAINER_PORT_PLOT_YIELD_BONUS');

insert or replace into Modifiers
	(ModifierId, 															ModifierType,																	SubjectRequirementSetId)
values
	('HD_WAREHOUSE_TRADE_BONUS',							'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD',		null),
	('HD_CONTAINER_PORT_TRADE_BONUS',					'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD',		null),
	('HD_WAREHOUSE_PRODUCT_TOURISM',					'MODIFIER_SINGLE_CITY_ADJUST_TOURISM',				null),
	('HD_WAREHOUSE_PLOT_YIELD_BONUS',					'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',					'HD_PLOT_HAS_INDUSTRY_OR_CORPORATION_REQUIRMENTS'),
	('HD_CONTAINER_PORT_PLOT_YIELD_BONUS',		'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',					'HD_PLOT_HAS_INDUSTRY_OR_CORPORATION_REQUIRMENTS');

insert or replace into ModifierArguments
	(ModifierId,														Name,										Value)
values
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

-- 阶级斗争尤里卡
update Boosts set BoostClass = 'BOOST_TRIGGER_NONE_LATE_GAME_CRITICAL_TECH', BuildingType = null, NumItems = 0,
	TriggerDescription = 'LOC_BOOST_TRIGGER_CLASS_STRUGGLE_HD_MONO', TriggerLongDescription = 'LOC_BOOST_TRIGGER_LONGDESC_CLASS_STRUGGLE_HD_MONO'
where CivicType = 'CIVIC_CLASS_STRUGGLE';

insert or replace into GlobalParameters
	(Name,                                 Value)
values
	('HD_CLASS_STRUGGLE_BOOST_WAREHOUSE',  1);

---------------------------------------------------------------------------------------------------------
-- ======
-- Boosts
-- ======
update Boosts set BoostClass = 'BOOST_TRIGGER_HAVE_X_IMPROVEMENTS', BuildingType = null, TriggerDescription = 'LOC_BOOST_TRIGGER_CAPITALISM_HD', NumItems = 1,
	TriggerLongDescription = 'LOC_BOOST_TRIGGER_LONGDESC_CAPITALISM_HD', ImprovementType = 'IMPROVEMENT_CORPORATION' where CivicType = 'CIVIC_CAPITALISM';

-- ============
-- New Policies
-- ============
insert or replace into Types
	(Type,														Kind)
values
	('POLICY_WAREHOUSE_MANAGEMENT',		'KIND_POLICY'),
	('POLICY_AUTO_STEREO_WAREHOUSE',	'KIND_POLICY');

insert or replace into Policies
	(PolicyType,											Name,																				Description,																			PrereqCivic,			PrereqTech,								GovernmentSlotType)
values
	('POLICY_WAREHOUSE_MANAGEMENT',		'LOC_POLICY_WAREHOUSE_MANAGEMENT_NAME',			'LOC_POLICY_WAREHOUSE_MANAGEMENT_DESCRIPTION',		null,							'TECH_INDUSTRIALIZATION',	'SLOT_ECONOMIC'),
	('POLICY_AUTO_STEREO_WAREHOUSE',	'LOC_POLICY_AUTO_STEREO_WAREHOUSE_NAME',		'LOC_POLICY_AUTO_STEREO_WAREHOUSE_DESCRIPTION',		null,							'TECH_PLASTICS',					'SLOT_ECONOMIC');
update Policies set PrereqTech = 'TECH_INDUSTRIAL_AUTOMATION_HD' where PolicyType = 'POLICY_AUTO_STEREO_WAREHOUSE' and
	exists (select TechnologyType from Technologies where TechnologyType = 'TECH_INDUSTRIAL_AUTOMATION_HD');

insert or replace into ObsoletePolicies
	(PolicyType,											ObsoletePolicy)
values
	('POLICY_WAREHOUSE_MANAGEMENT',		'POLICY_AUTO_STEREO_WAREHOUSE');

-- ==============
-- Policy Effects
-- ==============
update ModifierArguments set Value = 4 where Name = 'Amount' and ModifierId = 'ECOMMERCE_TRADEROUTEPRODUCTION';
update ModifierArguments set Value = 15 where Name = 'Amount' and ModifierId = 'ECOMMERCE_TRADEROUTEGOLD';

insert or replace into PolicyModifiers
	(PolicyType,			ModifierId)
values
	('POLICY_ECOMMERCE',	'ECOMMERCE_PRODUCT_TOURISM'),
	('POLICY_ECOMMERCE',	'ECOMMERCE_PRODUCT_TOURISM_POWERED'),
	('POLICY_WAREHOUSE_MANAGEMENT',	'WAREHOUSE_MANAGEMENT_COMMERCIAL_HUB_BONUS'),
	('POLICY_WAREHOUSE_MANAGEMENT',	'WAREHOUSE_MANAGEMENT_HARBOR_BONUS'),
	('POLICY_WAREHOUSE_MANAGEMENT',	'WAREHOUSE_MANAGEMENT_INDUSTRIAL_ZONE_BONUS'),
	('POLICY_AUTO_STEREO_WAREHOUSE',	'AUTO_STEREO_WAREHOUSE_COMMERCIAL_HUB_BONUS'),
	('POLICY_AUTO_STEREO_WAREHOUSE',	'AUTO_STEREO_WAREHOUSE_HARBOR_BONUS'),
	('POLICY_AUTO_STEREO_WAREHOUSE',	'AUTO_STEREO_WAREHOUSE_INDUSTRIAL_ZONE_BONUS');

insert or replace into Modifiers
	(ModifierId,								ModifierType,							SubjectRequirementSetId)
values
	('ECOMMERCE_PRODUCT_TOURISM',			'MODIFIER_PLAYER_CITIES_ADJUST_TOURISM',	NULL),
	('ECOMMERCE_PRODUCT_TOURISM_POWERED',	'MODIFIER_PLAYER_CITIES_ADJUST_TOURISM',	'CITY_IS_POWERED'),
	('WAREHOUSE_MANAGEMENT_COMMERCIAL_HUB_BONUS',		'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_MODIFIER',	'HD_WAREHOUSE_MANAGEMENT_COMMERCIAL_HUB_REQUIRMENTS'),
	('WAREHOUSE_MANAGEMENT_HARBOR_BONUS',						'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_MODIFIER',	'HD_WAREHOUSE_MANAGEMENT_HARBOR_REQUIRMENTS'),
	('WAREHOUSE_MANAGEMENT_INDUSTRIAL_ZONE_BONUS',	'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_MODIFIER',	'HD_WAREHOUSE_MANAGEMENT_INDUSTRIAL_ZONE_REQUIRMENTS'),
	('AUTO_STEREO_WAREHOUSE_COMMERCIAL_HUB_BONUS',		'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_MODIFIER',	'HD_WAREHOUSE_MANAGEMENT_COMMERCIAL_HUB_REQUIRMENTS'),
	('AUTO_STEREO_WAREHOUSE_HARBOR_BONUS',						'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_MODIFIER',	'HD_WAREHOUSE_MANAGEMENT_HARBOR_REQUIRMENTS'),
	('AUTO_STEREO_WAREHOUSE_INDUSTRIAL_ZONE_BONUS',		'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_MODIFIER',	'HD_WAREHOUSE_MANAGEMENT_INDUSTRIAL_ZONE_REQUIRMENTS');

insert or replace into ModifierArguments
	(ModifierId,								Name,					Value)
values
	('ECOMMERCE_PRODUCT_TOURISM',			'GreatWorkObjectType',	'GREATWORKOBJECT_PRODUCT'),
	('ECOMMERCE_PRODUCT_TOURISM',			'ScalingFactor',			300),
	('ECOMMERCE_PRODUCT_TOURISM_POWERED',	'GreatWorkObjectType',	'GREATWORKOBJECT_PRODUCT'),
	('ECOMMERCE_PRODUCT_TOURISM_POWERED',	'ScalingFactor',			300),
	('WAREHOUSE_MANAGEMENT_COMMERCIAL_HUB_BONUS',		'YieldType',	'YIELD_GOLD'),
	('WAREHOUSE_MANAGEMENT_COMMERCIAL_HUB_BONUS',		'Amount',			50),
	('WAREHOUSE_MANAGEMENT_HARBOR_BONUS',						'YieldType',	'YIELD_GOLD'),
	('WAREHOUSE_MANAGEMENT_HARBOR_BONUS',						'Amount',			50),
	('WAREHOUSE_MANAGEMENT_INDUSTRIAL_ZONE_BONUS',	'YieldType',	'YIELD_PRODUCTION'),
	('WAREHOUSE_MANAGEMENT_INDUSTRIAL_ZONE_BONUS',	'Amount',			50),
	('AUTO_STEREO_WAREHOUSE_COMMERCIAL_HUB_BONUS',		'YieldType',	'YIELD_GOLD'),
	('AUTO_STEREO_WAREHOUSE_COMMERCIAL_HUB_BONUS',		'Amount',			100),
	('AUTO_STEREO_WAREHOUSE_HARBOR_BONUS',						'YieldType',	'YIELD_GOLD'),
	('AUTO_STEREO_WAREHOUSE_HARBOR_BONUS',						'Amount',			100),
	('AUTO_STEREO_WAREHOUSE_INDUSTRIAL_ZONE_BONUS',		'YieldType',	'YIELD_PRODUCTION'),
	('AUTO_STEREO_WAREHOUSE_INDUSTRIAL_ZONE_BONUS',		'Amount',			100);

-- ==============
-- Wonder Effects
-- ==============
-- 巴拿马运河
insert or replace into BuildingModifiers
	(BuildingType,			ModifierId)
values
	('BUILDING_PANAMA_CANAL',   'PANAMA_PRODUCT_TOURISM');

insert or ignore into BuildingModifiers (BuildingType, ModifierId)
select  'BUILDING_PANAMA_CANAL', 'PANAMA_CANAL_GRANTS_MERCHANT'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PANAMA_CANAL');
insert or ignore into BuildingModifiers (BuildingType, ModifierId)
select  'BUILDING_PANAMA_CANAL', 'PANAMA_CANAL_EXTRA_MERCHANT_POINTS'
where exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PANAMA_CANAL');

insert or ignore into Modifiers
	(ModifierId,																					ModifierType,   																							RunOnce,Permanent)
values
	('PANAMA_CANAL_GRANTS_MERCHANT',											'MODIFIER_SINGLE_CITY_GRANT_GREAT_PERSON_CLASS_IN_CITY',			1,1);

insert or ignore into Modifiers
	(ModifierId,																					ModifierType,   																							SubjectRequirementSetId)
values
	('PANAMA_CANAL_EXTRA_MERCHANT_POINTS',								'MODIFIER_PLAYER_DISTRICTS_ATTACH_MODIFIER',									'DISTRICT_IS_CANAL'),
	('PANAMA_CANAL_EXTRA_MERCHANT_POINTS_MODIFIER',				'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS_PERCENT',					null);

insert or ignore into ModifierArguments
	(ModifierId,																					Name,   									Value)
values
	('PANAMA_CANAL_GRANTS_MERCHANT',											'Amount',   							1),
	('PANAMA_CANAL_GRANTS_MERCHANT',											'GreatPersonClassType', 	'GREAT_PERSON_CLASS_MERCHANT'),
	('PANAMA_CANAL_EXTRA_MERCHANT_POINTS',								'ModifierId', 						'PANAMA_CANAL_EXTRA_MERCHANT_POINTS_MODIFIER'),
	('PANAMA_CANAL_EXTRA_MERCHANT_POINTS_MODIFIER',				'Amount', 								10),
	('PANAMA_CANAL_EXTRA_MERCHANT_POINTS_MODIFIER',				'GreatPersonClassType', 	'GREAT_PERSON_CLASS_MERCHANT');

insert or replace into Modifiers
	(ModifierId,				ModifierType,															SubjectRequirementSetId)
values
	('PANAMA_PRODUCT_TOURISM',  'MODIFIER_PLAYER_CITIES_ADJUST_TOURISM',								'HD_CITY_HAS_CANAL');

insert or replace into ModifierArguments
	(ModifierId,				Name,					Value)
values
	('PANAMA_PRODUCT_TOURISM',  'GreatWorkObjectType',	'GREATWORKOBJECT_PRODUCT'),
	('PANAMA_PRODUCT_TOURISM',  'ScalingFactor',			150);

	-- 本城运河相邻区域外商收益
insert or ignore into BuildingModifiers
	(BuildingType, 						ModifierId)
select 
	'BUILDING_PANAMA_CANAL', 'PANAMA_CANAL_' || DistrictType || '_TRADE_BONUS'
from DistrictCorrespondingYieldType_HD where (RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT')
	and exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PANAMA_CANAL');

insert or ignore into BuildingModifiers
	(BuildingType, 						ModifierId)
select 
	'BUILDING_PANAMA_CANAL', 'PANAMA_CANAL_' || DistrictType || '_TRADE_BONUS_MODIFIER'
from DistrictCorrespondingYieldType_HD where (RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT')
	and exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PANAMA_CANAL');

insert or ignore into Modifiers
	(ModifierId,																					ModifierType,   															SubjectRequirementSetId)
select
	'PANAMA_CANAL_' || DistrictType || '_TRADE_BONUS',		'MODIFIER_CITY_DISTRICTS_ATTACH_MODIFIER',		'DISTRICT_IS_CANAL'
from DistrictCorrespondingYieldType_HD where (RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT');

insert or ignore into Modifiers
	(ModifierId,																								ModifierType,   																											OwnerRequirementSetId)
select
	'PANAMA_CANAL_' || DistrictType || '_TRADE_BONUS_MODIFIER', 'MODIFIER_SINGLE_CITY_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL',		'PLOT_ADJACENT_TO_' || DistrictType || '_REQUIREMENTS'
from DistrictCorrespondingYieldType_HD where (RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT');

insert or ignore into ModifierArguments
	(ModifierId,																								Name,   				Value)
select
	'PANAMA_CANAL_' || DistrictType || '_TRADE_BONUS',					'ModifierId',		'PANAMA_CANAL_' || DistrictType || '_TRADE_BONUS_MODIFIER'
from DistrictCorrespondingYieldType_HD where (RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT');

insert or ignore into ModifierArguments
	(ModifierId,																								Name,   				Value)
select
	'PANAMA_CANAL_' || DistrictType || '_TRADE_BONUS_MODIFIER', 'YieldType',    YieldType
from DistrictCorrespondingYieldType_HD where (RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT');

insert or ignore into ModifierArguments
	(ModifierId,																								Name,   				Value)
select
	'PANAMA_CANAL_' || DistrictType || '_TRADE_BONUS_MODIFIER', 'Amount',       Amount
from DistrictCorrespondingYieldType_HD where (RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT');

-- 金融中心
update Modifiers set SubjectRequirementSetId = 'CITY_HAS_BUILDING_EXHIBITION_REQUIREMENTS' where
	ModifierId = 'HD_NAT_FINANCE_CORP_TOURISM' or
	ModifierId like 'HD_NAT_FINANCE_PRODUCT_%';

insert or replace into BuildingModifiers
	(BuildingType,					ModifierId)
select
	'NAT_WON_CL_FINANCE',		'HD_NAT_FINANCE_PRODUCT_TOURISM'
where exists (select BuildingType from Buildings where BuildingType = 'NAT_WON_CL_FINANCE');

insert or replace into Modifiers
	(ModifierId,							ModifierType,										SubjectRequirementSetId)
values
	('HD_NAT_FINANCE_PRODUCT_TOURISM',	'MODIFIER_PLAYER_CITIES_ADJUST_TOURISM',	'HD_CITY_HAS_BUILDING_EXHIBITION_NO_BUILDING_CANAL');

insert or replace into ModifierArguments
	(ModifierId,				Name,					Value)
values
	('HD_NAT_FINANCE_PRODUCT_TOURISM',  'GreatWorkObjectType',	'GREATWORKOBJECT_PRODUCT'),
	('HD_NAT_FINANCE_PRODUCT_TOURISM',  'ScalingFactor',			150);

-- =========================
-- Product Slots and Theming
-- =========================
insert or replace into Building_GreatWorks (BuildingType, GreatWorkSlotType, NumSlots)
values ('BUILDING_EXHIBITION', 'GREATWORKSLOT_PRODUCT', 1);

insert or replace into DistrictModifiers
	(DistrictType,				ModifierId)
values
	('DISTRICT_CANAL',			'CANAL_GRANT_BUILDING');

insert or replace into BuildingModifiers
	(BuildingType,				ModifierId)
values
	('BUILDING_EXHIBITION',		'HD_EXHIBITION_IMPROVEMENT_GOLD');

insert or replace into Modifiers
	(ModifierId,						ModifierType,										SubjectRequirementSetId)
values
	('HD_EXHIBITION_IMPROVEMENT_GOLD',  'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',		'PLOT_IS_IMPROVED'),
	('CANAL_GRANT_BUILDING',			'MODIFIER_SINGLE_CITY_GRANT_BUILDING_IN_CITY_IGNORE',   Null);

insert or replace into ModifierArguments
	(ModifierId,						Name,				Value)
values
	('HD_EXHIBITION_IMPROVEMENT_GOLD',  'YieldType',		'YIELD_GOLD'),
	('HD_EXHIBITION_IMPROVEMENT_GOLD',  'Amount',			3),
	('CANAL_GRANT_BUILDING',			'BuildingType',	'BUILDING_CANAL');

-- adjust slots
update Building_GreatWorks set NumSlots = 2 where GreatWorkSlotType = 'GREATWORKSLOT_PRODUCT' and
	(BuildingType = 'BUILDING_SEAPORT' or
	BuildingType = 'BUILDING_STOCK_EXCHANGE' or
	BuildingType = 'BUILDING_FOOD_MARKET' or
	BuildingType = 'BUILDING_SHOPPING_MALL');

update Building_GreatWorks set NumSlots = 3 where GreatWorkSlotType = 'GREATWORKSLOT_PRODUCT' and
	BuildingType = 'BUILDING_PANAMA_CANAL';

insert or replace into Building_GreatWorks
	(BuildingType,				GreatWorkSlotType,		NumSlots)
values
	('BUILDING_CANAL',			'GREATWORKSLOT_PRODUCT',	1),
	('BUILDING_CASA_DE_CONTRATACION',			'GREATWORKSLOT_PRODUCT',	3),
	('BUILDING_RUHR_VALLEY',			'GREATWORKSLOT_PRODUCT',	3),
	('BUILDING_BIG_BEN',			'GREATWORKSLOT_PRODUCT',	3),
	('BUILDING_AIRPORT',			'GREATWORKSLOT_PRODUCT',	2);

insert or replace into Building_GreatWorks
	(BuildingType,	GreatWorkSlotType,		NumSlots)
select
	BuildingType,	'GREATWORKSLOT_PRODUCT',	3
from Buildings
where BuildingType in ('BUILDING_PORCELAIN_TOWER','NAT_WON_CL_FINANCE', 'NAT_WON_CL_FINANCE_INTERNAL');

insert or replace into Building_GreatWorks
	(BuildingType,	GreatWorkSlotType,		NumSlots)
select
	BuildingType,	'GREATWORKSLOT_PRODUCT',	4
from Buildings
where BuildingType in ('BUILDING_BURJ_KHALIFA','WON_CL_EMPIRE_STATES','NAT_WON_CL_AIRPORT','NAT_WON_CL_AIRPORT_INTERNAL');

-- update Building_GreatWorks set NonUniquePersonYield = 2, NonUniquePersonTourism = 2
--	where GreatWorkSlotType = 'GREATWORKSLOT_PRODUCT' and NumSlots >= 2;

update Building_GreatWorks set ThemingUniquePerson = 1, ThemingYieldMultiplier = 100, ThemingTourismMultiplier = 100, ThemingBonusDescription = 'LOC_PRODUCT_UNIQUE_THEMING'
	where GreatWorkSlotType = 'GREATWORKSLOT_PRODUCT' and NumSlots >= 3 and BuildingType not in ('BUILDING_XHH_WINE_STALL', 'BUILDING_XHH_FOOD_STALL', 'BUILDING_XHH_CLOTHING_STALL');

update Building_GreatWorks set ThemingYieldMultiplier = 200, ThemingTourismMultiplier = 200
	where GreatWorkSlotType = 'GREATWORKSLOT_PRODUCT' and BuildingType = 'BUILDING_BURJ_KHALIFA';

update Building_GreatWorks set ThemingUniquePerson = 0, ThemingSameObjectType = 1, ThemingBonusDescription = 'LOC_PRODUCT_ALL_THEMING'
	where BuildingType = 'WON_CL_EMPIRE_STATES' or BuildingType = 'BUILDING_BURJ_KHALIFA';

update ModifierArguments set Value = 'GREATWORKSLOT_PRODUCT' where ModifierId = 'GREATPERSON_BANK_GREAT_WORK_SLOTS' and Name = 'GreatWorkSlotType';

-- Château (France)
update Improvements set PrereqCivic = 'CIVIC_FEUDALISM',
	Housing = 1,
	SameAdjacentValid = 1,
	Description = 'LOC_IMPROVEMENT_CHATEAU_DESCRIPTION_MONOPOLIES'
where ImprovementType = 'IMPROVEMENT_CHATEAU';

create temporary table HD_ChateauResourceModifiers (
	ResourceType text not null,
	IndustryModifierId text not null,
	ChateauAttachModifierId text,
	PlantationAttachModifierId text,
	primary key (ResourceType, IndustryModifierId)
);

insert or replace into HD_ChateauResourceModifiers
	(ResourceType,		IndustryModifierId)
select
	ResourceType,		ModifierId
from (HDMonopolyResourceEffects m inner join HD_IndustryModifiers i on m.Category = i.Category)
where ResourceType in (select ResourceType from Improvement_ValidResources where ImprovementType in ('IMPROVEMENT_PLANTATION', 'IMPROVEMENT_FARM', 'IMPROVEMENT_LUMBER_MILL'));

update HD_ChateauResourceModifiers set ChateauAttachModifierId = ResourceType || '_' || IndustryModifierId || '_CHATEAU_ATTACH';
update HD_ChateauResourceModifiers set PlantationAttachModifierId = ResourceType || '_' || IndustryModifierId || '_PLANTATION_ATTACH';

insert or replace into ImprovementModifiers (ImprovementType, ModifierId)
	select 'IMPROVEMENT_CHATEAU', ChateauAttachModifierId from HD_ChateauResourceModifiers;

insert or replace into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId, SubjectStackLimit)
	select ChateauAttachModifierId, 'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER', 'HD_PLOT_HAS_' || ResourceType || '_ADJACENT', 1
from HD_ChateauResourceModifiers;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select ChateauAttachModifierId, 'ModifierId',	PlantationAttachModifierId
from HD_ChateauResourceModifiers;

insert or replace into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId, SubjectStackLimit) select
	PlantationAttachModifierId,
	'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER',
	'PLOT_HAS_IMPROVEMENT_CHATEAU_AND_ADJACENT_TO_OWNER_REQUIREMENTS',
	1
from HD_ChateauResourceModifiers;

insert or replace into ModifierArguments (ModifierId, Name, Value)
	select PlantationAttachModifierId, 'ModifierId', IndustryModifierId
from HD_ChateauResourceModifiers;

delete from Building_TourismBombs_XP2 where BuildingType = 'BUILDING_LEU_PAVILLION';

-- 社区建筑
update Modifiers set OwnerRequirementSetId = 'HD_CITY_HAS_IMPROVED_FAITH_RESOURCE_REQUIRMENTS' where ModifierId = 'HD_ANCESTRAL_TEMPLE_GROWTH';
update Modifiers set OwnerRequirementSetId = 'HD_CITY_HAS_IMPROVED_GPP_RESOURCE_REQUIRMENTS' where ModifierId = 'HD_TAVERN_EXTRA_GREAT_ARTIST_PONITS';
update Modifiers set OwnerRequirementSetId = 'HD_CITY_HAS_IMPROVED_AMENITY_RESOURCE_REQUIRMENTS' where ModifierId = 'HD_INN_EXTRA_GREAT_WRITER_PONITS';
update Modifiers set OwnerRequirementSetId = 'HD_CITY_HAS_IMPROVED_TOURISM_RESOURCE_REQUIRMENTS' where ModifierId = 'HD_DRAMA_STAGE_EXTRA_GREAT_MUSICIAN_PONITS';
update Modifiers set OwnerRequirementSetId = 'HD_CITY_HAS_IMPROVED_WONDER_RESOURCE_REQUIRMENTS' where ModifierId = 'HD_JNR_RECYCLING_PLANT_POP_GOLD_2';
update Modifiers set OwnerRequirementSetId = 'HD_CITY_HAS_IMPROVED_WONDER_RESOURCE_REQUIRMENTS' where ModifierId = 'HD_JNR_RECYCLING_PLANT_POP_PRODUCTION_2';
update Modifiers set OwnerRequirementSetId = 'HD_CITY_HAS_IMPROVED_MEDICINE_RESOURCE_REQUIRMENTS' where ModifierId = 'HD_JNR_HOSPITAL_EXTRA_GREAT_SCIENTIST_POINTS_3'
	and exists (select Category from HDMonopolyResourceClasses where Category = 'MEDICINE');
update Modifiers set OwnerRequirementSetId = 'HD_CITY_HAS_IMPROVED_GROWTH_FOOD_FISHERY_RESOURCE_REQUIRMENTS' where ModifierId = 'FOOD_MARKET_TRADE_FOOD_3';
update Modifiers set OwnerRequirementSetId = 'HD_CITY_HAS_IMPROVED_TRADER_ENTERTAINMENT_RESOURCE_REQUIRMENTS' where ModifierId = 'SHOPPING_MALL_TRADE_GOLD_3';

-----------------------------------------------------
-- 按行业类型分类 城市拥有改良的XX行业类型资源
insert or ignore into RequirementSets
	(RequirementSetId, 																									RequirementSetType)
select
	'HD_CITY_HAS_IMPROVED_' || Category || '_RESOURCE_REQUIRMENTS',			'REQUIREMENTSET_TEST_ANY'
from HDMonopolyResourceClasses where Category in ('GROWTH', 'FAITH', 'GPP', 'TRADER', 'FOOD', 'AMENITY', 'WONDER', 'TOURISM', 'FISHERY', 'ENTERTAINMENT', 'MEDICINE');

insert or ignore into RequirementSetRequirements
	(RequirementSetId,																									RequirementId) 
select
	'HD_CITY_HAS_IMPROVED_' || Category || '_RESOURCE_REQUIRMENTS',			'HD_REQUIRES_CITY_HAS_IMPROVED_' || ResourceType
from HDMonopolyResourceEffects where Category in ('GROWTH', 'FAITH', 'GPP', 'TRADER', 'FOOD', 'AMENITY', 'WONDER', 'TOURISM', 'FISHERY', 'ENTERTAINMENT', 'MEDICINE');

insert or ignore into Requirements
	(RequirementId, 																										RequirementType)
select
	'REQUIRES_HD_CITY_HAS_IMPROVED_' || Category || '_RESOURCE', 				'REQUIREMENT_REQUIREMENTSET_IS_MET'
from HDMonopolyResourceClasses where Category in ('GROWTH', 'FAITH', 'GPP', 'TRADER', 'FOOD', 'AMENITY', 'WONDER', 'TOURISM', 'FISHERY', 'ENTERTAINMENT', 'MEDICINE');

insert or ignore into RequirementArguments
	(RequirementId, 																										Name, 							Value)
select
	'REQUIRES_HD_CITY_HAS_IMPROVED_' || Category || '_RESOURCE', 				'RequirementSetId',	'HD_CITY_HAS_IMPROVED_' || Category || '_RESOURCE_REQUIRMENTS'
from HDMonopolyResourceClasses where Category in ('GROWTH', 'FAITH', 'GPP', 'TRADER', 'FOOD', 'AMENITY', 'WONDER', 'TOURISM', 'FISHERY', 'ENTERTAINMENT', 'MEDICINE');