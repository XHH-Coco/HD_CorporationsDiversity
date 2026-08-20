-- ===========================================================================
-- Utils
-- ===========================================================================

-- ===========================================================================
-- Consts
-- ===========================================================================
local plotImprovementNameTag = 'HD_PLOT_IMPROVEMENT_NAME';

-- ===========================================================================
-- Variables
-- ===========================================================================
local resNameTag = nil;
local improvementType = nil;
local x = -1;
local y = -1;

-- ===========================================================================
-- Functions
-- ===========================================================================
function OnBuildImprovementNeedName(param)
	local playerId = param.PlayerId;
	x = param.X;
	y = param.Y;

	if playerId ~= Game.GetLocalPlayer() then return; end
		
	local plot = Map.GetPlot(x, y);
	if not plot then return; end

	local improvementId = plot:GetImprovementType();
	local improvementInfo = GameInfo.Improvements[improvementId];
	if not improvementInfo then return; end
	improvementType = improvementInfo.ImprovementType;

	local resourceId = plot:GetResourceType();
	local resourceInfo = GameInfo.Resources[resourceId];
	if resourceInfo then
		resNameTag = resourceInfo.Name;
	else
		resNameTag = nil;
	end

	if improvementType == 'IMPROVEMENT_CORPORATION_BONUS' or improvementType == 'IMPROVEMENT_CORPORATION_STRATEGIC' then
		Controls.ResIcon:SetIcon("ICON_MONOPOLIES_AND_CORPS_" .. resourceInfo.ResourceType);
	end

	OnGenerate();

	ContextPtr:SetHide(false);
end

-- 生成名字
function OnGenerate()
	local prefixes = {};
	local suffixes = {};

	if improvementType == 'IMPROVEMENT_CORPORATION_BONUS' or improvementType == 'IMPROVEMENT_CORPORATION_STRATEGIC' then
		if GameInfo.CorporationNames then
			for row in GameInfo.CorporationNames() do
				if row.NameType == "PREFIX_ALL" then
					table.insert(prefixes, row.TextKey);
				else
					table.insert(suffixes, row.TextKey);
				end
			end
	
			local ourPrefix = prefixes[math.random(#prefixes)];
			local ourSuffix = suffixes[math.random(#suffixes)];
			if ourPrefix ~= nil and ourSuffix ~= nil and resNameTag ~= nil then
				Controls.NameEdit:SetText(Locale.Lookup(ourPrefix) .. " " .. Locale.Lookup(resNameTag) .. " " .. Locale.Lookup(ourSuffix));
			end
		end
	end
end

-- 确认命名
function OnConfirm()
	local improvementName = Controls.NameEdit:GetText();
	
	local param = {};
  param['OnStart'] = 'HD_NameImprovement';
  param['ImprovementName'] = improvementName;
  param['X'] = x;
  param['Y'] = y;
  UI.RequestPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.EXECUTE_SCRIPT, param);

	OnClose();
end

-- 关闭界面
function OnClose()
	ContextPtr:SetHide(true);
end

-- 键盘输入
function KeyHandler(key)
	if key == Keys.VK_ESCAPE then
		OnClose();
		return true;
	end
	return false;
end

function OnInputHandler(pInputStruct)
	local uiMsg = pInputStruct:GetMessageType();
	if uiMsg == KeyEvents.KeyUp then return KeyHandler(pInputStruct:GetKey()); end;
	return false;
end 

-- 初始化
function Initialize()
	ContextPtr:SetInputHandler(OnInputHandler, true);

	Controls.NameImprovementConfirmButton:RegisterCallback(Mouse.eLClick, OnConfirm);
	Controls.NameImprovementConfirmButton:RegisterCallback(Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);
	Controls.NameImprovementGenerateButton:RegisterCallback(Mouse.eLClick, OnGenerate);
	Controls.NameImprovementGenerateButton:RegisterCallback(Mouse.eMouseEnter, function() UI.PlaySound("Main_Menu_Mouse_Over"); end);
	Controls.NameEdit:RegisterCommitCallback(OnConfirm);

	LuaEvents.HD_BuildImprovementNeedName.Add(OnBuildImprovementNeedName);

	Events.LocalPlayerTurnEnd.Add(OnClose);
end
Initialize();