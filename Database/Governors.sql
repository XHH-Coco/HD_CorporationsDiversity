-- ============================================================================================================================================================
-- 二进制 Key
-- ============================================================================================================================================================
-- insert or replace into HD_Binary_Compress_Keys (Key, MaxExp) values

-- ============================================================================================================================================================
-- 全局参数
-- ============================================================================================================================================================
insert or replace into GlobalParameters (Name, Value) values
  ('HD_BUILD_STRATEGIC_INDUSTRY_CONSUME_RESOURCE_AMOUNT',                   15),
  ('HD_BUILD_STRATEGIC_CORPORATION_CONSUME_RESOURCE_AMOUNT',                30),
  ('HD_MILITARY_ENGINEERING_BUILD_STRATEGIC_INDUSTRY_CONSUME_CHARGE_NUM',   3),
  ('HD_BUILD_BONUS_INDUSTRY_NEED_RESOURCE_NUM',                             2),
  ('HD_BUILD_BONUS_CORPORATION_NEED_RESOURCE_NUM',                          3),
  ('HD_BUILDER_BUILD_BONUS_INDUSTRY_CONSUME_CHARGE_NUM',                    4);

-- ============================================================================================================================================================
-- 总督能力
-- ============================================================================================================================================================
delete from GovernorPromotionModifiers where GovernorPromotionType in (
  'GOVERNOR_PROMOTION_HD_DEFENDER_RIGHT_3',
  'GOVERNOR_PROMOTION_HD_MANAGER_LEFT_2',
  'GOVERNOR_PROMOTION_HD_MERCHANT_LEFT_2',
  'GOVERNOR_PROMOTION_HD_MERCHANT_LEFT_3'
);
-- delete from GovernorPromotionModifiers where GovernorPromotionType = 'GOVERNOR_PROMOTION_HD_DEFENDER_RIGHT_2' and ModifierId in (
--   'HD_GOVERNOR_DEFENDER_RIGHT_2_SUPPORT_MOVEMENT'
-- );

insert or ignore into GovernorPromotionModifiers (GovernorPromotionType, ModifierId) values
  -- 维克多 军备研究部
  ('GOVERNOR_PROMOTION_HD_DEFENDER_RIGHT_2', 'HD_GOVERNOR_DEFENDER_RIGHT_2_MILITARY_ENGINEERING_ABILITY_2'),
  ('GOVERNOR_PROMOTION_HD_DEFENDER_RIGHT_3', 'HD_GOVERNOR_DEFENDER_RIGHT_3_INDUSTRY_STRATEGIC_ATTACH'),
  ('GOVERNOR_PROMOTION_HD_DEFENDER_RIGHT_3', 'HD_GOVERNOR_DEFENDER_RIGHT_3_CORPORATION_STRATEGIC_ATTACH'),
  -- 马格努斯 实体产业
  ('GOVERNOR_PROMOTION_HD_MANAGER_LEFT_2',   'HD_GOVERNOR_MANAGER_LEFT_2_BUILDER_ABILITY'),
  -- 瑞娜 包税制度
  ('GOVERNOR_PROMOTION_HD_MERCHANT_LEFT_1',   'HD_GOVERNOR_MERCHANT_LEFT_1_UNIT_LEU_TYCOON_DISCOUNT'),
  ('GOVERNOR_PROMOTION_HD_MERCHANT_LEFT_1',   'HD_GOVERNOR_MERCHANT_LEFT_1_UNIT_LEU_INVESTOR_DISCOUNT'),
  ('GOVERNOR_PROMOTION_HD_MERCHANT_LEFT_1',   'HD_GOVERNOR_MERCHANT_LEFT_1_UNIT_HD_OVERSEAS_INVESTOR_DISCOUNT'),
  -- 瑞娜 股权投资
  ('GOVERNOR_PROMOTION_HD_MERCHANT_LEFT_2',   'HD_GOVERNOR_MERCHANT_LEFT_2_ENABLE_UNIT_HD_OVERSEAS_INVESTOR'),
  -- 瑞娜 跨国巨头
  ('GOVERNOR_PROMOTION_HD_MERCHANT_LEFT_3',   'HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_FOOD_ATTACH'),
  ('GOVERNOR_PROMOTION_HD_MERCHANT_LEFT_3',   'HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_PRODUCTION_ATTACH'),
  ('GOVERNOR_PROMOTION_HD_MERCHANT_LEFT_3',   'HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_SCIENCE_ATTACH'),
  ('GOVERNOR_PROMOTION_HD_MERCHANT_LEFT_3',   'HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_CULTURE_ATTACH'),
  ('GOVERNOR_PROMOTION_HD_MERCHANT_LEFT_3',   'HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_GOLD_ATTACH'),
  ('GOVERNOR_PROMOTION_HD_MERCHANT_LEFT_3',   'HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_FAITH_ATTACH'),
  ('GOVERNOR_PROMOTION_HD_MERCHANT_LEFT_3',   'HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_TOURISM_ATTACH');

