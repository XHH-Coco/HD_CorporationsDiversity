insert or replace into EnglishText (Tag, Text) values
  -- 城堡庄园
  ("LOC_IMPROVEMENT_CHATEAU_DESCRIPTION_MONOPOLIES",			"+2 [ICON_FOOD] Food, +1 [ICON_Culture] Culture and +1 [ICON_HOUSING] Housing. +1 [ICON_FOOD] Food from every adjacent Bonus resource. +2 [ICON_CULTURE] Culture from every adjacent Luxury resource and Wonder. Provide an extra copy for each adjacent improved Plantation, Farm or Lumber Mill Luxury resource. For each type of adjacent improved Plantation, Farm or Lumber Mill Luxury resource, Château receives its Industry bonus. +1 Appeal to adjacent tiles. Can only be built one per city. Must be placed adjacent to a Bonus or Luxury resource. "),
  -- 行业
  ("LOC_IMPROVEMENT_INDUSTRY_DESCRIPTION",                "An Industry dedicated to a specific resource grants unique bonuses to its city based on the resource's usages. [NEWLINE][NEWLINE]Upon construction, you may choose one of two possible usages for the resource and activate the corresponding bonus. Once the city builds either a Tier 3 Commercial Hub building or a Tier 2 Harbor building, you will then activate the corresponding bonus of the other usage."),
  -- 公司
  ("LOC_IMPROVEMENT_CORPORATION_EXPANSION2_DESCRIPTION",  "A Corporation dedicated to a specific resource inherits industry bonuses and provides unique nationwide bonuses based on the resource's usages. Also enable the city where it is located to develop the corresponding [ICON_GREATWORK_PRODUCT] product. [NEWLINE][NEWLINE]Upon completion, if two industry bonuses of different usages have already been activated, you may choose one of two possible usages for the resource and activate the corresponding Corporation bonus. Once the city builds either a Tier 4 Commercial Hub building or a Tier 3 Harbor building, you will then activate the corresponding bonus of the other usage. [NEWLINE][NEWLINE]Cannot be completely destroyed by natural disasters."),
  -- 仓库
  ("LOC_IMPROVEMENT_LEU_WAREHOUSE_NAME",                  "Warehouse"),
  ("LOC_IMPROVEMENT_LEU_WAREHOUSE_DESCRIPTION",           "+1 [ICON_PRODUCTION] Production to all Industries and Corporations. +1 [ICON_PRODUCTION] Production to all [ICON_TRADEROUTE] Trade Routes. [ICON_GREATWORK_PRODUCT] Products provide +50% [ICON_TOURISM] Tourism in this city. [NEWLINE][NEWLINE]Must be built on a land tile adjacent to a Bonus or Luxury resource. Cannot be built Marsh, Swamp or Geothermal Fissure tiles. Only one may be built in each city, and may not be built adjacent to another Warehouse."),
  -- 埠头
  ("LOC_IMPROVEMENT_LEU_CONTAINER_PORT_NAME",             "Pier"),
  ("LOC_IMPROVEMENT_LEU_CONTAINER_PORT_DESCRIPTION",      "+3 [ICON_GOLD] Gold to all Industries and Corporations. +3 [ICON_GOLD] Gold to all [ICON_TRADEROUTE] Trade Routes. [ICON_GREATWORK_PRODUCT] Products provide +50% [ICON_TOURISM] Tourism in this city. [NEWLINE][NEWLINE]Must be built on a Shallow Sea and Lake tile adjacent to land and adjacent to a Bonus or Luxury resource. Only one may be built in each city, and may not be built adjacent to another Pier."),
  -- 火车站
  ("LOC_IMPROVEMENT_LEU_STATION_DESCRIPTION",             "Improvement built by Tycoon or Military Engineers. Cannot be built Marsh, Swamp or Geothermal Fissure tiles. Only one may be built in each city, and may not be built adjacent to another Station. Railroads are instantly built on current and adjacent passable land tiles. [NEWLINE][NEWLINE]Improvements of this City provided +50% [ICON_TOURISM] Tourism. +50% [ICON_TOURISM] Tourism to [ICON_GREATWORK_PRODUCT] Products in this City if adjacent to Commercial Hub or Harbor districts. [NEWLINE][NEWLINE]Each type of adjacent Specialized districts or adjacent Aqueduct provide corresponding yield to International [ICON_TradeRoute] Trade Routes from this city. This bonus is doubled if this city is fully [ICON_POWER] Powered.");

