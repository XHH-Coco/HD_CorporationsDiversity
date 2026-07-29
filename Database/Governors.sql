-- ============================================================================================================================================================
-- 二进制 Key
-- ============================================================================================================================================================
insert or replace into HD_Binary_Compress_Keys (Key, MaxExp) values
  ('HD_PLOT_BINARY_COMPRESS_GOVERNOR_MANAGER_LEFT_3',                       4);

-- ============================================================================================================================================================
-- 全局参数
-- ============================================================================================================================================================
insert or replace into GlobalParameters (Name, Value) values
  ('HD_BUILD_STRATEGIC_INDUSTRY_CONSUME_RESOURCE_AMOUNT',                   30),
  ('HD_BUILD_STRATEGIC_CORPORATION_CONSUME_RESOURCE_AMOUNT',                60),
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
  'GOVERNOR_PROMOTION_HD_MANAGER_LEFT_3'
);
delete from GovernorPromotionModifiers where GovernorPromotionType = 'GOVERNOR_PROMOTION_HD_DEFENDER_RIGHT_2' and ModifierId in (
  'HD_GOVERNOR_DEFENDER_RIGHT_2_SUPPORT_MOVEMENT'
);

insert or ignore into GovernorPromotionModifiers (GovernorPromotionType, ModifierId) values
  -- 维克多 军备研究部
  ('GOVERNOR_PROMOTION_HD_DEFENDER_RIGHT_2', 'HD_GOVERNOR_DEFENDER_RIGHT_2_MILITARY_ENGINEERING_ABILITY_2'),
  ('GOVERNOR_PROMOTION_HD_DEFENDER_RIGHT_3', 'HD_GOVERNOR_DEFENDER_RIGHT_3_INDUSTRY_STRATEGIC_ATTACH'),
  ('GOVERNOR_PROMOTION_HD_DEFENDER_RIGHT_3', 'HD_GOVERNOR_DEFENDER_RIGHT_3_CORPORATION_STRATEGIC_ATTACH'),
  -- 马格努斯 实体产业
  ('GOVERNOR_PROMOTION_HD_MANAGER_LEFT_2',   'HD_GOVERNOR_MANAGER_LEFT_2_BUILDER_ABILITY'),
  -- 瑞娜 包税制度
  ('GOVERNOR_PROMOTION_HD_MERCHANT_LEFT_1',   'HD_GOVERNOR_MERCHANT_LEFT_1_UNIT_LEU_TYCOON_DISCOUNT'),
  ('GOVERNOR_PROMOTION_HD_MERCHANT_LEFT_1',   'HD_GOVERNOR_MERCHANT_LEFT_1_UNIT_LEU_INVESTOR_DISCOUNT');

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
  ('HD_GOVERNOR_MERCHANT_LEFT_1_UNIT_LEU_INVESTOR_DISCOUNT',            'MODIFIER_SINGLE_CITY_ADJUST_UNIT_PURCHASE_COST',                       0,  NULL);

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
	('HD_GOVERNOR_MERCHANT_LEFT_1_UNIT_LEU_INVESTOR_DISCOUNT',            'UnitType',               'UNIT_LEU_INVESTOR');

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

-- 马格努斯 横向一体化
insert or ignore into GovernorPromotionModifiers (GovernorPromotionType, ModifierId) select
  'GOVERNOR_PROMOTION_HD_MANAGER_LEFT_3', 'HD_GOVERNOR_MANAGER_LEFT_3_' || YieldType || '_' || Exp
from Yields, HD_Binary_Compress where YieldType in ('YIELD_FOOD', 'YIELD_PRODUCTION') and Exp < 5;

insert or ignore into Modifiers (ModifierId, ModifierType, OwnerRequirementSetId) select
  'HD_GOVERNOR_MANAGER_LEFT_3_' || YieldType || '_' || Exp, 'MODIFIER_SINGLE_CITY_ADJUST_TRADE_ROUTE_YIELD_TO_OTHERS', 'HD_PLOT_BINARY_COMPRESS_GOVERNOR_MANAGER_LEFT_3_' || Exp || '_REQUIREMENTS'
from Yields, HD_Binary_Compress where YieldType in ('YIELD_FOOD', 'YIELD_PRODUCTION') and Exp < 5;

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
  'HD_GOVERNOR_MANAGER_LEFT_3_' || YieldType || '_' || Exp, 'YieldType', YieldType
from Yields, HD_Binary_Compress where YieldType in ('YIELD_FOOD', 'YIELD_PRODUCTION') and Exp < 5;

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
  'HD_GOVERNOR_MANAGER_LEFT_3_' || YieldType || '_' || Exp, 'Amount', Amount * 2
from Yields, HD_Binary_Compress where YieldType in ('YIELD_FOOD') and Exp < 5;

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
  'HD_GOVERNOR_MANAGER_LEFT_3_' || YieldType || '_' || Exp, 'Amount', Amount
from Yields, HD_Binary_Compress where YieldType in ('YIELD_PRODUCTION') and Exp < 5;

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
  'HD_GOVERNOR_MANAGER_LEFT_3_' || YieldType || '_' || Exp, 'Domestic', 1
from Yields, HD_Binary_Compress where YieldType in ('YIELD_FOOD', 'YIELD_PRODUCTION') and Exp < 5;