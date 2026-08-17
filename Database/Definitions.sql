-- =====================================================================================================================================
-- Table Definitions
-- =====================================================================================================================================
create table HD_Monopoly_Categories(
	Category 					TEXT NOT NULL,
	IndustryEffect 		TEXT,
	CorporationEffect TEXT,
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
	Category			TEXT NOT NULL,
  YieldType			TEXT NOT NULL,
	YieldChange		INT Default	0,
	PRIMARY KEY (Category, YieldType)
);

create table HD_ProductTourism(
	ResourceType	TEXT NOT NULL,
  Amount				INT Default	0,
	PRIMARY KEY (ResourceType)
);

create table HD_GreatPerson_CreateResources(
  GreatPersonIndividualType TEXT NOT NULL,
  ResourceType 							TEXT NOT NULL,
	PRIMARY KEY (GreatPersonIndividualType)
);

create table HD_Building_Unlock_Second_Industry(
  BuildingType TEXT NOT NULL,
	PRIMARY KEY (BuildingType)
);

create table HD_Building_Unlock_Second_Corporation(
  BuildingType TEXT NOT NULL,
	PRIMARY KEY (BuildingType)
);

-- =====================================================================================================================================
-- Types
-- =====================================================================================================================================
insert or ignore into Types (Type, Kind) values
	('BUILDING_EXHIBITION', 							'KIND_BUILDING'),
	('BUILDING_CANAL',      							'KIND_BUILDING'),
	('BUILDING_OVERSEAS_INVESTOR_PREREQ', 'KIND_BUILDING'),
	('IMPROVEMENT_INDUSTRY_BONUS',      	'KIND_IMPROVEMENT'),
	('IMPROVEMENT_INDUSTRY_STRATEGIC',    'KIND_IMPROVEMENT'),
	('IMPROVEMENT_CORPORATION_BONUS',   	'KIND_IMPROVEMENT'),
	('IMPROVEMENT_CORPORATION_STRATEGIC', 'KIND_IMPROVEMENT'),
	('UNIT_HD_OVERSEAS_INVESTOR', 				'KIND_UNIT');

-- =====================================================================================================================================
-- Building Definitions
-- =====================================================================================================================================
insert or ignore into Buildings (BuildingType, Name, Cost, Description, PrereqTech, PrereqDistrict, PurchaseYield, MustPurchase, InternalOnly) values
	('BUILDING_EXHIBITION', 							'LOC_BUILDING_EXHIBITION_NAME', 							150, 	'LOC_BUILDING_EXHIBITION_DESCRIPTION', 	'TECH_ECONOMICS', 'DISTRICT_CITY_CENTER', 'YIELD_GOLD', 0, 0),
	('BUILDING_CANAL', 										'LOC_BUILDING_CANAL_NAME', 										0, 		'LOC_BUILDING_CANAL_DESCRIPTION', 			NULL, 						'DISTRICT_CANAL', 			NULL, 				1, 0),
	('BUILDING_OVERSEAS_INVESTOR_PREREQ', 'LOC_BUILDING_OVERSEAS_INVESTOR_PREREQ_NAME', 0, 		NULL, 																	NULL, 						NULL, 									NULL, 				1, 1);

insert or ignore into Buildings_XP2 (BuildingType, Pillage) values
	('BUILDING_CANAL', 										0),
	('BUILDING_OVERSEAS_INVESTOR_PREREQ', 0);

insert or ignore into HD_DUMMY_BUILDINGS (BuildingType) values
	('BUILDING_CANAL'),
	('BUILDING_OVERSEAS_INVESTOR_PREREQ');

