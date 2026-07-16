-- ===========================================================================
--	City Banner Manager overrides for Monopolies & Corporations
-- ===========================================================================
ExposedMembers.DLHD = ExposedMembers.DLHD or {};
ExposedMembers.DLHD.Utils = ExposedMembers.DLHD.Utils or {};
Utils = ExposedMembers.DLHD.Utils;

-- ======================================================================================================================================================
--	CONSTANTS
-- ======================================================================================================================================================
BANNERTYPE_INDUSTRY = UIManager:GetHash("BANNERTYPE_INDUSTRY");
BANNERTYPE_CORPORATION = UIManager:GetHash("BANNERTYPE_CORPORATION");
BANNERTYPE_CHATEAU = UIManager:GetHash("BANNERTYPE_CHATEAU");

local INDUSTRY_INDEX = GameInfo.Improvements['IMPROVEMENT_INDUSTRY'].Index;
local INDUSTRY_BONUS_INDEX = GameInfo.Improvements['IMPROVEMENT_INDUSTRY_BONUS'].Index;
local INDUSTRY_STRATEGIC_INDEX = GameInfo.Improvements['IMPROVEMENT_INDUSTRY_STRATEGIC'].Index;
local CORPORATION_INDEX = GameInfo.Improvements['IMPROVEMENT_CORPORATION'].Index;
local CORPORATION_BONUS_INDEX = GameInfo.Improvements['IMPROVEMENT_CORPORATION_BONUS'].Index;
local CORPORATION_STRATEGIC_INDEX = GameInfo.Improvements['IMPROVEMENT_CORPORATION_STRATEGIC'].Index;
local CHATEAU_INDEX = GameInfo.Improvements['IMPROVEMENT_CHATEAU'].Index;

local INDUSTRY_BONUS_TAG = 'HD_INDUSTRY_BONUS_';
local CORPORATION_BONUS_TAG = 'HD_CORPORATION_BONUS_';
local CHATEAU_PRODUCTION_RESOURCE_TAG = 'HD_CHATEAU_PRODUCTION_RESOURCE';
local CHATEAU_ENTERTAINMENT_RESOURCE_TAG = 'HD_CHATEAU_ENTERTAINMENT_RESOURCE';
local CHATEAU_CAN_CHOOSE_ENTERTAINMENT_RESOURCE_TAG = 'HD_CHATEAU_CAN_CHOOSE_ENTERTAINMENT_RESOURCE';
-- ======================================================================================================================================================
--	MEMBERS
-- ======================================================================================================================================================
local m_IndustryBannerIM = InstanceManager:new("IndustryBanner", "Anchor", Controls.CityBanners);
local m_CorporationBannerIM = InstanceManager:new("CorporationBanner", "Anchor", Controls.CityBanners);
local m_ChateauBannerIM = InstanceManager:new("ChateauBanner", "Anchor", Controls.CityBanners);
local m_ResourceTypeMap = {};

-- base function overrides
local BASE_CityBannerInitializeOtherBannerTypes = CityBanner.InitializeOtherBannerTypes;
local BASE_UpdateColorOtherBannerTypes = CityBanner.UpdateColorOtherBannerTypes;
local BASE_UpdateOtherImprovementBannerTypes = CityBanner.UpdateOtherImprovementBannerTypes;
local BASE_OnImprovementAddedToMap = OnImprovementAddedToMap;
local BASE_Initialize = Initialize;
local BASE_LateInitialize = LateInitialize;

-- ======================================================================================================================================================
-- 建造改良事件
-- ======================================================================================================================================================
function OnImprovementAddedToMap(locX:number, locY:number, eImprovementType:number, eOwner:number)

	if eImprovementType == -1 then
		UI.DataError("Received -1 eImprovementType for ("..tostring(locX)..","..tostring(locY)..") and owner "..tostring(eOwner));
		return;
	end

	local improvementData:table = GameInfo.Improvements[eImprovementType];
	if improvementData == nil then
		UI.DataError("No database entry for eImprovementType #"..tostring(eImprovementType).." for ("..tostring(locX)..","..tostring(locY)..") and owner "..tostring(eOwner));
		return;
	end

	-- 判断是否是行业/公司
	local bIsIndustry:boolean = false;
	local bIsCorporation:boolean = false;
	local improvementDataMODE:table = GameInfo.Improvements_MODE[improvementData.Hash];
	if improvementDataMODE ~= nil then
		if improvementDataMODE.Industry then
			bIsIndustry = true;
		elseif improvementDataMODE.Corporation then
			bIsCorporation = true;
		end
	else
		-- 判断是否是加成战略行业公司
		if eImprovementType == INDUSTRY_BONUS_INDEX or eImprovementType == INDUSTRY_STRATEGIC_INDEX then
			bIsIndustry = true;
		elseif eImprovementType == CORPORATION_BONUS_INDEX or eImprovementType == CORPORATION_STRATEGIC_INDEX then
			bIsCorporation = true;
		end
	end

	-- 判断是否是法国城堡庄园
	local isChateau = false
	if eImprovementType == CHATEAU_INDEX then
		isChateau = true;
	end

	-- we're only here for industries and corporations
	if not bIsIndustry
		and not bIsCorporation
		and not isChateau
	then
		BASE_OnImprovementAddedToMap(locX, locY, eImprovementType, eOwner);
		return;
	end

	local player = Players[eOwner];
	if player ~= nil then
		local plotID = Map.GetPlotIndex(locX, locY);
		if plotID ~= nil then
			local miniBanner = GetMiniBanner(eOwner, plotID);
			if miniBanner == nil then
				if bIsIndustry then
					local ownerCity = Cities.GetPlotPurchaseCity(locX, locY);
					local cityID = ownerCity:GetID();
					-- we're passing the plotID as the districtID argument because we need the location of the improvement
					AddMiniBannerToMap(eOwner, cityID, plotID, BANNERTYPE_INDUSTRY);
				elseif bIsCorporation then
					local ownerCity = Cities.GetPlotPurchaseCity(locX, locY);
					local cityID = ownerCity:GetID();
					-- we're passing the plotID as the districtID argument because we need the location of the improvement
					AddMiniBannerToMap(eOwner, cityID, plotID, BANNERTYPE_CORPORATION);
				elseif isChateau then
					-- 城堡庄园
					local ownerCity = Cities.GetPlotPurchaseCity(locX, locY);
					local cityID = ownerCity:GetID();
					AddMiniBannerToMap(eOwner, cityID, plotID, BANNERTYPE_CHATEAU);
				end
			end
		end
	end
