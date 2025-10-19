--------------------------
-- Resourceful 2 by xhh --
--------------------------

CREATE TEMPORARY TABLE "HDResourceful2_Product_Text"(
    "ResourceType"  TEXT
);
insert or replace into HDResourceful2_Product_Text
    (ResourceType)
values
    ("RESOURCE_SPONGE"),("RESOURCE_CASHMERE"),("RESOURCE_SANDALWOOD"),("RESOURCE_EBONY"),("RESOURCE_STRAWBERRY"),("RESOURCE_SALMON"),
    ("RESOURCE_BAMBOO"),("RESOURCE_ALABASTER"),("RESOURCE_QUARTZ"),("RESOURCE_LAPIS"),("RESOURCE_RUBY"),("RESOURCE_PLATINUM"),('RESOURCE_SORGHUM'),
    ("RESOURCE_SEA_URCHIN"),("RESOURCE_COD"),("RESOURCE_WOLF"),("RESOURCE_TIGER"),("RESOURCE_SAKURA"),("RESOURCE_POPPIES"),("RESOURCE_ORCA"),
    ("RESOURCE_LION"),("RESOURCE_TRAVERTINE"),("RESOURCE_TOXINS"),("RESOURCE_SAFFRON"),("RESOURCE_ALOE"),("RESOURCE_MEDIHERBS"),("RESOURCE_SEASHELLS"),
    ("RESOURCE_HAM"),('RESOURCE_MAPLE'),('RESOURCE_CORAL'),('RESOURCE_CAVIAR'),('RESOURCE_MACKEREL'),('RESOURCE_ALGAE'),('RESOURCE_GOLD2'),('RESOURCE_POTATO'),('RESOURCE_MUSHROOMS');

--------------------------------------------------------------------------------
-- Language: en_US
insert or replace into EnglishText
    (Tag,                                                                						Text)
select
	"LOC_PROJECT_CREATE_CORPORATION_PRODUCT_" || substr(ResourceType,10) || "_NAME",			"[ICON_" || ResourceType || "] {LOC_" || ResourceType || "_NAME} Corporation: Create New Product"
from HDResourceful2_Product_Text;

insert or replace into EnglishText
    (Tag,                                                                						Text)
select
	"LOC_PROJECT_CREATE_CORPORATION_PRODUCT_" || substr(ResourceType,10) || "_SHORT_NAME",		"[ICON_" || ResourceType || "] Create New {LOC_" || ResourceType || "_NAME} Product"
from HDResourceful2_Product_Text;

insert or replace into EnglishText
    (Tag,                                                                						Text)
select
	"LOC_PROJECT_CREATE_CORPORATION_PRODUCT_" || substr(ResourceType,10) || "_DESCRIPTION",		"Create a new product for the world based on the [ICON_" || ResourceType || "] {LOC_" || ResourceType || "_NAME} resource."
from HDResourceful2_Product_Text;

--------------------------------------------------------------------------------
-- Language: zh_Hans_CN
insert or replace into LocalizedText
    (Language,      Tag,                                                                					Text)
select
	"zh_Hans_CN",   "LOC_PROJECT_CREATE_CORPORATION_PRODUCT_" || substr(ResourceType,10) || "_NAME",		"[ICON_" || ResourceType || "] {LOC_" || ResourceType || "_NAME}公司：开发新产品"
from HDResourceful2_Product_Text;

insert or replace into LocalizedText
    (Language,      Tag,                                                                					Text)
select
	"zh_Hans_CN",   "LOC_PROJECT_CREATE_CORPORATION_PRODUCT_" || substr(ResourceType,10) || "_SHORT_NAME",	"[ICON_" || ResourceType || "] 开发新的{LOC_" || ResourceType || "_NAME}产品"
from HDResourceful2_Product_Text;

insert or replace into LocalizedText
    (Language,      Tag,                                                                					Text)
select
	"zh_Hans_CN",   "LOC_PROJECT_CREATE_CORPORATION_PRODUCT_" || substr(ResourceType,10) || "_DESCRIPTION",	"利用 [ICON_" || ResourceType || "] {LOC_" || ResourceType || "_NAME}资源为世界开发新产品。"
from HDResourceful2_Product_Text;

--------------------------------------------------------------------------------
-- Language: en_US
insert or replace into EnglishText
    (Tag,                                         Text)
