-- =========================
-- 批量插入行业公司特效
-- =========================
insert or ignore into ImprovementModifiers (ImprovementType, ModifierId) select 'IMPROVEMENT_INDUSTRY', ModifierId from HD_IndustryModifiers;
insert or ignore into ImprovementModifiers (ImprovementType, ModifierId) select 'IMPROVEMENT_CORPORATION', ModifierId from HD_IndustryModifiers;
insert or ignore into ImprovementModifiers (ImprovementType, ModifierId) select 'IMPROVEMENT_CORPORATION', ModifierId from HD_CorporationModifiers;

-- =====================================================================================================================================
-- 城堡庄园 TODO
-- =====================================================================================================================================
delete from ImprovementModifiers where ImprovementType = 'IMPROVEMENT_CHATEAU' and ModifierId like 'HD_CHATEAU_GRANT_RESOURCE_%_ATTACH';

create table HD_Chateau_Resources(
	ResourceType      TEXT NOT NULL,
  ResourceClassType TEXT NOT NULL,
	PRIMARY KEY (ResourceType)
);

insert or ignore into HD_Chateau_Resources (ResourceType, ResourceClassType) select
  ResourceType, ResourceClassType
from Resources where ResourceType in
  (select ResourceType from HD_Resource_Classification where ResourceClassificationType in (
    'RESOURCE_CLASSIFICATION_HD_CROPS',
    'RESOURCE_CLASSIFICATION_HD_FRUIT',
    'RESOURCE_CLASSIFICATION_HD_BREWING',
    'RESOURCE_CLASSIFICATION_HD_BEVERAGE',
    'RESOURCE_CLASSIFICATION_HD_CLOTH',
    'RESOURCE_CLASSIFICATION_HD_ART',
    'RESOURCE_CLASSIFICATION_HD_DECORATION',
    'RESOURCE_CLASSIFICATION_HD_ORNAMENTAL'
  ));

create table HD_Chateau_Categories(
	Category TEXT NOT NULL,
	PRIMARY KEY (Category)
);

insert or ignore into HD_Chateau_Categories (Category) select Category
  from HD_Monopoly_Resource_Categories where ResourceType in (select ResourceType from HD_Chateau_Resources);

-- 行业特效modifier只需要写所有庄稼、水果、饮料、酿造、服装、艺术、饰品或花木类资源所对应的行业特效
insert or ignore into ImprovementModifiers (ImprovementType, ModifierId) select 'IMPROVEMENT_CHATEAU', ModifierId
  from HD_IndustryModifiers where Category in (select Category from HD_Chateau_Categories);

-- 送奢侈modifier只需要写所有庄稼、水果、饮料、酿造、服装、艺术、饰品或花木类奢侈资源
insert or ignore into ImprovementModifiers (ImprovementType, ModifierId) select
  'IMPROVEMENT_CHATEAU', 'HD_MONOPOLY_CHATEAU_GRANT_' || ResourceType
from HD_Chateau_Resources where ResourceClassType = 'RESOURCECLASS_LUXURY';

insert or ignore into Modifiers (ModifierId, ModifierType, OwnerRequirementSetId) select
  'HD_MONOPOLY_CHATEAU_GRANT_' || ResourceType, 'MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT', 'HD_MONOPOLY_CHATEAU_GRANT_' || ResourceType || '_REQUIREMENTS'
from HD_Chateau_Resources where ResourceClassType = 'RESOURCECLASS_LUXURY';

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
  'HD_MONOPOLY_CHATEAU_GRANT_' || ResourceType, 'ResourceType', ResourceType
from HD_Chateau_Resources where ResourceClassType = 'RESOURCECLASS_LUXURY';

insert or ignore into ModifierArguments (ModifierId, Name, Value) select
  'HD_MONOPOLY_CHATEAU_GRANT_' || ResourceType, 'Amount', 1
from HD_Chateau_Resources where ResourceClassType = 'RESOURCECLASS_LUXURY';

-- Reqs
insert or ignore into Requirements (RequirementId, RequirementType) select
	'REQUIRES_HD_MONOPOLY_CHATEAU_GRANT_' || ResourceType, 'REQUIREMENT_PLOT_PROPERTY_MATCHES' from HD_Chateau_Resources where ResourceClassType = 'RESOURCECLASS_LUXURY';
insert or ignore into RequirementArguments (RequirementId, Name, Value) select
	'REQUIRES_HD_MONOPOLY_CHATEAU_GRANT_' || ResourceType, 'PropertyName', 'HD_CHATEAU_GRANT_' || ResourceType from HD_Chateau_Resources where ResourceClassType = 'RESOURCECLASS_LUXURY';
insert or ignore into RequirementArguments (RequirementId, Name, Value) select
	'REQUIRES_HD_MONOPOLY_CHATEAU_GRANT_' || ResourceType, 'PropertyMinimum', 1 from HD_Chateau_Resources where ResourceClassType = 'RESOURCECLASS_LUXURY';

insert or ignore into RequirementSets (RequirementSetId, RequirementSetType) select
	'HD_MONOPOLY_CHATEAU_GRANT_' || ResourceType || '_REQUIREMENTS', 'REQUIREMENTSET_TEST_ANY' from HD_Chateau_Resources where ResourceClassType = 'RESOURCECLASS_LUXURY';
insert or ignore into RequirementSetRequirements (RequirementSetId, RequirementId) select
	'HD_MONOPOLY_CHATEAU_GRANT_' || ResourceType || '_REQUIREMENTS', 'REQUIRES_HD_MONOPOLY_CHATEAU_GRANT_' || ResourceType from HD_Chateau_Resources where ResourceClassType = 'RESOURCECLASS_LUXURY';