end

-- ======================================================================================================================================================
-- 行业&公司
-- ======================================================================================================================================================
function CityBanner:CreateIndustryBanner()
	-- Set the appropriate instance factory (mini banner one) for this flag...
	self.m_InstanceManager = m_IndustryBannerIM;
	self.m_Instance = self.m_InstanceManager:GetInstance();

	self.m_PlotX, self.m_PlotY = Map.GetPlotLocation(self.m_DistrictID);

	local plot:table = Map.GetPlot( self.m_PlotX, self.m_PlotY );
	local resName:string = m_ResourceTypeMap[plot:GetResourceType()];
	if resName ~= nil then
		self.m_Instance.Icon:SetIcon("ICON_MONOPOLIES_AND_CORPS_" .. resName);

		self.m_IsImprovementBanner = true;

		local toolTipStr:string = Locale.Lookup("LOC_IMPROVEMENT_INDUSTRY_TYPE_NAME", Locale.Lookup("LOC_" .. resName .. "_NAME")) .. GetIndustryEffect(self.m_PlotX, self.m_PlotY);

		self.m_Instance.Icon:SetToolTipString(toolTipStr);
		self.m_Instance.IndustryButton:RegisterCallback(Mouse.eLClick, function() OnClickIndustryCorporationInstanceIcon(self.m_PlotX, self.m_PlotY); end);
	end
end

-- ===========================================================================
function CityBanner:UpdateIndustryBanner()
	local pLocalPlayerVis:table = PlayersVisibility[Game.GetLocalPlayer()];
	local bHidden:boolean = true;
	if (pLocalPlayerVis ~= nil) then
		if pLocalPlayerVis:IsVisible(self.m_PlotX, self.m_PlotY) then
			self.m_FogState = PLOT_VISIBLE;
			bHidden = false;
		elseif pLocalPlayerVis:IsRevealed(self.m_PlotX, self.m_PlotY) then
			self.m_FogState = PLOT_REVEALED;
		else
			self.m_FogState = PLOT_HIDDEN;
		end
	end

	self:SetFogState( self.m_FogState );
	self.m_Instance.Banner_Base:SetHide(bHidden);
	self.m_Instance.Icon:SetHide(bHidden);
end

-- ===========================================================================
function CityBanner:CreateCorporationBanner()
	-- Set the appropriate instance factory (mini banner one) for this flag...
	self.m_InstanceManager = m_CorporationBannerIM;
	self.m_Instance = self.m_InstanceManager:GetInstance();

	self.m_PlotX, self.m_PlotY = Map.GetPlotLocation(self.m_DistrictID);

	local plot:table = Map.GetPlot( self.m_PlotX, self.m_PlotY );
	local resName:string = m_ResourceTypeMap[plot:GetResourceType()];
	if resName ~= nil then
		self.m_Instance.Icon:SetIcon("ICON_MONOPOLIES_AND_CORPS_" .. resName);

		self.m_IsImprovementBanner = true;

		local corpName:string = Game.GetEconomicManager():GetCorporationName(Game.GetLocalPlayer(), plot:GetResourceType());

		local toolTipStr:string;

		if corpName ~= nil and corpName ~= "" then
			toolTipStr = corpName .. "[NEWLINE]" .. Locale.Lookup("LOC_IMPROVEMENT_CORPORATION_TYPE_NAME", Locale.Lookup("LOC_" .. resName .. "_NAME"));
		else
			toolTipStr = Locale.Lookup("LOC_IMPROVEMENT_CORPORATION_TYPE_NAME", Locale.Lookup("LOC_" .. resName .. "_NAME"));
		end

		toolTipStr = toolTipStr .. GetCorporationEffect(self.m_PlotX, self.m_PlotY);

		self.m_Instance.Icon:SetToolTipString(toolTipStr);
		self.m_Instance.CorporationButton:RegisterCallback(Mouse.eLClick, function() OnClickIndustryCorporationInstanceIcon(self.m_PlotX, self.m_PlotY); end);
	end
end