insert or ignore into Modifiers (ModifierId, ModifierType, Permanent, SubjectRequirementSetId) values
  -- 维克多 军备研究部
  ('HD_GOVERNOR_DEFENDER_RIGHT_2_MILITARY_ENGINEERING_ABILITY_2',       'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS',                 1,  NULL),
  ('HD_GOVERNOR_DEFENDER_RIGHT_3_INDUSTRY_STRATEGIC_ATTACH',            'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER',                         0,  'PLOT_HAS_IMPROVEMENT_INDUSTRY_STRATEGIC_REQUIREMENTS'),
  ('HD_GOVERNOR_DEFENDER_RIGHT_3_CORPORATION_STRATEGIC_ATTACH',         'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER',                         0,  'PLOT_HAS_IMPROVEMENT_CORPORATION_STRATEGIC_REQUIREMENTS'),
  ('HD_GOVERNOR_DEFENDER_RIGHT_3_CITY_YIELDS',                          'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER',                    0,  'HD_CITY_HAS_GOVERNOR_PROMOTION_HD_DEFENDER_RIGHT_3_REQUIREMENTS'),
  -- 马格努斯 实体产业
  ('HD_GOVERNOR_MANAGER_LEFT_2_BUILDER_ABILITY',                        'MODIFIER_PLAYER_UNITS_GRANT_ABILITY',                                  1,  NULL),
  -- 瑞娜 包税制度
  ('HD_GOVERNOR_MERCHANT_LEFT_1_UNIT_LEU_TYCOON_DISCOUNT',              'MODIFIER_SINGLE_CITY_ADJUST_UNIT_PURCHASE_COST',                       0,  NULL),
  ('HD_GOVERNOR_MERCHANT_LEFT_1_UNIT_LEU_INVESTOR_DISCOUNT',            'MODIFIER_SINGLE_CITY_ADJUST_UNIT_PURCHASE_COST',                       0,  NULL),
  ('HD_GOVERNOR_MERCHANT_LEFT_1_UNIT_HD_OVERSEAS_INVESTOR_DISCOUNT',    'MODIFIER_SINGLE_CITY_ADJUST_UNIT_PURCHASE_COST',                       0,  NULL),
  -- 瑞娜 股权投资
  ('HD_GOVERNOR_MERCHANT_LEFT_2_ENABLE_UNIT_HD_OVERSEAS_INVESTOR',      'MODIFIER_SINGLE_CITY_ADJUST_PROPERTY',                                 0,  NULL),
  -- 瑞娜 跨国巨头
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_FOOD_ATTACH',                   'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER',                         0,  'HD_PLOT_HAS_LAND_OR_SEA_TRANSNATIONAL_REQUIREMENTS'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_PRODUCTION_ATTACH',             'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER',                         0,  'HD_PLOT_HAS_LAND_OR_SEA_TRANSNATIONAL_REQUIREMENTS'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_SCIENCE_ATTACH',                'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER',                         0,  'HD_PLOT_HAS_LAND_OR_SEA_TRANSNATIONAL_REQUIREMENTS'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_CULTURE_ATTACH',                'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER',                         0,  'HD_PLOT_HAS_LAND_OR_SEA_TRANSNATIONAL_REQUIREMENTS'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_GOLD_ATTACH',                   'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER',                         0,  'HD_PLOT_HAS_LAND_OR_SEA_TRANSNATIONAL_REQUIREMENTS'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_FAITH_ATTACH',                  'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER',                         0,  'HD_PLOT_HAS_LAND_OR_SEA_TRANSNATIONAL_REQUIREMENTS'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_TOURISM_ATTACH',                'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER',                         0,  'HD_PLOT_HAS_LAND_OR_SEA_TRANSNATIONAL_REQUIREMENTS');

