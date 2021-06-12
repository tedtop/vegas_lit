export interface Game {
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
    StadiumID?: number;
    Channel?: string;
    Attendance?: null;
    AwayTeamScore?: number;
    HomeTeamScore?: number;
    AwayTeamRuns?: number;
    HomeTeamRuns?: number;
    Updated?: Date;
    Quarter?: null;
    TimeRemainingMinutes?: null;
    TimeRemainingSeconds?: null;
    PointSpread?: number;
    OverUnder?: number;
    AwayTeamMoneyLine?: number;
    HomeTeamMoneyLine?: number;
    GlobalGameID?: number;
    GlobalAwayTeamID?: number;
    GlobalHomeTeamID?: number;
    PointSpreadAwayTeamMoneyLine?: number;
    PointSpreadHomeTeamMoneyLine?: number;
    LastPlay?: null;
    IsClosed?: boolean;
    GameEndDateTime?: Date;
    HomeRotationNumber?: number;
    AwayRotationNumber?: number;
    NeutralVenue?: boolean;
    OverPayout?: number;
    UnderPayout?: number;
    Quarters?: Quarter[];
  }
  
export interface Quarter {
    QuarterID?: number;
    GameID?: number;
    Number?: number;
    Name?: string;
    AwayScore?: number;
    HomeScore?: number;
  }
  