-- ===========================================================================
function CityBanner:UpdateCorporationBanner()
	local pLocalPlayerVis:table = PlayersVisibility[Game.GetLocalPlayer()];
	local bHidden:boolean = true;
	if (pLocalPlayerVis ~= nil) then
		if pLocalPlayerVis:IsVisible(self.m_PlotX, self.m_PlotY) then
			self.m_FogState = PLOT_VISIBLE;
			bHidden = false;
		elseif pLocalPlayerVis:IsRevealed(self.m_PlotX, self.m_PlotY) then
			self.m_FogState = PLOT_REVEALED;
		else
			self.m_FogState = PLOT_HIDDEN;
		end
	end

	self:SetFogState( self.m_FogState );

	self.m_Instance.Banner_Base:SetHide(bHidden);
	self.m_Instance.Icon:SetHide(bHidden);
	self.m_Instance.CorporationRing:SetHide(bHidden);
end

-- ===========================================================================
function OnCorporationNameChanged(ePlayer:number, eResource:number, plotX:number, plotY:number )
	local plotID = Map.GetPlotIndex(plotX, plotY);

	if (plotID > 0) then
		-- as with other minibanners, we use the plotID as the district ID because it makes this easier
		local bannerInstance = GetMiniBanner( ePlayer, plotID );
		if (bannerInstance ~= nil) then
			local plot:table = Map.GetPlot(plotX, plotY);
			local resName:string = m_ResourceTypeMap[plot:GetResourceType()];
			local corpName:string = Game.GetEconomicManager():GetCorporationName(Game.GetLocalPlayer(), plot:GetResourceType());
			
			if resName ~= nil then
				local toolTipStr:string;

				if corpName ~= nil and corpName ~= "" then
					toolTipStr = corpName .. "[NEWLINE]" .. Locale.Lookup("LOC_IMPROVEMENT_CORPORATION_TYPE_NAME", Locale.Lookup("LOC_" .. resName .. "_NAME"));
				else
					toolTipStr = Locale.Lookup("LOC_IMPROVEMENT_CORPORATION_TYPE_NAME", Locale.Lookup("LOC_" .. resName .. "_NAME"));
				end
		
				toolTipStr = toolTipStr .. GetCorporationEffect(plotX, plotY);
		
				bannerInstance.m_Instance.Icon:SetToolTipString(toolTipStr);
			end
		end
	end
end

-- ===========================================================================
-- 获取行业/公司效果文本
function GetIndustryEffect(x, y)
	local plot = Map.GetPlot(x, y);
	if plot then
		local resourceId = plot:GetResourceType();
		local resourceInfo = GameInfo.Resources[resourceId];
		if resourceInfo then
			local effectList = {};
			local disabledList = {};

			-- 获取资源对应行业公司类别
			for row in GameInfo.HD_Monopoly_Resource_Categories() do
				if row.ResourceType == resourceInfo.ResourceType then
					local categoryData = GameInfo.HD_Monopoly_Categories[row.Category];
					if categoryData and categoryData.IndustryEffect then
						if plot:GetProperty(INDUSTRY_BONUS_TAG .. row.Category) == 1 then
							table.insert(effectList, {
								Category = row.Category,
								IndustryEffect = categoryData.IndustryEffect
							})
						else
							table.insert(disabledList, {
								Category = row.Category,
								IndustryEffect = categoryData.IndustryEffect
							})
						end
					end
				end
			end

			if #effectList == 0 and #disabledList ~= 0 then
				return '[NEWLINE][NEWLINE]' .. Locale.Lookup('LOC_SELECT_INDUSTRY_CATEGORY_TEXT');
			else
				local effectStr = '';

				for i, data in ipairs(effectList) do
					if i > 1 then effectStr = effectStr .. '[NEWLINE]'; end
					effectStr = effectStr .. '[ICON_Bullet]'
						.. Locale.Lookup('LOC_RESOURCE_CLASSIFICATION_HD_' .. data.Category .. '_NAME')
						.. Locale.Lookup('LOC_TOOLTIP_HD_COLON_TEXT')
						.. Locale.Lookup('LOC_' .. data.IndustryEffect .. '_DESCRIPTION');
				end

				for _, data in ipairs(disabledList) do
					effectStr = effectStr .. '[NEWLINE][ICON_Bullet]' .. Locale.Lookup(
						'LOC_NEED_ACTIVATE_SECOND_INDUSTRY_EFFECT_TEXT',
						'LOC_RESOURCE_CLASSIFICATION_HD_' .. data.Category .. '_NAME',
						'LOC_' .. data.IndustryEffect .. '_DESCRIPTION'
					)
				end

				effectStr = '[NEWLINE][NEWLINE]' .. Locale.Lookup('LOC_HD_INDUSTRY_EFFECT_TEXT', effectStr)

				return effectStr;
			end
		end
	end

	return "";
end

