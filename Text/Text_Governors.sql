insert or replace into EnglishText (Tag, Text) values
  -- ==============================================================================
  -- 维克多
  -- ==============================================================================
  ('LOC_GOVERNOR_PROMOTION_HD_DEFENDER_RIGHT_2_DESCRIPTION',              'Support units trained in this city receive +2 [ICON_MOVEMENT] Movement. Military Engineer units trained in this city gain +2 [ICON_CHARGES] Build charges, provide +3 [ICON_STRENGTH] Combat Strength to adjacent military units, and can establish an Industry on a Strategic resource by consuming 15 of the corresponding Strategic resource and 3 [ICON_CHARGES] Build charges.'),
  ('LOC_GOVERNOR_PROMOTION_HD_DEFENDER_RIGHT_3_DESCRIPTION',              'Each Strategic Industry or Corporation in your territory provides +10% [ICON_PRODUCTION] Production and [ICON_Science] Science to this city.'),
  -- ==============================================================================
  -- 马格努斯
  -- ==============================================================================
  ('LOC_GOVERNOR_PROMOTION_HD_MANAGER_LEFT_2_DESCRIPTION',                'All Builders can establish an Industry on a Bonus resource by consuming 4 [ICON_CHARGES] Build charges. For each Industrial Zone building in this city, you may establish one additional Industry on a Bonus resource.'),
  -- ==============================================================================
  -- 瑞娜
  -- ==============================================================================
  ('LOC_GOVERNOR_PROMOTION_HD_MERCHANT_LEFT_1_DESCRIPTION',               'Purchasing units in this city costs 15% less. Purchasing Merchants, Tycoons, Investors, and Overseas Investors costs an additional 15% less.'),
  ('LOC_GOVERNOR_PROMOTION_HD_MERCHANT_LEFT_2_DESCRIPTION',               'This city can train {LOC_UNIT_HD_OVERSEAS_INVESTOR_NAME}. {LOC_UNIT_HD_OVERSEAS_INVESTOR_DESCRIPTION}'),
  ('LOC_GOVERNOR_PROMOTION_HD_MERCHANT_LEFT_3_DESCRIPTION',               'In cities with Specialty Shop or Entrance Harbour, [ICON_GreatWork_Product] Products +100% [ICON_Tourism] Tourism and 1.5 times of all yields.');

insert or replace into LocalizedText (Language, Tag, Text) values
  -- ==============================================================================
  -- 维克多
  -- ==============================================================================
  ("zh_Hans_CN", "LOC_GOVERNOR_PROMOTION_HD_DEFENDER_RIGHT_2_DESCRIPTION",              "本城生产的支援单位+2 [ICON_MOVEMENT] 移动力。本城训练的军事工程单位+2 [ICON_CHARGES] 建造次数，并为相邻的军事单位+3 [ICON_STRENGTH] 战斗力，且可以消耗15点对应战略资源和3次 [ICON_CHARGES] 建造次数在战略资源上创立行业。"),
  ("zh_Hans_CN", "LOC_GOVERNOR_PROMOTION_HD_DEFENDER_RIGHT_3_DESCRIPTION",              "境内每座战略行业或公司为本城+10% [ICON_PRODUCTION] 生产力和 [ICON_Science] 科技值。"),
  -- ==============================================================================
  -- 马格努斯
  -- ==============================================================================
  ("zh_Hans_CN", "LOC_GOVERNOR_PROMOTION_HD_MANAGER_LEFT_2_DESCRIPTION",                "所有建造者可以消耗4次 [ICON_CHARGES] 建造次数在加成资源上创立行业。本城每有一级工业区建筑，可以额外创立一座加成资源的行业。"),
  -- ==============================================================================
  -- 瑞娜
  -- ==============================================================================
  ("zh_Hans_CN", "LOC_GOVERNOR_PROMOTION_HD_MERCHANT_LEFT_1_DESCRIPTION",               "本城购买单位-15%花费，购买商人、大亨、投资人和海外投资人额外-15%花费。"),
  ("zh_Hans_CN", "LOC_GOVERNOR_PROMOTION_HD_MERCHANT_LEFT_2_DESCRIPTION",               "本城可以训练{LOC_UNIT_HD_OVERSEAS_INVESTOR_NAME}，{LOC_UNIT_HD_OVERSEAS_INVESTOR_DESCRIPTION}"),
  ("zh_Hans_CN", "LOC_GOVERNOR_PROMOTION_HD_MERCHANT_LEFT_3_DESCRIPTION",               "建有特产商行或进口商埠的城市中 [ICON_GreatWork_Product] 产品获得+100% [ICON_Tourism] 旅游业绩和1.5倍所有产出。");