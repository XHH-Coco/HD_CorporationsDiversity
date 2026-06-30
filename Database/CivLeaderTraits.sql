-- 巴西
update Traits set Description = 'LOC_TRAIT_CIVILIZATION_AMAZON_DESCRIPTION_MONOPOLIES' where TraitType = 'TRAIT_CIVILIZATION_AMAZON';
update Units set Description = 'LOC_UNIT_HD_BANDEIRANTES_DESCRIPTION_MONOPOLIES' where UnitType = 'UNIT_HD_BANDEIRANTES';

delete from DistrictModifiers where DistrictType in ('DISTRICT_STREET_CARNIVAL', 'DISTRICT_WATER_STREET_CARNIVAL') and ModifierId = 'HD_BANDEIRANTES_ADD_TIMES';

insert or ignore into Modifiers (ModifierId, ModifierType) values
	('HD_AMAZON_INDUSTRY_GRANT_BANDEIRANTES', 'MODIFIER_SINGLE_CITY_GRANT_UNIT_IN_CITY');

insert or ignore into ModifierArguments (ModifierId, Name, Value) values
  ('HD_AMAZON_INDUSTRY_GRANT_BANDEIRANTES', 'UnitType', 					  'UNIT_HD_BANDEIRANTES'),
	('HD_AMAZON_INDUSTRY_GRANT_BANDEIRANTES', 'AllowUniqueOverride',  0),
	('HD_AMAZON_INDUSTRY_GRANT_BANDEIRANTES', 'Amount', 						  1);