function GetCorporationEffect(x, y)
	local plot = Map.GetPlot(x, y);
	if plot then
		local resourceId = plot:GetResourceType();
		local resourceInfo = GameInfo.Resources[resourceId];
		if resourceInfo then
			local industryEffectList = {};
			local industryDisabledList = {};
			local corporationEffectList = {};
			local corporationDisabledList = {};

			-- 获取资源对应行业公司类别
			for row in GameInfo.HD_Monopoly_Resource_Categories() do
				if row.ResourceType == resourceInfo.ResourceType then
					local categoryData = GameInfo.HD_Monopoly_Categories[row.Category];
					if categoryData then
						if categoryData.IndustryEffect then
							if plot:GetProperty(INDUSTRY_BONUS_TAG .. row.Category) == 1 then
								table.insert(industryEffectList, {
									Category = row.Category,
									IndustryEffect = categoryData.IndustryEffect
								})
							else
								table.insert(industryDisabledList, {
									Category = row.Category,
									IndustryEffect = categoryData.IndustryEffect
								})
							end
						end
						
						if categoryData.CorporationEffect then
							if plot:GetProperty(CORPORATION_BONUS_TAG .. row.Category) == 1 then
								table.insert(corporationEffectList, {
									Category = row.Category,
									CorporationEffect = categoryData.CorporationEffect
								})
							else
								table.insert(corporationDisabledList, {
									Category = row.Category,
									CorporationEffect = categoryData.CorporationEffect
								})
							end
						end
					end
				end
			end

			if #industryEffectList == 0 and #corporationEffectList == 0 and #industryDisabledList ~= 0 and #corporationDisabledList ~= 0 then
				return '[NEWLINE][NEWLINE]' .. Locale.Lookup('LOC_SELECT_CORPORATION_CATEGORY_TEXT');
			else
				local effectStr = '';
				local industryEffectStr = '';
				local corporationEffectStr = '';

				-- 行业文本
				for i, data in ipairs(industryEffectList) do
					if i > 1 then industryEffectStr = industryEffectStr .. '[NEWLINE]'; end
					industryEffectStr = industryEffectStr .. '[ICON_Bullet]'
						.. Locale.Lookup('LOC_RESOURCE_CLASSIFICATION_HD_' .. data.Category .. '_NAME')
						.. Locale.Lookup('LOC_TOOLTIP_HD_COLON_TEXT')
						.. Locale.Lookup('LOC_' .. data.IndustryEffect .. '_DESCRIPTION');
				end

				for _, data in ipairs(industryDisabledList) do
					industryEffectStr = industryEffectStr .. '[NEWLINE][ICON_Bullet]' .. Locale.Lookup(
						'LOC_NEED_ACTIVATE_SECOND_INDUSTRY_EFFECT_TEXT',
						'LOC_RESOURCE_CLASSIFICATION_HD_' .. data.Category .. '_NAME',
						'LOC_' .. data.IndustryEffect .. '_DESCRIPTION'
					)
				end

				if #industryEffectList + #industryDisabledList > 0 then
					effectStr = effectStr .. '[NEWLINE][NEWLINE]' .. Locale.Lookup('LOC_HD_INDUSTRY_EFFECT_TEXT', industryEffectStr)
				end

				-- 公司文本
				if #corporationEffectList == 0 and #corporationDisabledList ~= 0 then
					-- 未选择公司类别
					effectStr = effectStr .. '[NEWLINE][NEWLINE]' .. Locale.Lookup('LOC_SELECT_CORPORATION_CATEGORY_TEXT')
				elseif #corporationEffectList + #corporationDisabledList > 0 then
					-- 已选择至少一个公司类别
					for i, data in ipairs(corporationEffectList) do
						if i > 1 then corporationEffectStr = corporationEffectStr .. '[NEWLINE]'; end
						corporationEffectStr = corporationEffectStr .. '[ICON_Bullet]'
							.. Locale.Lookup('LOC_RESOURCE_CLASSIFICATION_HD_' .. data.Category .. '_NAME')
							.. Locale.Lookup('LOC_TOOLTIP_HD_COLON_TEXT')
							.. Locale.Lookup('LOC_' .. data.CorporationEffect .. '_DESCRIPTION');
					end
	
					for _, data in ipairs(corporationDisabledList) do
						corporationEffectStr = corporationEffectStr .. '[NEWLINE][ICON_Bullet]' .. Locale.Lookup(
							'LOC_NEED_ACTIVATE_SECOND_CORPORATION_EFFECT_TEXT',
							'LOC_RESOURCE_CLASSIFICATION_HD_' .. data.Category .. '_NAME',
							'LOC_' .. data.CorporationEffect .. '_DESCRIPTION'
						)
					end
	
					effectStr = effectStr .. '[NEWLINE][NEWLINE]' .. Locale.Lookup('LOC_HD_CORPORATION_EFFECT_TEXT', corporationEffectStr)
				end

				return effectStr;
			end
			
		end
	end

	return "";
end

-- ===========================================================================
-- 更新行业/公司效果文本事件
function CityBanner:UpdateIndustryCorporationText()
	if self.m_Type == BANNERTYPE_INDUSTRY then
		-- 行业
		local plot:table = Map.GetPlot( self.m_PlotX, self.m_PlotY );
		local resName:string = m_ResourceTypeMap[plot:GetResourceType()];
		print("更新行业图标", self.m_PlotX, self.m_PlotY, resName)
		if resName ~= nil then
			local toolTipStr:string = Locale.Lookup("LOC_IMPROVEMENT_INDUSTRY_TYPE_NAME", Locale.Lookup("LOC_" .. resName .. "_NAME")) .. GetIndustryEffect(self.m_PlotX, self.m_PlotY);
			self.m_Instance.Icon:SetToolTipString(toolTipStr);
		end
	elseif self.m_Type == BANNERTYPE_CORPORATION then
		-- 公司
		local plot:table = Map.GetPlot( self.m_PlotX, self.m_PlotY );
		local resName:string = m_ResourceTypeMap[plot:GetResourceType()];
		local corpName:string = Game.GetEconomicManager():GetCorporationName(Game.GetLocalPlayer(), plot:GetResourceType());
		print("更新公司图标", self.m_PlotX, self.m_PlotY, resName)
		if resName ~= nil then
			local toolTipStr:string;
			
			if corpName ~= nil and corpName ~= "" then
				toolTipStr = corpName .. "[NEWLINE]" .. Locale.Lookup("LOC_IMPROVEMENT_CORPORATION_TYPE_NAME", Locale.Lookup("LOC_" .. resName .. "_NAME"));
			else
				toolTipStr = Locale.Lookup("LOC_IMPROVEMENT_CORPORATION_TYPE_NAME", Locale.Lookup("LOC_" .. resName .. "_NAME"));
			end
	
			toolTipStr = toolTipStr .. GetCorporationEffect(self.m_PlotX, self.m_PlotY);
	
			self.m_Instance.Icon:SetToolTipString(toolTipStr);
		end
	end
