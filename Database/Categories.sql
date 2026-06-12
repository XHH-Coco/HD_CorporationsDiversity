
-- =====================================================================================================================================
-- 行业公司类别 来自“资源用途”
-- =====================================================================================================================================
insert or replace into HD_Monopoly_Categories (Category, IndustryEffect, CorporationEffect) select
	substr(ResourceClassificationType, 28),
	'INDUSTRY_HD_' || substr(ResourceClassificationType, 28) || '_BONUS',
	'CORPORATION_HD_' || substr(ResourceClassificationType, 28) || '_BONUS'
from HD_ResourceClassificationTypes where ParentClassificationType = 'USAGE';

insert or ignore into HD_Monopoly_Categories (Category, CorporationEffect) values
  ('TOYS',        'CORPORATION_HD_TOYS_BONUS'),
  ('COSMETICS',   'CORPORATION_HD_COSMETICS_BONUS'),
  ('JEANS',       'CORPORATION_HD_JEANS_BONUS'),
  ('PERFUME',     'CORPORATION_HD_PERFUME_BONUS');

-- =====================================================================================================================================
-- 资源的行业公司分类
-- =====================================================================================================================================
insert or replace into HD_Monopoly_Resource_Categories (ResourceType, Category) select
	ResourceType,
	substr(ResourceClassificationType, 28)
from HD_Resource_Classification where ResourceClassificationType in
	(select ResourceClassificationType from HD_ResourceClassificationTypes where ParentClassificationType = 'USAGE');

-- 其他Mod的资源默认为 庆典+家居
insert or replace into HD_Monopoly_Resource_Categories (ResourceType, Category)
select ResourceType, 'CELEBRATION'
	from Resources where (Frequency != 0 or SeaFrequency != 0) and ResourceType not in (select ResourceType from HD_Monopoly_Resource_Categories)
union all
select ResourceType, 'HOUSEHOLD'
	from Resources where (Frequency != 0 or SeaFrequency != 0) and ResourceType not in (select ResourceType from HD_Monopoly_Resource_Categories);

-- 特殊资源
insert or ignore into HD_Monopoly_Resource_Categories (ResourceType, Category) values
  ('RESOURCE_TOYS',       'TOYS'),
  ('RESOURCE_COSMETICS',  'COSMETICS'),
  ('RESOURCE_JEANS',      'JEANS'),
  ('RESOURCE_PERFUME',    'PERFUME');