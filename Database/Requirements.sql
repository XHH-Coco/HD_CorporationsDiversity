-- =====================================================================================================================================
-- 批量生产
-- =====================================================================================================================================
-- 按Property判定行业效果
insert or ignore into Requirements (RequirementId, RequirementType) select
	'REQUIRES_HD_' || Category || '_INDUSTRY_BONUS', 'REQUIREMENT_PLOT_PROPERTY_MATCHES' from HD_Monopoly_Categories;
insert or ignore into RequirementArguments (RequirementId, Name, Value) select
	'REQUIRES_HD_' || Category || '_INDUSTRY_BONUS', 'PropertyName', 'HD_INDUSTRY_BONUS_' || Category from HD_Monopoly_Categories;
insert or ignore into RequirementArguments (RequirementId, Name, Value) select
	'REQUIRES_HD_' || Category || '_INDUSTRY_BONUS', 'PropertyMinimum', 1 from HD_Monopoly_Categories;

insert or ignore into RequirementSets (RequirementSetId, RequirementSetType) select
	'HD_' || Category || '_INDUSTRY_BONUS_REQUIREMENTS', 'REQUIREMENTSET_TEST_ANY' from HD_Monopoly_Categories;
insert or ignore into RequirementSetRequirements (RequirementSetId, RequirementId) select
	'HD_' || Category || '_INDUSTRY_BONUS_REQUIREMENTS', 'REQUIRES_HD_' || Category || '_INDUSTRY_BONUS' from HD_Monopoly_Categories;

-- 按Property判定公司效果
insert or ignore into Requirements (RequirementId, RequirementType) select
	'REQUIRES_HD_' || Category || '_CORPORATION_BONUS', 'REQUIREMENT_PLOT_PROPERTY_MATCHES' from HD_Monopoly_Categories;
insert or ignore into RequirementArguments (RequirementId, Name, Value) select
	'REQUIRES_HD_' || Category || '_CORPORATION_BONUS', 'PropertyName', 'HD_CORPORATION_BONUS_' || Category from HD_Monopoly_Categories;
insert or ignore into RequirementArguments (RequirementId, Name, Value) select
	'REQUIRES_HD_' || Category || '_CORPORATION_BONUS', 'PropertyMinimum', 1 from HD_Monopoly_Categories;

insert or ignore into RequirementSets (RequirementSetId, RequirementSetType) select
	'HD_' || Category || '_CORPORATION_BONUS_REQUIREMENTS', 'REQUIREMENTSET_TEST_ANY' from HD_Monopoly_Categories;
insert or ignore into RequirementSetRequirements (RequirementSetId, RequirementId) select
	'HD_' || Category || '_CORPORATION_BONUS_REQUIREMENTS', 'REQUIRES_HD_' || Category || '_CORPORATION_BONUS' from HD_Monopoly_Categories;

-- =====================================================================================================================================
-- 其他
-- =====================================================================================================================================
insert or ignore into Requirements (RequirementId, RequirementType) values
	('HD_PLOT_ADJACENT_TO_IMPROVEMENT_WAREHOUSE_OR_CONTAINER_PORT',	'REQUIREMENT_REQUIREMENTSET_IS_MET');

insert or ignore into RequirementArguments (RequirementId, Name, Value) values
	('HD_PLOT_ADJACENT_TO_IMPROVEMENT_WAREHOUSE_OR_CONTAINER_PORT',	'RequirementSetId', 'HD_PLOT_ADJACENT_TO_IMPROVEMENT_WAREHOUSE_OR_CONTAINER_PORT_REQUIREMENTS');

insert or ignore into RequirementSets (RequirementSetId, RequirementSetType) values
	('HD_PLOT_ADJACENT_TO_IMPROVEMENT_WAREHOUSE_OR_CONTAINER_PORT_REQUIREMENTS',  	'REQUIREMENTSET_TEST_ANY'),
	('HD_WAREHOUSE_MANAGEMENT_COMMERCIAL_HUB_REQUIREMENTS',  												'REQUIREMENTSET_TEST_ALL'),
	('HD_WAREHOUSE_MANAGEMENT_HARBOR_REQUIREMENTS',  																'REQUIREMENTSET_TEST_ALL'),
	('HD_WAREHOUSE_MANAGEMENT_INDUSTRIAL_ZONE_REQUIREMENTS',  											'REQUIREMENTSET_TEST_ALL'),
	('HD_PLOT_HAS_INDUSTRY_OR_CORPORATION_REQUIREMENTS',  													'REQUIREMENTSET_TEST_ANY'),
	('HD_PLOT_HAS_LAND_OR_SEA_TRANSNATIONAL_REQUIREMENTS',  												'REQUIREMENTSET_TEST_ANY');