end

function RefreshIndustryCorporationBanner(param)
	local playerId = param.PlayerId;
	local plotId = Map.GetPlotIndex(param.X, param.Y);
	if playerId == Game.GetLocalPlayer() and plotId > 0 then
		local banner = GetMiniBanner(playerId, plotId);
		if banner ~= nil then
			banner:UpdateIndustryCorporationText();
		end
	end
end

-- ===========================================================================
-- 按钮点击事件 唤出自选类别界面
function OnClickIndustryCorporationInstanceIcon(x, y)
	local plot = Map.GetPlot(x, y);
	if plot then
		local playerId = plot:GetOwner();
		if playerId ~= Game.GetLocalPlayer() then return; end

		local city = Cities.GetPlotPurchaseCity(plot);
  	if not city then return; end

		local resourceId = plot:GetResourceType();
		local resourceInfo = GameInfo.Resources[resourceId];
		if resourceInfo then
			local disabledList = {};
			local improvementId = plot:GetImprovementType();
			if improvementId == INDUSTRY_INDEX
				or improvementId == INDUSTRY_BONUS_INDEX
				or improvementId == INDUSTRY_STRATEGIC_INDEX
			then
				-- 行业
				-- 获取可用行业类别
				for row in GameInfo.HD_Monopoly_Resource_Categories() do
					if row.ResourceType == resourceInfo.ResourceType then
						local categoryData = GameInfo.HD_Monopoly_Categories[row.Category];
						if categoryData and categoryData.IndustryEffect then
							if plot:GetProperty(INDUSTRY_BONUS_TAG .. row.Category) ~= 1 then
								table.insert(disabledList, row.Category)
							end
						end
					end
				end

				if #disabledList > 1 then
					print("点击图标唤起行业类别选择界面")
					local param = {
            PlayerId = playerId,
            CityName = city:GetName(),
            ResourceType = resourceInfo.ResourceType,
            SelectionList = {}
          };
          for _, category in ipairs(disabledList) do
            table.insert(param.SelectionList, {
              Id = 'HD_SELECTION_INDUSTRY_' .. category,
              ScriptParam = {Category = category, X = x, Y = y}
            });
          end
          CallIndustrySelectEvent(param);
				end
			elseif improvementId == CORPORATION_INDEX
				or improvementId == CORPORATION_BONUS_INDEX
				or improvementId == CORPORATION_STRATEGIC_INDEX
			then
				-- 公司
				-- 获取可用公司类别
				local hasAnyEffectTag = false;
				for row in GameInfo.HD_Monopoly_Resource_Categories() do
					if row.ResourceType == resourceInfo.ResourceType then
						local categoryData = GameInfo.HD_Monopoly_Categories[row.Category];
						if categoryData and categoryData.CorporationEffect then
							if plot:GetProperty(CORPORATION_BONUS_TAG .. row.Category) ~= 1 then
								if not categoryData.IndustryEffect or plot:GetProperty(INDUSTRY_BONUS_TAG .. row.Category) == 1 then
									table.insert(disabledList, row.Category)
								end
							else
								hasAnyEffectTag = true;
							end
						end
					end
				end

				-- 如果disabledList为空，说明之前没有选择行业效果
				if #disabledList == 0 and not hasAnyEffectTag then
					for row in GameInfo.HD_Monopoly_Resource_Categories() do
						if row.ResourceType == resourceInfo.ResourceType then
							local categoryInfo = GameInfo.HD_Monopoly_Categories[row.Category];
							if categoryInfo and categoryInfo.IndustryEffect and categoryInfo.CorporationEffect then
								table.insert(disabledList, row.Category);
							end
						end
					end
				end

				if #disabledList > 1 then
					print("点击图标唤起公司类别选择界面")
					local param = {
            PlayerId = playerId,
            CityName = city:GetName(),
            ResourceType = resourceInfo.ResourceType,
            SelectionList = {}
          };
          for _, category in ipairs(disabledList) do
            table.insert(param.SelectionList, {
              Id = 'HD_SELECTION_CORPORATION_' .. category,
              ScriptParam = {Category = category, X = x, Y = y}
            });
          end
          CallCorporationSelectEvent(param);
				end
			end

			-- 用于Debug
			if improvementId == INDUSTRY_INDEX
				or improvementId == INDUSTRY_BONUS_INDEX
				or improvementId == INDUSTRY_STRATEGIC_INDEX
				or improvementId == CORPORATION_INDEX
				or improvementId == CORPORATION_BONUS_INDEX
				or improvementId == CORPORATION_STRATEGIC_INDEX
			then
				for row in GameInfo.HD_Monopoly_Categories() do
					if plot:GetProperty(INDUSTRY_BONUS_TAG .. row.Category) == 1 then
						print("行业：" .. Locale.Lookup('LOC_RESOURCE_CLASSIFICATION_HD_' .. row.Category .. '_NAME'))
					end
					if plot:GetProperty(CORPORATION_BONUS_TAG .. row.Category) == 1 then
						print("公司：" .. Locale.Lookup('LOC_RESOURCE_CLASSIFICATION_HD_' .. row.Category .. '_NAME'))
					end
				end
			end
			
		end
	end
