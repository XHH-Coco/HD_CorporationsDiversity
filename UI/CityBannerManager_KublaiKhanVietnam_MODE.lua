-- ===========================================================================
--	City Banner Manager overrides for Monopolies & Corporations
-- ===========================================================================

-- ===========================================================================
--	CONSTANTS
-- ===========================================================================
BANNERTYPE_INDUSTRY = UIManager:GetHash("BANNERTYPE_INDUSTRY");
BANNERTYPE_CORPORATION = UIManager:GetHash("BANNERTYPE_CORPORATION");

local INDUSTRY_INDEX = GameInfo.Improvements['IMPROVEMENT_INDUSTRY'].Index;
local CORPORATION_INDEX = GameInfo.Improvements['IMPROVEMENT_CORPORATION'].Index;

-- ===========================================================================
--	MEMBERS
-- ===========================================================================
local m_IndustryBannerIM	:table	= InstanceManager:new( "IndustryBanner",	"Anchor", Controls.CityBanners );
local m_CorporationBannerIM	:table	= InstanceManager:new( "CorporationBanner",	"Anchor", Controls.CityBanners );
local m_ResourceTypeMap    	:table  = {};

-- base function overrides
local BASE_CityBannerInitializeOtherBannerTypes = CityBanner.InitializeOtherBannerTypes;
local BASE_UpdateColorOtherBannerTypes = CityBanner.UpdateColorOtherBannerTypes;
local BASE_UpdateOtherImprovementBannerTypes = CityBanner.UpdateOtherImprovementBannerTypes;
local BASE_OnImprovementAddedToMap = OnImprovementAddedToMap;
local BASE_Initialize = Initialize;
local BASE_LateInitialize = LateInitialize;

-- ===========================================================================
-- 建造改良事件
-- ===========================================================================
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

	-- Check if the improvement is an Industry or Corporation
	local bIsIndustry:boolean = false;
	local bIsCorporation:boolean = false;
	local improvementDataMODE:table = GameInfo.Improvements_MODE[improvementData.Hash];
	if (improvementDataMODE ~= nil) then
		if (improvementDataMODE.Industry) then
			bIsIndustry = true;
		elseif (improvementDataMODE.Corporation) then
			bIsCorporation = true;
		end
	end

	-- we're only here for industries and corporations
	if ( not bIsIndustry and not bIsCorporation ) then
		BASE_OnImprovementAddedToMap(locX, locY, eImprovementType, eOwner);
		return;
	end

	local pPlayer:table = Players[eOwner];
	local localPlayerID:number = Game.GetLocalPlayer();
	if (pPlayer ~= nil) then
		local plotID = Map.GetPlotIndex(locX, locY);
		if (plotID ~= nil) then
			local miniBanner = GetMiniBanner( eOwner, plotID );
			if (miniBanner == nil) then
				if ( bIsIndustry ) then
					local ownerCity = Cities.GetPlotPurchaseCity(locX, locY);
					local cityID = ownerCity:GetID();
					-- we're passing the plotID as the districtID argument because we need the location of the improvement
					AddMiniBannerToMap( eOwner, cityID, plotID, BANNERTYPE_INDUSTRY );
				elseif ( bIsCorporation ) then
					local ownerCity = Cities.GetPlotPurchaseCity(locX, locY);
					local cityID = ownerCity:GetID();
					-- we're passing the plotID as the districtID argument because we need the location of the improvement
					AddMiniBannerToMap( eOwner, cityID, plotID, BANNERTYPE_CORPORATION );
				end
			end
		end
	end
end

-- ===========================================================================
-- 行业&公司
-- ===========================================================================
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
		self.m_Instance.IndustryButton:RegisterCallback(Mouse.eLClick, function() OnClickInstanceIcon(self.m_PlotX, self.m_PlotY); end);
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
		self.m_Instance.CorporationButton:RegisterCallback(Mouse.eLClick, function() OnClickInstanceIcon(self.m_PlotX, self.m_PlotY); end);
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
-- if this is one of our banners, create it now
function CityBanner:InitializeOtherBannerTypes(bannerType : number)
	if (bannerType == BANNERTYPE_INDUSTRY) then
		self:CreateIndustryBanner();
		self:UpdateIndustryBanner();
	elseif (bannerType == BANNERTYPE_CORPORATION) then
		self:CreateCorporationBanner();
		self:UpdateCorporationBanner();
	else	-- not ours, continue the chain
		BASE_CityBannerInitializeOtherBannerTypes(bannerType);
	end
end

-- ===========================================================================
-- Handle color updates for our banner types
function CityBanner:UpdateColorOtherBannerTypes(backColor : number)
	if (self.m_Type == BANNERTYPE_INDUSTRY) then
		if self.m_Instance.Banner_Base ~= nil then
			self.m_Instance.Banner_Base:SetColor( backColor );
		end
	elseif (self.m_Type == BANNERTYPE_CORPORATION) then
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
	if (self.m_Type == BANNERTYPE_INDUSTRY) then
		self:UpdateIndustryBanner();
	elseif (self.m_Type == BANNERTYPE_CORPORATION) then
		self:UpdateCorporationBanner();
	else
		BASE_UpdateOtherImprovementBannerTypes();
	end
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
local INDUSTRY_BONUS_TAG = 'HD_INDUSTRY_BONUS_';
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

local CORPORATION_BONUS_TAG = 'HD_CORPORATION_BONUS_';
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
function OnClickInstanceIcon(x, y)
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
			if improvementId == INDUSTRY_INDEX then
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
			elseif improvementId == CORPORATION_INDEX then
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
			if improvementId == INDUSTRY_INDEX or improvementId == CORPORATION_INDEX then
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
end
