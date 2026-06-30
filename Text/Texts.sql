insert or replace into EnglishText (Tag, Text) values
  -- 文明领袖
  ("LOC_TRAIT_CIVILIZATION_AMAZON_DESCRIPTION_MONOPOLIES",          "Grant a Bandeirante after establishing [ICON_CAPITAL] Capital city. All districts (except city centers) will not remove Rainforest. Rainforest tiles provide a standard adjacency bonus for specialty districts, and grant +1 Appeal to adjacent tiles. When establishing an industry for the first time of each resource, grant a Bandeirante and all Bandeirantes receive +1 collection times. When you build Industry or Corporation on Rainforest tiles, immediately activate the corresponding bonus of all its usages."),
  ("LOC_UNIT_HD_BANDEIRANTES_DESCRIPTION_MONOPOLIES",               "Brazilian unique Recon unit, but cannot be trained, purchased or upgraded to a more advanced unit. Its [ICON_STRENGTH] Combat Strength increases according to your era. It automatically creates roads when passing through Woods, Rainforest, Marsh{LOC_OR_SWAMP_NAME}. It can collect resources on unowned rainforest tiles for 4 times. For every two of the same resource collected, the improved Resources on rainforest tiles in your cities gain the yields of that resource."),
  -- 科技 市政
  ("LOC_BOOST_TRIGGER_CAPITALISM_HD",                               "Create a Corporation."),
  ("LOC_BOOST_TRIGGER_LONGDESC_CAPITALISM_HD",                      "The savvy capitalist will do anything for 100% profit, which is providing a model for the study of how the economy works."),
  ("LOC_BOOST_TRIGGER_CLASS_STRUGGLE_HD_MONO",                      "Build 2 Warehouses or Piers."),
  ("LOC_BOOST_TRIGGER_LONGDESC_CLASS_STRUGGLE_HD_MONO",             "Factories and warehouses stand in close rows, and industry is developing at a rapid pace. However, workers are beginning to seek more rights. It's time for workers all over the world to unite."),
  -- 建筑
  ("LOC_BUILDING_EXHIBITION_NAME",                                  "Exhibition Center"),
  ("LOC_BUILDING_EXHIBITION_DESCRIPTION",                           "+3 [ICON_Gold] Gold on improved tiles in this City."),
  ("LOC_BUILDING_CANAL_NAME",                                       "Canal"),
  ("LOC_BUILDING_CANAL_DESCRIPTION",                                "Cities with Canals automatically receive this building."),
  -- 区域
  ("LOC_DISTRICT_CANAL_HD_DESCRIPTION",                             "A district for connecting waterways and promoting water transportation in the city.[NEWLINE]+1 [ICON_GreatWork_Product] Product Slot. +6 [ICON_Gold] Gold for adjacent Improvements. Multiplier of [ICON_Gold] Gold yield from districts at their destination [ICON_TradeRoute] Trade Routes passing through Canal is set to +100% (max. +100%). [NEWLINE]Must be built on flat land. Canals may either go straight through the hex or bend by 60 degrees, connecting two bodies of water or a body of water to a City Center.. However three-way Canal junctures are not allowed and Canals must have a full land tile on each side of the waterway they create. [NEWLINE]Military Engineers can spend a charge to complete 30% of a Canal's production."),
  -- 政策
  ("LOC_POLICY_ECOMMERCE_EXPANSION1_DESCRIPTION",                   "[ICON_TradeRoute] Trade Routes provide +4 [ICON_Production] Production and +15 [ICON_Gold] Gold. [ICON_Greatwork_Product] Products provide +200% [ICON_Tourism] Tourism, doubled when City is fully [ICON_POWER] powered."),
  ("LOC_POLICY_WAREHOUSE_MANAGEMENT_NAME",                          "Warehouse Management"),
  ("LOC_POLICY_WAREHOUSE_MANAGEMENT_DESCRIPTION",                   "+50% adjacency bonuses to Commercial Hub, Harbor and Industrial Zone districts adjacent to Warehouse or Pier Improvement."),
  ("LOC_POLICY_AUTO_STEREO_WAREHOUSE_NAME",                         "Automated Stereoscopic Warehouse"),
  ("LOC_POLICY_AUTO_STEREO_WAREHOUSE_DESCRIPTION",                  "+100% adjacency bonuses to Commercial Hub, Harbor and Industrial Zone districts adjacent to Warehouse or Pier Improvement."),
  -- 单位
  ("LOC_UNIT_LEU_TYCOON_DESCRIPTION",                               "Pricey Civilian unit that may only be purchased with [ICON_GOLD] Gold. Requires Tier 2 building of Commercial Hub or Tier 1 building of Harbor to be purchased.[NEWLINE][NEWLINE]Tycoons can create Industries on Luxury Resource tiles, and after the discovery of Steam Power they can create Railroads and Stations to improve yields, commerce and [ICON_PRODUCTION] Production in your territory."),
  ("LOC_UNIT_LEU_INVESTOR_DESCRIPTION",                             "Pricey Civilian unit that may only be purchased with [ICON_GOLD] Gold. Requires Tier 3 building of Commercial Hub or Tier 2 building of Harbor to be purchased.[NEWLINE][NEWLINE]Investors can found Corporations that allow your civilization to create [ICON_GREATWORK_PRODUCT] Products for additional yields and [ICON_TOURISM] Tourism, or create Warehouses and Container Ports in other civilizations to further strengthen commerce and your Corporations."),
  -- 其他
  ("LOC_HD_CORPORATION",                                            "Corporation");

