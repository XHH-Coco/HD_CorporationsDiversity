-- 大商开公司 by xiaoxiao
drop table if exists XXCAT_GreatPersonUniqueResources;
create table XXCAT_GreatPersonUniqueResources (
    GreatPersonIndividualType text not null primary key,
    ResourceType text not null
);

insert or ignore into XXCAT_GreatPersonUniqueResources
    (GreatPersonIndividualType,                     ResourceType)
values
    ('GREAT_PERSON_INDIVIDUAL_JOHN_SPILSBURY',      'RESOURCE_TOYS'),
    ('GREAT_PERSON_INDIVIDUAL_HELENA_RUBINSTEIN',   'RESOURCE_COSMETICS'),
    ('GREAT_PERSON_INDIVIDUAL_LEVI_STRAUSS',        'RESOURCE_JEANS'),
    ('GREAT_PERSON_INDIVIDUAL_ESTEE_LAUDER',        'RESOURCE_PERFUME');

update GreatPersonIndividuals set ActionRequiresCompletedDistrictType = null, ActionEffectTileHighlighting = 0 where GreatPersonIndividualType in
    (select GreatPersonIndividualType from XXCAT_GreatPersonUniqueResources);

-- delete from GreatPersonIndividualActionModifiers where GreatPersonIndividualType in
--     (select GreatPersonIndividualType from XXCAT_GreatPersonUniqueResources);

update ModifierArguments set Value = 3 where ModifierId in ('GREATPERSON_GRANT_TOYS','GREATPERSON_GRANT_COSMETICS','GREATPERSON_GRANT_JEANS','GREATPERSON_GRANT_PERFUME') and Name = 'Amount';

update GreatPersonIndividuals set ActionEffectTextOverride = 'LOC_' || GreatPersonIndividualType || '_ACTIVE' where GreatPersonIndividualType in
    (select GreatPersonIndividualType from XXCAT_GreatPersonUniqueResources);

update Resources set Happiness = 0 where ResourceType in ('RESOURCE_TOYS','RESOURCE_COSMETICS','RESOURCE_JEANS','RESOURCE_PERFUME');

insert or replace into HDMonopolyResourceClasses (Category) values
    ('TOYS'),('COSMETICS'),('JEANS'),('PERFUME');

insert or replace into HDMonopolyResourceEffects
    (ResourceType,              Category,       IndustryEffect,                     CorporationEffect,                      ProductEffect)
values
    ('RESOURCE_TOYS',           'TOYS',         'INDUSTRY_HD_TOYS_BONUS',           'CORPORATION_HD_TOYS_BONUS',            Null),
    ('RESOURCE_COSMETICS',      'COSMETICS',    'INDUSTRY_HD_COSMETICS_BONUS',      'CORPORATION_HD_COSMETICS_BONUS',       'PRODUCT_HD_COSMETICS_BONUS'),
    ('RESOURCE_JEANS',          'JEANS',        'INDUSTRY_HD_JEANS_BONUS',          'CORPORATION_HD_JEANS_BONUS',           'PRODUCT_HD_JEANS_BONUS'),
    ('RESOURCE_PERFUME',        'PERFUME',      'INDUSTRY_HD_PERFUME_BONUS',        'CORPORATION_HD_PERFUME_BONUS',         'PRODUCT_HD_PERFUME_BONUS');

insert or replace into ResourceCorporations
    (ResourceType,              ResourceEffect,                         ResourceEffectTExt)
values
    ('RESOURCE_TOYS',           'CORPORATION_HD_TOYS_BONUS',            'LOC_CORPORATION_HD_TOYS_BONUS_DESCRIPTION'),
    ('RESOURCE_COSMETICS',      'CORPORATION_HD_COSMETICS_BONUS',       'LOC_CORPORATION_HD_COSMETICS_BONUS_DESCRIPTION'),
    ('RESOURCE_JEANS',          'CORPORATION_HD_JEANS_BONUS',           'LOC_CORPORATION_HD_JEANS_BONUS_DESCRIPTION'),
    ('RESOURCE_PERFUME',        'CORPORATION_HD_PERFUME_BONUS',         'LOC_CORPORATION_HD_PERFUME_BONUS_DESCRIPTION');
    
insert or replace into HDResourceProducts
    (ResourceType,              ResourceEffect,                         ResourceEffectTExt)
values
    ('RESOURCE_COSMETICS',      'PRODUCT_HD_COSMETICS_BONUS',           'LOC_PRODUCT_HD_COSMETICS_BONUS_DESCRIPTION'),
    ('RESOURCE_JEANS',          'PRODUCT_HD_JEANS_BONUS',               'LOC_PRODUCT_HD_JEANS_BONUS_DESCRIPTION'),
    ('RESOURCE_PERFUME',        'PRODUCT_HD_PERFUME_BONUS',             'LOC_PRODUCT_HD_PERFUME_BONUS_DESCRIPTION');