insert or ignore into Modifiers (ModifierId, ModifierType, SubjectStackLimit) values
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_FOOD',                          'MODIFIER_SINGLE_CITY_ADJUST_GREATWORK_YIELD',                          1),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_PRODUCTION',                    'MODIFIER_SINGLE_CITY_ADJUST_GREATWORK_YIELD',                          1),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_SCIENCE',                       'MODIFIER_SINGLE_CITY_ADJUST_GREATWORK_YIELD',                          1),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_CULTURE',                       'MODIFIER_SINGLE_CITY_ADJUST_GREATWORK_YIELD',                          1),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_GOLD',                          'MODIFIER_SINGLE_CITY_ADJUST_GREATWORK_YIELD',                          1),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_FAITH',                         'MODIFIER_SINGLE_CITY_ADJUST_GREATWORK_YIELD',                          1),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_TOURISM',                       'MODIFIER_SINGLE_CITY_ADJUST_TOURISM',                                  1);

insert or ignore into ModifierArguments (ModifierId, Name, Value) values
  -- 维克多 军备研究部
  ('HD_GOVERNOR_DEFENDER_RIGHT_2_MILITARY_ENGINEERING_ABILITY_2',       'AbilityType',            'ABILITY_HD_GOVERNOR_DEFENDER_RIGHT_2_MILITARY_ENGINEERING_ABILITY_2'),
  ('HD_GOVERNOR_DEFENDER_RIGHT_3_INDUSTRY_STRATEGIC_ATTACH',            'ModifierId',             'HD_GOVERNOR_DEFENDER_RIGHT_3_CITY_YIELDS'),
  ('HD_GOVERNOR_DEFENDER_RIGHT_3_CORPORATION_STRATEGIC_ATTACH',         'ModifierId',             'HD_GOVERNOR_DEFENDER_RIGHT_3_CITY_YIELDS'),
  ('HD_GOVERNOR_DEFENDER_RIGHT_3_CITY_YIELDS',                          'YieldType',              'YIELD_PRODUCTION, YIELD_SCIENCE'),
  ('HD_GOVERNOR_DEFENDER_RIGHT_3_CITY_YIELDS',                          'Amount',                 '10, 10'),
  -- 马格努斯 实体产业
  ('HD_GOVERNOR_MANAGER_LEFT_2_BUILDER_ABILITY',                        'AbilityType',            'ABILITY_HD_GOVERNOR_MANAGER_LEFT_2_BUILDER_ABILITY'),
  -- 瑞娜 包税制度
	('HD_GOVERNOR_MERCHANT_LEFT_1_UNIT_LEU_TYCOON_DISCOUNT',              'Amount',                 15),
	('HD_GOVERNOR_MERCHANT_LEFT_1_UNIT_LEU_TYCOON_DISCOUNT',              'UnitType',               'UNIT_LEU_TYCOON'),
	('HD_GOVERNOR_MERCHANT_LEFT_1_UNIT_LEU_INVESTOR_DISCOUNT',            'Amount',                 15),
	('HD_GOVERNOR_MERCHANT_LEFT_1_UNIT_LEU_INVESTOR_DISCOUNT',            'UnitType',               'UNIT_LEU_INVESTOR'),
	('HD_GOVERNOR_MERCHANT_LEFT_1_UNIT_HD_OVERSEAS_INVESTOR_DISCOUNT',    'Amount',                 15),
	('HD_GOVERNOR_MERCHANT_LEFT_1_UNIT_HD_OVERSEAS_INVESTOR_DISCOUNT',    'UnitType',               'UNIT_HD_OVERSEAS_INVESTOR'),
	-- 瑞娜 股权投资
  ('HD_GOVERNOR_MERCHANT_LEFT_2_ENABLE_UNIT_HD_OVERSEAS_INVESTOR',      'Key',                    'HD_CITY_ENABLE_UNIT_HD_OVERSEAS_INVESTOR'),
	('HD_GOVERNOR_MERCHANT_LEFT_2_ENABLE_UNIT_HD_OVERSEAS_INVESTOR',      'Amount',                 1),
  -- 瑞娜 跨国巨头
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_FOOD_ATTACH',                   'ModifierId',             'HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_FOOD'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_PRODUCTION_ATTACH',             'ModifierId',             'HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_PRODUCTION'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_SCIENCE_ATTACH',                'ModifierId',             'HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_SCIENCE'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_CULTURE_ATTACH',                'ModifierId',             'HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_CULTURE'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_GOLD_ATTACH',                   'ModifierId',             'HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_GOLD'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_FAITH_ATTACH',                  'ModifierId',             'HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_FAITH'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_TOURISM_ATTACH',                'ModifierId',             'HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_TOURISM'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_FOOD',                          'GreatWorkObjectType',    'GREATWORKOBJECT_PRODUCT'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_FOOD',                          'YieldType',              'YIELD_FOOD'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_FOOD',                          'ScalingFactor',          150),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_PRODUCTION',                    'GreatWorkObjectType',    'GREATWORKOBJECT_PRODUCT'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_PRODUCTION',                    'YieldType',              'YIELD_PRODUCTION'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_PRODUCTION',                    'ScalingFactor',          150),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_SCIENCE',                       'GreatWorkObjectType',    'GREATWORKOBJECT_PRODUCT'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_SCIENCE',                       'YieldType',              'YIELD_SCIENCE'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_SCIENCE',                       'ScalingFactor',          150),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_CULTURE',                       'GreatWorkObjectType',    'GREATWORKOBJECT_PRODUCT'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_CULTURE',                       'YieldType',              'YIELD_CULTURE'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_CULTURE',                       'ScalingFactor',          150),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_GOLD',                          'GreatWorkObjectType',    'GREATWORKOBJECT_PRODUCT'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_GOLD',                          'YieldType',              'YIELD_GOLD'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_GOLD',                          'ScalingFactor',          150),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_FAITH',                         'GreatWorkObjectType',    'GREATWORKOBJECT_PRODUCT'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_FAITH',                         'YieldType',              'YIELD_FAITH'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_FAITH',                         'ScalingFactor',          150),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_TOURISM',                       'GreatWorkObjectType',    'GREATWORKOBJECT_PRODUCT'),
  ('HD_GOVERNOR_MERCHANT_LEFT_3_PRODUCT_TOURISM',                       'ScalingFactor',          200);

