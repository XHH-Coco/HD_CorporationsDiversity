ExposedMembers.DLHD = ExposedMembers.DLHD or {};
ExposedMembers.DLHD.Utils = ExposedMembers.DLHD.Utils or {};
Utils = ExposedMembers.DLHD.Utils;

local INDUSTRY_INDEX = GameInfo.Improvements['IMPROVEMENT_INDUSTRY'].Index;
local CORPORATION_INDEX = GameInfo.Improvements['IMPROVEMENT_CORPORATION'].Index;
local CHATEAU_INDEX = GameInfo.Improvements['IMPROVEMENT_CHATEAU'].Index;

local INDUSTRY_BONUS_TAG = 'HD_INDUSTRY_BONUS_';
local CORPORATION_BONUS_TAG = 'HD_CORPORATION_BONUS_';
local CITY_UNLOCK_SECOND_INDUSTRY_TAG = 'HD_CITY_UNLOCK_SECOND_INDUSTRY';
local CITY_UNLOCK_SECOND_CORPORATION_TAG = 'HD_CITY_UNLOCK_SECOND_CORPORATION';

-- 巴西UA
local JUNGLE_INDUSTRY_CORPORATION_ALL_CATEGORY_TAG = 'HD_JUNGLE_INDUSTRY_CORPORATION_ALL_CATEGORY';

