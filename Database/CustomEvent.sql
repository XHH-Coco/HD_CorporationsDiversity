-- 事件
insert or ignore into HD_CustomEvents (CustomEventType, Name, Description, UIStyle, Sound) values
	('HD_CUSTOMEVENT_SELECT_INDUSTRY_CATEGORY',    'LOC_HD_CUSTOMEVENT_SELECT_INDUSTRY_CATEGORY_NAME',    'LOC_HD_CUSTOMEVENT_SELECT_INDUSTRY_CATEGORY_DESCRIPTION',    'Light', 'Tech_Tray_Slide_Open'),
	('HD_CUSTOMEVENT_SELECT_CORPORATION_CATEGORY', 'LOC_HD_CUSTOMEVENT_SELECT_CORPORATION_CATEGORY_NAME', 'LOC_HD_CUSTOMEVENT_SELECT_CORPORATION_CATEGORY_DESCRIPTION', 'Light', 'Tech_Tray_Slide_Open');

-- 事件选项
insert or ignore into HD_CustomEventSelections (SelectionType, CustomEventType, Icon, Description, ButtonText, Sound) select
  'HD_SELECTION_INDUSTRY_' || Category,
  'HD_CUSTOMEVENT_SELECT_INDUSTRY_CATEGORY',
  'ICON_HD_SELECTION_INDUSTRY_' || Category,
  'LOC_INDUSTRY_HD_' || Category || '_BONUS_DESCRIPTION',
  'LOC_RESOURCE_CLASSIFICATION_HD_' || Category || '_NAME',
  'ALERT_POSITIVE'
from HD_Monopoly_Categories where IndustryEffect is not NULL;

insert or ignore into HD_CustomEventSelections (SelectionType, CustomEventType, Icon, Description, ButtonText, Sound) select
  'HD_SELECTION_CORPORATION_' || Category,
  'HD_CUSTOMEVENT_SELECT_CORPORATION_CATEGORY',
  'ICON_HD_SELECTION_CORPORATION_' || Category,
  'LOC_CORPORATION_HD_' || Category || '_BONUS_DESCRIPTION',
  'LOC_RESOURCE_CLASSIFICATION_HD_' || Category || '_NAME',
  'ALERT_POSITIVE'
from HD_Monopoly_Categories where CorporationEffect is not NULL;