values
    ("LOC_GREATWORK_PRODUCT_SORGHUM_1_NAME",      "Sorghum rice"),
    ("LOC_GREATWORK_PRODUCT_SORGHUM_2_NAME",      "New Year cake"),
    ("LOC_GREATWORK_PRODUCT_SORGHUM_3_NAME",      "Fish noodle"),
    ("LOC_GREATWORK_PRODUCT_SORGHUM_4_NAME",      "Kaoliang spirit"),
    ("LOC_GREATWORK_PRODUCT_SORGHUM_5_NAME",      "Red sorghum"),

    ("LOC_GREATWORK_PRODUCT_LAPIS_1_NAME",        "Afghan emperor green scattered beads"),
    ("LOC_GREATWORK_PRODUCT_LAPIS_2_NAME",        "Lapis lazuli meteorite pendant"),
    ("LOC_GREATWORK_PRODUCT_LAPIS_3_NAME",        "Water jade ice soul bracelet"),
    ("LOC_GREATWORK_PRODUCT_LAPIS_4_NAME",        "The amulet of Veenuri"),
    ("LOC_GREATWORK_PRODUCT_LAPIS_5_NAME",        "Glass wall lamp"),

    ("LOC_GREATWORK_PRODUCT_PLATINUM_1_NAME",     "Platinum electrode catalyst"),
    ("LOC_GREATWORK_PRODUCT_PLATINUM_2_NAME",     "The rings of farkman's dreams"),
    ("LOC_GREATWORK_PRODUCT_PLATINUM_3_NAME",     "Pure white wishing flower"),
    ("LOC_GREATWORK_PRODUCT_PLATINUM_4_NAME",     "PT999- Confession balloon"),
    ("LOC_GREATWORK_PRODUCT_PLATINUM_5_NAME",     "High grade platinum iridium fountain pen"),

    ("LOC_GREATWORK_PRODUCT_RUBY_1_NAME",         "Burmese heart pigeon blood"),
    ("LOC_GREATWORK_PRODUCT_RUBY_2_NAME",         "Brazilian natural red tourmaline ring"),
    ("LOC_GREATWORK_PRODUCT_RUBY_3_NAME",         "18 karat gold inlaid with Burgundy garnet"),
    ("LOC_GREATWORK_PRODUCT_RUBY_4_NAME",         "Mansing jedi spinel"),
    ("LOC_GREATWORK_PRODUCT_RUBY_5_NAME",         "Hot sunflowers"),

    ("LOC_GREATWORK_PRODUCT_SANDALWOOD_1_NAME",   "Indian sandalwood beads"),
    ("LOC_GREATWORK_PRODUCT_SANDALWOOD_2_NAME",   "Tangyu submerged water smoked sandalwood"),
    ("LOC_GREATWORK_PRODUCT_SANDALWOOD_3_NAME",   "Carved sandalwood brave"),
    ("LOC_GREATWORK_PRODUCT_SANDALWOOD_4_NAME",   "The goose and pear are sweet in the tent"),
    ("LOC_GREATWORK_PRODUCT_SANDALWOOD_5_NAME",   "Red sandalwood hand string full of Gold stars"),

    ("LOC_GREATWORK_PRODUCT_POPPIES_1_NAME",      "When is the Spring Flower and autumn Moon -- Li Yu"),
    ("LOC_GREATWORK_PRODUCT_POPPIES_2_NAME",      "Icelandic poppies"),
    ("LOC_GREATWORK_PRODUCT_POPPIES_3_NAME",      "Medicinal poppy seed oil"),
    ("LOC_GREATWORK_PRODUCT_POPPIES_4_NAME",      "Poppies sachet"),
    ("LOC_GREATWORK_PRODUCT_POPPIES_5_NAME",      "Four seasons gardening supplies"),

    ("LOC_GREATWORK_PRODUCT_BAMBOO_1_NAME",       "Kung Fu Panda perimeter pillow"),
    ("LOC_GREATWORK_PRODUCT_BAMBOO_2_NAME",       "Giant panda kitchen knife cutting board"),
    ("LOC_GREATWORK_PRODUCT_BAMBOO_3_NAME",       "Bamboo paper towel"),
    ("LOC_GREATWORK_PRODUCT_BAMBOO_4_NAME",       "Calligraphy paper"),
    ("LOC_GREATWORK_PRODUCT_BAMBOO_5_NAME",       "Xian Zhu Li"),

    ("LOC_GREATWORK_PRODUCT_EBONY_1_NAME",        "Ebony agarwood perfume"),
    ("LOC_GREATWORK_PRODUCT_EBONY_2_NAME",        "Ummy black hair cream"),
    ("LOC_GREATWORK_PRODUCT_EBONY_3_NAME",        "Silk ebony home decoration"),
    ("LOC_GREATWORK_PRODUCT_EBONY_4_NAME",        "Black wood carving of mother and child antelope"),
    ("LOC_GREATWORK_PRODUCT_EBONY_5_NAME",        "Golden carved ebony chopsticks"),

    ("LOC_GREATWORK_PRODUCT_SAKURA_1_NAME",       "Sapling of yoshino sakura"),
    ("LOC_GREATWORK_PRODUCT_SAKURA_2_NAME",       "Cherry blossom deep clean mud membrane"),
    ("LOC_GREATWORK_PRODUCT_SAKURA_3_NAME",       "Congo cherry cabinets"),
    ("LOC_GREATWORK_PRODUCT_SAKURA_4_NAME",       "Quri-Cola Cherry"),
    ("LOC_GREATWORK_PRODUCT_SAKURA_5_NAME",       "Cherry Blossom Campus Simulator"),

    ("LOC_GREATWORK_PRODUCT_CASHMERE_1_NAME",     "Reginae Fashion"),
    ("LOC_GREATWORK_PRODUCT_CASHMERE_2_NAME",     "Round neck cashmere sweater with rich bird"),
    ("LOC_GREATWORK_PRODUCT_CASHMERE_3_NAME",     "Thermal underwear"),
    ("LOC_GREATWORK_PRODUCT_CASHMERE_4_NAME",     "Xiyangyang Needlepoint"),
    ("LOC_GREATWORK_PRODUCT_CASHMERE_5_NAME",     "Alxa cashmere scarf"),

    ("LOC_GREATWORK_PRODUCT_TRAVERTINE_1_NAME",   "Cream white polished floor tile"),
    ("LOC_GREATWORK_PRODUCT_TRAVERTINE_2_NAME",   "Danish light luxury white tea table"),
    ("LOC_GREATWORK_PRODUCT_TRAVERTINE_3_NAME",   "Travertine hot springs"),
    ("LOC_GREATWORK_PRODUCT_TRAVERTINE_4_NAME",   "Siwei Cough powder"),
    ("LOC_GREATWORK_PRODUCT_TRAVERTINE_5_NAME",   "Eight travertine pills"),

    ("LOC_GREATWORK_PRODUCT_ALABASTER_1_NAME",    "Candlestick of northern Europe alabaster"),
    ("LOC_GREATWORK_PRODUCT_ALABASTER_2_NAME",    "Statues of ancient Greek philosophers"),
    ("LOC_GREATWORK_PRODUCT_ALABASTER_3_NAME",    "Florence gypsum powder"),
    ("LOC_GREATWORK_PRODUCT_ALABASTER_4_NAME",    "Egyptian alabaster perfume vase"),
    ("LOC_GREATWORK_PRODUCT_ALABASTER_5_NAME",    "ANVERS polished lamps"),

    ("LOC_GREATWORK_PRODUCT_SPONGE_1_NAME",       "Adristia natural sponge"),
    ("LOC_GREATWORK_PRODUCT_SPONGE_2_NAME",       "Sponge ash painkiller"),
    ("LOC_GREATWORK_PRODUCT_SPONGE_3_NAME",       "Sponge sea water purification plant"),
    ("LOC_GREATWORK_PRODUCT_SPONGE_4_NAME",       "Roman bath sponge"),
    ("LOC_GREATWORK_PRODUCT_SPONGE_5_NAME",       "Squarepants of SpongeBob squarepants"),

    ("LOC_GREATWORK_PRODUCT_SEA_URCHIN_1_NAME",   "Dalian sea urchin sauce"),
    ("LOC_GREATWORK_PRODUCT_SEA_URCHIN_2_NAME",   "Purple sea urchin yellow powder"),
    ("LOC_GREATWORK_PRODUCT_SEA_URCHIN_3_NAME",   "Xiamen chilled sea urchin sashimi"),
    ("LOC_GREATWORK_PRODUCT_SEA_URCHIN_4_NAME",   "Canned sea urchin in Hokkaido juice"),
    ("LOC_GREATWORK_PRODUCT_SEA_URCHIN_5_NAME",   "Live Canadian sea urchin sashimi"),

    ("LOC_GREATWORK_PRODUCT_ORCA_1_NAME",         "Orca baby pillow"),
    ("LOC_GREATWORK_PRODUCT_ORCA_2_NAME",         "Aquarium orca theme photography"),
    ("LOC_GREATWORK_PRODUCT_ORCA_3_NAME",         "Orca microlandscape resin model"),
    ("LOC_GREATWORK_PRODUCT_ORCA_4_NAME",         "Report on the INTELLIGENCE of killer whales"),
    ("LOC_GREATWORK_PRODUCT_ORCA_5_NAME",         "Icelandic Orca Science Guide"),

    ("LOC_GREATWORK_PRODUCT_WOLF_1_NAME",         "Grey Goat and Big Big Wolf cartoon"),
    ("LOC_GREATWORK_PRODUCT_WOLF_2_NAME",         "A mock-up of a Newfoundland white Wolf"),
    ("LOC_GREATWORK_PRODUCT_WOLF_3_NAME",         "Arctic Wolf stuffed animal"),
    ("LOC_GREATWORK_PRODUCT_WOLF_4_NAME",         "Report on the habits of wolves"),
    ("LOC_GREATWORK_PRODUCT_WOLF_5_NAME",         "Septwolves men's wear"),

    ("LOC_GREATWORK_PRODUCT_TIGER_1_NAME",        "Tiger stripes vest"),
    ("LOC_GREATWORK_PRODUCT_TIGER_2_NAME",        "The year of the tiger window"),
    ("LOC_GREATWORK_PRODUCT_TIGER_3_NAME",        "List of State key protected wildlife"),
    ("LOC_GREATWORK_PRODUCT_TIGER_4_NAME",        "Siberian Tiger Picture Album"),
    ("LOC_GREATWORK_PRODUCT_TIGER_5_NAME",        "Gold roller"),

    ("LOC_GREATWORK_PRODUCT_LION_1_NAME",         "Simba -- the Lion King"),
    ("LOC_GREATWORK_PRODUCT_LION_2_NAME",         "Zootopia"),
    ("LOC_GREATWORK_PRODUCT_LION_3_NAME",         "Circus de Medrano"),
    ("LOC_GREATWORK_PRODUCT_LION_4_NAME",         "White marble lion"),
    ("LOC_GREATWORK_PRODUCT_LION_5_NAME",         "Chinese folk art -- Lion Dance"),

    ("LOC_GREATWORK_PRODUCT_TOXINS_1_NAME",       "Camouflage poison dart frog doll"),
    ("LOC_GREATWORK_PRODUCT_TOXINS_2_NAME",       "Handbook for the Endangered Protection of poison dart Frog"),
    ("LOC_GREATWORK_PRODUCT_TOXINS_3_NAME",       "Poison blow arrow model"),
    ("LOC_GREATWORK_PRODUCT_TOXINS_4_NAME",       "Gold poison dart Frog simulation key chain"),
    ("LOC_GREATWORK_PRODUCT_TOXINS_5_NAME",       "Jingdong poison Dart Frog backpack on sale"),

    ("LOC_GREATWORK_PRODUCT_SAFFRON_1_NAME",      "Iranian filament Saffron tea"),
    ("LOC_GREATWORK_PRODUCT_SAFFRON_2_NAME",      "Saffron soap"),
    ("LOC_GREATWORK_PRODUCT_SAFFRON_3_NAME",      "Yulin herbal tea"),
    ("LOC_GREATWORK_PRODUCT_SAFFRON_4_NAME",      "Saffron mud mask"),
    ("LOC_GREATWORK_PRODUCT_SAFFRON_5_NAME",      "Crocus landscape potted plants"),

    ("LOC_GREATWORK_PRODUCT_STRAWBERRY_1_NAME",   "Fresh strawberry fruit scoop"),
    ("LOC_GREATWORK_PRODUCT_STRAWBERRY_2_NAME",   "Strawberry cool tea"),
    ("LOC_GREATWORK_PRODUCT_STRAWBERRY_3_NAME",   "Cupid strawberry jam"),
    ("LOC_GREATWORK_PRODUCT_STRAWBERRY_4_NAME",   "Strawberry cream in jurong box"),
    ("LOC_GREATWORK_PRODUCT_STRAWBERRY_5_NAME",   "Meltybliss strawberry chocolate"),

    ("LOC_GREATWORK_PRODUCT_ALOE_1_NAME",         "Curaçao Aloe Vera Gel"),
    ("LOC_GREATWORK_PRODUCT_ALOE_2_NAME",         "Tequila Sunrise"),
    ("LOC_GREATWORK_PRODUCT_ALOE_3_NAME",         "Aloe Ointment"),
    ("LOC_GREATWORK_PRODUCT_ALOE_4_NAME",         "Honey Aloe Vera Sauce"),
    ("LOC_GREATWORK_PRODUCT_ALOE_5_NAME",         "Fujian Wild Aloe Vera"),

    ("LOC_GREATWORK_PRODUCT_MEDIHERBS_1_NAME",    "Capsule Dendrobii"),
    ("LOC_GREATWORK_PRODUCT_MEDIHERBS_2_NAME",    "Dendrobium Juice"),
    ("LOC_GREATWORK_PRODUCT_MEDIHERBS_3_NAME",    "Woundplast"),
    ("LOC_GREATWORK_PRODUCT_MEDIHERBS_4_NAME",    "Dried Dendrobium"),
    ("LOC_GREATWORK_PRODUCT_MEDIHERBS_5_NAME",    "Dendrobium Toothpaste"),

    ("LOC_GREATWORK_PRODUCT_QUARTZ_1_NAME",       "Jingdezhen Porcelain Glaze"),
    ("LOC_GREATWORK_PRODUCT_QUARTZ_2_NAME",       "Zambian Amethyst"),
    ("LOC_GREATWORK_PRODUCT_QUARTZ_3_NAME",       "Quartz Electronic Watch"),
    ("LOC_GREATWORK_PRODUCT_QUARTZ_4_NAME",       "High-purity Quartz Sand"),
    ("LOC_GREATWORK_PRODUCT_QUARTZ_5_NAME",       "Glazed Marble"),

    ("LOC_GREATWORK_PRODUCT_COD_1_NAME",          "Great Britain Fish Chips"),
    ("LOC_GREATWORK_PRODUCT_COD_2_NAME",          "North Atlantic Cod Liver Oil"),
    ("LOC_GREATWORK_PRODUCT_COD_3_NAME",          "Pollock Roe"),
    ("LOC_GREATWORK_PRODUCT_COD_4_NAME",          "Klippfisk"),
    ("LOC_GREATWORK_PRODUCT_COD_5_NAME",          "Pan Fried Silver Cod"),

    ("LOC_GREATWORK_PRODUCT_SALMON_1_NAME",       "Salmon Sushi"),
    ("LOC_GREATWORK_PRODUCT_SALMON_2_NAME",       "Salmon Sashimi"),
    ("LOC_GREATWORK_PRODUCT_SALMON_3_NAME",       "Smoked Salmon"),
    ("LOC_GREATWORK_PRODUCT_SALMON_4_NAME",       "Salmon Roe"),
    ("LOC_GREATWORK_PRODUCT_SALMON_5_NAME",       "Grilled Salmon Brisket"),

    ("LOC_GREATWORK_PRODUCT_SEASHELLS_1_NAME",    "Bronze Shell oins"),
    ("LOC_GREATWORK_PRODUCT_SEASHELLS_2_NAME",    "Shell Sand Additives"),
    ("LOC_GREATWORK_PRODUCT_SEASHELLS_3_NAME",    "Giant Tridacna"),
    ("LOC_GREATWORK_PRODUCT_SEASHELLS_4_NAME",    "Nautilus Cup"),
    ("LOC_GREATWORK_PRODUCT_SEASHELLS_5_NAME",    "Neapolitan Relief Carving Pearl Shells"),

    ("LOC_GREATWORK_PRODUCT_HAM_1_NAME",    "Jinhua Ham"),
    ("LOC_GREATWORK_PRODUCT_HAM_2_NAME",    "Xuanwei Ham"),
    ("LOC_GREATWORK_PRODUCT_HAM_3_NAME",    "Prosciutto di Parma"),
    ("LOC_GREATWORK_PRODUCT_HAM_4_NAME",    "Jamón Ibérico"),
    ("LOC_GREATWORK_PRODUCT_HAM_5_NAME",    "Rugao Ham"),

    ("LOC_GREATWORK_PRODUCT_MAPLE_1_NAME",    "Potted Zelkova"),
    ("LOC_GREATWORK_PRODUCT_MAPLE_2_NAME",    "Zelkova Nursery Garden"),
    ("LOC_GREATWORK_PRODUCT_MAPLE_3_NAME",    "Zelkova Protection Forest"),
    ("LOC_GREATWORK_PRODUCT_MAPLE_4_NAME",    "Zelkova Furnitures"),
    ("LOC_GREATWORK_PRODUCT_MAPLE_5_NAME",    "Zelkova Bark Heat-Relieving Drink"),

    ("LOC_GREATWORK_PRODUCT_GOLD2_1_NAME",    "Sytontil Ointment"),
    ("LOC_GREATWORK_PRODUCT_GOLD2_2_NAME",    "Vulcanized Rubber"),
    ("LOC_GREATWORK_PRODUCT_GOLD2_3_NAME",    "Vitriol"),
    ("LOC_GREATWORK_PRODUCT_GOLD2_4_NAME",    "Indigo Pigment"),
    ("LOC_GREATWORK_PRODUCT_GOLD2_5_NAME",    "Fireworks"),

    ("LOC_GREATWORK_PRODUCT_CAVIAR_1_NAME",    "Rainbow Trout Raw"),
    ("LOC_GREATWORK_PRODUCT_CAVIAR_2_NAME",    "Lemon-baked Rainbow Trout"),
    ("LOC_GREATWORK_PRODUCT_CAVIAR_3_NAME",    "Rainbow Trout Eggs"),
    ("LOC_GREATWORK_PRODUCT_CAVIAR_4_NAME",    "Pan-fried Rainbow Trout"),
    ("LOC_GREATWORK_PRODUCT_CAVIAR_5_NAME",    "Trout Soup"),

    ("LOC_GREATWORK_PRODUCT_MACKEREL_1_NAME",    "Canned Mackerels"),
    ("LOC_GREATWORK_PRODUCT_MACKEREL_2_NAME",    "Mackerel chips"),
    ("LOC_GREATWORK_PRODUCT_MACKEREL_3_NAME",    "Marinated Mackerel"),
    ("LOC_GREATWORK_PRODUCT_MACKEREL_4_NAME",    "Mackerel Extract Powder"),
    ("LOC_GREATWORK_PRODUCT_MACKEREL_5_NAME",    "Japanese-style Salt-baked Mackerel"),

    ("LOC_GREATWORK_PRODUCT_ALGAE_1_NAME",    "Quick-cooked Sea Mustard"),
    ("LOC_GREATWORK_PRODUCT_ALGAE_2_NAME",    "Marinated Sea Cucumber Salad"),
    ("LOC_GREATWORK_PRODUCT_ALGAE_3_NAME",    "Spicy And Sour Sea Cucumber Strips"),
    ("LOC_GREATWORK_PRODUCT_ALGAE_4_NAME",    "Seaweed Egg Drop Soup"),
    ("LOC_GREATWORK_PRODUCT_ALGAE_5_NAME",    "Sea Sedge"),

    ("LOC_GREATWORK_PRODUCT_CORAL_1_NAME",    "Red Horn-like Coral"),
    ("LOC_GREATWORK_PRODUCT_CORAL_2_NAME",    "Aka Coral Pendant"),
    ("LOC_GREATWORK_PRODUCT_CORAL_3_NAME",    "Baby Face"),
    ("LOC_GREATWORK_PRODUCT_CORAL_4_NAME",    "Angel Skin"),
    ("LOC_GREATWORK_PRODUCT_CORAL_5_NAME",    "Rose Coral"),

    ("LOC_GREATWORK_PRODUCT_POTATO_1_NAME",    "Roasted Sweet Potato"),
    ("LOC_GREATWORK_PRODUCT_POTATO_2_NAME",    "Candied Sweet Potato"),
    ("LOC_GREATWORK_PRODUCT_POTATO_3_NAME",    "Sweet Potato Balls"),
    ("LOC_GREATWORK_PRODUCT_POTATO_4_NAME",    "Baked Sweet Potato With Cheese"),
    ("LOC_GREATWORK_PRODUCT_POTATO_5_NAME",    "Sweet Potato Crisps"),

    ("LOC_GREATWORK_PRODUCT_MUSHROOMS_1_NAME",    "Grilled Mushroom Sticks"),
    ("LOC_GREATWORK_PRODUCT_MUSHROOMS_2_NAME",    "White Mushroom Soup"),
    ("LOC_GREATWORK_PRODUCT_MUSHROOMS_3_NAME",    "Dried Mushroom"),
    ("LOC_GREATWORK_PRODUCT_MUSHROOMS_4_NAME",    "Crispy Fried Mushrooms With Salt And Pepper"),
    ("LOC_GREATWORK_PRODUCT_MUSHROOMS_5_NAME",    "Garlic-flavored Stir-fried Button Mushrooms");

