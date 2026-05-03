-- =====================================================================================================================================
-- 产品产出
-- =====================================================================================================================================


delete from GreatWork_YieldChanges where GreatWorkType like 'GREATWORK_PRODUCT_%' and GreatWorkType not like 'GREATWORK_PRODUCT_BAVARIA_%';

-- =====================================================================================================================================
-- 删除产品特效
-- =====================================================================================================================================
delete from GreatWorkModifiers where GreatWorkType like 'GREATWORK_PRODUCT_%' and GreatWorkType not like 'GREATWORK_PRODUCT_BAVARIA_%';-- and ModifierID like 'PRODUCT_%'



delete from Projects_XP2 where ProjectType like 'PROJECT_CREATE_CORPORATION_PRODUCT_%';

update Projects set Cost = 160 where ProjectType like 'PROJECT_CREATE_CORPORATION_PRODUCT_%';

-- Tourism
update GreatWorks set Tourism = 18 where GreatWorkType like 'GREATWORK_PRODUCT_%' and GreatWorkType not like 'GREATWORK_PRODUCT_BAVARIA_%';

update GreatWorks set Tourism = 24 where GreatWorkType in
  (select 'GREATWORK_PRODUCT_'||substr(a.ResourceType, 10)||'_'||b.Count
from HDMonopolyResourceEffects a, HDCounter b where Category = 'TOURISM' and Count < 6);

update GreatWorks set Tourism = 24 where GreatWorkType in
  (select 'GREATWORK_PRODUCT_'||substr(a.ResourceType, 10)||'_'||b.Count
from HDMonopolyResourceEffects a, HDCounter b where Category = 'ENTERTAINMENT' and Count < 6);

-- Product Yields
insert or replace into GreatWork_YieldChanges
    (GreatWorkType,                                                 YieldType,          YieldChange)
select
    'GREATWORK_PRODUCT_'||substr(a.ResourceType, 10)||'_'||b.Count, 'YIELD_PRODUCTION', 4
from HDMonopolyResourceEffects a, HDCounter b where Category = 'AMENITY' and Count < 6;

insert or replace into GreatWork_YieldChanges
    (GreatWorkType,                                                 YieldType,          YieldChange)
select
    'GREATWORK_PRODUCT_'||substr(a.ResourceType, 10)||'_'||b.Count, 'YIELD_GOLD',      8
from HDMonopolyResourceEffects a, HDCounter b where Category = 'AMENITY' and Count < 6;

insert or replace into GreatWork_YieldChanges
    (GreatWorkType,                                                 YieldType,          YieldChange)
select
    'GREATWORK_PRODUCT_'||substr(a.ResourceType, 10)||'_'||b.Count, 'YIELD_FOOD',       8
from HDMonopolyResourceEffects a, HDCounter b where Category = 'GROWTH' and Count < 6;

insert or replace into GreatWork_YieldChanges
    (GreatWorkType,                                                 YieldType,          YieldChange)
select
    'GREATWORK_PRODUCT_'||substr(a.ResourceType, 10)||'_'||b.Count, 'YIELD_FAITH',      5
from HDMonopolyResourceEffects a, HDCounter b where Category = 'FAITH' and Count < 6;

insert or replace into GreatWork_YieldChanges
    (GreatWorkType,                                                 YieldType,          YieldChange)
select
    'GREATWORK_PRODUCT_'||substr(a.ResourceType, 10)||'_'||b.Count, 'YIELD_GOLD',       6
from HDMonopolyResourceEffects a, HDCounter b where Category = 'FAITH' and Count < 6;

insert or replace into GreatWork_YieldChanges
    (GreatWorkType,                                                 YieldType,          YieldChange)
select
    'GREATWORK_PRODUCT_'||substr(a.ResourceType, 10)||'_'||b.Count, 'YIELD_SCIENCE',    4
from HDMonopolyResourceEffects a, HDCounter b where Category = 'GPP' and Count < 6;

insert or replace into GreatWork_YieldChanges
    (GreatWorkType,                                                 YieldType,          YieldChange)
select
    'GREATWORK_PRODUCT_'||substr(a.ResourceType, 10)||'_'||b.Count, 'YIELD_CULTURE',    4
from HDMonopolyResourceEffects a, HDCounter b where Category = 'GPP' and Count < 6;

insert or replace into GreatWork_YieldChanges
    (GreatWorkType,                                                 YieldType,          YieldChange)
select
    'GREATWORK_PRODUCT_'||substr(a.ResourceType, 10)||'_'||b.Count, 'YIELD_GOLD',       16
from HDMonopolyResourceEffects a, HDCounter b where Category = 'TRADER' and Count < 6;

insert or replace into GreatWork_YieldChanges
    (GreatWorkType,                                                 YieldType,          YieldChange)
select
    'GREATWORK_PRODUCT_'||substr(a.ResourceType, 10)||'_'||b.Count, 'YIELD_FOOD',       4
from HDMonopolyResourceEffects a, HDCounter b where Category = 'FOOD' and Count < 6;

insert or replace into GreatWork_YieldChanges
    (GreatWorkType,                                                 YieldType,          YieldChange)
select
    'GREATWORK_PRODUCT_'||substr(a.ResourceType, 10)||'_'||b.Count, 'YIELD_GOLD',       8
from HDMonopolyResourceEffects a, HDCounter b where Category = 'FOOD' and Count < 6;

insert or replace into GreatWork_YieldChanges
    (GreatWorkType,                                                 YieldType,          YieldChange)
select
    'GREATWORK_PRODUCT_'||substr(a.ResourceType, 10)||'_'||b.Count, 'YIELD_PRODUCTION', 8
from HDMonopolyResourceEffects a, HDCounter b where Category = 'WONDER' and Count < 6;

insert or replace into GreatWork_YieldChanges
    (GreatWorkType,                                                 YieldType,          YieldChange)
select
    'GREATWORK_PRODUCT_'||substr(a.ResourceType, 10)||'_'||b.Count, 'YIELD_CULTURE',    6
from HDMonopolyResourceEffects a, HDCounter b where Category = 'TOURISM' and Count < 6;

insert or replace into GreatWork_YieldChanges
    (GreatWorkType,                                                 YieldType,          YieldChange)
select
    'GREATWORK_PRODUCT_'||substr(a.ResourceType, 10)||'_'||b.Count, 'YIELD_FOOD',       4
from HDMonopolyResourceEffects a, HDCounter b where Category = 'FISHERY' and Count < 6;

insert or replace into GreatWork_YieldChanges
    (GreatWorkType,                                                 YieldType,          YieldChange)
select
    'GREATWORK_PRODUCT_'||substr(a.ResourceType, 10)||'_'||b.Count, 'YIELD_PRODUCTION', 4
from HDMonopolyResourceEffects a, HDCounter b where Category = 'FISHERY' and Count < 6;