-- insert or replace into ImprovementModifiers
--     (ImprovementType,           ModifierId)
-- values
--     ('IMPROVEMENT_CORPORATION', 'CORPORATION_HD_TOYS_COMMERCIAL'),
--     ('IMPROVEMENT_CORPORATION', 'CORPORATION_HD_TOYS_HARBOR'),
--     ('IMPROVEMENT_CORPORATION', 'CORPORATION_HD_COSMETICS_PLOT_BONUS'),
--     ('IMPROVEMENT_CORPORATION', 'CORPORATION_HD_JEANS_DISCOUNT'),
--     ('IMPROVEMENT_CORPORATION', 'CORPORATION_HD_JEANS_IGNORE_TERRAIN'),
--     ('IMPROVEMENT_CORPORATION', 'CORPORATION_HD_PERFUME_PLOT_BONUS');

-- insert or replace into Modifiers
--     (ModifierId,                                     ModifierType,                                               OwnerRequirementSetId,              SubjectRequirementSetId)
-- values
--     ('CORPORATION_HD_TOYS_COMMERCIAL',               'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_PER_POPULATION',  'HD_RESOURCE_TOYS_IN_PLOT',         'HD_CITY_HAS_COMMERCIAL_HUB'),
--     ('CORPORATION_HD_TOYS_HARBOR',                   'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_PER_POPULATION',  'HD_RESOURCE_TOYS_IN_PLOT',         'HD_CITY_HAS_HARBOR'),
--     ('CORPORATION_HD_COSMETICS_PLOT_BONUS',          'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',                        'HD_RESOURCE_COSMETICS_IN_PLOT',    'PLOT_IS_IMPROVED'),
--     ('CORPORATION_HD_JEANS_DISCOUNT',                'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_PURCHASE_COST',         'HD_RESOURCE_JEANS_IN_PLOT',        Null),
--     ('CORPORATION_HD_JEANS_IGNORE_TERRAIN',          'MODIFIER_PLAYER_UNITS_ADJUST_IGNORE_TERRAIN',              'HD_RESOURCE_JEANS_IN_PLOT',        'UNIT_IS_ROCK_BAND'),
--     ('CORPORATION_HD_JEANS_IGNORE_RIVERS',           'MODIFIER_PLAYER_UNITS_ADJUST_IGNORE_RIVERS',               'HD_RESOURCE_JEANS_IN_PLOT',        'UNIT_IS_ROCK_BAND'),
--     ('CORPORATION_HD_JEANS_IGNORE_SHORES',           'MODIFIER_PLAYER_UNITS_ADJUST_IGNORE_SHORES',               'HD_RESOURCE_JEANS_IN_PLOT',        'UNIT_IS_ROCK_BAND'),
--     ('CORPORATION_HD_PERFUME_PLOT_BONUS',            'MODIFIER_PLAYER_ADJUST_PLOT_YIELD',                        'HD_RESOURCE_PERFUME_IN_PLOT',      'PLOT_IS_IMPROVED');

-- insert or replace into ModifierArguments
--     (ModifierId,                                    Name,           Value)
-- values
--     ('CORPORATION_HD_TOYS_COMMERCIAL',              'YieldType',    'YIELD_CULTURE'),
--     ('CORPORATION_HD_TOYS_COMMERCIAL',              'Amount',       0.6),
--     ('CORPORATION_HD_TOYS_HARBOR',                  'YieldType',    'YIELD_SCIENCE'),
--     ('CORPORATION_HD_TOYS_HARBOR',                  'Amount',       0.6),
--     ('CORPORATION_HD_COSMETICS_PLOT_BONUS',         'YieldType',    'YIELD_CULTURE,YIELD_PRODUCTION'),
--     ('CORPORATION_HD_COSMETICS_PLOT_BONUS',         'Amount',       '1,1'),
--     ('CORPORATION_HD_PERFUME_PLOT_BONUS',           'YieldType',    'YIELD_SCIENCE,YIELD_FAITH'),
--     ('CORPORATION_HD_PERFUME_PLOT_BONUS',           'Amount',       '2,2'),
--     ('CORPORATION_HD_JEANS_DISCOUNT',               'UnitType',     'UNIT_ROCK_BAND'),
--     ('CORPORATION_HD_JEANS_DISCOUNT',               'Amount',       50),
--     ('CORPORATION_HD_JEANS_IGNORE_TERRAIN',         'Type',         'ALL'),
--     ('CORPORATION_HD_JEANS_IGNORE_TERRAIN',         'Ignore',       1),
--     ('CORPORATION_HD_JEANS_IGNORE_RIVERS',          'Ignore',       1),
--     ('CORPORATION_HD_JEANS_IGNORE_SHORES',          'Ignore',       1);