-- 马格努斯 实体产业
insert or ignore into GovernorPromotionModifiers (GovernorPromotionType, ModifierId) select
  'GOVERNOR_PROMOTION_HD_MANAGER_LEFT_2', 'HD_GOVERNOR_MANAGER_LEFT_2_INDUSTRIAL_ZONE_TIER_' || Count
from HDCounter where Count <= (select Tier from HD_DistrictBuildingHighestTier where DistrictType = 'DISTRICT_INDUSTRIAL_ZONE');

insert or ignore into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) select
  'HD_GOVERNOR_MANAGER_LEFT_2_INDUSTRIAL_ZONE_TIER_' || Count, 'MODIFIER_SINGLE_CITY_ADJUST_PROPERTY', 'CITY_HAS_DISTRICT_INDUSTRIAL_ZONE_TIER_' || Count || '_BUILDING_REQUIREMENTS'
from HDCounter where Count <= (select Tier from HD_DistrictBuildingHighestTier where DistrictType = 'DISTRICT_INDUSTRIAL_ZONE');

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
  'HD_GOVERNOR_MANAGER_LEFT_2_INDUSTRIAL_ZONE_TIER_' || Count, 'Key', 'HD_CITY_ALLOW_EXTRA_IMPROVEMENT_INDUSTRY_BONUS'
from HDCounter where Count <= (select Tier from HD_DistrictBuildingHighestTier where DistrictType = 'DISTRICT_INDUSTRIAL_ZONE');

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
  'HD_GOVERNOR_MANAGER_LEFT_2_INDUSTRIAL_ZONE_TIER_' || Count, 'Amount', 1
from HDCounter where Count <= (select Tier from HD_DistrictBuildingHighestTier where DistrictType = 'DISTRICT_INDUSTRIAL_ZONE');