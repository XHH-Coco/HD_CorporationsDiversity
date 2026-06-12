-- =========================
-- 批量插入行业公司特效
-- =========================
insert or ignore into ImprovementModifiers (ImprovementType, ModifierId) select 'IMPROVEMENT_INDUSTRY', ModifierId from HD_IndustryModifiers;
insert or ignore into ImprovementModifiers (ImprovementType, ModifierId) select 'IMPROVEMENT_CORPORATION', ModifierId from HD_IndustryModifiers;
insert or ignore into ImprovementModifiers (ImprovementType, ModifierId) select 'IMPROVEMENT_CORPORATION', ModifierId from HD_CorporationModifiers;

-- =====================================================================================================================================
-- 城堡庄园 TODO
-- =====================================================================================================================================
-- create temporary table HD_ChateauResourceModifiers (
-- 	ResourceType text not null,
-- 	IndustryModifierId text not null,
-- 	ChateauAttachModifierId text,
-- 	PlantationAttachModifierId text,
-- 	primary key (ResourceType, IndustryModifierId)
-- );

-- insert or replace into HD_ChateauResourceModifiers
-- 	(ResourceType,		IndustryModifierId)
-- select
-- 	ResourceType,		ModifierId
-- from (HDMonopolyResourceEffects m inner join HD_IndustryModifiers i on m.Category = i.Category)
-- where ResourceType in (select ResourceType from Improvement_ValidResources where ImprovementType in ('IMPROVEMENT_PLANTATION', 'IMPROVEMENT_FARM', 'IMPROVEMENT_LUMBER_MILL'));

-- update HD_ChateauResourceModifiers set ChateauAttachModifierId = ResourceType || '_' || IndustryModifierId || '_CHATEAU_ATTACH';
-- update HD_ChateauResourceModifiers set PlantationAttachModifierId = ResourceType || '_' || IndustryModifierId || '_PLANTATION_ATTACH';

-- insert or replace into ImprovementModifiers (ImprovementType, ModifierId)
-- 	select 'IMPROVEMENT_CHATEAU', ChateauAttachModifierId from HD_ChateauResourceModifiers;

-- insert or replace into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId, SubjectStackLimit)
-- 	select ChateauAttachModifierId, 'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER', 'HD_PLOT_HAS_' || ResourceType || '_ADJACENT', 1
-- from HD_ChateauResourceModifiers;

-- insert or replace into ModifierArguments (ModifierId, Name, Value)
-- 	select ChateauAttachModifierId, 'ModifierId',	PlantationAttachModifierId
-- from HD_ChateauResourceModifiers;

-- insert or replace into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId, SubjectStackLimit) select
-- 	PlantationAttachModifierId,
-- 	'MODIFIER_PLAYER_IMPROVEMENTS_ATTACH_MODIFIER',
-- 	'PLOT_HAS_IMPROVEMENT_CHATEAU_AND_ADJACENT_TO_OWNER_REQUIREMENTS',
-- 	1
-- from HD_ChateauResourceModifiers;

-- insert or replace into ModifierArguments (ModifierId, Name, Value)
-- 	select PlantationAttachModifierId, 'ModifierId', IndustryModifierId
-- from HD_ChateauResourceModifiers;