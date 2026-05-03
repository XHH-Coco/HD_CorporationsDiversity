
-- =====================================================================================================================================
-- 行业公司类型 来自“资源用途”
-- =====================================================================================================================================
insert or replace into HD_Monopoly_Categories (Category, IndustryEffect, CorporationEffect) select
	substr(ResourceClassificationType, 28),
	'INDUSTRY_HD_' || substr(ResourceClassificationType, 28) || '_BONUS',
	'CORPORATION_HD_' || substr(ResourceClassificationType, 28) || '_BONUS'
from HD_ResourceClassificationTypes where ParentClassificationType = 'USAGE';

-- =====================================================================================================================================
-- 资源的行业公司分类
-- =====================================================================================================================================
insert or replace into HD_Monopoly_Resource_Categories (ResourceType, Category) select
	ResourceType,
	substr(ResourceClassificationType, 28),
from HD_Resource_Classification where ResourceClassificationType in
	(select ResourceClassificationType from HD_ResourceClassificationTypes where ParentClassificationType = 'USAGE');

-- 其他Mod的资源默认为 庆典+家居
insert or replace into HD_Monopoly_Resource_Categories (ResourceType, Category)
select ResourceType, 'CELEBRATION', 'INDUSTRY_HD_CELEBRATION_BONUS', 'CORPORATION_HD_CELEBRATION_BONUS'
	from Resources where (Frequency != 0 or SeaFrequency != 0) and ResourceType not in (select ResourceType from HD_Monopoly_Resource_Categories)
union all
select ResourceType, 'HOUSEHOLD', 'INDUSTRY_HD_HOUSEHOLD_BONUS', 'CORPORATION_HD_HOUSEHOLD_BONUS'
	from Resources where (Frequency != 0 or SeaFrequency != 0) and ResourceType not in (select ResourceType from HD_Monopoly_Resource_Categories);

-- =====================================================================================================================================
-- Requirements
-- =====================================================================================================================================
-- 按Property判定行业效果
insert or ignore into Requirements (RequirementId, RequirementType) select
	'REQUIRES_HD_' || Category || '_INDUSTRY_BONUS', 'REQUIREMENT_PLOT_PROPERTY_MATCHES' from HD_Monopoly_Categories;
insert or ignore into RequirementArguments (RequirementId, Name, Value) select
	'REQUIRES_HD_' || Category || '_INDUSTRY_BONUS', 'PropertyName', 'HD_' || Category || '_INDUSTRY_BONUS' from HD_Monopoly_Categories;
insert or ignore into RequirementArguments (RequirementId, Name, Value) select
	'REQUIRES_HD_' || Category || '_INDUSTRY_BONUS', 'PropertyMinimum', 1 from HD_Monopoly_Categories;

insert or replace into RequirementSets (RequirementSetId, RequirementSetType) select
	'HD_' || Category || '_INDUSTRY_BONUS_REQUIREMENTS', 'REQUIREMENTSET_TEST_ANY' from HD_Monopoly_Categories;
insert or replace into RequirementSetRequirements (RequirementSetId, RequirementId) select
	'HD_' || Category || '_INDUSTRY_BONUS_REQUIREMENTS', 'REQUIRES_HD_' || Category || '_INDUSTRY_BONUS' from HD_Monopoly_Categories;

-- 按Property判定公司效果
insert or ignore into Requirements (RequirementId, RequirementType) select
	'REQUIRES_HD_' || Category || '_CORPORATION_BONUS', 'REQUIREMENT_PLOT_PROPERTY_MATCHES' from HD_Monopoly_Categories;
insert or ignore into RequirementArguments (RequirementId, Name, Value) select
	'REQUIRES_HD_' || Category || '_CORPORATION_BONUS', 'PropertyName', 'HD_' || Category || '_CORPORATION_BONUS' from HD_Monopoly_Categories;
insert or ignore into RequirementArguments (RequirementId, Name, Value) select
	'REQUIRES_HD_' || Category || '_CORPORATION_BONUS', 'PropertyMinimum', 1 from HD_Monopoly_Categories;

insert or replace into RequirementSets (RequirementSetId, RequirementSetType) select
	'HD_' || Category || '_CORPORATION_BONUS_REQUIREMENTS', 'REQUIREMENTSET_TEST_ANY' from HD_Monopoly_Categories;
insert or replace into RequirementSetRequirements (RequirementSetId, RequirementId) select
	'HD_' || Category || '_CORPORATION_BONUS_REQUIREMENTS', 'REQUIRES_HD_' || Category || '_CORPORATION_BONUS' from HD_Monopoly_Categories;

insert or ignore into Requirements (RequirementId, RequirementType) values
	('REQUIRES_CITY_HAS_NO_BUILDING_CANAL',													'REQUIREMENT_CITY_HAS_BUILDING'),
	('HD_PLOT_ADJACENT_TO_IMPROVEMENT_WAREHOUSE_OR_CONTAINER_PORT',	'REQUIREMENT_REQUIREMENTSET_IS_MET');

update Requirements set Inverse = 1 where RequirementId = 'REQUIRES_CITY_HAS_NO_BUILDING_CANAL';

insert or ignore into RequirementArguments (RequirementId, Name, Value) values
	('REQUIRES_CITY_HAS_NO_BUILDING_CANAL',													'BuildingType',  		'BUILDING_CANAL'),
	('HD_PLOT_ADJACENT_TO_IMPROVEMENT_WAREHOUSE_OR_CONTAINER_PORT',	'RequirementSetId', 'HD_PLOT_ADJACENT_TO_IMPROVEMENT_WAREHOUSE_OR_CONTAINER_PORT_REQUIRMENTS');

