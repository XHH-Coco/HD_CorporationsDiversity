-- =====================================================================================================================================
-- 巴拿马运河
-- =====================================================================================================================================
insert or replace into BuildingModifiers (BuildingType, ModifierId) values
	('BUILDING_PANAMA_CANAL',   'PANAMA_PRODUCT_TOURISM'),
	('BUILDING_PANAMA_CANAL',   'PANAMA_CANAL_GRANTS_MERCHANT'),
	('BUILDING_PANAMA_CANAL',   'PANAMA_CANAL_EXTRA_MERCHANT_POINTS');

insert or ignore into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) values
	('PANAMA_PRODUCT_TOURISM',  													'MODIFIER_PLAYER_CITIES_ADJUST_TOURISM',											'REQUIRES_CITY_HAS_DISTRICT_CANAL_UDMET'),
	('PANAMA_CANAL_GRANTS_MERCHANT',											'MODIFIER_SINGLE_CITY_GRANT_GREAT_PERSON_CLASS_IN_CITY',			null),
	('PANAMA_CANAL_EXTRA_MERCHANT_POINTS',								'MODIFIER_PLAYER_DISTRICTS_ATTACH_MODIFIER',									'DISTRICT_IS_CANAL'),
	('PANAMA_CANAL_EXTRA_MERCHANT_POINTS_MODIFIER',				'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS_PERCENT',					null);

update Modifiers set RunOnce = 1, Permanent = 1 where ModifierId = 'PANAMA_CANAL_GRANTS_MERCHANT';

insert or ignore into ModifierArguments (ModifierId, Name, Value) values
	('PANAMA_PRODUCT_TOURISM',  													'GreatWorkObjectType',		'GREATWORKOBJECT_PRODUCT'),
	('PANAMA_PRODUCT_TOURISM',  													'ScalingFactor',					150),
	('PANAMA_CANAL_GRANTS_MERCHANT',											'Amount',   							1),
	('PANAMA_CANAL_GRANTS_MERCHANT',											'GreatPersonClassType', 	'GREAT_PERSON_CLASS_MERCHANT'),
	('PANAMA_CANAL_EXTRA_MERCHANT_POINTS',								'ModifierId', 						'PANAMA_CANAL_EXTRA_MERCHANT_POINTS_MODIFIER'),
	('PANAMA_CANAL_EXTRA_MERCHANT_POINTS_MODIFIER',				'Amount', 								10),
	('PANAMA_CANAL_EXTRA_MERCHANT_POINTS_MODIFIER',				'GreatPersonClassType', 	'GREAT_PERSON_CLASS_MERCHANT');

	-- 本城运河相邻区域外商收益
insert or ignore into BuildingModifiers (BuildingType, ModifierId) select 
	'BUILDING_PANAMA_CANAL', 'PANAMA_CANAL_' || DistrictType || '_TRADE_BONUS'
