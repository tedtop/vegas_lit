import 'dart:convert';

class NcaafGame {
  NcaafGame({
    this.gameId,
    this.season,
    this.seasonType,
    this.week,
    this.status,
    this.day,
    this.dateTime,
    this.awayTeam,
    this.homeTeam,
    this.awayTeamId,
    this.homeTeamId,
    this.awayTeamName,
    this.homeTeamName,
    this.awayTeamScore,
    this.homeTeamScore,
    this.period,
    this.timeRemainingMinutes,
    this.timeRemainingSeconds,
    this.pointSpread,
    this.overUnder,
    this.awayTeamMoneyLine,
    this.homeTeamMoneyLine,
    this.updated,
    this.created,
    this.globalGameId,
    this.globalAwayTeamId,
    this.globalHomeTeamId,
    this.stadiumId,
    this.yardLine,
    this.yardLineTerritory,
    this.down,
    this.distance,
    this.possession,
    this.isClosed,
    this.gameEndDateTime,
    this.title,
    this.homeRotationNumber,
    this.awayRotationNumber,
    this.channel,
    this.neutralVenue,
    this.awayPointSpreadPayout,
    this.homePointSpreadPayout,
    this.overPayout,
    this.underPayout,
    this.stadium,
    this.periods,
  });

  factory NcaafGame.fromJson(String str) =>
      NcaafGame.fromMap(json.decode(str) as Map<String, dynamic>);

  factory NcaafGame.fromMap(Map<String, dynamic> json) => NcaafGame(
        gameId: json['GameID'] as int?,
        season: json['GameID'] as int?,
        seasonType: json['SeasonType'] as int?,
        week: json['Week'] as int?,
        status: json['Status'] as String?,
        day: DateTime.parse(json['Day'] as String),
        dateTime: DateTime.parse(json['DateTime'] as String),
        awayTeam: json['AwayTeam'] as String?,
        homeTeam: json['HomeTeam'] as String?,
        awayTeamId: json['AwayTeamID'] as int?,
        homeTeamId: json['HomeTeamID'] as int?,
        awayTeamName: json['AwayTeamName'] as String?,
        homeTeamName: json['HomeTeamName'] as String?,
        awayTeamScore: json['AwayTeamScore'],
        homeTeamScore: json['HomeTeamScore'],
        period: json['Period'],
        timeRemainingMinutes: json['TimeRemainingMinutes'],
        timeRemainingSeconds: json['TimeRemainingSeconds'],
        pointSpread: json['PointSpread'] == null
            ? null
            : json['PointSpread'].toDouble() as double?,
        overUnder: json['OverUnder'] == null
            ? null
            : json['OverUnder'].toDouble() as double?,
        awayTeamMoneyLine: json['AwayTeamMoneyLine'] as int?,
        homeTeamMoneyLine: json['HomeTeamMoneyLine'] as int?,
        updated: DateTime.parse(json['Updated'] as String),
        created: DateTime.parse(json['Created'] as String),
        globalGameId: json['GlobalGameID'] as int?,
        globalAwayTeamId: json['GlobalAwayTeamID'] as int?,
        globalHomeTeamId: json['GlobalHomeTeamID'] as int?,
        stadiumId: json['StadiumID'] as int?,
        yardLine: json['YardLine'],
        yardLineTerritory: json['YardLineTerritory'],
        down: json['Down'],
        distance: json['Distance'],
        possession: json['Possession'],
        isClosed: json['IsClosed'] as bool?,
        gameEndDateTime: json['GameEndDateTime'],
        title: json['Title'],
        homeRotationNumber: json['HomeRotationNumber'] as int?,
        awayRotationNumber: json['AwayRotationNumber'] as int?,
        channel: json['Channel'] as String?,
        neutralVenue: json['NeutralVenue'] as bool?,
        awayPointSpreadPayout: json['AwayPointSpreadPayout'] as int?,
        homePointSpreadPayout: json['HomePointSpreadPayout'] as int?,
        overPayout: json['OverPayout'] as int?,
        underPayout: json['UnderPayout'] as int?,
        stadium: json['Stadium'],
        periods: List<dynamic>.from(
          json['Periods'].map((dynamic x) => x) as Iterable<dynamic>,
        ),
      );

