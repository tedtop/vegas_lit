import 'dart:convert';

class NcaabGame {
  NcaabGame({
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

  factory NcaabGame.fromJson(String str) => NcaabGame.fromMap(json.decode(str));

  factory NcaabGame.fromMap(Map<String, dynamic> json) => NcaabGame(
        gameId: json['GameID'],
        season: json['Season'],
        seasonType: json['SeasonType'],
        status: json['Status'],
        day: json['Day'] == null ? null : DateTime.parse(json['Day']),
        dateTime:
            json['DateTime'] == null ? null : DateTime.parse(json['DateTime']),
        awayTeam: json['AwayTeam'],
        homeTeam: json['HomeTeam'],
        awayTeamId: json['AwayTeamID'],
        homeTeamId: json['HomeTeamID'],
        stadiumId: json['StadiumID'],
        channel: json['Channel'],
        attendance: json['Attendance'],
        awayTeamScore: json['AwayTeamScore'],
        homeTeamScore: json['HomeTeamScore'],
        updated:
            json['Updated'] == null ? null : DateTime.parse(json['Updated']),
        quarter: json['Quarter'],
        timeRemainingMinutes: json['TimeRemainingMinutes'],
        timeRemainingSeconds: json['TimeRemainingSeconds'],
        pointSpread: json['PointSpread'] == null
            ? null
            : double.tryParse(json['PointSpread'].toString()),
        overUnder: json['OverUnder'] == null
            ? null
            : double.tryParse(json['OverUnder'].toString()),
        awayTeamMoneyLine: json['AwayTeamMoneyLine'] ?? 100,
        homeTeamMoneyLine: json['HomeTeamMoneyLine'] ?? -100,
        globalGameId: json['GlobalGameID'],
        globalAwayTeamId: json['GlobalAwayTeamID'],
        globalHomeTeamId: json['GlobalHomeTeamID'],
        pointSpreadAwayTeamMoneyLine: json['PointSpreadAwayTeamMoneyLine'],
        pointSpreadHomeTeamMoneyLine: json['PointSpreadHomeTeamMoneyLine'],
        lastPlay: json['LastPlay'],
        isClosed: json['IsClosed'],
        gameEndDateTime: json['GameEndDateTime'],
        homeRotationNumber: json['HomeRotationNumber'],
        awayRotationNumber: json['AwayRotationNumber'],
        neutralVenue: json['NeutralVenue'],
        overPayout: json['OverPayout'],
        underPayout: json['UnderPayout'],
        quarters: json['Quarters'] == null
            ? null
            : List<dynamic>.from(json['Quarters'].map((x) => x)),
      );

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

  NcaabGame copyWith({
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
      NcaabGame(
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

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'GameID': gameId,
        'Season': season,
        'SeasonType': seasonType,
        'Status': status,
        'Day': day == null ? null : day.toIso8601String(),
        'DateTime': dateTime == null ? null : dateTime.toIso8601String(),
        'AwayTeam': awayTeam,
        'HomeTeam': homeTeam,
        'AwayTeamID': awayTeamId,
        'HomeTeamID': homeTeamId,
        'StadiumID': stadiumId,
        'Channel': channel,
        'Attendance': attendance,
        'AwayTeamScore': awayTeamScore,
        'HomeTeamScore': homeTeamScore,
        'Updated': updated == null ? null : updated.toIso8601String(),
        'Quarter': quarter,
        'TimeRemainingMinutes': timeRemainingMinutes,
        'TimeRemainingSeconds': timeRemainingSeconds,
        'PointSpread': pointSpread,
        'OverUnder': overUnder,
        'AwayTeamMoneyLine': awayTeamMoneyLine,
        'HomeTeamMoneyLine': homeTeamMoneyLine,
        'GlobalGameID': globalGameId,
        'GlobalAwayTeamID': globalAwayTeamId,
        'GlobalHomeTeamID': globalHomeTeamId,
        'PointSpreadAwayTeamMoneyLine': pointSpreadAwayTeamMoneyLine,
        'PointSpreadHomeTeamMoneyLine': pointSpreadHomeTeamMoneyLine,
        'LastPlay': lastPlay,
        'IsClosed': isClosed,
        'GameEndDateTime': gameEndDateTime,
        'HomeRotationNumber': homeRotationNumber,
        'AwayRotationNumber': awayRotationNumber,
        'NeutralVenue': neutralVenue,
        'OverPayout': overPayout,
        'UnderPayout': underPayout,
        'Quarters': quarters == null
            ? null
            : List<dynamic>.from(quarters.map((x) => x)),
      };
}
