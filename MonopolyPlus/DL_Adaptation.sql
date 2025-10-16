-------------------------------------
--     Adaptation for the Mod      --
-------------------------------------

-- 大亨和投资人修改
update Units set Cost = 200, CostProgressionParam1 = 20, MustPurchase = 0, PrereqTech = 'TECH_MASS_PRODUCTION' where UnitType = 'UNIT_LEU_TYCOON';
delete from TypeProperties where Type in ('UNIT_LEU_INVESTOR', 'UNIT_LEU_TYCOON') and Name = 'LIFESPAN';

-- 回调海滨度假区和滑雪场的建造单位
update Improvement_ValidBuildUnits set UnitType = 'UNIT_BUILDER' where ImprovementType = 'IMPROVEMENT_BEACH_RESORT';
update Improvement_ValidBuildUnits set UnitType = 'UNIT_BUILDER' where ImprovementType = 'IMPROVEMENT_SKI_RESORT';

-- 火车站修改
    -- 基础
update Improvements set Appeal = 0, YieldFromAppeal = NULL, YieldFromAppealPercent = 100, Removable = 1 where ImprovementType = 'IMPROVEMENT_LEU_STATION';
    -- 军工也可以建造
insert or ignore into Improvement_ValidBuildUnits
    (ImprovementType,               UnitType)
values
    ('IMPROVEMENT_LEU_STATION',     'UNIT_MILITARY_ENGINEER');

    -- 删除内商和耗电特效
delete from ImprovementModifiers where ImprovementType = 'IMPROVEMENT_LEU_STATION' and (
    (ModifierId like 'LEU_STATION_DOMESTIC_PRODUCTION_%_OTHERS') or
    (ModifierId like 'LEU_STATION_DOMESTIC_PRODUCTION_%_OTHERS_POWERED') or
    (ModifierId like 'LEU_STATION_DOMESTIC_GOLD_%_OTHERS') or
    (ModifierId like 'LEU_STATION_DOMESTIC_GOLD_%_OTHERS_POWERED') or
    (ModifierId like 'LEU_STATION_DOMESTIC_CULTURE_%_OTHERS') or
    (ModifierId like 'LEU_STATION_DOMESTIC_CULTURE_%_OTHERS_POWERED') or
    (ModifierId like 'LEU_STATION_DOMESTIC_FOOD_%_OTHERS') or
    (ModifierId like 'LEU_STATION_DOMESTIC_FOOD_%_OTHERS_POWERED') or
    (ModifierId = 'LEU_STATION_REQUIRED_POWER')
);

    -- 相邻加成
update Adjacency_YieldChanges set YieldChange = 1 where ID = 'Station_Production_From_Industry';
delete from District_Adjacencies where YieldChangeId = 'Station_Production';
update Improvement_YieldChanges set YieldChange = 2 where ImprovementType = 'IMPROVEMENT_LEU_STATION' and YieldType = 'YIELD_PRODUCTION';

update Improvement_Tourism set PrereqTech = 'TECH_FLIGHT' where ImprovementType = 'IMPROVEMENT_LEU_STATION';
insert or ignore into Adjacency_YieldChanges
    (ID,                                        Description,   YieldType,               YieldChange,    TilesRequired,  AdjacentDistrict)
values
    ('HD_INDUSTRIAL_STATION_PRODUCTION',       'Placeholder', 'YIELD_PRODUCTION',       2,              1,              'DISTRICT_INDUSTRIAL_ZONE'),
    ('HD_COMMERCIAL_STATION_PRODUCTION',       'Placeholder', 'YIELD_PRODUCTION',       2,              1,              'DISTRICT_COMMERCIAL_HUB'),
    ('HD_HARBOR_STATION_PRODUCTION',           'Placeholder', 'YIELD_PRODUCTION',       2,              1,              'DISTRICT_HARBOR'),
    ('HD_CANAL_STATION_PRODUCTION',            'Placeholder', 'YIELD_PRODUCTION',       2,              1,              'DISTRICT_CANAL'),
    ('HD_AERODROME_STATION_PRODUCTION',        'Placeholder', 'YIELD_PRODUCTION',       2,              1,              'DISTRICT_AERODROME');
insert or ignore into Adjacency_YieldChanges
	(ID,								            Description,	YieldType,				YieldChange,	AdjacentImprovement)
values
    ('HD_MOUNTAIN_TUNNEL_STATION_PRODUCTION',		'Placeholder',	'YIELD_PRODUCTION',		3,				'IMPROVEMENT_MOUNTAIN_TUNNEL');
insert or ignore into Improvement_Adjacencies
    (ImprovementType,           YieldChangeId)
values
    ('IMPROVEMENT_LEU_STATION', 'HD_INDUSTRIAL_STATION_PRODUCTION'),
    ('IMPROVEMENT_LEU_STATION', 'HD_COMMERCIAL_STATION_PRODUCTION'),
    ('IMPROVEMENT_LEU_STATION', 'HD_HARBOR_STATION_PRODUCTION'),
    ('IMPROVEMENT_LEU_STATION', 'HD_CANAL_STATION_PRODUCTION'),
    ('IMPROVEMENT_LEU_STATION', 'HD_AERODROME_STATION_PRODUCTION'),
    ('IMPROVEMENT_LEU_STATION', 'HD_MOUNTAIN_TUNNEL_STATION_PRODUCTION');

    -- 上丘陵
