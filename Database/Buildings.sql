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

-- 解锁第二行业/公司特效的建筑
insert or ignore into HD_Building_Unlock_Second_Industry (BuildingType) select BuildingType
	from HD_BuildingTiers where PrereqDistrict = 'DISTRICT_COMMERCIAL_HUB' and Tier = 3;

insert or ignore into HD_Building_Unlock_Second_Industry (BuildingType) select BuildingType
	from HD_BuildingTiers where PrereqDistrict = 'DISTRICT_HARBOR' and Tier = 2;

insert or ignore into HD_Building_Unlock_Second_Corporation (BuildingType) select BuildingType
	from HD_BuildingTiers where PrereqDistrict = 'DISTRICT_COMMERCIAL_HUB' and Tier = 4;

insert or ignore into HD_Building_Unlock_Second_Corporation (BuildingType) select BuildingType
	from HD_BuildingTiers where PrereqDistrict = 'DISTRICT_HARBOR' and Tier = 3;

insert or replace into BuildingModifiers (BuildingType, ModifierId) select
	BuildingType, 'HD_CITY_UNLOCK_SECOND_INDUSTRY'
from HD_Building_Unlock_Second_Industry;

insert or replace into BuildingModifiers (BuildingType, ModifierId) select
	BuildingType, 'HD_CITY_UNLOCK_SECOND_CORPORATION'
from HD_Building_Unlock_Second_Corporation;

-- 特产商行/进口商埠解锁公司特效的建筑
insert or ignore into HD_Building_Unlock_SpecialtyShop_Corporation (BuildingType) select BuildingType
	from HD_BuildingTiers where PrereqDistrict = 'DISTRICT_COMMERCIAL_HUB' and Tier = 4;

insert or replace into BuildingModifiers (BuildingType, ModifierId) select
	BuildingType, 'HD_CITY_UNLOCK_SPECIALTY_SHOP_CORPORATION'
from HD_Building_Unlock_SpecialtyShop_Corporation;

insert or ignore into HD_Building_Unlock_EntranceHarbor_Corporation (BuildingType) select BuildingType
	from HD_BuildingTiers where PrereqDistrict = 'DISTRICT_HARBOR' and Tier = 3;

insert or replace into BuildingModifiers (BuildingType, ModifierId) select
	BuildingType, 'HD_CITY_UNLOCK_ENTRANCE_HARBOR_CORPORATION'
from HD_Building_Unlock_EntranceHarbor_Corporation;

insert or replace into Modifiers (ModifierId, ModifierType) values
	('HD_CITY_UNLOCK_SECOND_INDUSTRY',  						'MODIFIER_SINGLE_CITY_ADJUST_PROPERTY'),
	('HD_CITY_UNLOCK_SECOND_CORPORATION', 					'MODIFIER_SINGLE_CITY_ADJUST_PROPERTY'),
	('HD_CITY_UNLOCK_SPECIALTY_SHOP_CORPORATION', 	'MODIFIER_SINGLE_CITY_ADJUST_PROPERTY'),
	('HD_CITY_UNLOCK_ENTRANCE_HARBOR_CORPORATION', 	'MODIFIER_SINGLE_CITY_ADJUST_PROPERTY');

insert or replace into ModifierArguments (ModifierId, Name, Value) values
	('HD_CITY_UNLOCK_SECOND_INDUSTRY',  						'Key',		'HD_CITY_UNLOCK_SECOND_INDUSTRY'),
	('HD_CITY_UNLOCK_SECOND_INDUSTRY',  						'Amount',	1),
	('HD_CITY_UNLOCK_SECOND_CORPORATION', 					'Key',		'HD_CITY_UNLOCK_SECOND_CORPORATION'),
	('HD_CITY_UNLOCK_SECOND_CORPORATION', 					'Amount',	1),
	('HD_CITY_UNLOCK_SPECIALTY_SHOP_CORPORATION', 	'Key',		'HD_CITY_UNLOCK_SPECIALTY_SHOP_CORPORATION'),
	('HD_CITY_UNLOCK_SPECIALTY_SHOP_CORPORATION', 	'Amount',	1),
	('HD_CITY_UNLOCK_ENTRANCE_HARBOR_CORPORATION', 	'Key',		'HD_CITY_UNLOCK_ENTRANCE_HARBOR_CORPORATION'),
	('HD_CITY_UNLOCK_ENTRANCE_HARBOR_CORPORATION', 	'Amount',	1);