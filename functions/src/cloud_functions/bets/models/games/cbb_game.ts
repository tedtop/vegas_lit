export interface NcaabGame {
  GameID?: number;
  Season?: number;
  SeasonType?: number;
  Status?: string;
  Day?: Date;
  DateTime?: Date;
  AwayTeam?: string;
  HomeTeam?: string;
  AwayTeamID?: number;
  HomeTeamID?: number;
  AwayTeamScore?: number;
  HomeTeamScore?: number;
  Updated?: Date;
  Period?: string;
  TimeRemainingMinutes?: null;
  TimeRemainingSeconds?: null;
  PointSpread?: number;
  OverUnder?: number;
  AwayTeamMoneyLine?: number;
  HomeTeamMoneyLine?: number;
  GlobalGameID?: number;
  GlobalAwayTeamID?: number;
  GlobalHomeTeamID?: number;
  TournamentID?: number;
  Bracket?: string;
  Round?: number;
  AwayTeamSeed?: number;
  HomeTeamSeed?: number;
  AwayTeamPreviousGameID?: number;
  HomeTeamPreviousGameID?: number;
  AwayTeamPreviousGlobalGameID?: number;
  HomeTeamPreviousGlobalGameID?: number;
  TournamentDisplayOrder?: number;
  TournamentDisplayOrderForHomeTeam?: string;
  IsClosed?: boolean;
  GameEndDateTime?: Date;
  HomeRotationNumber?: number;
  AwayRotationNumber?: number;
  TopTeamPreviousGameId?: number;
  BottomTeamPreviousGameId?: number;
  Channel?: string;
  NeutralVenue?: boolean;
  AwayPointSpreadPayout?: number;
  HomePointSpreadPayout?: number;
  OverPayout?: number;
  UnderPayout?: number;
  Stadium?: Stadium;
  Periods?: Period[];
}

export interface Period {
  PeriodID?: number;
  GameID?: number;
  Number?: number;
  Name?: string;
  Type?: Type;
  AwayScore?: number;
  HomeScore?: number;
}

export enum Type {
  Half = "Half",
}

export interface Stadium {
  StadiumID?: number;
  Active?: boolean;
  Name?: string;
  Address?: null;
  City?: string;
  State?: string;
  Zip?: null;
  Country?: null;
  Capacity?: number;
  GeoLat?: number;
  GeoLong?: number;
}