insert or ignore into RequirementSetRequirements (RequirementSetId, RequirementId) values
	('HD_PLOT_ADJACENT_TO_IMPROVEMENT_WAREHOUSE_OR_CONTAINER_PORT_REQUIREMENTS',		'REQUIRES_PLOT_ADJACENT_TO_IMPROVEMENT_LEU_WAREHOUSE'),
	('HD_PLOT_ADJACENT_TO_IMPROVEMENT_WAREHOUSE_OR_CONTAINER_PORT_REQUIREMENTS',		'REQUIRES_PLOT_ADJACENT_TO_IMPROVEMENT_LEU_CONTAINER_PORT'),
	('HD_WAREHOUSE_MANAGEMENT_COMMERCIAL_HUB_REQUIREMENTS',													'HD_PLOT_ADJACENT_TO_IMPROVEMENT_WAREHOUSE_OR_CONTAINER_PORT'),
	('HD_WAREHOUSE_MANAGEMENT_COMMERCIAL_HUB_REQUIREMENTS',													'REQUIRES_DISTRICT_IS_COMMERCIAL_HUB'),
	('HD_WAREHOUSE_MANAGEMENT_HARBOR_REQUIREMENTS',																	'HD_PLOT_ADJACENT_TO_IMPROVEMENT_WAREHOUSE_OR_CONTAINER_PORT'),
	('HD_WAREHOUSE_MANAGEMENT_HARBOR_REQUIREMENTS',																	'REQUIRES_DISTRICT_IS_HARBOR'),
	('HD_WAREHOUSE_MANAGEMENT_INDUSTRIAL_ZONE_REQUIREMENTS',												'HD_PLOT_ADJACENT_TO_IMPROVEMENT_WAREHOUSE_OR_CONTAINER_PORT'),
	('HD_WAREHOUSE_MANAGEMENT_INDUSTRIAL_ZONE_REQUIREMENTS',												'REQUIRES_DISTRICT_IS_INDUSTRIAL_ZONE'),
	('HD_PLOT_HAS_INDUSTRY_OR_CORPORATION_REQUIREMENTS',														'REQUIRES_PLOT_HAS_IMPROVEMENT_INDUSTRY'),
	('HD_PLOT_HAS_INDUSTRY_OR_CORPORATION_REQUIREMENTS',														'REQUIRES_PLOT_HAS_IMPROVEMENT_INDUSTRY_BONUS'),
	('HD_PLOT_HAS_INDUSTRY_OR_CORPORATION_REQUIREMENTS',														'REQUIRES_PLOT_HAS_IMPROVEMENT_INDUSTRY_STRATEGIC'),
	('HD_PLOT_HAS_INDUSTRY_OR_CORPORATION_REQUIREMENTS',														'REQUIRES_PLOT_HAS_IMPROVEMENT_CORPORATION'),
	('HD_PLOT_HAS_INDUSTRY_OR_CORPORATION_REQUIREMENTS',														'REQUIRES_PLOT_HAS_IMPROVEMENT_CORPORATION_BONUS'),
	('HD_PLOT_HAS_INDUSTRY_OR_CORPORATION_REQUIREMENTS',														'REQUIRES_PLOT_HAS_IMPROVEMENT_CORPORATION_STRATEGIC'),
	('PLOT_HAS_IMPROVEMENT_INDUSTRY_REQUIREMENTS',																	'REQUIRES_PLOT_HAS_IMPROVEMENT_INDUSTRY_BONUS'),
	('PLOT_HAS_IMPROVEMENT_INDUSTRY_REQUIREMENTS',																	'REQUIRES_PLOT_HAS_IMPROVEMENT_INDUSTRY_STRATEGIC'),
	('PLOT_HAS_IMPROVEMENT_CORPORATION_REQUIREMENTS',																'REQUIRES_PLOT_HAS_IMPROVEMENT_CORPORATION_BONUS'),
	('PLOT_HAS_IMPROVEMENT_CORPORATION_REQUIREMENTS',																'REQUIRES_PLOT_HAS_IMPROVEMENT_CORPORATION_STRATEGIC'),
	('HD_PLOT_HAS_LAND_OR_SEA_TRANSNATIONAL_REQUIREMENTS',													'REQUIRES_PLOT_HAS_IMPROVEMENT_LEU_TRANSNATIONAL'),
	('HD_PLOT_HAS_LAND_OR_SEA_TRANSNATIONAL_REQUIREMENTS',													'REQUIRES_PLOT_HAS_IMPROVEMENT_LEU_TRANSNATIONAL_SEA');