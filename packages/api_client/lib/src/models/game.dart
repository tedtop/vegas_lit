import 'dart:convert';

class Game {
  Game({
    this.gameId,
    this.season,
    this.seasonType,
    this.status,
    this.day,
    this.dateTime,
    this.awayTeam,
    this.homeTeam,
    this.awayTeamId,
    this.homeTeamId,
    this.stadiumId,
    this.channel,
    this.attendance,
    this.awayTeamScore,
    this.homeTeamScore,
    this.updated,
    this.quarter,
    this.timeRemainingMinutes,
    this.timeRemainingSeconds,
    this.pointSpread,
    this.overUnder,
    this.awayTeamMoneyLine,
    this.homeTeamMoneyLine,
    this.globalGameId,
    this.globalAwayTeamId,
    this.globalHomeTeamId,
    this.pointSpreadAwayTeamMoneyLine,
    this.pointSpreadHomeTeamMoneyLine,
    this.lastPlay,
    this.isClosed,
    this.gameEndDateTime,
    this.homeRotationNumber,
    this.awayRotationNumber,
    this.neutralVenue,
    this.overPayout,
    this.underPayout,
    this.quarters,
  });

  final int gameId;
  final int season;
  final int seasonType;
  final String status;
  final DateTime day;
  final DateTime dateTime;
  final String awayTeam;
  final String homeTeam;
  final int awayTeamId;
  final int homeTeamId;
  final int stadiumId;
  final String channel;
  final dynamic attendance;
  final dynamic awayTeamScore;
  final dynamic homeTeamScore;
  final DateTime updated;
  final dynamic quarter;
  final dynamic timeRemainingMinutes;
  final dynamic timeRemainingSeconds;
  final double pointSpread;
  final double overUnder;
  final int awayTeamMoneyLine;
  final int homeTeamMoneyLine;
  final int globalGameId;
  final int globalAwayTeamId;
  final int globalHomeTeamId;
  final int pointSpreadAwayTeamMoneyLine;
  final int pointSpreadHomeTeamMoneyLine;
  final dynamic lastPlay;
  final bool isClosed;
  final dynamic gameEndDateTime;
  final int homeRotationNumber;
  final int awayRotationNumber;
  final bool neutralVenue;
  final int overPayout;
  final int underPayout;
  final List<dynamic> quarters;