--------------------------------------------------------------------------------
-- Language: zh_Hans_CN
insert or replace into LocalizedText
    (Language,      Tag,                                         Text)
values
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SORGHUM_1_NAME",      "东北农家高粱米"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SORGHUM_2_NAME",      "油炸年糕"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SORGHUM_3_NAME",      "高粱鱼面"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SORGHUM_4_NAME",      "贵州高粱酒"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SORGHUM_5_NAME",      "《红高粱》"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_LAPIS_1_NAME",        "阿富汗帝王青散珠"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_LAPIS_2_NAME",        "青金石陨石背云吊坠"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_LAPIS_3_NAME",        "水玉冰魄手镯"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_LAPIS_4_NAME",        "吠努离护符"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_LAPIS_5_NAME",        "璧琉璃盏"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_PLATINUM_1_NAME",     "铂电极催化剂"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_PLATINUM_2_NAME",     "法卡曼之梦对戒"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_PLATINUM_3_NAME",     "纯白许愿花"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_PLATINUM_4_NAME",     "PT999-告白气球"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_PLATINUM_5_NAME",     "高档铂铱合金钢笔"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_RUBY_1_NAME",         "缅甸心形鸽子血"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_RUBY_2_NAME",         "巴西天然红碧玺戒指"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_RUBY_3_NAME",         "18K金镶酒红石榴石"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_RUBY_4_NAME",         "曼辛绝地武士尖晶石"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_RUBY_5_NAME",         "炙热太阳花"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SANDALWOOD_1_NAME",   "印度老山檀散珠"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SANDALWOOD_2_NAME",   "唐域沉水熏檀香"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SANDALWOOD_3_NAME",   "巴西精雕檀香木貔貅"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SANDALWOOD_4_NAME",   "鹅梨帐中香"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SANDALWOOD_5_NAME",   "满金星紫檀手串"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_POPPIES_1_NAME",      "《虞美人·春花秋月何时了》——李煜"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_POPPIES_2_NAME",      "冰岛虞美人花苗"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_POPPIES_3_NAME",      "药用虞美人籽油"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_POPPIES_4_NAME",      "虞美人香包"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_POPPIES_5_NAME",      "四季园艺用品"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_BAMBOO_1_NAME",       "功夫熊猫周边抱枕"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_BAMBOO_2_NAME",       "熊猫大厨刀砧板"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_BAMBOO_3_NAME",       "竹制纸巾"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_BAMBOO_4_NAME",       "书法宣纸"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_BAMBOO_5_NAME",       "鲜竹沥口服液"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_EBONY_1_NAME",        "乌木沉香香水"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_EBONY_2_NAME",        "乌密青丝膏"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_EBONY_3_NAME",        "金丝乌木家装"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_EBONY_4_NAME",        "乌木雕母子羚像"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_EBONY_5_NAME",        "金雕乌木筷子"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SAKURA_1_NAME",       "染井吉野樱树苗"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SAKURA_2_NAME",       "樱花深层清洁泥膜"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SAKURA_3_NAME",       "刚果樱桃木橱柜"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SAKURA_4_NAME",       "樱桃味可乐"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SAKURA_5_NAME",       "樱花校园模拟器"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_CASHMERE_1_NAME",     "雷吉娜时装"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_CASHMERE_2_NAME",     "富贵鸟圆领羊绒衫"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_CASHMERE_3_NAME",     "北极人保暖内衣"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_CASHMERE_4_NAME",     "喜羊羊图案针织品"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_CASHMERE_5_NAME",     "阿拉善山羊绒围巾"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_TRAVERTINE_1_NAME",   "奶油白抛光地砖"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_TRAVERTINE_2_NAME",   "丹麦轻奢素白茶几"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_TRAVERTINE_3_NAME",   "石灰华温泉花"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_TRAVERTINE_4_NAME",   "四味止咳散"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_TRAVERTINE_5_NAME",   "八味石灰华丸"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_ALABASTER_1_NAME",    "北欧雪花石膏情调烛台"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_ALABASTER_2_NAME",    "古希腊先哲雕塑"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_ALABASTER_3_NAME",    "佛罗伦斯石膏粉"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_ALABASTER_4_NAME",    "埃及雪花石膏香料瓶"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_ALABASTER_5_NAME",    "ANVERS抛光灯具"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SPONGE_1_NAME",       "阿德里斯蒂亚天然海绵"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SPONGE_2_NAME",       "海绵灰止疼剂"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SPONGE_3_NAME",       "海绵海水净化装置"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SPONGE_4_NAME",       "罗马浴海绵"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SPONGE_5_NAME",       "海绵宝宝的方裤衩"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SEA_URCHIN_1_NAME",   "大连海胆酱"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SEA_URCHIN_2_NAME",   "紫海胆黄粉"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SEA_URCHIN_3_NAME",   "厦门冰鲜海胆刺身"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SEA_URCHIN_4_NAME",   "北海道原汁海胆罐头"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SEA_URCHIN_5_NAME",   "加拿大鲜活海胆刺身"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_ORCA_1_NAME",         "虎鲸宝宝抱枕"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_ORCA_2_NAME",         "海洋馆虎鲸主题摄影"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_ORCA_3_NAME",         "虎鲸微景观树脂模型"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_ORCA_4_NAME",         "虎鲸智商研究报告"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_ORCA_5_NAME",         "冰岛虎鲸科普图鉴"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_WOLF_1_NAME",         "灰羊羊与喜太狼动画片"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_WOLF_2_NAME",         "纽芬兰白狼仿真标本"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_WOLF_3_NAME",         "北极狼毛绒玩具"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_WOLF_4_NAME",         "狼的习性研究报告"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_WOLF_5_NAME",         "七匹狼男装"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_TIGER_1_NAME",        "虎纹背心"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_TIGER_2_NAME",        "虎年窗花"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_TIGER_3_NAME",        "国家重点保护野生动物名录"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_TIGER_4_NAME",        "东北虎画册"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_TIGER_5_NAME",        "黄金虎符"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_LION_1_NAME",         "辛巴——狮子王周边"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_LION_2_NAME",         "《动物乌托邦》"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_LION_3_NAME",         "梅德拉诺马戏团"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_LION_4_NAME",         "汉白玉石狮"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_LION_5_NAME",         "中国民间艺术——醒狮"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_TOXINS_1_NAME",       "迷彩箭毒蛙玩偶"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_TOXINS_2_NAME",       "箭毒蛙濒危保护手册"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_TOXINS_3_NAME",       "毒吹箭模型"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_TOXINS_4_NAME",       "黄金箭毒蛙仿真钥匙扣"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_TOXINS_5_NAME",       "京东特卖箭毒蛙型背包"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SAFFRON_1_NAME",      "伊朗长丝藏红花茶"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SAFFRON_2_NAME",      "藏红花香皂"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SAFFRON_3_NAME",      "玉林花草茶"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SAFFRON_4_NAME",      "藏红花泥面膜"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SAFFRON_5_NAME",      "番红花景观盆栽"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_STRAWBERRY_1_NAME",   "鲜草莓水果捞"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_STRAWBERRY_2_NAME",   "草莓清凉茶"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_STRAWBERRY_3_NAME",   "丘比特草莓酱"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_STRAWBERRY_4_NAME",   "句容箱装奶油草莓"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_STRAWBERRY_5_NAME",   "幸福草莓巧克力"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_ALOE_1_NAME",         "库拉索芦荟凝胶"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_ALOE_2_NAME",         "龙舌兰日出"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_ALOE_3_NAME",         "芦荟散"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_ALOE_4_NAME",         "蜂蜜芦荟酱"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_ALOE_5_NAME",         "福建芦荟盆栽"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_MEDIHERBS_1_NAME",    "铁皮枫斗晶"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_MEDIHERBS_2_NAME",    "天台铁皮石斛汁"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_MEDIHERBS_3_NAME",    "外敷跌打散"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_MEDIHERBS_4_NAME",    "干制铁皮石斛"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_MEDIHERBS_5_NAME",    "铁皮石斛牙膏"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_QUARTZ_1_NAME",       "景德镇瓷釉"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_QUARTZ_2_NAME",       "赞比亚紫水晶"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_QUARTZ_3_NAME",       "石英电子表"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_QUARTZ_4_NAME",       "高纯石英砂"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_QUARTZ_5_NAME",       "七彩石英玻璃"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_COD_1_NAME",          "大不列颠炸鱼薯条"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_COD_2_NAME",          "北大西洋深海鱼肝油"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_COD_3_NAME",          "明太子"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_COD_4_NAME",          "挪威干腌鳕鱼"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_COD_5_NAME",          "关谷香煎银鳕鱼"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SALMON_1_NAME",       "挪威厚切三文鱼刺身"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SALMON_2_NAME",       "鹅肝三文鱼寿司"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SALMON_3_NAME",       "瑞典烟熏三文鱼"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SALMON_4_NAME",       "牛油果三文鱼籽酱"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SALMON_5_NAME",       "炙烤三文鱼腩"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SEASHELLS_1_NAME",    "青铜贝币"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SEASHELLS_2_NAME",    "贝壳沙添加剂"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SEASHELLS_3_NAME",    "大砗磲"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SEASHELLS_4_NAME",    "鹦鹉杯"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_SEASHELLS_5_NAME",    "那不勒斯珍珠贝雕"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_HAM_1_NAME",         "金华火腿"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_HAM_2_NAME",         "宣威火腿"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_HAM_3_NAME",         "帕尔玛火腿"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_HAM_4_NAME",         "伊比利亚火腿"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_HAM_5_NAME",         "如皋火腿"),

    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_MAPLE_1_NAME",    "榉树盆栽"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_MAPLE_2_NAME",    "榉树苗圃"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_MAPLE_3_NAME",    "榉树防护林"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_MAPLE_4_NAME",    "榉木家具"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_MAPLE_5_NAME",    "榉树皮祛暑饮"),

    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_GOLD2_1_NAME",    "硫桐脂软膏"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_GOLD2_2_NAME",    "硫化橡胶"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_GOLD2_3_NAME",    "硫酸"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_GOLD2_4_NAME",    "群青"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_GOLD2_5_NAME",    "烟火"),

    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_CAVIAR_1_NAME",    "虹鳟鱼生"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_CAVIAR_2_NAME",    "柠檬烤虹鳟鱼"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_CAVIAR_3_NAME",    "虹鳟鱼卵"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_CAVIAR_4_NAME",    "香煎虹鳟鱼"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_CAVIAR_5_NAME",    "鳟鱼汤"),

    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_MACKEREL_1_NAME",    "鲭鱼罐头"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_MACKEREL_2_NAME",    "鲭属淮山鱼签"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_MACKEREL_3_NAME",    "酱烧鲭鱼"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_MACKEREL_4_NAME",    "鲭鱼肉浸膏"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_MACKEREL_5_NAME",    "日式盐烤鲭鱼"),

    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_ALGAE_1_NAME",    "速食裙带菜"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_ALGAE_2_NAME",    "凉拌海带头"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_ALGAE_3_NAME",    "酸辣海带丝"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_ALGAE_4_NAME",    "紫菜蛋花汤"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_ALGAE_5_NAME",    "海苔"),

    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_CORAL_1_NAME",    "红鹿角珊瑚"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_CORAL_2_NAME",    "阿卡珊瑚吊坠"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_CORAL_3_NAME",    "孩儿面"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_CORAL_4_NAME",    "天使之肌"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_CORAL_5_NAME",    "玫瑰珊瑚"),

    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_POTATO_1_NAME",    "烤番薯"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_POTATO_2_NAME",    "拔丝地瓜"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_POTATO_3_NAME",    "红薯丸子"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_POTATO_4_NAME",    "芝士焗红薯"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_POTATO_5_NAME",    "红薯酥条"),

    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_MUSHROOMS_1_NAME",    "烤口蘑串"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_MUSHROOMS_2_NAME",    "白蘑菇汤"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_MUSHROOMS_3_NAME",    "蘑菇干"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_MUSHROOMS_4_NAME",    "椒盐香煎蘑菇"),
    ("zh_Hans_CN",  "LOC_GREATWORK_PRODUCT_MUSHROOMS_5_NAME",    "蒜香炒口蘑");