end

-- ===========================================================================
-- 行业公司类别选择函数
function CallIndustrySelectEvent(param)
	local playerId = param.PlayerId;
	local cityName = param.CityName;
	local resourceType = param.ResourceType;
	local resourceInfo = GameInfo.Resources[resourceType];
	local selectionList = param.SelectionList;

	if not resourceInfo then return; end

	for _, selection in ipairs(selectionList) do
		selection.Description = Locale.Lookup('LOC_HD_' .. resourceType .. '_' .. selection.ScriptParam.Category .. '_INDUSTRY_DESCRIPTION', cityName).. '[NEWLINE][NEWLINE]' .. Locale.Lookup('LOC_INDUSTRY_HD_' .. selection.ScriptParam.Category .. '_BONUS_DESCRIPTION');
	end

	local sendParam = {
		PlayerId = playerId,
		EventId = 'HD_CUSTOMEVENT_SELECT_INDUSTRY_CATEGORY',
		EventName = Locale.Lookup('LOC_HD_CUSTOMEVENT_SELECT_INDUSTRY_CATEGORY_NAME', cityName, '[ICON_' .. resourceType .. '] ' .. Locale.Lookup(resourceInfo.Name)),
		EventDescription = Locale.Lookup('LOC_HD_BUILD_' .. resourceType .. '_INDUSTRY_TEXT', cityName) .. '[NEWLINE][NEWLINE]' .. Locale.Lookup('LOC_HD_CUSTOMEVENT_SELECT_INDUSTRY_CATEGORY_DESCRIPTION'),
		EventDescriptionHeight = 90,
		SelectionList = selectionList
	};

	LuaEvents.HD_TriggerCustomEventPanel_Light.Call(sendParam);
end

function CallCorporationSelectEvent(param)
	local playerId = param.PlayerId;
	local cityName = param.CityName;
	local resourceType = param.ResourceType;
	local resourceInfo = GameInfo.Resources[resourceType];
	local selectionList = param.SelectionList;

	if not resourceInfo then return; end

	for _, selection in ipairs(selectionList) do
		selection.Description = Locale.Lookup('LOC_HD_' .. resourceType .. '_' .. selection.ScriptParam.Category .. '_CORPORATION_DESCRIPTION', cityName).. '[NEWLINE][NEWLINE]' .. Locale.Lookup('LOC_CORPORATION_HD_' .. selection.ScriptParam.Category .. '_BONUS_DESCRIPTION');
	end

	local sendParam = {
		PlayerId = playerId,
		EventId = 'HD_CUSTOMEVENT_SELECT_CORPORATION_CATEGORY',
		EventName = Locale.Lookup('LOC_HD_CUSTOMEVENT_SELECT_CORPORATION_CATEGORY_NAME', cityName, '[ICON_' .. resourceType .. '] ' .. Locale.Lookup(resourceInfo.Name)),
		EventDescription = Locale.Lookup('LOC_HD_BUILD_' .. resourceType .. '_CORPORATION_TEXT', cityName) .. '[NEWLINE][NEWLINE]' .. Locale.Lookup('LOC_HD_CUSTOMEVENT_SELECT_CORPORATION_CATEGORY_DESCRIPTION'),
		EventDescriptionHeight = 90,
		SelectionList = selectionList
	};

	LuaEvents.HD_TriggerCustomEventPanel_Light.Call(sendParam);
end

-- ======================================================================================================================================================
-- 城堡庄园
-- ======================================================================================================================================================
function CityBanner:CreateChateauBanner()
	self.m_InstanceManager = m_ChateauBannerIM;
	self.m_Instance = self.m_InstanceManager:GetInstance();

	self.m_PlotX, self.m_PlotY = Map.GetPlotLocation(self.m_DistrictID);

	local plot:table = Map.GetPlot( self.m_PlotX, self.m_PlotY );

	self.m_Instance.Icon:SetIcon("ICON_IMPROVEMENT_CHATEAU");
	self.m_IsImprovementBanner = true;
	
	local toolTipStr = Locale.Lookup("LOC_IMPROVEMENT_CHATEAU_NAME") .. '[NEWLINE][NEWLINE]' .. GetChateauEffect(self.m_PlotX, self.m_PlotY);
	self.m_Instance.Icon:SetToolTipString(toolTipStr);
	self.m_Instance.ChateauButton:RegisterCallback(Mouse.eLClick, function() OnClickChateauInstanceIcon(self.m_PlotX, self.m_PlotY); end);
end

