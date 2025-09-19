update Parameters set DefaultValue = 1 where ParameterId = 'GameMode_Monopolies';

insert or ignore into GameModePlayerItemOverrides (GameModeType, Domain, CivilizationType, LeaderType, Type, Description) select
  'GAMEMODE_MONOPOLIES', Domain, CivilizationType, LeaderType, 'IMPROVEMENT_CHATEAU', 'LOC_IMPROVEMENT_CHATEAU_DESCRIPTION_MONOPOLIES'
from PlayerItems where Type = 'IMPROVEMENT_CHATEAU';

insert or ignore into PlayerItemOverrideQueries (QueryId) values
  ('HDMonopoliesModePlayerItemOverrides');

insert or ignore into Queries (QueryId, SQL) values
  ('HDMonopoliesModePlayerItemOverrides', "SELECT * FROM GameModePlayerItemOverrides WHERE GameModeType = 'GAMEMODE_MONOPOLIES'");

insert or ignore into QueryCriteria (QueryId, ConfigurationGroup, ConfigurationId, Operator, ConfigurationValue) values
  ('HDMonopoliesModePlayerItemOverrides', 'Game', 'GAMEMODE_MONOPOLIES', 'Equals', 1);