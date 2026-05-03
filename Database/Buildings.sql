-- 建筑特性
insert or replace into BuildingModifiers (BuildingType, ModifierId) values
	('BUILDING_EXHIBITION',		'HD_EXHIBITION_IMPROVEMENT_GOLD');

insert or replace into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) values
	('HD_EXHIBITION_IMPROVEMENT_GOLD',  'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD',		'PLOT_IS_IMPROVED');

insert or replace into ModifierArguments (ModifierId, Name, Value) values
	('HD_EXHIBITION_IMPROVEMENT_GOLD',  'YieldType',	'YIELD_GOLD'),
	('HD_EXHIBITION_IMPROVEMENT_GOLD',  'Amount',			3);

-- 产品槽位
update Building_GreatWorks set NumSlots = 2 where GreatWorkSlotType = 'GREATWORKSLOT_PRODUCT' and
	(BuildingType = 'BUILDING_SEAPORT' or
	BuildingType = 'BUILDING_STOCK_EXCHANGE' or
	BuildingType = 'BUILDING_FOOD_MARKET' or
	BuildingType = 'BUILDING_SHOPPING_MALL');

update Building_GreatWorks set NumSlots = 3 where GreatWorkSlotType = 'GREATWORKSLOT_PRODUCT' and
	BuildingType = 'BUILDING_PANAMA_CANAL';

insert or replace into Building_GreatWorks (BuildingType, GreatWorkSlotType, NumSlots) values
	('BUILDING_EXHIBITION', 						'GREATWORKSLOT_PRODUCT', 	1),
	('BUILDING_CANAL',									'GREATWORKSLOT_PRODUCT',	1),
	('BUILDING_CASA_DE_CONTRATACION',		'GREATWORKSLOT_PRODUCT',	3),
	('BUILDING_RUHR_VALLEY',						'GREATWORKSLOT_PRODUCT',	3),
	('BUILDING_BIG_BEN',								'GREATWORKSLOT_PRODUCT',	3),
	('BUILDING_AIRPORT',								'GREATWORKSLOT_PRODUCT',	2);

insert or replace into Building_GreatWorks (BuildingType, GreatWorkSlotType, NumSlots) select
	BuildingType, 'GREATWORKSLOT_PRODUCT', 3
from Buildings where BuildingType in ('BUILDING_PORCELAIN_TOWER','NAT_WON_CL_FINANCE', 'NAT_WON_CL_FINANCE_INTERNAL');

insert or replace into Building_GreatWorks (BuildingType, GreatWorkSlotType, NumSlots) select
	BuildingType, 'GREATWORKSLOT_PRODUCT', 4
from Buildings where BuildingType in ('BUILDING_BURJ_KHALIFA','WON_CL_EMPIRE_STATES','NAT_WON_CL_AIRPORT','NAT_WON_CL_AIRPORT_INTERNAL');

update Building_GreatWorks set ThemingUniquePerson = 1, ThemingYieldMultiplier = 100, ThemingTourismMultiplier = 100, ThemingBonusDescription = 'LOC_BUILDING_THEMINGBONUS_PRODUCT_UNIQUE'
	where GreatWorkSlotType = 'GREATWORKSLOT_PRODUCT' and NumSlots >= 3 and BuildingType not in ('BUILDING_XHH_WINE_STALL', 'BUILDING_XHH_FOOD_STALL', 'BUILDING_XHH_CLOTHING_STALL');

update Building_GreatWorks set ThemingUniquePerson = 0, ThemingSameObjectType = 1, ThemingBonusDescription = 'LOC_BUILDING_THEMINGBONUS_PRODUCT_ALL'
	where BuildingType = 'WON_CL_EMPIRE_STATES' or BuildingType = 'BUILDING_BURJ_KHALIFA';

update Building_GreatWorks set ThemingYieldMultiplier = 200, ThemingTourismMultiplier = 200, ThemingBonusDescription = 'LOC_BUILDING_THEMINGBONUS_PRODUCT_ALL_BIG'
	where GreatWorkSlotType = 'GREATWORKSLOT_PRODUCT' and BuildingType = 'BUILDING_BURJ_KHALIFA';

-- 其他
delete from Building_TourismBombs_XP2 where BuildingType = 'BUILDING_LEU_PAVILLION';