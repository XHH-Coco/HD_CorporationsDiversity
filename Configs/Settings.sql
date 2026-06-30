update Parameters set DefaultValue = 1 where ParameterId = 'GameMode_Monopolies';

insert or ignore into Queries (QueryId, SQL) values
  ('HDMonopoliesModePlayerInfoOverrides', "SELECT * FROM GameModePlayerInfoOverrides WHERE GameModeType = 'GAMEMODE_MONOPOLIES'"),
  ('HDMonopoliesModePlayerItemOverrides', "SELECT * FROM GameModePlayerItemOverrides WHERE GameModeType = 'GAMEMODE_MONOPOLIES'");

insert or ignore into QueryCriteria (QueryId, ConfigurationGroup, ConfigurationId, Operator, ConfigurationValue) values
  ('HDMonopoliesModePlayerInfoOverrides', 'Game', 'GAMEMODE_MONOPOLIES', 'Equals', 1),
  ('HDMonopoliesModePlayerItemOverrides', 'Game', 'GAMEMODE_MONOPOLIES', 'Equals', 1);

-- Player 覆盖
insert or ignore into GameModePlayerInfoOverrides (GameModeType, Domain, CivilizationType, LeaderType, CivilizationAbilityDescription) select
  'GAMEMODE_MONOPOLIES', Domain, 'CIVILIZATION_BRAZIL', LeaderType, 'LOC_TRAIT_CIVILIZATION_AMAZON_DESCRIPTION_MONOPOLIES'
from Players where CivilizationType = 'CIVILIZATION_BRAZIL';

insert or ignore into PlayerInfoOverrideQueries (QueryId) values
  ('HDMonopoliesModePlayerInfoOverrides');

-- PlayerItem 覆盖
insert or ignore into GameModePlayerItemOverrides (GameModeType, Domain, CivilizationType, LeaderType, Type, Description) select
  'GAMEMODE_MONOPOLIES', Domain, CivilizationType, LeaderType, 'IMPROVEMENT_CHATEAU', 'LOC_IMPROVEMENT_CHATEAU_DESCRIPTION_MONOPOLIES'
from PlayerItems where Type = 'IMPROVEMENT_CHATEAU';

insert or ignore into GameModePlayerItemOverrides (GameModeType, Domain, CivilizationType, LeaderType, Type, Description) select
  'GAMEMODE_MONOPOLIES', Domain, CivilizationType, LeaderType, 'UNIT_HD_BANDEIRANTES', 'LOC_UNIT_HD_BANDEIRANTES_DESCRIPTION_MONOPOLIES'
from PlayerItems where Type = 'UNIT_HD_BANDEIRANTES';

insert or ignore into PlayerItemOverrideQueries (QueryId) values
  ('HDMonopoliesModePlayerItemOverrides');