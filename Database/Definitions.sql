-- =====================================================================================================================================
-- Table Definitions
-- =====================================================================================================================================
create table HD_Monopoly_Categories(
	Category TEXT NOT NULL,
	IndustryEffect 		TEXT NOT NULL,
	CorporationEffect TEXT NOT NULL,
	PRIMARY KEY (Category)
);

create table HD_Monopoly_Resource_Categories(
	ResourceType			TEXT NOT NULL,
	Category 					TEXT NOT NULL,
	PRIMARY KEY (ResourceType, Category)
	FOREIGN KEY (ResourceType) REFERENCES Resources(ResourceType) ON DELETE CASCADE ON UPDATE CASCADE
	FOREIGN KEY (Category) REFERENCES HD_Monopoly_Categories(Category) ON DELETE CASCADE ON UPDATE CASCADE
);

create table HD_IndustryModifiers(
	Category 		TEXT NOT NULL,
	ModifierId 	TEXT NOT NULL,
	PRIMARY KEY (Category, ModifierId)
);

create table HD_CorporationModifiers(
	Category 		TEXT NOT NULL,
	ModifierId 	TEXT NOT NULL,
	PRIMARY KEY (Category, ModifierId)
);

create table HD_ProductYields(
	Category 		TEXT NOT NULL,
	YieldType 	TEXT NOT NULL,
	YieldChange INT NOT NULL,
	PRIMARY KEY (Category, YieldType)
);

-- =====================================================================================================================================
-- Building Definitions
-- =====================================================================================================================================
insert or ignore into Types (Type, Kind) values
	('BUILDING_EXHIBITION', 'KIND_BUILDING'),
	('BUILDING_CANAL',      'KIND_BUILDING');

insert or ignore into Buildings (BuildingType, Name, Cost, Description, PrereqTech, PrereqDistrict, PurchaseYield, MustPurchase) values
	('BUILDING_EXHIBITION', 'LOC_BUILDING_EXHIBITION_NAME', 150, 	'LOC_BUILDING_EXHIBITION_DESCRIPTION', 	'TECH_ECONOMICS', 'DISTRICT_CITY_CENTER', 'YIELD_GOLD', 0),
	('BUILDING_CANAL', 			'LOC_BUILDING_CANAL_NAME', 			0, 		'LOC_BUILDING_CANAL_DESCRIPTION', 			NULL, 						'DISTRICT_CANAL', 			NULL, 				1);

insert or ignore into Buildings_XP2 (BuildingType, Pillage) values
	('BUILDING_CANAL', 0);

insert or ignore into HD_DUMMY_BUILDINGS (BuildingType) values
	('BUILDING_CANAL');