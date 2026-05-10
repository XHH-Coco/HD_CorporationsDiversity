-------------------------
-- EMPIRE Adapt by xhh --
-------------------------

delete from BuildingModifiers where BuildingType = 'WON_CL_EMPIRE_STATES' and ModifierID = 'EMPIRE_ADJUST_CITY_YIELD_MODIFIER';

update ModifierArguments set Value = 300 where ModifierId = 'EMPIRE_CITY_WONDER_TOURISM' and Name = 'ScalingFactor';

insert or replace into BuildingModifiers (BuildingType, ModifierId) values
	('WON_CL_EMPIRE_STATES',	'EMPIRE_STATES_GOLD'),
	('WON_CL_EMPIRE_STATES',	'EMPIRE_STATES_TOURISM_1'),
	('WON_CL_EMPIRE_STATES',	'EMPIRE_STATES_TOURISM_2'),
	('WON_CL_EMPIRE_STATES',	'EMPIRE_STATES_TOURISM_3'),
	('WON_CL_EMPIRE_STATES',	'EMPIRE_STATES_TOURISM_4'),
	('WON_CL_EMPIRE_STATES',	'EMPIRE_STATES_TOURISM_5'),
	('WON_CL_EMPIRE_STATES',	'EMPIRE_STATES_TOURISM_6');

insert or replace into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) values
	('EMPIRE_STATES_GOLD',      'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER_PER_GOVERNOR_TITLE',  NULL),
	('EMPIRE_STATES_TOURISM_1', 'MODIFIER_PLAYER_CITIES_ADJUST_TOURISM',                                 'CITY_HAS_1_TITLE_GOVERNOR_REQUIREMENTS'),
	('EMPIRE_STATES_TOURISM_2', 'MODIFIER_PLAYER_CITIES_ADJUST_TOURISM',                                 'CITY_HAS_2_TITLE_GOVERNOR_REQUIREMENTS'),
	('EMPIRE_STATES_TOURISM_3', 'MODIFIER_PLAYER_CITIES_ADJUST_TOURISM',                                 'CITY_HAS_3_TITLE_GOVERNOR_REQUIREMENTS'),
	('EMPIRE_STATES_TOURISM_4', 'MODIFIER_PLAYER_CITIES_ADJUST_TOURISM',                                 'CITY_HAS_4_TITLE_GOVERNOR_REQUIREMENTS'),
	('EMPIRE_STATES_TOURISM_5', 'MODIFIER_PLAYER_CITIES_ADJUST_TOURISM',                                 'CITY_HAS_5_TITLE_GOVERNOR_REQUIREMENTS'),
	('EMPIRE_STATES_TOURISM_6', 'MODIFIER_PLAYER_CITIES_ADJUST_TOURISM',                                 'CITY_HAS_6_TITLE_GOVERNOR_REQUIREMENTS');

insert or replace into ModifierArguments (ModifierId, Name, Value) values
	('EMPIRE_STATES_GOLD',      'YieldType',            'YIELD_GOLD'),
	('EMPIRE_STATES_GOLD',      'Amount',               5),
	('EMPIRE_STATES_TOURISM_1', 'GreatWorkObjectType',	'GREATWORKOBJECT_PRODUCT'),
	('EMPIRE_STATES_TOURISM_1', 'ScalingFactor',        125),
	('EMPIRE_STATES_TOURISM_2', 'GreatWorkObjectType',	'GREATWORKOBJECT_PRODUCT'),
	('EMPIRE_STATES_TOURISM_2', 'ScalingFactor',        125),
	('EMPIRE_STATES_TOURISM_3', 'GreatWorkObjectType',	'GREATWORKOBJECT_PRODUCT'),
	('EMPIRE_STATES_TOURISM_3', 'ScalingFactor',        125),
	('EMPIRE_STATES_TOURISM_4', 'GreatWorkObjectType',	'GREATWORKOBJECT_PRODUCT'),
	('EMPIRE_STATES_TOURISM_4', 'ScalingFactor',        125),
	('EMPIRE_STATES_TOURISM_5', 'GreatWorkObjectType',	'GREATWORKOBJECT_PRODUCT'),
	('EMPIRE_STATES_TOURISM_5', 'ScalingFactor',        125),
	('EMPIRE_STATES_TOURISM_6', 'GreatWorkObjectType',	'GREATWORKOBJECT_PRODUCT'),
	('EMPIRE_STATES_TOURISM_6', 'ScalingFactor',        125);