  final int? gameId;
  final int? season;
  final int? seasonType;
  final int? week;
  final String? status;
  final DateTime? day;
  final DateTime? dateTime;
  final String? awayTeam;
  final String? homeTeam;
  final int? awayTeamId;
  final int? homeTeamId;
  final String? awayTeamName;
  final String? homeTeamName;
  final dynamic awayTeamScore;
  final dynamic homeTeamScore;
  final dynamic period;
  final dynamic timeRemainingMinutes;
  final dynamic timeRemainingSeconds;
  final double? pointSpread;
  final double? overUnder;
  final int? awayTeamMoneyLine;
  final int? homeTeamMoneyLine;
  final DateTime? updated;
  final DateTime? created;
  final int? globalGameId;
  final int? globalAwayTeamId;
  final int? globalHomeTeamId;
  final int? stadiumId;
  final dynamic yardLine;
  final dynamic yardLineTerritory;
  final dynamic down;
  final dynamic distance;
  final dynamic possession;
  final bool? isClosed;
  final dynamic gameEndDateTime;
  final dynamic title;
  final int? homeRotationNumber;
  final int? awayRotationNumber;
  final String? channel;
  final bool? neutralVenue;
  final int? awayPointSpreadPayout;
  final int? homePointSpreadPayout;
  final int? overPayout;
  final int? underPayout;
  final dynamic stadium;
  final List<dynamic>? periods;

  NcaafGame copyWith({
    int? gameId,
    int? season,
    int? seasonType,
    int? week,
    String? status,
    DateTime? day,
    DateTime? dateTime,
    String? awayTeam,
    String? homeTeam,
    int? awayTeamId,
    int? homeTeamId,
    String? awayTeamName,
    String? homeTeamName,
    dynamic awayTeamScore,
    dynamic homeTeamScore,
    dynamic period,
    dynamic timeRemainingMinutes,
    dynamic timeRemainingSeconds,
    double? pointSpread,
    double? overUnder,
    int? awayTeamMoneyLine,
    int? homeTeamMoneyLine,
    DateTime? updated,
    DateTime? created,
    int? globalGameId,
    int? globalAwayTeamId,
    int? globalHomeTeamId,
    int? stadiumId,
    dynamic yardLine,
    dynamic yardLineTerritory,
    dynamic down,
    dynamic distance,
    dynamic possession,
    bool? isClosed,
    dynamic gameEndDateTime,
    dynamic title,
    int? homeRotationNumber,
    int? awayRotationNumber,
    String? channel,
    bool? neutralVenue,
    int? awayPointSpreadPayout,
    int? homePointSpreadPayout,
    int? overPayout,
    int? underPayout,
    dynamic stadium,
    List<dynamic>? periods,
  }) =>
      NcaafGame(
        gameId: gameId ?? this.gameId,
        season: season ?? this.season,
        seasonType: seasonType ?? this.seasonType,
        week: week ?? this.week,
        status: status ?? this.status,
        day: day ?? this.day,
        dateTime: dateTime ?? this.dateTime,
        awayTeam: awayTeam ?? this.awayTeam,
        homeTeam: homeTeam ?? this.homeTeam,
        awayTeamId: awayTeamId ?? this.awayTeamId,
        homeTeamId: homeTeamId ?? this.homeTeamId,
        awayTeamName: awayTeamName ?? this.awayTeamName,
        homeTeamName: homeTeamName ?? this.homeTeamName,
        awayTeamScore: awayTeamScore ?? this.awayTeamScore,
        homeTeamScore: homeTeamScore ?? this.homeTeamScore,
        period: period ?? this.period,
        timeRemainingMinutes: timeRemainingMinutes ?? this.timeRemainingMinutes,
        timeRemainingSeconds: timeRemainingSeconds ?? this.timeRemainingSeconds,
        pointSpread: pointSpread ?? this.pointSpread,
        overUnder: overUnder ?? this.overUnder,
        awayTeamMoneyLine: awayTeamMoneyLine ?? this.awayTeamMoneyLine,
        homeTeamMoneyLine: homeTeamMoneyLine ?? this.homeTeamMoneyLine,
        updated: updated ?? this.updated,
        created: created ?? this.created,
        globalGameId: globalGameId ?? this.globalGameId,
        globalAwayTeamId: globalAwayTeamId ?? this.globalAwayTeamId,
        globalHomeTeamId: globalHomeTeamId ?? this.globalHomeTeamId,
        stadiumId: stadiumId ?? this.stadiumId,
        yardLine: yardLine ?? this.yardLine,
        yardLineTerritory: yardLineTerritory ?? this.yardLineTerritory,
        down: down ?? this.down,
        distance: distance ?? this.distance,
        possession: possession ?? this.possession,
        isClosed: isClosed ?? this.isClosed,
        gameEndDateTime: gameEndDateTime ?? this.gameEndDateTime,
        title: title ?? this.title,
        homeRotationNumber: homeRotationNumber ?? this.homeRotationNumber,
        awayRotationNumber: awayRotationNumber ?? this.awayRotationNumber,
        channel: channel ?? this.channel,
        neutralVenue: neutralVenue ?? this.neutralVenue,
        awayPointSpreadPayout:
            awayPointSpreadPayout ?? this.awayPointSpreadPayout,
        homePointSpreadPayout:
            homePointSpreadPayout ?? this.homePointSpreadPayout,
        overPayout: overPayout ?? this.overPayout,
        underPayout: underPayout ?? this.underPayout,
        stadium: stadium ?? this.stadium,
        periods: periods ?? this.periods,
      );