from DistrictCorrespondingYieldType_HD where (RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT')
	and exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PANAMA_CANAL');

insert or ignore into BuildingModifiers (BuildingType, ModifierId) select 
	'BUILDING_PANAMA_CANAL', 'PANAMA_CANAL_' || DistrictType || '_TRADE_BONUS_MODIFIER'
from DistrictCorrespondingYieldType_HD where (RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT')
	and exists (select BuildingType from Buildings where BuildingType = 'BUILDING_PANAMA_CANAL');

insert or ignore into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) select
	'PANAMA_CANAL_' || DistrictType || '_TRADE_BONUS', 'MODIFIER_CITY_DISTRICTS_ATTACH_MODIFIER', 'DISTRICT_IS_CANAL'
from DistrictCorrespondingYieldType_HD where (RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT');

insert or ignore into Modifiers (ModifierId, ModifierType, OwnerRequirementSetId) select
	'PANAMA_CANAL_' || DistrictType || '_TRADE_BONUS_MODIFIER', 'MODIFIER_SINGLE_CITY_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL', 'PLOT_ADJACENT_TO_' || DistrictType || '_REQUIREMENTS'
from DistrictCorrespondingYieldType_HD where (RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT');

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
	'PANAMA_CANAL_' || DistrictType || '_TRADE_BONUS', 'ModifierId', 'PANAMA_CANAL_' || DistrictType || '_TRADE_BONUS_MODIFIER'
from DistrictCorrespondingYieldType_HD where (RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT');

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
	'PANAMA_CANAL_' || DistrictType || '_TRADE_BONUS_MODIFIER', 'YieldType', YieldType
from DistrictCorrespondingYieldType_HD where (RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT');

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
	'PANAMA_CANAL_' || DistrictType || '_TRADE_BONUS_MODIFIER', 'Amount', Amount
from DistrictCorrespondingYieldType_HD where (RequiresPopulation = 1 or DistrictType = 'DISTRICT_AQUEDUCT');

-- =====================================================================================================================================
-- 金融中心
-- =====================================================================================================================================
update Modifiers set SubjectRequirementSetId = 'CITY_HAS_BUILDING_EXHIBITION_REQUIREMENTS' where
	ModifierId = 'HD_NAT_FINANCE_CORP_TOURISM' or
	ModifierId like 'HD_NAT_FINANCE_PRODUCT_%';

insert or replace into BuildingModifiers (BuildingType, ModifierId) select
	'NAT_WON_CL_FINANCE',		'HD_NAT_FINANCE_PRODUCT_TOURISM'
where exists (select BuildingType from Buildings where BuildingType = 'NAT_WON_CL_FINANCE');

insert or replace into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) values
	('HD_NAT_FINANCE_PRODUCT_TOURISM',	'MODIFIER_PLAYER_CITIES_ADJUST_TOURISM',	'HD_CITY_HAS_BUILDING_EXHIBITION_NO_BUILDING_CANAL');

insert or replace into ModifierArguments (ModifierId, Name, Value) values
	('HD_NAT_FINANCE_PRODUCT_TOURISM',  'GreatWorkObjectType',	'GREATWORKOBJECT_PRODUCT'),
	('HD_NAT_FINANCE_PRODUCT_TOURISM',  'ScalingFactor',				150);

-- =====================================================================================================================================
-- 威尼斯军械库
-- =====================================================================================================================================
update Buildings set Description = 'LOC_BUILDING_VENETIAN_ARSENAL_CORP_DESCRIPTION' where BuildingType = 'BUILDING_VENETIAN_ARSENAL';

insert or replace into BuildingModifiers (BuildingType, ModifierId) values
	('BUILDING_VENETIAN_ARSENAL',		'HD_VENETIAN_ARSENAL_GRANT_TYCOON');

insert or replace into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) values
	('HD_VENETIAN_ARSENAL_GRANT_TYCOON',	'MODIFIER_SINGLE_CITY_GRANT_UNIT_IN_CITY',		null);

insert or replace into ModifierArguments (ModifierId, Name, Value) values 
	('HD_VENETIAN_ARSENAL_GRANT_TYCOON',	'UnitType',		    'UNIT_LEU_TYCOON'),
	('HD_VENETIAN_ARSENAL_GRANT_TYCOON',	'Amount',					1);

-- =====================================================================================================================================
-- 鲁尔山谷
-- =====================================================================================================================================
update Buildings set Description = 'LOC_BUILDING_RUHR_VALLEY_CORP_DESCRIPTION', AdjacentDistrict = NULL where BuildingType = 'BUILDING_RUHR_VALLEY';
delete from BuildingPrereqs where Building = 'BUILDING_RUHR_VALLEY';

delete from BuildingModifiers where BuildingType = 'BUILDING_RUHR_VALLEY' and ModifierId in (
	'RUHRVALLEY_ADDPRODUCTIONYIELD',
	'RUHR_VALLEY_TRADE_ROUTE_PRODUCTION_FROM_OTHERS',
	'RUHR_VALLEY_TRADE_ROUTE_PRODUCTION_DOM_OTHERS',
	'RUHR_VALLEY_TRADE_ROUTE_PRODUCTION_TO_OTHERS',
	'RUHR_VALLEY_CITIES_PRODUCTION_MODIFIER',
	'RUHR_VALLEY_CITIES_EXTRA_GREAT_ENGINEER_POINTS'
);

insert or replace into BuildingModifiers (BuildingType, ModifierId) values
	('BUILDING_RUHR_VALLEY', 'HD_RUHR_VALLEY_TYCOON_ABILITY'),
	('BUILDING_RUHR_VALLEY', 'HD_RUHR_VALLEY_INVESTOR_ABILITY'),
	('BUILDING_RUHR_VALLEY', 'HD_RUHR_VALLEY_BONUS_CORPORATION_ATTACH'),
	('BUILDING_RUHR_VALLEY', 'HD_RUHR_VALLEY_STRATEGIC_CORPORATION_ATTACH'),
	('BUILDING_RUHR_VALLEY', 'HD_RUHR_VALLEY_INDUSTRY_CORPORATION_ATTACH');

insert or replace into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) values
	('HD_RUHR_VALLEY_TYCOON_ABILITY',														'MODIFIER_PLAYER_UNITS_GRANT_ABILITY',								null),
	('HD_RUHR_VALLEY_INVESTOR_ABILITY',													'MODIFIER_PLAYER_UNITS_GRANT_ABILITY',								null),
	('HD_RUHR_VALLEY_BONUS_CORPORATION_ATTACH',									'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER',				'PLOT_HAS_IMPROVEMENT_CORPORATION_BONUS_REQUIREMENTS'),
	('HD_RUHR_VALLEY_STRATEGIC_CORPORATION_ATTACH',							'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER',				'PLOT_HAS_IMPROVEMENT_CORPORATION_STRATEGIC_REQUIREMENTS'),
	('HD_RUHR_VALLEY_BONUS_CORPORATION_CITY_YIELDS_BONUS',			'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',		null),
	('HD_RUHR_VALLEY_STRATEGIC_CORPORATION_CITY_YIELDS_BONUS',	'MODIFIER_SINGLE_CITY_ADJUST_CITY_YIELD_MODIFIER',		null),
	('HD_RUHR_VALLEY_INDUSTRY_CORPORATION_ATTACH',							'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER',				'HD_PLOT_HAS_INDUSTRY_OR_CORPORATION_REQUIREMENTS'),
	('HD_RUHR_VALLEY_INDUSTRY_CORPORATION_GPP_BOOST',						'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS_PERCENT',	null);

insert or replace into ModifierArguments (ModifierId, Name, Value) values
	('HD_RUHR_VALLEY_TYCOON_ABILITY',														'AbilityType',					'ABILITY_HD_RUHR_VALLEY_TYCOON_ABILITY'),
	('HD_RUHR_VALLEY_INVESTOR_ABILITY',													'AbilityType',					'ABILITY_HD_RUHR_VALLEY_INVESTOR_ABILITY'),
	('HD_RUHR_VALLEY_BONUS_CORPORATION_ATTACH',									'ModifierId',						'HD_RUHR_VALLEY_BONUS_CORPORATION_CITY_YIELDS_BONUS'),
	('HD_RUHR_VALLEY_STRATEGIC_CORPORATION_ATTACH',							'ModifierId',						'HD_RUHR_VALLEY_STRATEGIC_CORPORATION_CITY_YIELDS_BONUS'),
  ('HD_RUHR_VALLEY_BONUS_CORPORATION_CITY_YIELDS_BONUS',      'YieldType',    				'YIELD_PRODUCTION'),
  ('HD_RUHR_VALLEY_BONUS_CORPORATION_CITY_YIELDS_BONUS',      'Amount',       				5),
  ('HD_RUHR_VALLEY_STRATEGIC_CORPORATION_CITY_YIELDS_BONUS',  'YieldType',    				'YIELD_SCIENCE'),
  ('HD_RUHR_VALLEY_STRATEGIC_CORPORATION_CITY_YIELDS_BONUS',  'Amount',       				5),
	('HD_RUHR_VALLEY_INDUSTRY_CORPORATION_ATTACH',							'ModifierId',						'HD_RUHR_VALLEY_INDUSTRY_CORPORATION_GPP_BOOST'),
	('HD_RUHR_VALLEY_INDUSTRY_CORPORATION_GPP_BOOST',						'GreatPersonClassType',	'GREAT_PERSON_CLASS_ENGINEER'),
	('HD_RUHR_VALLEY_INDUSTRY_CORPORATION_GPP_BOOST',						'Amount',								5);