-- =====================================================================================================================================
-- Improvement Definitions
-- =====================================================================================================================================
insert or replace into Improvements (ImprovementType, Name, Description, PlunderType, PlunderAmount, Icon, OnePerCity) values
	('IMPROVEMENT_INDUSTRY_BONUS', 				'LOC_IMPROVEMENT_INDUSTRY_BONUS_NAME', 				'LOC_IMPROVEMENT_INDUSTRY_DESCRIPTION', 							'PLUNDER_GOLD', 50, 'ICON_IMPROVEMENT_INDUSTRY', 		1),
	('IMPROVEMENT_INDUSTRY_STRATEGIC', 		'LOC_IMPROVEMENT_INDUSTRY_STRATEGIC_NAME', 		'LOC_IMPROVEMENT_INDUSTRY_DESCRIPTION', 							'PLUNDER_GOLD', 50, 'ICON_IMPROVEMENT_INDUSTRY', 		1),
	('IMPROVEMENT_CORPORATION_BONUS', 		'LOC_IMPROVEMENT_CORPORATION_BONUS_NAME', 		'LOC_IMPROVEMENT_CORPORATION_EXPANSION2_DESCRIPTION', 'PLUNDER_GOLD', 50, 'ICON_IMPROVEMENT_CORPORATION', 1),
	('IMPROVEMENT_CORPORATION_STRATEGIC', 'LOC_IMPROVEMENT_CORPORATION_STRATEGIC_NAME', 'LOC_IMPROVEMENT_CORPORATION_EXPANSION2_DESCRIPTION', 'PLUNDER_GOLD', 50, 'ICON_IMPROVEMENT_CORPORATION', 1);

insert or ignore into CivilopediaPageExcludes (SectionId, PageId) values
	('IMPROVEMENTS', 'IMPROVEMENT_INDUSTRY_BONUS'),
	('IMPROVEMENTS', 'IMPROVEMENT_INDUSTRY_STRATEGIC'),
	('IMPROVEMENTS', 'IMPROVEMENT_CORPORATION_BONUS'),
	('IMPROVEMENTS', 'IMPROVEMENT_CORPORATION_STRATEGIC');

insert or ignore into ImprovementsNeedCount_HD (ImprovementType) values
	('IMPROVEMENT_INDUSTRY_BONUS'),
	('IMPROVEMENT_INDUSTRY_STRATEGIC'),
	('IMPROVEMENT_CORPORATION_BONUS'),
	('IMPROVEMENT_CORPORATION_STRATEGIC');

-- =====================================================================================================================================
-- Unit Definitions
-- =====================================================================================================================================
insert or ignore into Units
	(UnitType, Name, Description, Cost, CostProgressionModel, CostProgressionParam1, PurchaseYield,
	BaseSightRange, BaseMoves, Domain, FormationClass, BuildCharges, CanCapture, CanRetreatWhenCaptured, PseudoYieldType, CanTrain, AdvisorType)
values
	('UNIT_HD_OVERSEAS_INVESTOR', 'LOC_UNIT_HD_OVERSEAS_INVESTOR_NAME', 'LOC_UNIT_HD_OVERSEAS_INVESTOR_DESCRIPTION', 150, 'COST_PROGRESSION_PREVIOUS_COPIES', 10, 'YIELD_GOLD',
	2, 4, 'DOMAIN_LAND', 'FORMATION_CLASS_CIVILIAN', 1, 1, 1, 'PSEUDOYIELD_UNIT_LEU_INVESTOR', 1, 'ADVISOR_GENERIC');

insert or ignore into UnitAiInfos (UnitType, AiType) values
	('UNIT_HD_OVERSEAS_INVESTOR', 'UNITAI_BUILD');

insert or ignore into TypeTags (Type, Tag) values
  ('UNIT_HD_OVERSEAS_INVESTOR', 'CLASS_LANDCIVILIAN'),
  ('UNIT_HD_OVERSEAS_INVESTOR', 'CLASS_MONOPOLY_UNIT');

insert or ignore into Unit_BuildingPrereqs (Unit, PrereqBuilding) values
	('UNIT_HD_OVERSEAS_INVESTOR', 'BUILDING_OVERSEAS_INVESTOR_PREREQ');

insert or ignore into TypeProperties (Type, Name, Value, PropertyType) values
	('UNIT_HD_OVERSEAS_INVESTOR', 'CAN_TELEPORT_TO_CITY', 1, 'PROPERTYTYPE_IDENTITY');