  Game copyWith({
    int gameId,
    int season,
    int seasonType,
    String status,
    DateTime day,
    DateTime dateTime,
    String awayTeam,
    String homeTeam,
    int awayTeamId,
    int homeTeamId,
    int stadiumId,
    String channel,
    dynamic attendance,
    dynamic awayTeamScore,
    dynamic homeTeamScore,
    DateTime updated,
    dynamic quarter,
    dynamic timeRemainingMinutes,
    dynamic timeRemainingSeconds,
    double pointSpread,
    double overUnder,
    int awayTeamMoneyLine,
    int homeTeamMoneyLine,
    int globalGameId,
    int globalAwayTeamId,
    int globalHomeTeamId,
    int pointSpreadAwayTeamMoneyLine,
    int pointSpreadHomeTeamMoneyLine,
    dynamic lastPlay,
    bool isClosed,
    dynamic gameEndDateTime,
    int homeRotationNumber,
    int awayRotationNumber,
    bool neutralVenue,
    int overPayout,
    int underPayout,
    List<dynamic> quarters,
  }) =>
      Game(
        gameId: gameId ?? this.gameId,
        season: season ?? this.season,
        seasonType: seasonType ?? this.seasonType,
        status: status ?? this.status,
        day: day ?? this.day,
        dateTime: dateTime ?? this.dateTime,
        awayTeam: awayTeam ?? this.awayTeam,
        homeTeam: homeTeam ?? this.homeTeam,
        awayTeamId: awayTeamId ?? this.awayTeamId,
        homeTeamId: homeTeamId ?? this.homeTeamId,
        stadiumId: stadiumId ?? this.stadiumId,
        channel: channel ?? this.channel,
        attendance: attendance ?? this.attendance,
        awayTeamScore: awayTeamScore ?? this.awayTeamScore,
        homeTeamScore: homeTeamScore ?? this.homeTeamScore,
        updated: updated ?? this.updated,
        quarter: quarter ?? this.quarter,
        timeRemainingMinutes: timeRemainingMinutes ?? this.timeRemainingMinutes,
        timeRemainingSeconds: timeRemainingSeconds ?? this.timeRemainingSeconds,
        pointSpread: pointSpread ?? this.pointSpread,
        overUnder: overUnder ?? this.overUnder,
        awayTeamMoneyLine: awayTeamMoneyLine ?? this.awayTeamMoneyLine,
        homeTeamMoneyLine: homeTeamMoneyLine ?? this.homeTeamMoneyLine,
        globalGameId: globalGameId ?? this.globalGameId,
        globalAwayTeamId: globalAwayTeamId ?? this.globalAwayTeamId,
        globalHomeTeamId: globalHomeTeamId ?? this.globalHomeTeamId,
        pointSpreadAwayTeamMoneyLine:
            pointSpreadAwayTeamMoneyLine ?? this.pointSpreadAwayTeamMoneyLine,
        pointSpreadHomeTeamMoneyLine:
            pointSpreadHomeTeamMoneyLine ?? this.pointSpreadHomeTeamMoneyLine,
        lastPlay: lastPlay ?? this.lastPlay,
        isClosed: isClosed ?? this.isClosed,
        gameEndDateTime: gameEndDateTime ?? this.gameEndDateTime,
        homeRotationNumber: homeRotationNumber ?? this.homeRotationNumber,
        awayRotationNumber: awayRotationNumber ?? this.awayRotationNumber,
        neutralVenue: neutralVenue ?? this.neutralVenue,
        overPayout: overPayout ?? this.overPayout,
        underPayout: underPayout ?? this.underPayout,
        quarters: quarters ?? this.quarters,
      );