  String toJson() => json.encode(toMap());
  Map<String, Object?> toMap() => {
        'GameID': gameId,
        'Season': season,
        'SeasonType': seasonType,
        'Week': week,
        'Status': status,
        'Day': day!.toIso8601String(),
        'DateTime': dateTime!.toIso8601String(),
        'AwayTeam': awayTeam,
        'HomeTeam': homeTeam,
        'AwayTeamID': awayTeamId,
        'HomeTeamID': homeTeamId,
        'AwayTeamName': awayTeamName,
        'HomeTeamName': homeTeamName,
        'AwayTeamScore': awayTeamScore,
        'HomeTeamScore': homeTeamScore,
        'Period': period,
        'TimeRemainingMinutes': timeRemainingMinutes,
        'TimeRemainingSeconds': timeRemainingSeconds,
        'PointSpread': pointSpread,
        'OverUnder': overUnder,
        'AwayTeamMoneyLine': awayTeamMoneyLine,
        'HomeTeamMoneyLine': homeTeamMoneyLine,
        'Updated': updated!.toIso8601String(),
        'Created': created!.toIso8601String(),
        'GlobalGameID': globalGameId,
        'GlobalAwayTeamID': globalAwayTeamId,
        'GlobalHomeTeamID': globalHomeTeamId,
        'StadiumID': stadiumId,
        'YardLine': yardLine,
        'YardLineTerritory': yardLineTerritory,
        'Down': down,
        'Distance': distance,
        'Possession': possession,
        'IsClosed': isClosed,
        'GameEndDateTime': gameEndDateTime,
        'Title': title,
        'HomeRotationNumber': homeRotationNumber,
        'AwayRotationNumber': awayRotationNumber,
        'Channel': channel,
        'NeutralVenue': neutralVenue,
        'AwayPointSpreadPayout': awayPointSpreadPayout,
        'HomePointSpreadPayout': homePointSpreadPayout,
        'OverPayout': overPayout,
        'UnderPayout': underPayout,
        'Stadium': stadium,
        'Periods': List<dynamic>.from(periods!.map<void>((dynamic x) => x)),
      };
}
