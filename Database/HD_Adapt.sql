-- 鲁尔山谷
insert or replace into GlobalParameters (Name, Value)
  values ('HD_RUHR_VALLEY_SHARE_INDUSTRY',	1);

update Buildings set AdjacentDistrict = Null, AdjacentImprovement = 'IMPROVEMENT_INDUSTRY', RequiresRiver = 0, Description = 'LOC_BUILDING_RUHR_VALLEY_CORP_DESCRIPTION' where BuildingType = 'BUILDING_RUHR_VALLEY';
delete from BuildingModifiers where BuildingType = 'BUILDING_RUHR_VALLEY' and
	ModifierId not in ('RUHRVALLEY_ADDPRODUCTIONYIELD', 'RUHR_VALLEY_COAL');

insert or replace into BuildingModifiers (BuildingType, ModifierId)
  select 'BUILDING_RUHR_VALLEY', ModifierId || '_RUHR_VALLEY_ATTACH' from HD_IndustryModifiers;

insert or replace into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
  select ModifierId || '_RUHR_VALLEY_ATTACH', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 'HD_RUHR_VALLEY_SHARE_' || Category || '_INDUSTRY_REQUIREMENTS' from HD_IndustryModifiers;

insert or replace into ModifierArguments (ModifierId, Name, Value)
  select ModifierId || '_RUHR_VALLEY_ATTACH', 'ModifierId', ModifierId from HD_IndustryModifiers;

-- 威尼斯军械库
update Buildings set Description = 'LOC_BUILDING_VENETIAN_ARSENAL_CORP_DESCRIPTION' where BuildingType = 'BUILDING_VENETIAN_ARSENAL';
insert or replace into BuildingModifiers
	(BuildingType, 									ModifierId)
values
	('BUILDING_VENETIAN_ARSENAL',		'HD_VENETIAN_ARSENAL_GRANT_TYCOON');

insert or replace into Modifiers
	(ModifierId,													ModifierType,																	SubjectRequirementSetId)
values
	('HD_VENETIAN_ARSENAL_GRANT_TYCOON',	'MODIFIER_SINGLE_CITY_GRANT_UNIT_IN_CITY',		null);

insert or replace into ModifierArguments 
	(ModifierId,													Name,							Value) 
values 
	('HD_VENETIAN_ARSENAL_GRANT_TYCOON',	'UnitType',		    'UNIT_LEU_TYCOON'),
	('HD_VENETIAN_ARSENAL_GRANT_TYCOON',	'Amount',					1);