insert or replace into LocalizedText (Language, Tag, Text) values
  -- 城堡庄园
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_CHATEAU_DESCRIPTION_MONOPOLIES",     "+2 [ICON_FOOD] 食物、+1 [ICON_Culture] 文化值、+1 [ICON_HOUSING] 住房。每相邻1个加成资源+1 [ICON_FOOD] 食物，每相邻1个奢侈资源或奇观+2 [ICON_Culture] 文化值。额外提供一份相邻的且已改良的种植园、农场或伐木场奢侈资源。获得每种与城堡庄园相邻且已改良的种植园、农场或伐木场奢侈资源的对应行业效果。为相邻单元格+1魅力。每个城市仅限建造一座，且必须建在加成或奢侈品资源旁。"),
  -- 行业
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_INDUSTRY_DESCRIPTION",               "致力于一种特定资源的行业，根据资源的用途为其所在城市带来独特加成效果。[NEWLINE][NEWLINE]建成时，可从资源的两种用途中择一，激活该用途所对应的加成效果。当所在城市建成商业中心三级建筑或港口二级建筑后，激活另一种用途所对应的加成效果。"),
  -- 公司
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_CORPORATION_EXPANSION2_DESCRIPTION", "致力于一种特定资源的公司，继承行业加成效果的同时，根据资源的用途带来全国性的独特加成效果；同时允许所在城市开发该资源对应的 [ICON_GREATWORK_PRODUCT] 产品。[NEWLINE][NEWLINE]建成时，若已经解锁了两种用途的行业加成效果，则可从资源的两种用途中择一，激活该用途所对应的公司加成效果。当所在城市建成商业中心四级建筑或港口三级建筑后，激活另一种用途所对应的加成效果。[NEWLINE][NEWLINE]无法被自然灾害完全摧毁。"),
  -- 仓库
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_LEU_WAREHOUSE_NAME",                 "仓库"),
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_LEU_WAREHOUSE_DESCRIPTION",          "所有行业和公司+1 [ICON_PRODUCTION] 生产力。所有 [ICON_TRADEROUTE] 贸易路线+1 [ICON_PRODUCTION] 生产力。本城来自 [ICON_GREATWORK_PRODUCT] 产品的 [ICON_TOURISM] 旅游业绩+50%。[NEWLINE][NEWLINE]必须建在与加成或奢侈资源相邻的单元格上。无法建在沼泽或地热裂缝上。无法建在另一座仓库旁。每个城市仅限建造一座。"),
  -- 埠头
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_LEU_CONTAINER_PORT_NAME",            "埠头"),
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_LEU_CONTAINER_PORT_DESCRIPTION",     "所有行业和公司+3 [ICON_GOLD] 金币。所有 [ICON_TRADEROUTE] 贸易路线+3 [ICON_GOLD] 金币。本城来自 [ICON_GREATWORK_PRODUCT] 产品的 [ICON_TOURISM] 旅游业绩+50%。[NEWLINE][NEWLINE]必须建在与加成或奢侈资源相邻，且与陆地相邻的浅海或湖泊单元格上。无法建在另一座埠头旁。每个城市仅限建造一座。"),
  -- 火车站
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_LEU_STATION_DESCRIPTION",            "由大亨或军事工程师建造，不能建在沼泽或地热裂缝上，一座城市只能拥有一个火车站，火车站不能与另一个火车站相邻。在所在单元格和所有相邻的可通行陆地单元格上自动创建铁路。[NEWLINE][NEWLINE]本城改良提供的 [ICON_TOURISM] 旅游业绩+50%。若相邻商业中心或港口，则分别为本城的 [ICON_GREATWORK_PRODUCT] 产品提供的 [ICON_TOURISM] 旅游业绩+50%。[NEWLINE][NEWLINE]相邻的每种专业化区域或水渠为本城出发的国际 [ICON_TradeRoute] 贸易路线提供对应产出；此城 [ICON_POWER] 供电充足时效果翻倍。"),
  -- 跨国公司
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_LEU_TRANSNATIONAL_NAME",             "跨国公司"),
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_LEU_TRANSNATIONAL_DESCRIPTION",      "只能建造在有奢侈品资源或战略资源的无主单元格上。建成后，将占领该单元格，获得该资源，并直接将其产量提供给[ICON_CAPITAL]首都。如果其所在的单元格被掠夺，您将失去该单元格并移除该改良设施。"),
  -- 离岸油轮
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_LEU_TRANSNATIONAL_SEA_NAME",         "离岸油轮"),
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_LEU_TRANSNATIONAL_SEA_DESCRIPTION",  "只能建造在有奢侈品资源或战略资源的无主水域单元格上。将占领该单元格，获得该资源，并直接将其产量提供给[ICON_CAPITAL]首都。如果其所在的单元格被掠夺，您将失去该单元格并移除该改良设施。");
  
 