local FEATURE_JUNGLE_INDEX = GameInfo.Features['FEATURE_JUNGLE'].Index;
-- ======================================================================================================================================================
-- 行业/公司
-- ======================================================================================================================================================
-- 建造行业/公司
local Brazil_Industry_Bandeirante_Tag = 'HD_Brazil_Industry_Bandeirante_';
function BuildIndustryCorporation(x, y, improvementId, playerId, resourceId, isPillaged, isWorked)
  local player = Players[playerId];
  if not player then return; end
  
  local plot = Map.GetPlot(x, y);
  if not plot then return; end

  local resourceInfo = GameInfo.Resources[resourceId];
  if not resourceInfo then return; end

  local city = Cities.GetPlotPurchaseCity(plot);
  if not city then return; end

  local categoryList = {};

  if improvementId == INDUSTRY_INDEX then
    print("建造行业")

    -- 巴西UA 获得旗手和采集次数
    if Utils.CivilizationHasTrait(playerId, 'TRAIT_CIVILIZATION_AMAZON')
      and player:GetProperty(Brazil_Industry_Bandeirante_Tag .. resourceId) ~= 1
    then
      player:SetProperty(Brazil_Industry_Bandeirante_Tag .. resourceId, 1);
      print("巴西首次建立" .. Locale.Lookup(resourceInfo.Name) .. "行业 获得旗手和采集次数");
      player:AttachModifierByID('HD_BANDEIRANTES_ADD_TIMES');
      city:AttachModifierByID('HD_AMAZON_INDUSTRY_GRANT_BANDEIRANTES');
    end


    -- 查询可用行业类别
    print("============================================")
    print("可用行业类别：")
    for row in GameInfo.HD_Monopoly_Resource_Categories() do
      if row.ResourceType == resourceInfo.ResourceType then
        table.insert(categoryList, row.Category);
        print(Locale.Lookup('LOC_RESOURCE_CLASSIFICATION_HD_' .. row.Category .. '_NAME'));
      end
    end
    print("============================================")

    -- 清空其他行业类别的property
    for row in GameInfo.HD_Monopoly_Categories() do
      if plot:GetProperty(INDUSTRY_BONUS_TAG .. row.Category) == 1 then
        plot:SetProperty(INDUSTRY_BONUS_TAG .. row.Category, 0);
      end
    end

    if #categoryList == 1 then
      -- 如果只有一种类别，直接赋值plot property
      plot:SetProperty(INDUSTRY_BONUS_TAG .. categoryList[1], 1);
      print("选择行业类别：" .. Locale.Lookup('LOC_RESOURCE_CLASSIFICATION_HD_' .. categoryList[1] .. '_NAME'));
      ReportingEvents.SendLuaEvent('HD_RefreshIndustryCorporationBanner', {PlayerId = playerId, X = x, Y = y});
    elseif #categoryList > 1 then
      -- 判断城市是否解锁第二行业
      local unlockSecondIndustry = city:GetProperty(CITY_UNLOCK_SECOND_INDUSTRY_TAG) or 0;

      -- 巴西UA 雨林行业直接解锁所有特效
      local HAS_JUNGLE_INDUSTRY_CORPORATION_ALL_CATEGORY = player:GetProperty(JUNGLE_INDUSTRY_CORPORATION_ALL_CATEGORY_TAG) or 0;
      if HAS_JUNGLE_INDUSTRY_CORPORATION_ALL_CATEGORY > 0 and plot:GetFeatureType() == FEATURE_JUNGLE_INDEX then
        unlockSecondIndustry = 1;
      end

      if unlockSecondIndustry > 0 then
        -- 城市已解锁第二行业
        for _, category in ipairs(categoryList) do
          plot:SetProperty(INDUSTRY_BONUS_TAG .. category, 1);
          print("选择行业类别：" .. Locale.Lookup('LOC_RESOURCE_CLASSIFICATION_HD_' .. category .. '_NAME'));
        end
        ReportingEvents.SendLuaEvent('HD_RefreshIndustryCorporationBanner', {PlayerId = playerId, X = x, Y = y});
      else
        -- 城市只能选择一种行业
        if not player:IsHuman() then
          -- 如果是AI，则随机选择一种类别
          local randomIndex = Game.GetRandNum(#categoryList, "Random Industry Category for Player " .. playerId) + 1;
          plot:SetProperty(INDUSTRY_BONUS_TAG .. categoryList[randomIndex], 1);
          print("选择行业类别：" .. Locale.Lookup('LOC_RESOURCE_CLASSIFICATION_HD_' .. categoryList[randomIndex] .. '_NAME'));
          ReportingEvents.SendLuaEvent('HD_RefreshIndustryCorporationBanner', {PlayerId = playerId, X = x, Y = y});
        else
          -- 如果是玩家，则唤起UI面板
          local param = {
            PlayerId = playerId,
            CityName = city:GetName(),
            ResourceType = resourceInfo.ResourceType,
            SelectionList = {}
          };
          for _, category in ipairs(categoryList) do
            table.insert(param.SelectionList, {
              Id = 'HD_SELECTION_INDUSTRY_' .. category,
              ScriptParam = {Category = category, X = x, Y = y}
            });
          end
          ReportingEvents.SendLuaEvent('HD_CallIndustrySelectEvent', param);
        end
      end
    end
  elseif improvementId == CORPORATION_INDEX then
    print("建造公司")

    -- 查询可用公司类别
    print("============================================")
    print("可用公司类别：")
    for row in GameInfo.HD_Monopoly_Resource_Categories() do
      if row.ResourceType == resourceInfo.ResourceType then
        local categoryInfo = GameInfo.HD_Monopoly_Categories[row.Category];
        if categoryInfo then
          if not categoryInfo.IndustryEffect or plot:GetProperty(INDUSTRY_BONUS_TAG .. row.Category) == 1 then
            table.insert(categoryList, row.Category);
            print(Locale.Lookup('LOC_RESOURCE_CLASSIFICATION_HD_' .. row.Category .. '_NAME'));
          end
        end
      end
    end
    print("============================================")

    -- 如果categoryList为空，说明之前没有选择行业效果
    if #categoryList == 0 then
      print("公司categoryList为空，说明之前没有选择行业效果");
      print("重新填充categoryList：");
      for row in GameInfo.HD_Monopoly_Resource_Categories() do
        if row.ResourceType == resourceInfo.ResourceType then
          local categoryInfo = GameInfo.HD_Monopoly_Categories[row.Category];
          if categoryInfo and categoryInfo.IndustryEffect and categoryInfo.CorporationEffect then
            table.insert(categoryList, row.Category);
            print(Locale.Lookup('LOC_RESOURCE_CLASSIFICATION_HD_' .. row.Category .. '_NAME'));
          end
        end
      end
    end

    -- 清空其他公司类别的property
    for row in GameInfo.HD_Monopoly_Categories() do
      if plot:GetProperty(CORPORATION_BONUS_TAG .. row.Category) == 1 then
        plot:SetProperty(CORPORATION_BONUS_TAG .. row.Category, 0);
      end
    end

    if #categoryList == 1 then
      -- 如果只有一种类别，直接赋值plot property
      plot:SetProperty(CORPORATION_BONUS_TAG .. categoryList[1], 1);
      print("选择公司类别：" .. Locale.Lookup('LOC_RESOURCE_CLASSIFICATION_HD_' .. categoryList[1] .. '_NAME'));
      ReportingEvents.SendLuaEvent('HD_RefreshIndustryCorporationBanner', {PlayerId = playerId, X = x, Y = y});
    elseif #categoryList > 1 then
      -- 判断城市是否解锁第二公司
      local unlockSecondCorporation = city:GetProperty(CITY_UNLOCK_SECOND_CORPORATION_TAG) or 0;

      -- 巴西UA 雨林公司直接解锁所有特效
      local HAS_JUNGLE_INDUSTRY_CORPORATION_ALL_CATEGORY = player:GetProperty(JUNGLE_INDUSTRY_CORPORATION_ALL_CATEGORY_TAG) or 0;
      if HAS_JUNGLE_INDUSTRY_CORPORATION_ALL_CATEGORY > 0 and plot:GetFeatureType() == FEATURE_JUNGLE_INDEX then
        unlockSecondCorporation = 1;
      end

      if unlockSecondCorporation > 0 then
        -- 城市已解锁第二公司
        for _, category in ipairs(categoryList) do
          plot:SetProperty(CORPORATION_BONUS_TAG .. category, 1);
          print("选择公司类别：" .. Locale.Lookup('LOC_RESOURCE_CLASSIFICATION_HD_' .. category .. '_NAME'));
        end
        ReportingEvents.SendLuaEvent('HD_RefreshIndustryCorporationBanner', {PlayerId = playerId, X = x, Y = y});
      else
        -- 城市只能选择一种公司
        if not player:IsHuman() then
          -- 如果是AI，则随机选择一种类别
          local randomIndex = Game.GetRandNum(#categoryList, "Random Corporation Category for Player " .. playerId) + 1;
          plot:SetProperty(CORPORATION_BONUS_TAG .. categoryList[randomIndex], 1);
          print("选择公司类别：" .. Locale.Lookup('LOC_RESOURCE_CLASSIFICATION_HD_' .. categoryList[randomIndex] .. '_NAME'));
          ReportingEvents.SendLuaEvent('HD_RefreshIndustryCorporationBanner', {PlayerId = playerId, X = x, Y = y});
        else
          -- 如果是玩家，则唤起UI面板
          local param = {
            PlayerId = playerId,
            CityName = city:GetName(),
            ResourceType = resourceInfo.ResourceType,
            SelectionList = {}
          };
          for _, category in ipairs(categoryList) do
            table.insert(param.SelectionList, {
              Id = 'HD_SELECTION_CORPORATION_' .. category,
              ScriptParam = {Category = category, X = x, Y = y}
            });
          end
          ReportingEvents.SendLuaEvent('HD_CallCorporationSelectEvent', param);
        end
      end
    end
  end
end

-- 处理自定义事件选择
function OnChooseIndustryCorporationCategory(playerId, param)
  local player = Players[playerId];
  local selectionInfo = GameInfo.HD_CustomEventSelections[param.SelectionId];
	local selectionType = selectionInfo.SelectionType;
  local customEventType = selectionInfo.CustomEventType;
	local scriptParam = param.Param;
	local x = scriptParam.X;
	local y = scriptParam.Y;
	local plot = Map.GetPlot(x, y);
  local category = scriptParam.Category;

  if not (customEventType == 'HD_CUSTOMEVENT_SELECT_INDUSTRY_CATEGORY' or customEventType == 'HD_CUSTOMEVENT_SELECT_CORPORATION_CATEGORY') then
		return;
	end

	print("==========================================================================")
	print('OnChooseIndustryCorporationCategory', playerId, param.SelectionId, x, y, category);

  local city = Cities.GetPlotPurchaseCity(plot);
  if not city then return; end

  if player and selectionInfo and plot then
    if customEventType == 'HD_CUSTOMEVENT_SELECT_INDUSTRY_CATEGORY' then
      plot:SetProperty(INDUSTRY_BONUS_TAG .. category, 1);
      print("选择行业类别：" .. Locale.Lookup('LOC_RESOURCE_CLASSIFICATION_HD_' .. category .. '_NAME'));
      ReportingEvents.SendLuaEvent('HD_RefreshIndustryCorporationBanner', {PlayerId = playerId, X = x, Y = y});
    elseif customEventType == 'HD_CUSTOMEVENT_SELECT_CORPORATION_CATEGORY' then
      -- 判断是否需要补齐行业property
      local categoryInfo = GameInfo.HD_Monopoly_Categories[category];
      if categoryInfo and categoryInfo.IndustryEffect and plot:GetProperty(INDUSTRY_BONUS_TAG .. category) ~= 1 then
        plot:SetProperty(INDUSTRY_BONUS_TAG .. category, 1);
        print("补齐行业类别：" .. Locale.Lookup('LOC_RESOURCE_CLASSIFICATION_HD_' .. category .. '_NAME'));
      end
      -- 设置公司property
      plot:SetProperty(CORPORATION_BONUS_TAG .. category, 1);
      print("选择公司类别：" .. Locale.Lookup('LOC_RESOURCE_CLASSIFICATION_HD_' .. category .. '_NAME'));
      ReportingEvents.SendLuaEvent('HD_RefreshIndustryCorporationBanner', {PlayerId = playerId, X = x, Y = y});
    end
  end
end
GameEvents.HD_CustomEvent_OnChooseSelection.Add(OnChooseIndustryCorporationCategory);

-- 建造解锁第二行业/公司的建筑
function BuildingUnlockSecondEffect(playerId, cityId, buildingId, plotId, bOriginalConstruction)
  local player = Players[playerId];
  if not player then return; end

  local city = CityManager.GetCity(playerId, cityId);
  if not city then return; end

  local buildingInfo = GameInfo.Buildings[buildingId];
  if buildingInfo then
    if GameInfo.HD_Building_Unlock_Second_Industry[buildingInfo.BuildingType] ~= nil then
      -- 解锁第二行业
      local cityPlots = city:GetOwnedPlots();
      for _, plot in pairs(cityPlots) do
        if plot and (plot:GetImprovementType() == INDUSTRY_INDEX or plot:GetImprovementType() == CORPORATION_INDEX) then
          local resourceInfo = GameInfo.Resources[plot:GetResourceType()];
          if not resourceInfo then return; end

          for row in GameInfo.HD_Monopoly_Resource_Categories() do
            if row.ResourceType == resourceInfo.ResourceType and plot:GetProperty(INDUSTRY_BONUS_TAG .. row.Category) ~= 1 then
              local categoryInfo = GameInfo.HD_Monopoly_Categories[row.Category];
              if categoryInfo and categoryInfo.IndustryEffect then
                plot:SetProperty(INDUSTRY_BONUS_TAG .. row.Category, 1);
                print(Locale.Lookup(buildingInfo.Name) .. " 解锁行业类别：" .. Locale.Lookup('LOC_RESOURCE_CLASSIFICATION_HD_' .. row.Category .. '_NAME'));
              end
            end
          end
          ReportingEvents.SendLuaEvent('HD_RefreshIndustryCorporationBanner', {PlayerId = playerId, X = plot:GetX(), Y = plot:GetY()});
        end
      end
    elseif GameInfo.HD_Building_Unlock_Second_Corporation[buildingInfo.BuildingType] ~= nil then
      -- 解锁第二公司
      local cityPlots = city:GetOwnedPlots();
      for _, plot in pairs(cityPlots) do
        if plot and plot:GetImprovementType() == CORPORATION_INDEX then
          local resourceInfo = GameInfo.Resources[plot:GetResourceType()];
          if not resourceInfo then return; end

          for row in GameInfo.HD_Monopoly_Resource_Categories() do
            if row.ResourceType == resourceInfo.ResourceType and plot:GetProperty(CORPORATION_BONUS_TAG .. row.Category) ~= 1 then
              local categoryInfo = GameInfo.HD_Monopoly_Categories[row.Category];
              if categoryInfo and categoryInfo.CorporationEffect then
                plot:SetProperty(CORPORATION_BONUS_TAG .. row.Category, 1);
                print(Locale.Lookup(buildingInfo.Name) .. " 解锁公司类别：" .. Locale.Lookup('LOC_RESOURCE_CLASSIFICATION_HD_' .. row.Category .. '_NAME'));
              end
            end
          end
          ReportingEvents.SendLuaEvent('HD_RefreshIndustryCorporationBanner', {PlayerId = playerId, X = plot:GetX(), Y = plot:GetY()});
        end
      end
    end
  end
end
GameEvents.BuildingConstructed.Add(BuildingUnlockSecondEffect)

-- ======================================================================================================================================================
-- 城堡庄园
-- ======================================================================================================================================================
-- 建造法国城堡庄园
local CHATEAU_PRODUCTION_RESOURCE_TAG = 'HD_CHATEAU_PRODUCTION_RESOURCE';
local CHATEAU_ENTERTAINMENT_RESOURCE_TAG = 'HD_CHATEAU_ENTERTAINMENT_RESOURCE';
local CHATEAU_GRANT_RESOURCE_TAG = 'HD_CHATEAU_GRANT_';
local CHATEAU_CAN_CHOOSE_ENTERTAINMENT_RESOURCE_TAG = 'HD_CHATEAU_CAN_CHOOSE_ENTERTAINMENT_RESOURCE';
function BuildChateau(x, y, improvementId, playerId, resourceId, isPillaged, isWorked)
  local player = Players[playerId];
  if not player then return; end
  
  local plot = Map.GetPlot(x, y);
  if not plot then return; end

  local city = Cities.GetPlotPurchaseCity(plot);
  if not city then return; end

  if improvementId == CHATEAU_INDEX then
    print("建造城堡庄园")
    
    -- 清空城堡庄园相关的property
    local productionResourceIndex = plot:GetProperty(CHATEAU_PRODUCTION_RESOURCE_TAG) or -1;
    local entertainmentResourceIndex = plot:GetProperty(CHATEAU_ENTERTAINMENT_RESOURCE_TAG) or -1;
    if productionResourceIndex ~= -1 then
      plot:SetProperty(CHATEAU_PRODUCTION_RESOURCE_TAG, -1);
    end
    if entertainmentResourceIndex ~= -1 then
      plot:SetProperty(CHATEAU_ENTERTAINMENT_RESOURCE_TAG, -1);
    end
    -- 清空其他行业类别的property
    for row in GameInfo.HD_Monopoly_Categories() do
      if plot:GetProperty(INDUSTRY_BONUS_TAG .. row.Category) == 1 then
        plot:SetProperty(INDUSTRY_BONUS_TAG .. row.Category, 0);
      end
    end

    -- 查询本城的合法资源 作为生产资源待选列表
    local resourceMap = Utils.GetCityPlotsResources(playerId, city:GetID(), {
      ClassificationList = {'RESOURCE_CLASSIFICATION_HD_CROPS', 'RESOURCE_CLASSIFICATION_HD_FRUIT', 'RESOURCE_CLASSIFICATION_HD_BREWING', 'RESOURCE_CLASSIFICATION_HD_BEVERAGE'},
      NeedImproved = true
    });
    local resourceList = {};
    for resourceType, has in pairs(resourceMap) do
      if has == true then
        table.insert(resourceList, {
          ResourceType = resourceType,
          DetailParam = {
            IndustryEffect = true
          }
        })
      end
    end

    if player:IsHuman() then
      -- 如果是玩家 唤起界面
      local param = {
        PlayerId = playerId,
        CityName = city:GetName(),
        Type = 'PRODUCTION_RESOURCE',
        X = x,
        Y = y,
        ResourceList = resourceList
      };
      ReportingEvents.SendLuaEvent('HD_CallChateauSelectResourceEvent', param);
    elseif #resourceList > 0 then
      -- 如果是AI 随机选择一个
      local randomIndex = Game.GetRandNum(#resourceList, "Random Chateau Resource for Player " .. playerId) + 1;
      local resourceInfo = GameInfo.Resources[resourceList[randomIndex].ResourceType];

      if resourceInfo then
        ChateauOnChooseResource(playerId, {
          ResourceId = resourceInfo.Index,
          X = x,
          Y = y,
          ScriptParam = {Type = 'PRODUCTION_RESOURCE'}
        });
        print("AI城堡庄园随机选择资源：" .. Locale.Lookup(resourceInfo.Name));
      end

      -- 娱乐资源
      local canChooseEntertainmentResource = city:GetProperty(CHATEAU_CAN_CHOOSE_ENTERTAINMENT_RESOURCE_TAG) or 0;
      if canChooseEntertainmentResource > 0 then
        resourceMap = Utils.GetCityPlotsResources(playerId, cityId, {
          ClassificationList = {'RESOURCE_CLASSIFICATION_HD_CLOTH', 'RESOURCE_CLASSIFICATION_HD_ART', 'RESOURCE_CLASSIFICATION_HD_DECORATION', 'RESOURCE_CLASSIFICATION_HD_ORNAMENTAL'},
          NeedImproved = true
        });

        resourceList = {};
        for resourceType, has in pairs(resourceMap) do
          if has == true then
            table.insert(resourceList, {
              ResourceType = resourceType,
              DetailParam = {
                IndustryEffect = true
              }
            })
          end
        end

        if #resourceList > 0 then
          randomIndex = Game.GetRandNum(#resourceList, "Random Chateau Resource for Player " .. playerId) + 1;
          resourceInfo = GameInfo.Resources[resourceList[randomIndex].ResourceType];

          if resourceInfo then
            ChateauOnChooseResource(playerId, {
              ResourceId = resourceInfo.Index,
              X = x,
              Y = y,
              ScriptParam = {Type = 'ENTERTAINMENT_RESOURCE'}
            });
            print("AI城堡庄园随机选择资源：" .. Locale.Lookup(resourceInfo.Name));
          end
        end
      end
    end
    
  end
end

-- 选择资源
function ChateauOnChooseResource(playerId, param)
  local player = Players[playerId];
  if not player then return; end
  
  local plot = Map.GetPlot(param.X, param.Y);
  if not plot then return; end

  local resourceInfo = GameInfo.Resources[param.ResourceId];
  if not resourceInfo then return; end

  local improvementId = plot:GetImprovementType();
  if improvementId == CHATEAU_INDEX then
    print("城堡庄园选择资源：" .. Locale.Lookup(resourceInfo.Name));

    -- 设置行业类别property 用于实现行业特效
    for row in GameInfo.HD_Monopoly_Resource_Categories() do
      if row.ResourceType == resourceInfo.ResourceType then
        local categoryInfo = GameInfo.HD_Monopoly_Categories[row.Category];
        if categoryInfo and categoryInfo.IndustryEffect then
          if plot:GetProperty(INDUSTRY_BONUS_TAG .. row.Category) ~= 1 then
            plot:SetProperty(INDUSTRY_BONUS_TAG .. row.Category, 1);
            print("城堡庄园提供行业特效：" .. Locale.Lookup('LOC_RESOURCE_CLASSIFICATION_HD_' .. row.Category .. '_NAME'));
          end
        end
      end
    end

    -- 设置资源property 用于送一份奢侈资源
    if resourceInfo.ResourceClassType == 'RESOURCECLASS_LUXURY' then
      plot:SetProperty(CHATEAU_GRANT_RESOURCE_TAG .. resourceInfo.ResourceType, 1);
      print("城堡庄园赠送奢侈资源：" .. Locale.Lookup(resourceInfo.Name));
    end
    
    -- 设置Type property 用于记录城堡庄园的资源
    local scriptParam = param.ScriptParam or {};
    if scriptParam.Type == 'PRODUCTION_RESOURCE' then
      plot:SetProperty(CHATEAU_PRODUCTION_RESOURCE_TAG, param.ResourceId);
      print('记录城堡庄园的生产资源：' .. param.ResourceId);
    elseif scriptParam.Type == 'ENTERTAINMENT_RESOURCE' then
      plot:SetProperty(CHATEAU_ENTERTAINMENT_RESOURCE_TAG, param.ResourceId);
      print('记录城堡庄园的娱乐资源：' .. param.ResourceId);
    end

    -- 刷新描述
    ReportingEvents.SendLuaEvent('HD_RefreshChateauBanner', {PlayerId = playerId, X = param.X, Y = param.Y});
  end
end
GameEvents.HD_ResourceSelection_OnChooseResource.Add(ChateauOnChooseResource);

-- 城市建造中世纪以及以后的奇观
function ChateauWonderCompleted(x, y, buildingId, playerId, cityId, percentComplete, unknown)
  local player = Players[playerId];
  if not player then return; end

  if not Utils.CivilizationHasTrait(playerId, 'TRAIT_CIVILIZATION_IMPROVEMENT_CHATEAU') then return; end

  local era = Utils.GetBuildingEra(buildingId);
  if era >= 2 then
    local city = CityManager.GetCity(playerId, cityId);
    if not city then return; end

    if city:GetProperty(CHATEAU_CAN_CHOOSE_ENTERTAINMENT_RESOURCE_TAG) ~= 1 then
      city:SetProperty(CHATEAU_CAN_CHOOSE_ENTERTAINMENT_RESOURCE_TAG, 1);
    end
    print(Locale.Lookup(city:GetName()) .. '建造了中世纪或以后的奇观：' .. buildingId);

    local cityPlots = city:GetOwnedPlots();
    for _, plot in pairs(cityPlots) do
      if plot and plot:GetImprovementType() == CHATEAU_INDEX then
        -- 如果是AI 随机选择一个
        if not player:IsHuman() then
          local resourceMap = Utils.GetCityPlotsResources(playerId, cityId, {
            ClassificationList = {'RESOURCE_CLASSIFICATION_HD_CLOTH', 'RESOURCE_CLASSIFICATION_HD_ART', 'RESOURCE_CLASSIFICATION_HD_DECORATION', 'RESOURCE_CLASSIFICATION_HD_ORNAMENTAL'},
            NeedImproved = true
          });
  
          local resourceList = {};
          for resourceType, has in pairs(resourceMap) do
            if has == true then
              table.insert(resourceList, {
                ResourceType = resourceType,
                DetailParam = {
                  IndustryEffect = true
                }
              })
            end
          end

          if #resourceList > 0 then
            local randomIndex = Game.GetRandNum(#resourceList, "Random Chateau Resource for Player " .. playerId) + 1;
            local resourceInfo = GameInfo.Resources[resourceList[randomIndex].ResourceType];

            if resourceInfo then
              ChateauOnChooseResource(playerId, {
                ResourceId = resourceInfo.Index,
                X = plot:GetX(),
                Y = plot:GetY(),
                ScriptParam = {Type = 'ENTERTAINMENT_RESOURCE'}
              });
              print("AI城堡庄园随机选择资源：" .. Locale.Lookup(resourceInfo.Name));
            end
          end
        end

        -- 刷新描述
        ReportingEvents.SendLuaEvent('HD_RefreshChateauBanner', {PlayerId = playerId, X = plot:GetX(), Y = plot:GetY()});
      end
    end
    
  end
end
Events.WonderCompleted.Add(ChateauWonderCompleted);

--------------------------------------------------------------
-- Initialize
function Initialize()
	Events.ImprovementAddedToMap.Add(BuildIndustryCorporation);
	Events.ImprovementAddedToMap.Add(BuildChateau);
end
Events.LoadGameViewStateDone.Add(Initialize);