  factory Game.fromJson(String str) => Game.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Game.fromMap(Map<String, dynamic> json) => Game(
        gameId: json["GameID"] == null ? null : json['GameID'],
        season: json['Season'],
        seasonType: json['SeasonType'] == null ? null : json['SeasonType'],
        status: json["Status"] == null ? null : json["Status"],
        day: json["Day"] == null ? null : DateTime.parse(json["Day"]),
        dateTime:
            json["DateTime"] == null ? null : DateTime.parse(json["DateTime"]),
        awayTeam: json["AwayTeam"] == null ? null : json["AwayTeam"],
        homeTeam: json["HomeTeam"] == null ? null : json["HomeTeam"],
        awayTeamId: json["AwayTeamID"] == null ? null : json["AwayTeamID"],
        homeTeamId: json["HomeTeamID"] == null ? null : json["HomeTeamID"],
        stadiumId: json["StadiumID"] == null ? null : json["StadiumID"],
        channel: json["Channel"] == null ? null : json["Channel"],
        attendance: json["Attendance"],
        awayTeamScore: json["AwayTeamScore"],
        homeTeamScore: json["HomeTeamScore"],
        updated:
            json["Updated"] == null ? null : DateTime.parse(json["Updated"]),
        quarter: json["Quarter"],
        timeRemainingMinutes: json["TimeRemainingMinutes"],
        timeRemainingSeconds: json["TimeRemainingSeconds"],
        pointSpread:
            json["PointSpread"] == null ? null : json["PointSpread"].toDouble(),
        overUnder:
            json["OverUnder"] == null ? null : json["OverUnder"].toDouble(),
        awayTeamMoneyLine:
            json["AwayTeamMoneyLine"] == null ? 100 : json["AwayTeamMoneyLine"],
        homeTeamMoneyLine: json["HomeTeamMoneyLine"] == null
            ? -100
            : json["HomeTeamMoneyLine"],
        globalGameId:
            json["GlobalGameID"] == null ? null : json["GlobalGameID"],
        globalAwayTeamId:
            json["GlobalAwayTeamID"] == null ? null : json["GlobalAwayTeamID"],
        globalHomeTeamId:
            json["GlobalHomeTeamID"] == null ? null : json["GlobalHomeTeamID"],
        pointSpreadAwayTeamMoneyLine:
            json["PointSpreadAwayTeamMoneyLine"] == null
                ? null
                : json["PointSpreadAwayTeamMoneyLine"],
        pointSpreadHomeTeamMoneyLine:
            json["PointSpreadHomeTeamMoneyLine"] == null
                ? null
                : json["PointSpreadHomeTeamMoneyLine"],
        lastPlay: json["LastPlay"],
        isClosed: json["IsClosed"] == null ? null : json["IsClosed"],
        gameEndDateTime: json["GameEndDateTime"],
        homeRotationNumber: json["HomeRotationNumber"] == null
            ? null
            : json["HomeRotationNumber"],
        awayRotationNumber: json["AwayRotationNumber"] == null
            ? null
            : json["AwayRotationNumber"],
        neutralVenue:
            json["NeutralVenue"] == null ? null : json["NeutralVenue"],
        overPayout: json["OverPayout"] == null ? null : json["OverPayout"],
        underPayout: json["UnderPayout"] == null ? null : json["UnderPayout"],
        quarters: json["Quarters"] == null
            ? null
            : List<dynamic>.from(json["Quarters"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "GameID": gameId == null ? null : gameId,
        "Season": season == null ? null : season,
        "SeasonType": seasonType == null ? null : seasonType,
        "Status": status == null ? null : status,
        "Day": day == null ? null : day.toIso8601String(),
        "DateTime": dateTime == null ? null : dateTime.toIso8601String(),
        "AwayTeam": awayTeam == null ? null : awayTeam,
        "HomeTeam": homeTeam == null ? null : homeTeam,
        "AwayTeamID": awayTeamId == null ? null : awayTeamId,
        "HomeTeamID": homeTeamId == null ? null : homeTeamId,
        "StadiumID": stadiumId == null ? null : stadiumId,
        "Channel": channel == null ? null : channel,
        "Attendance": attendance,
        "AwayTeamScore": awayTeamScore,
        "HomeTeamScore": homeTeamScore,
        "Updated": updated == null ? null : updated.toIso8601String(),
        "Quarter": quarter,
        "TimeRemainingMinutes": timeRemainingMinutes,
        "TimeRemainingSeconds": timeRemainingSeconds,
        "PointSpread": pointSpread == null ? null : pointSpread,
        "OverUnder": overUnder == null ? null : overUnder,
        "AwayTeamMoneyLine":
            awayTeamMoneyLine == null ? null : awayTeamMoneyLine,
        "HomeTeamMoneyLine":
            homeTeamMoneyLine == null ? null : homeTeamMoneyLine,
        "GlobalGameID": globalGameId == null ? null : globalGameId,
        "GlobalAwayTeamID": globalAwayTeamId == null ? null : globalAwayTeamId,
        "GlobalHomeTeamID": globalHomeTeamId == null ? null : globalHomeTeamId,
        "PointSpreadAwayTeamMoneyLine": pointSpreadAwayTeamMoneyLine == null
            ? null
            : pointSpreadAwayTeamMoneyLine,
        "PointSpreadHomeTeamMoneyLine": pointSpreadHomeTeamMoneyLine == null
            ? null
            : pointSpreadHomeTeamMoneyLine,
        "LastPlay": lastPlay,
        "IsClosed": isClosed == null ? null : isClosed,
        "GameEndDateTime": gameEndDateTime,
        "HomeRotationNumber":
            homeRotationNumber == null ? null : homeRotationNumber,
        "AwayRotationNumber":
            awayRotationNumber == null ? null : awayRotationNumber,
        "NeutralVenue": neutralVenue == null ? null : neutralVenue,
        "OverPayout": overPayout == null ? null : overPayout,
        "UnderPayout": underPayout == null ? null : underPayout,
        "Quarters": quarters == null
            ? null
            : List<dynamic>.from(quarters.map((x) => x)),
      };
}
