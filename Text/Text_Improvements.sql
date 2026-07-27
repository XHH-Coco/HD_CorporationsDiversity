insert or replace into EnglishText (Tag, Text) values
  -- 城堡庄园
  ("LOC_IMPROVEMENT_CHATEAU_DESCRIPTION_MONOPOLIES",			"+2 [ICON_FOOD] Food, +1 [ICON_Culture] Culture and +1 [ICON_HOUSING] Housing. +1 [ICON_FOOD] Food and [ICON_PRODUCTION] Production from every adjacent district. +2 [ICON_CULTURE] Culture from every adjacent Wonder. +1 [ICON_CULTURE] Culture from every Château in your empire. +1 Appeal to adjacent tiles. [NEWLINE]Upon construction, you may choose an improved Resource in this city of Crops, Fruit, Brewing or Beverage Usage as the ""[COLOR:Green]Production Resource[ENDCOLOR]"" for this Château. When the city has built a Medieval or later Wonder, you may choose an improved Resource in this city of Cloth, Art, Decoration or Ornamental Usage as the ""[COLOR:219,112,147,255]Entertainment Resource[ENDCOLOR]"" for this Château. The city receives the industrial bonuses of the selected resource; if a luxury resource is chosen, an additional copy of that resource is provided. [NEWLINE]Can only be built one per city."),
  ("LOC_CHATEAU_SELECT_RESOURCE_TITLE",                   "{1_City}: Château"),
  ("LOC_CHATEAU_SELECT_PRODUCTION_RESOURCE_TEXT",         "Manorial economy is a self-sustaining agricultural system: serfs cultivate crops and fruits in the fields, artisans process these harvests into bread, jam, or beverages, while the lord, as the highest ruler of the estate, enjoys a comfortable life... [NEWLINE]Today, a local landowner in {1_CityName} has just established a Château on his hereditary estate and is preparing to send people to collect usable seeds from nearby homes for the first year's cultivation."),
  ("LOC_CHATEAU_SELECT_ENTERTAINMENT_RESOURCE_TEXT",      "In a luxurious Château, elegant nobles dressed in opulent attire and adorned with exquisite jewelry either admired renowned paintings and sculptures collected from around the world in magnificent exhibition halls, or savored tea and coffee in the courtyard filled with rare and exotic flowers. [NEWLINE]Over generations of lordship, this Château in {1_CityName} has accumulated abundant resources and immense wealth. The lord even enslaved serfs to build him a grand medieval church. Now he begins to wonder: what luxuries should he acquire to truly display his wealth and status?"),
  ("LOC_CHATEAU_PRODUCTION_RESOURCE_TEXT",                "[COLOR:Green]Production Resource[ENDCOLOR]: {1_Icon} {2_Resource}"),
  ("LOC_CHATEAU_NO_PRODUCTION_RESOURCE_TEXT",             "[COLOR:Civ6Red]Click this icon to select Production Resource.[ENDCOLOR]"),
  ("LOC_CHATEAU_ENTERTAINMENT_RESOURCE_TEXT",             "[COLOR:219,112,147,255]Entertainment Resource[ENDCOLOR]: {1_Icon} {2_Resource}"),
  ("LOC_CHATEAU_NO_ENTERTAINMENT_RESOURCE_TEXT",          "[COLOR:Civ6Red]Click this icon to select Entertainment Resource.[ENDCOLOR]"),
  ("LOC_CHATEAU_INDUSTRY_TEXT",                           "[NEWLINE]Industry Bonuses: [NEWLINE]{1_Effect}"),
  -- 加成战略资源 行业/公司
  ("LOC_IMPROVEMENT_INDUSTRY_BONUS_NAME",                 "Industry"),
  ("LOC_IMPROVEMENT_INDUSTRY_STRATEGIC_NAME",             "Industry"),
  ("LOC_IMPROVEMENT_CORPORATION_BONUS_NAME",              "Corporation"),
  ("LOC_IMPROVEMENT_CORPORATION_STRATEGIC_NAME",          "Corporation"),

  ("LOC_IMPROVEMENT_IC_BONUS_CITY_DISABLED",             "[COLOR:Red]This city can only build at most {1_Num} {1_Num : plural 1?Industry; other?Industries;} or {1_Num : plural 1?Corporation; other?Corporations;} of Bonus Resource.[ENDCOLOR]"),
  ("LOC_IMPROVEMENT_IC_STRATEGIC_CITY_DISABLED",         "[COLOR:Red]This city can only build at most {1_Num} {1_Num : plural 1?Industry; other?Industries;} or {1_Num : plural 1?Corporation; other?Corporations;} of Strategic Resource.[ENDCOLOR]"),
  ("LOC_IMPROVEMENT_INDUSTRY_PLAYER_DISABLED",           "[COLOR:Red]You have already built Industry or Corporation of {1_Icon} {2_Resource}.[ENDCOLOR]"),
  ("LOC_IMPROVEMENT_CORPORATION_GAME_DISABLED",          "[COLOR:Red]Corporation of {1_Icon} {2_Resource} has already been built in the world.[ENDCOLOR]"),
  ("LOC_IMPROVEMENT_IC_BONUS_RESOURCE_DISABLED",         "[COLOR:Red]You need to control at least {1_Num} {1_Num : plural 1?copy; other?copies;} of {2_Icon} {3_Resource}.[ENDCOLOR]"),
  ("LOC_IMPROVEMENT_IC_STRATEGIC_RESOURCE_DISABLED",     "[COLOR:Red]Need to consume {1_Num} {2_Icon} {3_Resource}. {LOC_DEAL_RESOURCES_NOT_ENOUGH}.[ENDCOLOR]"),
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
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_CHATEAU_DESCRIPTION_MONOPOLIES",     "+2 [ICON_FOOD] 食物、+1 [ICON_HOUSING] 住房。每相邻1个区域+1 [ICON_FOOD] 食物和 [ICON_PRODUCTION] 生产力，每相邻1个奇观+2 [ICON_Culture] 文化值。境内每有一座城堡庄园+1 [ICON_CULTURE] 文化值。为相邻单元格+1魅力。[NEWLINE]建成后，可以从本城改良的庄稼、水果、酿造或饮料资源中选择一个作为该城堡庄园的“[COLOR:Green]生产资源[ENDCOLOR]”；当城市拥有一座中世纪或以后的奇观后，可以从本城改良的服装、艺术、饰品或花木资源中选择一个作为该城堡庄园的“[COLOR:219,112,147,255]娱乐资源[ENDCOLOR]”。该城市获得被选中的资源的行业效果；若选中的为奢侈资源，则额外提供一份该资源。[NEWLINE]每个城市仅限建造一座。"),
  ("zh_Hans_CN",  "LOC_CHATEAU_SELECT_RESOURCE_TITLE",                  "{1_City}建立了城堡庄园"),
  ("zh_Hans_CN",  "LOC_CHATEAU_SELECT_PRODUCTION_RESOURCE_TEXT",        "庄园经济是一种以农业为主的自给自足的经济模式：农奴们在田野间种植庄稼和水果，工匠们负责将这些农作物加工成面包、果酱或饮品，而领主作为庄园的最高统治者则过着优渥的生活……[NEWLINE]现今，{1_CityName}当地的地主在他的世袭领地中刚刚建立起一座城堡庄园，他正准备派人从周围的民居征收一些可用的种子，作为庄园里第一年的耕种作物。"),
  ("zh_Hans_CN",  "LOC_CHATEAU_SELECT_ENTERTAINMENT_RESOURCE_TEXT",     "在豪华的城堡庄园里，优雅的贵族们穿着奢华的礼服，戴着精致的珠宝，或是在金碧辉煌的展厅里品鉴着从各地收集来的名画和雕塑，或是在种满奇花异草的庭院中品味茶和咖啡。[NEWLINE]经过几代领主的经营，{1_CityName}的城堡庄园已经积累了丰饶的物资和无数的财富。领主甚至役使农奴们为他建造起了一座宏伟的中世纪教堂。他开始思考，应该用哪些奢侈品来彰显他的财富与地位呢？"),
  ("zh_Hans_CN",  "LOC_CHATEAU_PRODUCTION_RESOURCE_TEXT",               "[COLOR:Green]生产资源[ENDCOLOR]：{1_Icon} {2_Resource}"),
  ("zh_Hans_CN",  "LOC_CHATEAU_NO_PRODUCTION_RESOURCE_TEXT",            "[COLOR:Civ6Red]点击图标选择生产资源。[ENDCOLOR]"),
  ("zh_Hans_CN",  "LOC_CHATEAU_ENTERTAINMENT_RESOURCE_TEXT",            "[COLOR:219,112,147,255]娱乐资源[ENDCOLOR]：{1_Icon} {2_Resource}"),
  ("zh_Hans_CN",  "LOC_CHATEAU_NO_ENTERTAINMENT_RESOURCE_TEXT",         "[COLOR:Civ6Red]点击图标选择娱乐资源。[ENDCOLOR]"),
  ("zh_Hans_CN",  "LOC_CHATEAU_INDUSTRY_TEXT",                          "[NEWLINE]行业效果：[NEWLINE]{1_Effect}"),
  -- 加成战略资源 行业/公司
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_INDUSTRY_BONUS_NAME",                "行业"),
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_INDUSTRY_STRATEGIC_NAME",            "行业"),
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_CORPORATION_BONUS_NAME",             "公司"),
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_CORPORATION_STRATEGIC_NAME",         "公司"),

  ("zh_Hans_CN",  "LOC_IMPROVEMENT_IC_BONUS_CITY_DISABLED",             "[COLOR:Red]本城最多只能建立{1_Num}座改良加成资源的行业或公司。[ENDCOLOR]"),
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_IC_STRATEGIC_CITY_DISABLED",         "[COLOR:Red]本城最多只能建立{1_Num}座改良战略资源的行业或公司。[ENDCOLOR]"),
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_INDUSTRY_PLAYER_DISABLED",           "[COLOR:Red]你已经建立了 {1_Icon} {2_Resource}行业或公司。[ENDCOLOR]"),
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_CORPORATION_GAME_DISABLED",          "[COLOR:Red]世界上已经建立了 {1_Icon} {2_Resource}公司。[ENDCOLOR]"),
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_IC_BONUS_RESOURCE_DISABLED",         "[COLOR:Red]需要至少控制{1_Num}处 {2_Icon} {3_Resource}资源。[ENDCOLOR]"),
  ("zh_Hans_CN",  "LOC_IMPROVEMENT_IC_STRATEGIC_RESOURCE_DISABLED",     "[COLOR:Red]需要消耗{1_Num} {2_Icon} {3_Resource}，{LOC_DEAL_RESOURCES_NOT_ENOUGH}。[ENDCOLOR]"),
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