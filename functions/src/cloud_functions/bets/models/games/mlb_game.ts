export interface MlbGame {
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
  RescheduledGameID?: null;
  StadiumID?: number;
  Channel?: null | string;
  Inning?: null;
  InningHalf?: null;
  AwayTeamRuns?: null;
  HomeTeamRuns?: null;
  AwayTeamHits?: null;
  HomeTeamHits?: null;
  AwayTeamErrors?: null;
  HomeTeamErrors?: null;
  WinningPitcherID?: null;
  LosingPitcherID?: null;
  SavingPitcherID?: null;
  Attendance?: null;
  AwayTeamProbablePitcherID?: number;
  HomeTeamProbablePitcherID?: number | null;
  Outs?: null;
  Balls?: null;
  Strikes?: null;
  CurrentPitcherID?: null;
  CurrentHitterID?: null;
  AwayTeamStartingPitcherID?: null;
  HomeTeamStartingPitcherID?: null;
  CurrentPitchingTeamID?: null;
  CurrentHittingTeamID?: null;
  PointSpread?: number;
  OverUnder?: number;
  AwayTeamMoneyLine?: number;
  HomeTeamMoneyLine?: number;
  ForecastTempLow?: number;
  ForecastTempHigh?: number;
  ForecastDescription?: string;
  ForecastWindChill?: number;
  ForecastWindSpeed?: number;
  ForecastWindDirection?: number;
  RescheduledFromGameID?: null;
  RunnerOnFirst?: null;
  RunnerOnSecond?: null;
  RunnerOnThird?: null;
  AwayTeamStartingPitcher?: string;
  HomeTeamStartingPitcher?: null | string;
  CurrentPitcher?: null;
  CurrentHitter?: null;
  WinningPitcher?: null;
  LosingPitcher?: null;
  SavingPitcher?: null;
  DueUpHitterID1?: null;
  DueUpHitterID2?: null;
  DueUpHitterID3?: null;
  GlobalGameID?: number;
  GlobalAwayTeamID?: number;
  GlobalHomeTeamID?: number;
  PointSpreadAwayTeamMoneyLine?: number;
  PointSpreadHomeTeamMoneyLine?: number;
  LastPlay?: null;
  IsClosed?: boolean;
  Updated?: Date;
  GameEndDateTime?: null;
  HomeRotationNumber?: number;
  AwayRotationNumber?: number;
  NeutralVenue?: boolean;
  InningDescription?: null;
  OverPayout?: number;
  UnderPayout?: number;
  Innings?: any[];
}