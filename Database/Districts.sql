insert or replace into DistrictModifiers (DistrictType, ModifierId) values
	('DISTRICT_CANAL',			'CANAL_GRANT_BUILDING');

insert or replace into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) values
	('CANAL_GRANT_BUILDING',			'MODIFIER_SINGLE_CITY_GRANT_BUILDING_IN_CITY_IGNORE',   Null);

insert or replace into ModifierArguments (ModifierId, Name, Value) values
	('CANAL_GRANT_BUILDING',			'BuildingType',	'BUILDING_CANAL');