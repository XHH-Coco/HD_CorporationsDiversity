local INDUSTRY_INDEX = GameInfo.Improvements['IMPROVEMENT_INDUSTRY'].Index;
local CORPORATION_INDEX = GameInfo.Improvements['IMPROVEMENT_CORPORATION'].Index;

local INDUSTRY_BONUS_TAG = 'HD_INDUSTRY_BONUS_';
local CORPORATION_BONUS_TAG = 'HD_CORPORATION_BONUS_';
local CITY_UNLOCK_SECOND_INDUSTRY_TAG = 'HD_CITY_UNLOCK_SECOND_INDUSTRY';
local CITY_UNLOCK_SECOND_CORPORATION_TAG = 'HD_CITY_UNLOCK_SECOND_CORPORATION';

-- 建造行业/公司
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

-- print("==================================================================================")
-- for row in GameInfo.GreatWorks() do
--   if row.Name == Locale.Lookup(row.Name) then
--     print(row.Name)
--   end
-- end

-- local resourceMap = {};
-- for row in GameInfo.HD_Resource_Classification() do
--   if GameInfo.HD_ResourceClassificationTypes[row.ResourceClassificationType].ParentClassificationType == 'USAGE' then
--     local categoryList = resourceMap[row.ResourceType] or {};
--     local category = row.ResourceClassificationType:gsub('RESOURCE_CLASSIFICATION_HD_', '');
--     table.insert(categoryList, category);
--     resourceMap[row.ResourceType] = categoryList;
--   end
-- end

-- for row in GameInfo.Resources() do
--   if row.ResourceClassType == 'RESOURCECLASS_BONUS' then
--     local icon = '[ICON_'.. row.ResourceType .. ']';
--     local name = Locale.Lookup(row.Name);
--     print('("LOC_PROJECT_CREATE_CORPORATION_PRODUCT_' .. row.ResourceType:gsub('RESOURCE_', '') .. '_NAME",             "' .. icon .. ' ' .. name .. ' Corporation: Create New Product"),');
--     print('("LOC_PROJECT_CREATE_CORPORATION_PRODUCT_' .. row.ResourceType:gsub('RESOURCE_', '') .. '_SHORT_NAME",       "' .. icon .. ' Create New ' .. name .. ' Product"),');
--     print('("LOC_PROJECT_CREATE_CORPORATION_PRODUCT_' .. row.ResourceType:gsub('RESOURCE_', '') .. '_DESCRIPTION",      "Create a new product for the world based on the ' .. icon .. ' ' .. name .. ' resource."),');
--     print('')
--   end
-- end

-- for row in GameInfo.Resources() do
--   if row.ResourceClassType == 'RESOURCECLASS_STRATEGIC' then
--     local icon = '[ICON_'.. row.ResourceType .. ']';
--     local name = Locale.Lookup(row.Name);
--     print('("LOC_PROJECT_CREATE_CORPORATION_PRODUCT_' .. row.ResourceType:gsub('RESOURCE_', '') .. '_NAME",             "' .. icon .. ' ' .. name .. ' Corporation: Create New Product"),');
--     print('("LOC_PROJECT_CREATE_CORPORATION_PRODUCT_' .. row.ResourceType:gsub('RESOURCE_', '') .. '_SHORT_NAME",       "' .. icon .. ' Create New ' .. name .. ' Product"),');
--     print('("LOC_PROJECT_CREATE_CORPORATION_PRODUCT_' .. row.ResourceType:gsub('RESOURCE_', '') .. '_DESCRIPTION",      "Create a new product for the world based on the ' .. icon .. ' ' .. name .. ' resource."),');
--     print('')
--   end
-- end
-- print("==================================================================================")

--------------------------------------------------------------
-- Initialize
function Initialize()
	Events.ImprovementAddedToMap.Add(BuildIndustryCorporation);
end
Events.LoadGameViewStateDone.Add(Initialize);