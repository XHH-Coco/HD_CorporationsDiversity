-- 记录产品项目
insert or ignore into HD_Product_Projects (ProjectType, Cost, NeedCorporation) select
  ProjectType, Cost, 1
from Projects where ProjectType like 'PROJECT_CREATE_CORPORATION_PRODUCT_%';

insert or ignore into HD_Product_Projects (ProjectType, Cost, NeedCorporation) select
  ProjectType, Cost, 0
from Projects where ProjectType like 'PROJECT_CREATE_PRODUCT_%';