insert or ignore into Improvement_ValidTerrains
    (ImprovementType,               TerrainType)
values
    ('IMPROVEMENT_LEU_STATION',     'TERRAIN_GRASS_HILLS'),
    ('IMPROVEMENT_LEU_STATION',     'TERRAIN_PLAINS_HILLS'),
    ('IMPROVEMENT_LEU_STATION',     'TERRAIN_DESERT_HILLS'),
    ('IMPROVEMENT_LEU_STATION',     'TERRAIN_TUNDRA_HILLS'),
    ('IMPROVEMENT_LEU_STATION',     'TERRAIN_SNOW_HILLS');

    -- 本城改良和产品业绩
insert or ignore into ImprovementModifiers
    (ImprovementType,           ModifierId)
values
    ('IMPROVEMENT_LEU_STATION', 'LEU_STATION_IMPROVEMENT_TOURISM'),
    ('IMPROVEMENT_LEU_STATION', 'LEU_STATION_PRODUCT_TOURISM_COMMERCIAL_HUB'),
    ('IMPROVEMENT_LEU_STATION', 'LEU_STATION_PRODUCT_TOURISM_HARBOR');

insert or ignore into Modifiers
    (ModifierId,                                                ModifierType,                                               OwnerRequirementSetId)
values
    ('LEU_STATION_IMPROVEMENT_TOURISM',                         'MODIFIER_SINGLE_CITY_ADJUST_IMPROVEMENT_TOURISM',          null),
    ('LEU_STATION_PRODUCT_TOURISM_COMMERCIAL_HUB',              'MODIFIER_SINGLE_CITY_ADJUST_TOURISM',                      'PLOT_ADJACENT_TO_DISTRICT_COMMERCIAL_HUB_REQUIREMENTS'),
    ('LEU_STATION_PRODUCT_TOURISM_HARBOR',                      'MODIFIER_SINGLE_CITY_ADJUST_TOURISM',                      'PLOT_ADJACENT_TO_DISTRICT_HARBOR_REQUIREMENTS');

insert or ignore into ModifierArguments
    (ModifierId,                                                Name,                                           Value)
values
    ('LEU_STATION_IMPROVEMENT_TOURISM',                         'Amount',                                       50),
    ('LEU_STATION_PRODUCT_TOURISM_COMMERCIAL_HUB',              'GreatWorkObjectType',                          'GREATWORKOBJECT_PRODUCT'),
    ('LEU_STATION_PRODUCT_TOURISM_COMMERCIAL_HUB',              'ScalingFactor',                                150),
    ('LEU_STATION_PRODUCT_TOURISM_HARBOR',                      'GreatWorkObjectType',                          'GREATWORKOBJECT_PRODUCT'),
    ('LEU_STATION_PRODUCT_TOURISM_HARBOR',                      'ScalingFactor',                                150);

--     -- 相邻区域相邻加成
-- insert or ignore into ImprovementModifiers
--     (ImprovementType,               ModifierId)
-- select
--     'IMPROVEMENT_LEU_STATION',      'HD_STATION_' || DistrictType || '_BONUS'
-- from DistrictCorrespondingYieldType_HD where HasAdjacency = 1;

-- insert or ignore into Modifiers
--     (ModifierId,                                ModifierType,                                       SubjectRequirementSetId)
-- select
--     'HD_STATION_' || DistrictType || '_BONUS',  'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_MODIFIER',    'HD_DISTRICT_IS_' || DistrictType || '_ADJACENT'
-- from DistrictCorrespondingYieldType_HD where HasAdjacency = 1;

-- insert or ignore into ModifierArguments
--     (ModifierId,                                Name,           Value)
-- select
--     'HD_STATION_' || DistrictType || '_BONUS',  'YieldType',    YieldType
-- from DistrictCorrespondingYieldType_HD where HasAdjacency = 1;

-- insert or ignore into ModifierArguments
--     (ModifierId,                                Name,           Value)
-- select
--     'HD_STATION_' || DistrictType || '_BONUS',  'Amount',       50
-- from DistrictCorrespondingYieldType_HD where HasAdjacency = 1;

--     -- 相邻区域相邻加成 供电
-- insert or ignore into ImprovementModifiers
--     (ImprovementType,               ModifierId)
-- select
--     'IMPROVEMENT_LEU_STATION',      'HD_STATION_' || DistrictType || '_BONUS_POWERED'
-- from DistrictCorrespondingYieldType_HD where HasAdjacency = 1;

-- insert or ignore into Modifiers
--     (ModifierId,                                        ModifierType,                                       OwnerRequirementSetId,  SubjectRequirementSetId)
-- select
--     'HD_STATION_' || DistrictType || '_BONUS_POWERED',  'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_MODIFIER',  'CITY_IS_POWERED',      'HD_DISTRICT_IS_' || DistrictType || '_ADJACENT'
-- from DistrictCorrespondingYieldType_HD where HasAdjacency = 1;

