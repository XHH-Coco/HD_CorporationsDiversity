---------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Building Definitions
---------------------------------------------------------------------------------------------------------------------------------------------------------------
insert or ignore into Types (Type, Kind) values
	('BUILDING_EXHIBITION', 'KIND_BUILDING'),
	('BUILDING_CANAL',      'KIND_BUILDING');

insert or ignore into Buildings 
	(BuildingType, Name, Cost, Description, PrereqTech, PrereqDistrict, PurchaseYield, MustPurchase) 
values
	('BUILDING_EXHIBITION', 'LOC_BUILDING_EXHIBITION_NAME', 150, 'LOC_BUILDING_EXHIBITION_DESCRIPTION', 'TECH_ECONOMICS', 'DISTRICT_CITY_CENTER', 'YIELD_GOLD', 0),
	('BUILDING_CANAL', 'LOC_BUILDING_CANAL_NAME', 0, 'LOC_BUILDING_CANAL_DESCRIPTION', NULL, 'DISTRICT_CANAL', NULL, 1);

insert or replace into Buildings_XP2 (BuildingType, Pillage) values ('BUILDING_CANAL', 0);

insert or replace into HD_DUMMY_BUILDINGS (BuildingType) values ('BUILDING_CANAL');