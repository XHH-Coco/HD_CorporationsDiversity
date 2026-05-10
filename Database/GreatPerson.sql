-- 美帝奇
update ModifierArguments set Value = 'GREATWORKSLOT_PRODUCT' where ModifierId = 'GREATPERSON_BANK_GREAT_WORK_SLOTS' and Name = 'GreatWorkSlotType';

-- 大商开公司
insert or ignore into HD_GreatPerson_CreateResources (GreatPersonIndividualType, ResourceType) values
  ('GREAT_PERSON_INDIVIDUAL_JOHN_SPILSBURY',      'RESOURCE_TOYS'),
  ('GREAT_PERSON_INDIVIDUAL_HELENA_RUBINSTEIN',   'RESOURCE_COSMETICS'),
  ('GREAT_PERSON_INDIVIDUAL_LEVI_STRAUSS',        'RESOURCE_JEANS'),
  ('GREAT_PERSON_INDIVIDUAL_ESTEE_LAUDER',        'RESOURCE_PERFUME');

update GreatPersonIndividuals set ActionRequiresCompletedDistrictType = null, ActionEffectTileHighlighting = 0
  where GreatPersonIndividualType in (select GreatPersonIndividualType from HD_GreatPerson_CreateResources);

update ModifierArguments set Value = 3 where ModifierId in (
  'GREATPERSON_GRANT_TOYS',
  'GREATPERSON_GRANT_COSMETICS',
  'GREATPERSON_GRANT_JEANS',
  'GREATPERSON_GRANT_PERFUME'
) and Name = 'Amount';

update GreatPersonIndividuals set ActionEffectTextOverride = 'LOC_' || GreatPersonIndividualType || '_ACTIVE'
  where GreatPersonIndividualType in (select GreatPersonIndividualType from HD_GreatPerson_CreateResources);

update Resources set Happiness = 0 where ResourceType in (
  'RESOURCE_TOYS',
  'RESOURCE_COSMETICS',
  'RESOURCE_JEANS',
  'RESOURCE_PERFUME'
);