-- insert or ignore into Requirements
--     (RequirementId,                             RequirementType)
-- values
--     ('REQUIRES_RESOURCE_TOYS_IN_PLOT',          'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES'),
--     ('REQUIRES_RESOURCE_COSMETICS_IN_PLOT',     'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES'),
--     ('REQUIRES_RESOURCE_JEANS_IN_PLOT',         'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES'),
--     ('REQUIRES_RESOURCE_PERFUME_IN_PLOT',       'REQUIREMENT_PLOT_RESOURCE_TYPE_MATCHES'),
--     ('REQUIRES_CITY_HAS_SUGUBA',                'REQUIREMENT_CITY_HAS_DISTRICT'),
--     ('REQUIRES_CITY_HAS_COTHON',                'REQUIREMENT_CITY_HAS_DISTRICT'),
--     ('REQUIRES_CITY_HAS_ROYAL_NAVY_DOCKYARD',   'REQUIREMENT_CITY_HAS_DISTRICT');

-- insert or ignore into RequirementArguments
--     (RequirementId,                             Name,                Value)
-- values
--     ('REQUIRES_RESOURCE_TOYS_IN_PLOT',          'ResourceType',      'RESOURCE_TOYS'),
--     ('REQUIRES_RESOURCE_COSMETICS_IN_PLOT',     'ResourceType',      'RESOURCE_COSMETICS'),
--     ('REQUIRES_RESOURCE_JEANS_IN_PLOT',         'ResourceType',      'RESOURCE_JEANS'),
--     ('REQUIRES_RESOURCE_PERFUME_IN_PLOT',       'ResourceType',      'RESOURCE_PERFUME'),
--     ('REQUIRES_CITY_HAS_SUGUBA',                'DistrictType',      'DISTRICT_SUGUBA'),
--     ('REQUIRES_CITY_HAS_COTHON',                'DistrictType',      'DISTRICT_COTHON'),
--     ('REQUIRES_CITY_HAS_ROYAL_NAVY_DOCKYARD',   'DistrictType',      'DISTRICT_ROYAL_NAVY_DOCKYARD');

-- insert or ignore into RequirementSets
--     (RequirementSetId,                          RequirementSetType)
-- values
--     ('HD_RESOURCE_TOYS_IN_PLOT',                'REQUIREMENTSET_TEST_ALL'),
--     ('HD_RESOURCE_COSMETICS_IN_PLOT',           'REQUIREMENTSET_TEST_ALL'),
--     ('HD_RESOURCE_JEANS_IN_PLOT',               'REQUIREMENTSET_TEST_ALL'),
--     ('HD_RESOURCE_PERFUME_IN_PLOT',             'REQUIREMENTSET_TEST_ALL'),
--     ('HD_CITY_HAS_COMMERCIAL_HUB',              'REQUIREMENTSET_TEST_ANY'),
--     ('HD_CITY_HAS_HARBOR',                      'REQUIREMENTSET_TEST_ANY');

-- insert or ignore into RequirementSetRequirements
--     (RequirementSetId,                          RequirementId)
-- values
--     ('HD_RESOURCE_TOYS_IN_PLOT',                'REQUIRES_RESOURCE_TOYS_IN_PLOT'),
--     ('HD_RESOURCE_COSMETICS_IN_PLOT',           'REQUIRES_RESOURCE_COSMETICS_IN_PLOT'),
--     ('HD_RESOURCE_JEANS_IN_PLOT',               'REQUIRES_RESOURCE_JEANS_IN_PLOT'),
--     ('HD_RESOURCE_PERFUME_IN_PLOT',             'REQUIRES_RESOURCE_PERFUME_IN_PLOT'),
--     ('HD_CITY_HAS_COMMERCIAL_HUB',              'REQUIRES_CITY_HAS_COMMERCIAL_HUB'),
--     ('HD_CITY_HAS_COMMERCIAL_HUB',              'REQUIRES_CITY_HAS_SUGUBA'),
--     ('HD_CITY_HAS_HARBOR',                      'REQUIRES_CITY_HAS_HARBOR'),
--     ('HD_CITY_HAS_HARBOR',                      'REQUIRES_CITY_HAS_COTHON'),
--     ('HD_CITY_HAS_HARBOR',                      'REQUIRES_CITY_HAS_ROYAL_NAVY_DOCKYARD');