insert or replace into LocalizedText (Language, Tag, Text) values
  -- 文明领袖
  ("zh_Hans_CN",  "LOC_TRAIT_CIVILIZATION_AMAZON_DESCRIPTION_MONOPOLIES", "建立 [ICON_CAPITAL] 首都后获得一位旗手。除市中心外的区域不移除雨林。雨林单元格为专业化区域提供标准相邻加成，并为相邻的单元格提供+1魅力。首次建立某种资源的行业时，获得一名旗手，且所有旗手+1收集次数。建造在雨林上的行业或公司直接激活所有用途所对应的加成效果。"),
  ("zh_Hans_CN",  "LOC_UNIT_HD_BANDEIRANTES_DESCRIPTION_MONOPOLIES",      "巴西特色侦察单位，无法升级成高级单位，无法在城市中建造或购买该单位。[ICON_STRENGTH] 战斗力随你所处的时代提升。经过森林、雨林或沼泽时自动创建道路。可以收集4次无主雨林单元格上的资源，每收集两个同种资源，境内改良的雨林资源获得该资源的产出。"),
  -- 科技 市政
  ("zh_Hans_CN",  "LOC_BOOST_TRIGGER_CAPITALISM_HD",                      "建造1座公司。"),
  ("zh_Hans_CN",  "LOC_BOOST_TRIGGER_LONGDESC_CAPITALISM_HD",             "精明的资本家为了100%的利润可以做任何事，这正在为发掘经济运行规律的研究提供典型。"),
  ("zh_Hans_CN",  "LOC_BOOST_TRIGGER_CLASS_STRUGGLE_HD_MONO",             "建造2座仓库或埠头。"),
  ("zh_Hans_CN",  "LOC_BOOST_TRIGGER_LONGDESC_CLASS_STRUGGLE_HD_MONO",    "工厂和仓库鳞次栉比，工业飞速发展。然而工人们开始寻求更多的权益。是时候让全世界的工人团结起来了。"),
  -- 建筑
  ("zh_Hans_CN",  "LOC_BUILDING_EXHIBITION_NAME",                         "会展中心"),
  ("zh_Hans_CN",  "LOC_BUILDING_EXHIBITION_DESCRIPTION",                  "本城已改良的单元格+3 [ICON_Gold] 金币。"),
  ("zh_Hans_CN",  "LOC_BUILDING_CANAL_NAME",                              "运河"),
  ("zh_Hans_CN",  "LOC_BUILDING_CANAL_DESCRIPTION",                       "有运河的城市自动获得该建筑。"),
  -- 区域
  ("zh_Hans_CN",  "LOC_DISTRICT_CANAL_HD_DESCRIPTION",                    "城市中专注于沟通水域与促进水运的区域。[NEWLINE]+1 [ICON_GreatWork_Product] 产品槽位。为相邻的单改良设施+6 [ICON_Gold] 金币。如 [ICON_TradeRoute] 贸易路线途径此处，其将从目的地的区域处获得成倍 [ICON_Gold] 金币。[NEWLINE]只能建造在平原上。运河可笔直穿过单元格，也可在其中进行60度转向，连接两块水域单元格或将一块水域单元格与市中心连接。无法建造三向连接运河，且运河在其所建水路的两侧皆必须含有一个完整的陆地单元格。[NEWLINE]军事工程师可消耗1次使用次数来完成运河30%的修建进度。"),
  -- 相邻加成
  ("zh_Hans_CN",  "LOC_WAREHOUSE_ADJ_GOLD",                               "+{1_num} [ICON_GOLD] 金币来自相邻的仓库"),
  ("zh_Hans_CN",  "LOC_WAREHOUSE_ADJ_PRODUCTION",                         "+{1_num} [ICON_Production] 生产力来自相邻的仓库"),
  ("zh_Hans_CN",  "LOC_CONTAINER_PORT_ADJ_GOLD",                          "+{1_num} [ICON_GOLD] 金币来自相邻的埠头"),
  ("zh_Hans_CN",  "LOC_CONTAINER_PORT_ADJ_PRODUCTION",                    "+{1_num} [ICON_Production] 生产力来自相邻的埠头"),
  -- 政策
  ("zh_Hans_CN",  "LOC_POLICY_ECOMMERCE_EXPANSION1_DESCRIPTION",          "所有 [ICON_TradeRoute] 贸易路线+4 [ICON_Production] 生产力、+15 [ICON_Gold] 金币。所有城市来自 [ICON_GreatWork_Product] 产品的 [ICON_Tourism] 旅游业绩+200%；城市 [ICON_POWER] 供电充足时，该效果翻倍。"),
  ("zh_Hans_CN",  "LOC_POLICY_WAREHOUSE_MANAGEMENT_NAME",                 "仓库管理"),
  ("zh_Hans_CN",  "LOC_POLICY_WAREHOUSE_MANAGEMENT_DESCRIPTION",          "相邻仓库或埠头的工业区、商业中心和港口+50%相邻加成。"),
  ("zh_Hans_CN",  "LOC_POLICY_AUTO_STEREO_WAREHOUSE_NAME",                "自动化立体仓库"),
  ("zh_Hans_CN",  "LOC_POLICY_AUTO_STEREO_WAREHOUSE_DESCRIPTION",         "相邻仓库或埠头的工业区、商业中心和港口+100%相邻加成。"),
  -- 单位
  ("zh_Hans_CN",  "LOC_UNIT_LEU_TYCOON_NAME",                             "大亨"),
  ("zh_Hans_CN",  "LOC_UNIT_LEU_TYCOON_DESCRIPTION",                      "需要商业中心二级建筑或港口一级建筑方可建造或购买的高价平民单位。[NEWLINE][NEWLINE]可以在奢侈资源上创建行业，在研究“蒸汽动力”后，他们也可创建铁路和火车站来改善你的领土上的区域产出、贸易和 [ICON_PRODUCTION] 生产力。"),
  ("zh_Hans_CN",  "LOC_UNIT_LEU_INVESTOR_NAME",                           "投资人"),
  ("zh_Hans_CN",  "LOC_UNIT_LEU_INVESTOR_DESCRIPTION",                    "需要商业中心三级建筑或港口二级建筑方可建造或购买的高价平民单位。[NEWLINE][NEWLINE]投资人可以创建公司，让你的文明创造 [ICON_GREATWORK_PRODUCT] 产品以获得额外的产出和 [ICON_TOURISM] 旅游业绩。此外，他们可以用来在其他文明中创建仓库和集装箱港口，进一步强化贸易和你的公司。"),
  -- 其他
  ("zh_Hans_CN",  "LOC_HD_CORPORATION",                                   "公司"),
  ("zh_Hans_CN",  "LOC_POWER_REQUIREMENT_MISC",                           "其他消耗来源"),
  ("zh_Hans_CN",  "LOC_TUTORIAL_CORPORATION_OPPORTUNITY_B",               "我们现在能够利用领土中的奢侈品资源来创建公司。控制或垄断一种奢侈品资源后，即可创建公司。创建公司后可以开发产品，销往其他文明。销往其他城市的产品将增加该公司的金币产出并进一步提升其旅游业绩。");