-- ===========================================================================
function CityBanner:UpdateChateauBanner()
	local pLocalPlayerVis:table = PlayersVisibility[Game.GetLocalPlayer()];
	local bHidden:boolean = true;
	if (pLocalPlayerVis ~= nil) then
		if pLocalPlayerVis:IsVisible(self.m_PlotX, self.m_PlotY) then
			self.m_FogState = PLOT_VISIBLE;
			bHidden = false;
		elseif pLocalPlayerVis:IsRevealed(self.m_PlotX, self.m_PlotY) then
			self.m_FogState = PLOT_REVEALED;
		else
			self.m_FogState = PLOT_HIDDEN;
		end
	end

	self:SetFogState( self.m_FogState );
	self.m_Instance.Banner_Base:SetHide(bHidden);
	self.m_Instance.Icon:SetHide(bHidden);
end

-- ===========================================================================
-- 按钮点击事件 唤出城堡庄园选择资源界面
function OnClickChateauInstanceIcon(x, y)
	local plot = Map.GetPlot(x, y);
	if plot then
		local playerId = plot:GetOwner();
		if playerId ~= Game.GetLocalPlayer() then return; end

		local city = Cities.GetPlotPurchaseCity(plot);
  	if not city then return; end

		-- 选择生产资源
		local productionResourceIndex = plot:GetProperty(CHATEAU_PRODUCTION_RESOURCE_TAG) or -1;
		if productionResourceIndex == -1 then
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

			local param = {
        PlayerId = playerId,
        CityName = city:GetName(),
        Type = 'PRODUCTION_RESOURCE',
        X = x,
        Y = y,
        ResourceList = resourceList
      };
			CallChateauSelectResourceEvent(param);
		else
			-- 选择娱乐资源
			local entertainmentResourceIndex = plot:GetProperty(CHATEAU_ENTERTAINMENT_RESOURCE_TAG) or -1;
			local canChooseEntertainmentResource = city:GetProperty(CHATEAU_CAN_CHOOSE_ENTERTAINMENT_RESOURCE_TAG) or 0;
			if entertainmentResourceIndex == -1 and canChooseEntertainmentResource > 0 then
				local resourceMap = Utils.GetCityPlotsResources(playerId, city:GetID(), {
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

				local param = {
					PlayerId = playerId,
					CityName = city:GetName(),
					Type = 'ENTERTAINMENT_RESOURCE',
					X = x,
					Y = y,
					ResourceList = resourceList
				};
				CallChateauSelectResourceEvent(param);
			end
		end
	end
end

function CallChateauSelectResourceEvent(param)
	local playerId = param.PlayerId;
	local cityName = param.CityName;
	local resourceList = param.ResourceList;
	local x = param.X;
	local y = param.Y;

	local sendParam = {
		PlayerId = playerId,
		ResourceList = resourceList,
		X = x,
		Y = y,
		ScriptParam = {
			Type = param.Type
		}
	}

	if param.Type == 'PRODUCTION_RESOURCE' then
		sendParam.HeaderTitle = Locale.Lookup('LOC_CHATEAU_SELECT_RESOURCE_TITLE', cityName);
		sendParam.SubheaderIcon = 'ICON_IMPROVEMENT_CHATEAU';
		sendParam.SubheaderLabel = Locale.Lookup('LOC_CHATEAU_SELECT_PRODUCTION_RESOURCE_TEXT', cityName);
	elseif param.Type == 'ENTERTAINMENT_RESOURCE' then
		sendParam.HeaderTitle = Locale.Lookup('LOC_CHATEAU_SELECT_RESOURCE_TITLE', cityName);
		sendParam.SubheaderIcon = 'ICON_IMPROVEMENT_CHATEAU';
		sendParam.SubheaderLabel = Locale.Lookup('LOC_CHATEAU_SELECT_ENTERTAINMENT_RESOURCE_TEXT', cityName);
	end
	
	LuaEvents.HD_TriggerResourceSelectionPanel.Call(sendParam);
end

function RefreshChateauBanner(param)
	local playerId = param.PlayerId;
	local plotId = Map.GetPlotIndex(param.X, param.Y);
	if playerId == Game.GetLocalPlayer() and plotId > 0 then
		local banner = GetMiniBanner(playerId, plotId);
		if banner ~= nil then
			banner:UpdateChateauText();
		end
	end
end

function CityBanner:UpdateChateauText()
	if self.m_Type == BANNERTYPE_CHATEAU then
		print('UpdateChateauText');
		local toolTipStr = Locale.Lookup("LOC_IMPROVEMENT_CHATEAU_NAME") .. '[NEWLINE][NEWLINE]' .. GetChateauEffect(self.m_PlotX, self.m_PlotY);
		self.m_Instance.Icon:SetToolTipString(toolTipStr);
	end
end

function GetChateauEffect(x, y)
	local plot = Map.GetPlot(x, y);
	if plot then
		local city = Cities.GetPlotPurchaseCity(plot);
  	if not city then return; end
		local canChooseEntertainmentResource = city:GetProperty(CHATEAU_CAN_CHOOSE_ENTERTAINMENT_RESOURCE_TAG) or 0;

		local strList = {};
		-- 生产资源
		local productionResourceIndex = plot:GetProperty(CHATEAU_PRODUCTION_RESOURCE_TAG) or -1;
		local productionResourceInfo = GameInfo.Resources[productionResourceIndex];
		if productionResourceInfo then
			table.insert(strList, Locale.Lookup('LOC_CHATEAU_PRODUCTION_RESOURCE_TEXT', '[ICON_' .. productionResourceInfo.ResourceType .. ']', productionResourceInfo.Name));
		else
			table.insert(strList, Locale.Lookup('LOC_CHATEAU_NO_PRODUCTION_RESOURCE_TEXT'));
		end
		-- 娱乐资源
    local entertainmentResourceIndex = plot:GetProperty(CHATEAU_ENTERTAINMENT_RESOURCE_TAG) or -1;
		local entertainmentResourceInfo = GameInfo.Resources[entertainmentResourceIndex];
		if entertainmentResourceInfo then
			table.insert(strList, Locale.Lookup('LOC_CHATEAU_ENTERTAINMENT_RESOURCE_TEXT', '[ICON_' .. entertainmentResourceInfo.ResourceType .. ']', entertainmentResourceInfo.Name));
		elseif productionResourceInfo and canChooseEntertainmentResource > 0 then
			table.insert(strList, Locale.Lookup('LOC_CHATEAU_NO_ENTERTAINMENT_RESOURCE_TEXT'));
		end
		-- 行业特效
		local effectList = {};
		for row in GameInfo.HD_Monopoly_Categories() do
      if plot:GetProperty(INDUSTRY_BONUS_TAG .. row.Category) == 1 then
        table.insert(effectList, '[ICON_BULLET]' .. Locale.Lookup('LOC_RESOURCE_CLASSIFICATION_HD_' .. row.Category .. '_NAME') .. Locale.Lookup('LOC_TOOLTIP_HD_COLON_TEXT') .. Locale.Lookup("LOC_" .. row.IndustryEffect .. "_DESCRIPTION"))
      end
    end
		if #effectList > 0 then
			local effectStr = '';
			for i, str in ipairs(effectList) do
				if i > 1 then effectStr = effectStr .. "[NEWLINE]"; end
				effectStr = effectStr .. str;
			end
			table.insert(strList, Locale.Lookup('LOC_CHATEAU_INDUSTRY_TEXT', effectStr));
		end
		
		local result = '';
		if #strList > 0 then
			for i, str in ipairs(strList) do
				if i > 1 then result = result .. "[NEWLINE]"; end
				result = result .. str;
			end
		end

		return result;
	end

	return "";
end

-- ======================================================================================================================================================
-- 通用函数
-- ======================================================================================================================================================
-- if this is one of our banners, create it now
function CityBanner:InitializeOtherBannerTypes(bannerType : number)
	if bannerType == BANNERTYPE_INDUSTRY then
		self:CreateIndustryBanner();
		self:UpdateIndustryBanner();
	elseif bannerType == BANNERTYPE_CORPORATION then
		self:CreateCorporationBanner();
		self:UpdateCorporationBanner();
	elseif bannerType == BANNERTYPE_CHATEAU then
		-- 城堡庄园
		self:CreateChateauBanner();
		self:UpdateChateauBanner();
	else
		BASE_CityBannerInitializeOtherBannerTypes(bannerType);
	end
end

-- ===========================================================================
-- Handle color updates for our banner types
function CityBanner:UpdateColorOtherBannerTypes(backColor : number)
	if self.m_Type == BANNERTYPE_INDUSTRY then
		if self.m_Instance.Banner_Base ~= nil then
			self.m_Instance.Banner_Base:SetColor( backColor );
		end
	elseif self.m_Type == BANNERTYPE_CORPORATION then
		if self.m_Instance.Banner_Base ~= nil then
			self.m_Instance.Banner_Base:SetColor( backColor );
		end
	elseif self.m_Type == BANNERTYPE_CHATEAU then
		-- 城堡庄园
		if self.m_Instance.Banner_Base ~= nil then
			self.m_Instance.Banner_Base:SetColor( backColor );
		end
	else
		BASE_UpdateColorOtherBannerTypes();
	end
end

-- ===========================================================================
-- Handle updates for our banner types
function CityBanner:UpdateOtherImprovementBannerTypes()
	if self.m_Type == BANNERTYPE_INDUSTRY then
		self:UpdateIndustryBanner();
	elseif self.m_Type == BANNERTYPE_CORPORATION then
		self:UpdateCorporationBanner();
	elseif self.m_Type == BANNERTYPE_CHATEAU then
		-- 城堡庄园
		self:UpdateChateauBanner();
	else
		BASE_UpdateOtherImprovementBannerTypes();
	end
end

-- ===========================================================================
function LateInitialize()
	BASE_LateInitialize();

	m_ResourceTypeMap = {};
	do
		for row in GameInfo.Resources() do
			m_ResourceTypeMap[row.Index] = row.ResourceType;
		end
	end
end

-- ===========================================================================
function Initialize()
	BASE_Initialize();

	Events.CorporationNameChanged.Add(OnCorporationNameChanged);

	LuaEvents.HD_CallIndustrySelectEvent.Add(CallIndustrySelectEvent);
	LuaEvents.HD_CallCorporationSelectEvent.Add(CallCorporationSelectEvent);
	LuaEvents.HD_RefreshIndustryCorporationBanner.Add(RefreshIndustryCorporationBanner);
	
	LuaEvents.HD_CallChateauSelectResourceEvent.Add(CallChateauSelectResourceEvent);
	LuaEvents.HD_RefreshChateauBanner.Add(RefreshChateauBanner);
end