-- -- 化妆品公司
-- insert or replace into ImprovementModifiers
--     (ImprovementType,                   ModifierId)
-- select
-- 	'IMPROVEMENT_CORPORATION',			'CORPORATION_HD_COSMETICS_' || ImprovementType || '_TOURISM_BOOST'
-- from Improvement_Tourism where TourismSource in ('TOURISMSOURCE_CULTURE','TOURISMSOURCE_PRODUCTION');

-- insert or replace into Modifiers
-- 	(ModifierId,									                        ModifierType,							   OwnerRequirementSetId)
-- select
--     'CORPORATION_HD_COSMETICS_' || ImprovementType || '_TOURISM_BOOST',    'MODIFIER_PLAYER_CITIES_ADJUST_TOURISM',    'HD_RESOURCE_COSMETICS_IN_PLOT'
-- from Improvement_Tourism where TourismSource in ('TOURISMSOURCE_CULTURE','TOURISMSOURCE_PRODUCTION');

-- insert or replace into ModifierArguments
-- 	(ModifierId,					                                        Name,				Value)
-- select
-- 	'CORPORATION_HD_COSMETICS_' || ImprovementType || '_TOURISM_BOOST',	    'ImprovementType',	ImprovementType
-- from Improvement_Tourism where TourismSource in ('TOURISMSOURCE_CULTURE','TOURISMSOURCE_PRODUCTION');

-- insert or replace into ModifierArguments
-- 	(ModifierId,					                                        Name,				Value)
-- select
-- 	'CORPORATION_HD_COSMETICS_' || ImprovementType || '_TOURISM_BOOST',	    'ScalingFactor',	150
-- from Improvement_Tourism where TourismSource in ('TOURISMSOURCE_CULTURE','TOURISMSOURCE_PRODUCTION');

-- -- 香水公司
-- insert or replace into ImprovementModifiers
--     (ImprovementType,                   ModifierId)
-- select
-- 	'IMPROVEMENT_CORPORATION',			'CORPORATION_HD_PERFUME_' || ImprovementType || '_TOURISM_BOOST'
-- from Improvement_Tourism where TourismSource in ('TOURISMSOURCE_SCIENCE','TOURISMSOURCE_FAITH');

-- insert or replace into Modifiers
-- 	(ModifierId,									                        ModifierType,							   OwnerRequirementSetId)
-- select
--     'CORPORATION_HD_PERFUME_' || ImprovementType || '_TOURISM_BOOST',       'MODIFIER_PLAYER_CITIES_ADJUST_TOURISM',    'HD_RESOURCE_PERFUME_IN_PLOT'
-- from Improvement_Tourism where TourismSource in ('TOURISMSOURCE_SCIENCE','TOURISMSOURCE_FAITH');

-- insert or replace into ModifierArguments
-- 	(ModifierId,					                                        Name,				Value)
-- select
-- 	'CORPORATION_HD_PERFUME_' || ImprovementType || '_TOURISM_BOOST',	    'ImprovementType',	ImprovementType
-- from Improvement_Tourism where TourismSource in ('TOURISMSOURCE_SCIENCE','TOURISMSOURCE_FAITH');

-- insert or replace into ModifierArguments
-- 	(ModifierId,					                                        Name,				Value)
-- select
-- 	'CORPORATION_HD_PERFUME_' || ImprovementType || '_TOURISM_BOOST',	    'ScalingFactor',	150
-- from Improvement_Tourism where TourismSource in ('TOURISMSOURCE_SCIENCE','TOURISMSOURCE_FAITH');