-- insert or ignore into ModifierArguments
--     (ModifierId,                                        Name,           Value)
-- select
--     'HD_STATION_' || DistrictType || '_BONUS_POWERED',  'YieldType',    YieldType
-- from DistrictCorrespondingYieldType_HD where HasAdjacency = 1;

-- insert or ignore into ModifierArguments
--     (ModifierId,                                        Name,           Value)
-- select
--     'HD_STATION_' || DistrictType || '_BONUS_POWERED',  'Amount',       50
-- from DistrictCorrespondingYieldType_HD where HasAdjacency = 1;

    -- 相邻区域给外商产出
insert or ignore into ImprovementModifiers
    (ImprovementType,               ModifierId)
select
    'IMPROVEMENT_LEU_STATION',      'HD_STATION_' || DistrictType || '_INTERNATIONAL_TRADE_BONUS'
from DistrictCorrespondingYieldType_HD where RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT';

insert or ignore into Modifiers
    (ModifierId,                                                    ModifierType,                                                         OwnerRequirementSetId)
select
    'HD_STATION_' || DistrictType || '_INTERNATIONAL_TRADE_BONUS',  'MODIFIER_SINGLE_CITY_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL',    'PLOT_ADJACENT_TO_' || DistrictType || '_REQUIREMENTS'
from DistrictCorrespondingYieldType_HD where RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT';

insert or ignore into ModifierArguments
    (ModifierId,                                                        Name,           Value)
select
    'HD_STATION_' || DistrictType || '_INTERNATIONAL_TRADE_BONUS',      'YieldType',    YieldType
from DistrictCorrespondingYieldType_HD where RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT';

insert or ignore into ModifierArguments
    (ModifierId,                                                        Name,           Value)
select
    'HD_STATION_' || DistrictType || '_INTERNATIONAL_TRADE_BONUS',      'Amount',       Amount
from DistrictCorrespondingYieldType_HD where RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT';

    -- 相邻区域给外商产出 供电
insert or ignore into ImprovementModifiers
    (ImprovementType,               ModifierId)
select
    'IMPROVEMENT_LEU_STATION',      'HD_STATION_' || DistrictType || '_INTERNATIONAL_TRADE_BONUS_POWERED'
from DistrictCorrespondingYieldType_HD where RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT';

insert or ignore into Modifiers
    (ModifierId,                                                            ModifierType,                                                         OwnerRequirementSetId,                                    SubjectRequirementSetId)
select
    'HD_STATION_' || DistrictType || '_INTERNATIONAL_TRADE_BONUS_POWERED',  'MODIFIER_SINGLE_CITY_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL',    'PLOT_ADJACENT_TO_' || DistrictType || '_REQUIREMENTS',   'CITY_IS_POWERED'
from DistrictCorrespondingYieldType_HD where RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT';

insert or ignore into ModifierArguments
    (ModifierId,                                                                Name,           Value)
select
    'HD_STATION_' || DistrictType || '_INTERNATIONAL_TRADE_BONUS_POWERED',      'YieldType',    YieldType
from DistrictCorrespondingYieldType_HD where RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT';

insert or ignore into ModifierArguments
    (ModifierId,                                                                Name,           Value)
select
    'HD_STATION_' || DistrictType || '_INTERNATIONAL_TRADE_BONUS_POWERED',      'Amount',       Amount
from DistrictCorrespondingYieldType_HD where RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT';

-- BUG Fixing
update ModifierArguments set Value = 'YIELD_PRODUCTION' where Value = 'YIELD_PRODUCION' and Name = 'YieldType';

insert or ignore into RequirementSetRequirements
    (RequirementSetId,		RequirementId)
select	'LEU_IS_'||ResourceType||'_CORPORATION',		'REQUIRES_LEU_CORPORATION_PLOT'
FROM ResourceCorporations;

-- 跨国公司
update Improvements set PrereqTech = null, PrereqCivic = 'CIVIC_CAPITALISM' where ImprovementType = 'IMPROVEMENT_LEU_TRANSNATIONAL';
update Improvements set PrereqTech = null, PrereqCivic = 'CIVIC_CAPITALISM' where ImprovementType = 'IMPROVEMENT_LEU_TRANSNATIONAL_SEA';
delete from Improvement_BonusYieldChanges where Id = 553;
delete from Improvement_BonusYieldChanges where Id = 554;

update Improvements set PrereqTech = null, PrereqCivic = 'CIVIC_NEOCOLONIALISM_HD' where ImprovementType = 'IMPROVEMENT_LEU_TRANSNATIONAL'
    and exists (select CivicType from Civics where CivicType = 'CIVIC_NEOCOLONIALISM_HD');
update Improvements set PrereqTech = null, PrereqCivic = 'CIVIC_NEOCOLONIALISM_HD' where ImprovementType = 'IMPROVEMENT_LEU_TRANSNATIONAL_SEA'
    and exists (select CivicType from Civics where CivicType = 'CIVIC_NEOCOLONIALISM_HD');