insert or ignore into RequirementSets (RequirementSetId, RequirementSetType) values
	('CITY_HAS_COMMERCIAL_HUB_AND_PLOT_DOES_NOT_HAVE_INCOMPLETE_WONDER',						'REQUIREMENTSET_TEST_ALL'),
	('CITY_HAS_CAMPUS_AND_PLOT_DOES_NOT_HAVE_INCOMPLETE_WONDER',										'REQUIREMENTSET_TEST_ALL'),
	('CITY_HAS_BUILDING_EXHIBITION_REQUIREMENTS',																		'REQUIREMENTSET_TEST_ALL'),
	('HD_CITY_HAS_BUILDING_EXHIBITION_NO_BUILDING_CANAL',														'REQUIREMENTSET_TEST_ALL'),
	('HD_PLOT_ADJACENT_TO_IMPROVEMENT_WAREHOUSE_OR_CONTAINER_PORT_REQUIRMENTS',  		'REQUIREMENTSET_TEST_ANY'),
	('HD_WAREHOUSE_MANAGEMENT_COMMERCIAL_HUB_REQUIRMENTS',  												'REQUIREMENTSET_TEST_ALL'),
	('HD_WAREHOUSE_MANAGEMENT_HARBOR_REQUIRMENTS',  																'REQUIREMENTSET_TEST_ALL'),
	('HD_WAREHOUSE_MANAGEMENT_INDUSTRIAL_ZONE_REQUIRMENTS',  												'REQUIREMENTSET_TEST_ALL'),
	('HD_PLOT_HAS_INDUSTRY_OR_CORPORATION_REQUIRMENTS',  														'REQUIREMENTSET_TEST_ANY');

insert or ignore into RequirementSetRequirements (RequirementSetId, RequirementId) values
	('CITY_HAS_COMMERCIAL_HUB_AND_PLOT_DOES_NOT_HAVE_INCOMPLETE_WONDER',						'REQUIRES_PLOT_DOES_NOT_HAVE_INCOMPLETE_WONDER'),
	('CITY_HAS_COMMERCIAL_HUB_AND_PLOT_DOES_NOT_HAVE_INCOMPLETE_WONDER',						'REQUIRES_CITY_HAS_DISTRICT_COMMERCIAL_HUB'),
	('CITY_HAS_CAMPUS_AND_PLOT_DOES_NOT_HAVE_INCOMPLETE_WONDER',										'REQUIRES_PLOT_DOES_NOT_HAVE_INCOMPLETE_WONDER'),
	('CITY_HAS_CAMPUS_AND_PLOT_DOES_NOT_HAVE_INCOMPLETE_WONDER',										'REQUIRES_CITY_HAS_DISTRICT_CAMPUS'),
	('CITY_HAS_BUILDING_EXHIBITION_REQUIREMENTS',																		'REQUIRES_CITY_HAS_BUILDING_EXHIBITION'),
	('HD_CITY_HAS_BUILDING_EXHIBITION_NO_BUILDING_CANAL',														'REQUIRES_CITY_HAS_BUILDING_EXHIBITION'),
	('HD_CITY_HAS_BUILDING_EXHIBITION_NO_BUILDING_CANAL',														'REQUIRES_CITY_HAS_NO_BUILDING_CANAL'),
	('HD_PLOT_ADJACENT_TO_IMPROVEMENT_WAREHOUSE_OR_CONTAINER_PORT_REQUIRMENTS',			'REQUIRES_PLOT_ADJACENT_TO_IMPROVEMENT_LEU_WAREHOUSE'),
	('HD_PLOT_ADJACENT_TO_IMPROVEMENT_WAREHOUSE_OR_CONTAINER_PORT_REQUIRMENTS',			'REQUIRES_PLOT_ADJACENT_TO_IMPROVEMENT_LEU_CONTAINER_PORT'),
	('HD_WAREHOUSE_MANAGEMENT_COMMERCIAL_HUB_REQUIRMENTS',													'HD_PLOT_ADJACENT_TO_IMPROVEMENT_WAREHOUSE_OR_CONTAINER_PORT'),
	('HD_WAREHOUSE_MANAGEMENT_COMMERCIAL_HUB_REQUIRMENTS',													'REQUIRES_DISTRICT_IS_COMMERCIAL_HUB'),
	('HD_WAREHOUSE_MANAGEMENT_HARBOR_REQUIRMENTS',																	'HD_PLOT_ADJACENT_TO_IMPROVEMENT_WAREHOUSE_OR_CONTAINER_PORT'),
	('HD_WAREHOUSE_MANAGEMENT_HARBOR_REQUIRMENTS',																	'REQUIRES_DISTRICT_IS_HARBOR'),
	('HD_WAREHOUSE_MANAGEMENT_INDUSTRIAL_ZONE_REQUIRMENTS',													'HD_PLOT_ADJACENT_TO_IMPROVEMENT_WAREHOUSE_OR_CONTAINER_PORT'),
	('HD_WAREHOUSE_MANAGEMENT_INDUSTRIAL_ZONE_REQUIRMENTS',													'REQUIRES_DISTRICT_IS_INDUSTRIAL_ZONE'),
	('HD_PLOT_HAS_INDUSTRY_OR_CORPORATION_REQUIRMENTS',															'REQUIRES_PLOT_HAS_IMPROVEMENT_INDUSTRY'),
	('HD_PLOT_HAS_INDUSTRY_OR_CORPORATION_REQUIRMENTS',															'REQUIRES_PLOT_HAS_IMPROVEMENT_CORPORATION');