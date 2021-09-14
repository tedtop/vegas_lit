// To parse this JSON data, do
//
//     final nflGame = nflGameFromMap(jsonString);

import 'dart:convert';

class NflGame {
  NflGame({
    this.gameKey,
    this.seasonType,
    this.season,
    this.week,
    this.date,
    this.awayTeam,
    this.homeTeam,
    this.awayScore,
    this.homeScore,
    this.channel,
    this.pointSpread,
    this.overUnder,
    this.quarter,
    this.timeRemaining,
    this.possession,
    this.down,
    this.distance,
    this.yardLine,
    this.yardLineTerritory,
    this.redZone,
    this.awayScoreQuarter1,
    this.awayScoreQuarter2,
    this.awayScoreQuarter3,
    this.awayScoreQuarter4,
    this.awayScoreOvertime,
    this.homeScoreQuarter1,
    this.homeScoreQuarter2,
    this.homeScoreQuarter3,
    this.homeScoreQuarter4,
    this.homeScoreOvertime,
    this.hasStarted,
    this.isInProgress,
    this.isOver,
    this.has1StQuarterStarted,
    this.has2NdQuarterStarted,
    this.has3RdQuarterStarted,
    this.has4ThQuarterStarted,
    this.isOvertime,
    this.downAndDistance,
    this.quarterDescription,
    this.stadiumId,
    this.lastUpdated,
    this.geoLat,
    this.geoLong,
    this.forecastTempLow,
    this.forecastTempHigh,
    this.forecastDescription,
    this.forecastWindChill,
    this.forecastWindSpeed,
    this.awayTeamMoneyLine,
    this.homeTeamMoneyLine,
    this.canceled,
    this.closed,
    this.lastPlay,
    this.day,
    this.dateTime,
    this.awayTeamId,
    this.homeTeamId,
    this.globalGameId,
    this.globalAwayTeamId,
    this.globalHomeTeamId,
    this.pointSpreadAwayTeamMoneyLine,
    this.pointSpreadHomeTeamMoneyLine,
    this.scoreId,
    this.status,
    this.gameEndDateTime,
    this.homeRotationNumber,
    this.awayRotationNumber,
    this.neutralVenue,
    this.refereeId,
    this.overPayout,
    this.underPayout,
    this.stadiumDetails,
  });

  factory NflGame.fromJson(String str) => NflGame.fromMap(json.decode(str));
  factory NflGame.fromMap(Map<String, dynamic> json) => NflGame(
        gameKey: json['GameKey'],
        seasonType: json['SeasonType'],
        season: json['Season'],
        week: json['Week'],
        date: DateTime.parse(json['Date']),
        awayTeam: json['AwayTeam'],
        homeTeam: json['HomeTeam'],
        awayScore: json['AwayScore'],
        homeScore: json['HomeScore'],
        channel: channelValues.map[json['Channel']],
        pointSpread:
            json['PointSpread'] == null ? null : json['PointSpread'].toDouble(),
        overUnder:
            json['OverUnder'] == null ? null : json['OverUnder'].toDouble(),
        quarter: json['Quarter'],
        timeRemaining: json['TimeRemaining'],
        possession: json['Possession'],
        down: json['Down'],
        distance: json['Distance'],
        yardLine: json['YardLine'],
        yardLineTerritory: json['YardLineTerritory'],
        redZone: json['RedZone'],
        awayScoreQuarter1: json['AwayScoreQuarter1'],
        awayScoreQuarter2: json['AwayScoreQuarter2'],
        awayScoreQuarter3: json['AwayScoreQuarter3'],
        awayScoreQuarter4: json['AwayScoreQuarter4'],
        awayScoreOvertime: json['AwayScoreOvertime'],
        homeScoreQuarter1: json['HomeScoreQuarter1'],
        homeScoreQuarter2: json['HomeScoreQuarter2'],
        homeScoreQuarter3: json['HomeScoreQuarter3'],
        homeScoreQuarter4: json['HomeScoreQuarter4'],
        homeScoreOvertime: json['HomeScoreOvertime'],
        hasStarted: json['HasStarted'],
        isInProgress: json['IsInProgress'],
        isOver: json['IsOver'],
        has1StQuarterStarted: json['Has1stQuarterStarted'],
        has2NdQuarterStarted: json['Has2ndQuarterStarted'],
        has3RdQuarterStarted: json['Has3rdQuarterStarted'],
        has4ThQuarterStarted: json['Has4thQuarterStarted'],
        isOvertime: json['IsOvertime'],
        downAndDistance: json['DownAndDistance'],
        quarterDescription: json['QuarterDescription'],
        stadiumId: json['StadiumID'],
        lastUpdated: DateTime.parse(json['LastUpdated']),
        geoLat: json['GeoLat'],
        geoLong: json['GeoLong'],
        forecastTempLow: json['ForecastTempLow'],
        forecastTempHigh: json['ForecastTempHigh'],
        forecastDescription: json['ForecastDescription'],
        forecastWindChill: json['ForecastWindChill'],
        forecastWindSpeed: json['ForecastWindSpeed'],
        awayTeamMoneyLine: json['AwayTeamMoneyLine'],
        homeTeamMoneyLine: json['HomeTeamMoneyLine'],
        canceled: json['Canceled'],
        closed: json['Closed'],
        lastPlay: json['LastPlay'],
        day: DateTime.parse(json['Day']),
        dateTime: DateTime.parse(json['DateTime']),
        awayTeamId: json['AwayTeamID'],
        homeTeamId: json['HomeTeamID'],
        globalGameId: json['GlobalGameID'],
        globalAwayTeamId: json['GlobalAwayTeamID'],
        globalHomeTeamId: json['GlobalHomeTeamID'],
        pointSpreadAwayTeamMoneyLine: json['PointSpreadAwayTeamMoneyLine'],
        pointSpreadHomeTeamMoneyLine: json['PointSpreadHomeTeamMoneyLine'],
        scoreId: json['ScoreID'],
        status: json['Status'],
        gameEndDateTime: json['GameEndDateTime'],
        homeRotationNumber: json['HomeRotationNumber'],
        awayRotationNumber: json['AwayRotationNumber'],
        neutralVenue: json['NeutralVenue'],
        refereeId: json['RefereeID'],
        overPayout: json['OverPayout'],
        underPayout: json['UnderPayout'],
        stadiumDetails: StadiumDetails.fromMap(json['StadiumDetails']),
      );

  final String gameKey;
  final int seasonType;
  final int season;
  final int week;
  final DateTime date;
  final String awayTeam;
  final String homeTeam;
  final dynamic awayScore;
  final dynamic homeScore;
  final Channel channel;
  final double pointSpread;
  final double overUnder;
  final dynamic quarter;
  final dynamic timeRemaining;
  final dynamic possession;
  final dynamic down;
  final dynamic distance;
  final dynamic yardLine;
  final dynamic yardLineTerritory;
  final dynamic redZone;
  final dynamic awayScoreQuarter1;
  final dynamic awayScoreQuarter2;
  final dynamic awayScoreQuarter3;
  final dynamic awayScoreQuarter4;
  final dynamic awayScoreOvertime;
  final dynamic homeScoreQuarter1;
  final dynamic homeScoreQuarter2;
  final dynamic homeScoreQuarter3;
  final dynamic homeScoreQuarter4;
  final dynamic homeScoreOvertime;
  final bool hasStarted;
  final bool isInProgress;
  final bool isOver;
  final bool has1StQuarterStarted;
  final bool has2NdQuarterStarted;
  final bool has3RdQuarterStarted;
  final bool has4ThQuarterStarted;
  final bool isOvertime;
  final dynamic downAndDistance;
  final String quarterDescription;
  final int stadiumId;
  final DateTime lastUpdated;
  final dynamic geoLat;
  final dynamic geoLong;
  final dynamic forecastTempLow;
  final dynamic forecastTempHigh;
  final dynamic forecastDescription;
  final dynamic forecastWindChill;
  final dynamic forecastWindSpeed;
  final int awayTeamMoneyLine;
  final int homeTeamMoneyLine;
  final bool canceled;
  final bool closed;
  final dynamic lastPlay;
  final DateTime day;
  final DateTime dateTime;
  final int awayTeamId;
  final int homeTeamId;
  final int globalGameId;
  final int globalAwayTeamId;
  final int globalHomeTeamId;
  final int pointSpreadAwayTeamMoneyLine;
  final int pointSpreadHomeTeamMoneyLine;
  final int scoreId;
  final String status;
  final dynamic gameEndDateTime;
  final int homeRotationNumber;
  final int awayRotationNumber;
  final bool neutralVenue;
  final dynamic refereeId;
  final int overPayout;
  final int underPayout;
  final StadiumDetails stadiumDetails;

  NflGame copyWith({
    String gameKey,
    int seasonType,
    int season,
    int week,
    DateTime date,
    String awayTeam,
    String homeTeam,
    dynamic awayScore,
    dynamic homeScore,
    Channel channel,
    double pointSpread,
    double overUnder,
    dynamic quarter,
    dynamic timeRemaining,
    dynamic possession,
    dynamic down,
    dynamic distance,
    dynamic yardLine,
    dynamic yardLineTerritory,
    dynamic redZone,
    dynamic awayScoreQuarter1,
    dynamic awayScoreQuarter2,
    dynamic awayScoreQuarter3,
    dynamic awayScoreQuarter4,
    dynamic awayScoreOvertime,
    dynamic homeScoreQuarter1,
    dynamic homeScoreQuarter2,
    dynamic homeScoreQuarter3,
    dynamic homeScoreQuarter4,
    dynamic homeScoreOvertime,
    bool hasStarted,
    bool isInProgress,
    bool isOver,
    bool has1StQuarterStarted,
    bool has2NdQuarterStarted,
    bool has3RdQuarterStarted,
    bool has4ThQuarterStarted,
    bool isOvertime,
    dynamic downAndDistance,
    String quarterDescription,
    int stadiumId,
    DateTime lastUpdated,
    dynamic geoLat,
    dynamic geoLong,
    dynamic forecastTempLow,
    dynamic forecastTempHigh,
    dynamic forecastDescription,
    dynamic forecastWindChill,
    dynamic forecastWindSpeed,
    int awayTeamMoneyLine,
    int homeTeamMoneyLine,
    bool canceled,
    bool closed,
    dynamic lastPlay,
    DateTime day,
    DateTime dateTime,
    int awayTeamId,
    int homeTeamId,
    int globalGameId,
    int globalAwayTeamId,
    int globalHomeTeamId,
    int pointSpreadAwayTeamMoneyLine,
    int pointSpreadHomeTeamMoneyLine,
    int scoreId,
    String status,
    dynamic gameEndDateTime,
    int homeRotationNumber,
    int awayRotationNumber,
    bool neutralVenue,
    dynamic refereeId,
    int overPayout,
    int underPayout,
    StadiumDetails stadiumDetails,
  }) =>
      NflGame(
        gameKey: gameKey ?? this.gameKey,
        seasonType: seasonType ?? this.seasonType,
        season: season ?? this.season,
        week: week ?? this.week,
        date: date ?? this.date,
        awayTeam: awayTeam ?? this.awayTeam,
        homeTeam: homeTeam ?? this.homeTeam,
        awayScore: awayScore ?? this.awayScore,
        homeScore: homeScore ?? this.homeScore,
        channel: channel ?? this.channel,
        pointSpread: pointSpread ?? this.pointSpread,
        overUnder: overUnder ?? this.overUnder,
        quarter: quarter ?? this.quarter,
        timeRemaining: timeRemaining ?? this.timeRemaining,
        possession: possession ?? this.possession,
        down: down ?? this.down,
        distance: distance ?? this.distance,
        yardLine: yardLine ?? this.yardLine,
        yardLineTerritory: yardLineTerritory ?? this.yardLineTerritory,
        redZone: redZone ?? this.redZone,
        awayScoreQuarter1: awayScoreQuarter1 ?? this.awayScoreQuarter1,
        awayScoreQuarter2: awayScoreQuarter2 ?? this.awayScoreQuarter2,
        awayScoreQuarter3: awayScoreQuarter3 ?? this.awayScoreQuarter3,
        awayScoreQuarter4: awayScoreQuarter4 ?? this.awayScoreQuarter4,
        awayScoreOvertime: awayScoreOvertime ?? this.awayScoreOvertime,
        homeScoreQuarter1: homeScoreQuarter1 ?? this.homeScoreQuarter1,
        homeScoreQuarter2: homeScoreQuarter2 ?? this.homeScoreQuarter2,
        homeScoreQuarter3: homeScoreQuarter3 ?? this.homeScoreQuarter3,
        homeScoreQuarter4: homeScoreQuarter4 ?? this.homeScoreQuarter4,
        homeScoreOvertime: homeScoreOvertime ?? this.homeScoreOvertime,
        hasStarted: hasStarted ?? this.hasStarted,
        isInProgress: isInProgress ?? this.isInProgress,
        isOver: isOver ?? this.isOver,
        has1StQuarterStarted: has1StQuarterStarted ?? this.has1StQuarterStarted,
        has2NdQuarterStarted: has2NdQuarterStarted ?? this.has2NdQuarterStarted,
        has3RdQuarterStarted: has3RdQuarterStarted ?? this.has3RdQuarterStarted,
        has4ThQuarterStarted: has4ThQuarterStarted ?? this.has4ThQuarterStarted,
        isOvertime: isOvertime ?? this.isOvertime,
        downAndDistance: downAndDistance ?? this.downAndDistance,
        quarterDescription: quarterDescription ?? this.quarterDescription,
        stadiumId: stadiumId ?? this.stadiumId,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        geoLat: geoLat ?? this.geoLat,
        geoLong: geoLong ?? this.geoLong,
        forecastTempLow: forecastTempLow ?? this.forecastTempLow,
        forecastTempHigh: forecastTempHigh ?? this.forecastTempHigh,
        forecastDescription: forecastDescription ?? this.forecastDescription,
        forecastWindChill: forecastWindChill ?? this.forecastWindChill,
        forecastWindSpeed: forecastWindSpeed ?? this.forecastWindSpeed,
        awayTeamMoneyLine: awayTeamMoneyLine ?? this.awayTeamMoneyLine,
        homeTeamMoneyLine: homeTeamMoneyLine ?? this.homeTeamMoneyLine,
        canceled: canceled ?? this.canceled,
        closed: closed ?? this.closed,
        lastPlay: lastPlay ?? this.lastPlay,
        day: day ?? this.day,
        dateTime: dateTime ?? this.dateTime,
        awayTeamId: awayTeamId ?? this.awayTeamId,
        homeTeamId: homeTeamId ?? this.homeTeamId,
        globalGameId: globalGameId ?? this.globalGameId,
        globalAwayTeamId: globalAwayTeamId ?? this.globalAwayTeamId,
        globalHomeTeamId: globalHomeTeamId ?? this.globalHomeTeamId,
        pointSpreadAwayTeamMoneyLine:
            pointSpreadAwayTeamMoneyLine ?? this.pointSpreadAwayTeamMoneyLine,
        pointSpreadHomeTeamMoneyLine:
            pointSpreadHomeTeamMoneyLine ?? this.pointSpreadHomeTeamMoneyLine,
        scoreId: scoreId ?? this.scoreId,
        status: status ?? this.status,
        gameEndDateTime: gameEndDateTime ?? this.gameEndDateTime,
        homeRotationNumber: homeRotationNumber ?? this.homeRotationNumber,
        awayRotationNumber: awayRotationNumber ?? this.awayRotationNumber,
        neutralVenue: neutralVenue ?? this.neutralVenue,
        refereeId: refereeId ?? this.refereeId,
        overPayout: overPayout ?? this.overPayout,
        underPayout: underPayout ?? this.underPayout,
        stadiumDetails: stadiumDetails ?? this.stadiumDetails,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'GameKey': gameKey,
        'SeasonType': seasonType,
        'Season': season,
        'Week': week,
        'Date': date.toIso8601String(),
        'AwayTeam': awayTeam,
        'HomeTeam': homeTeam,
        'AwayScore': awayScore,
        'HomeScore': homeScore,
        'Channel': channelValues.reverse[channel],
        'PointSpread': pointSpread,
        'OverUnder': overUnder,
        'Quarter': quarter,
        'TimeRemaining': timeRemaining,
        'Possession': possession,
        'Down': down,
        'Distance': distance,
        'YardLine': yardLine,
        'YardLineTerritory': yardLineTerritory,
        'RedZone': redZone,
        'AwayScoreQuarter1': awayScoreQuarter1,
        'AwayScoreQuarter2': awayScoreQuarter2,
        'AwayScoreQuarter3': awayScoreQuarter3,
        'AwayScoreQuarter4': awayScoreQuarter4,
        'AwayScoreOvertime': awayScoreOvertime,
        'HomeScoreQuarter1': homeScoreQuarter1,
        'HomeScoreQuarter2': homeScoreQuarter2,
        'HomeScoreQuarter3': homeScoreQuarter3,
        'HomeScoreQuarter4': homeScoreQuarter4,
        'HomeScoreOvertime': homeScoreOvertime,
        'HasStarted': hasStarted,
        'IsInProgress': isInProgress,
        'IsOver': isOver,
        'Has1stQuarterStarted': has1StQuarterStarted,
        'Has2ndQuarterStarted': has2NdQuarterStarted,
        'Has3rdQuarterStarted': has3RdQuarterStarted,
        'Has4thQuarterStarted': has4ThQuarterStarted,
        'IsOvertime': isOvertime,
        'DownAndDistance': downAndDistance,
        'QuarterDescription': quarterDescription,
        'StadiumID': stadiumId,
        'LastUpdated': lastUpdated.toIso8601String(),
        'GeoLat': geoLat,
        'GeoLong': geoLong,
        'ForecastTempLow': forecastTempLow,
        'ForecastTempHigh': forecastTempHigh,
        'ForecastDescription': forecastDescription,
        'ForecastWindChill': forecastWindChill,
        'ForecastWindSpeed': forecastWindSpeed,
        'AwayTeamMoneyLine': awayTeamMoneyLine,
        'HomeTeamMoneyLine': homeTeamMoneyLine,
        'Canceled': canceled,
        'Closed': closed,
        'LastPlay': lastPlay,
        'Day': day.toIso8601String(),
        'DateTime': dateTime.toIso8601String(),
        'AwayTeamID': awayTeamId,
        'HomeTeamID': homeTeamId,
        'GlobalGameID': globalGameId,
        'GlobalAwayTeamID': globalAwayTeamId,
        'GlobalHomeTeamID': globalHomeTeamId,
        'PointSpreadAwayTeamMoneyLine': pointSpreadAwayTeamMoneyLine,
        'PointSpreadHomeTeamMoneyLine': pointSpreadHomeTeamMoneyLine,
        'ScoreID': scoreId,
        'Status': status,
        'GameEndDateTime': gameEndDateTime,
        'HomeRotationNumber': homeRotationNumber,
        'AwayRotationNumber': awayRotationNumber,
        'NeutralVenue': neutralVenue,
        'RefereeID': refereeId,
        'OverPayout': overPayout,
        'UnderPayout': underPayout,
        'StadiumDetails': stadiumDetails.toMap(),
      };
}

// ignore: constant_identifier_names
enum Channel { FOX, CBS, NBC }

final channelValues =
    EnumValues({'CBS': Channel.CBS, 'FOX': Channel.FOX, 'NBC': Channel.NBC});

class StadiumDetails {
  StadiumDetails({
    this.stadiumId,
    this.name,
    this.city,
    this.state,
    this.country,
    this.capacity,
    this.playingSurface,
    this.geoLat,
    this.geoLong,
    this.type,
  });
  factory StadiumDetails.fromJson(String str) =>
      StadiumDetails.fromMap(json.decode(str));
  factory StadiumDetails.fromMap(Map<String, dynamic> json) => StadiumDetails(
        stadiumId: json['StadiumID'],
        name: json['Name'],
        city: json['City'],
        state: json['State'],
        country: countryValues.map[json['Country']],
        capacity: json['Capacity'],
        playingSurface: playingSurfaceValues.map[json['PlayingSurface']],
        geoLat: json['GeoLat'].toDouble(),
        geoLong: json['GeoLong'].toDouble(),
        type: typeValues.map[json['Type']],
      );

  final int stadiumId;
  final String name;
  final String city;
  final String state;
  final Country country;
  final int capacity;
  final PlayingSurface playingSurface;
  final double geoLat;
  final double geoLong;
  final Type type;

  StadiumDetails copyWith({
    int stadiumId,
    String name,
    String city,
    String state,
    Country country,
    int capacity,
    PlayingSurface playingSurface,
    double geoLat,
    double geoLong,
    Type type,
  }) =>
      StadiumDetails(
        stadiumId: stadiumId ?? this.stadiumId,
        name: name ?? this.name,
        city: city ?? this.city,
        state: state ?? this.state,
        country: country ?? this.country,
        capacity: capacity ?? this.capacity,
        playingSurface: playingSurface ?? this.playingSurface,
        geoLat: geoLat ?? this.geoLat,
        geoLong: geoLong ?? this.geoLong,
        type: type ?? this.type,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'StadiumID': stadiumId,
        'Name': name,
        'City': city,
        'State': state,
        'Country': countryValues.reverse[country],
        'Capacity': capacity,
        'PlayingSurface': playingSurfaceValues.reverse[playingSurface],
        'GeoLat': geoLat,
        'GeoLong': geoLong,
        'Type': typeValues.reverse[type],
      };
}

// ignore: constant_identifier_names
enum Country { USA }

final countryValues = EnumValues({'USA': Country.USA});

// ignore: constant_identifier_names
enum PlayingSurface { ARTIFICIAL, GRASS }

final playingSurfaceValues = EnumValues(
    {'Artificial': PlayingSurface.ARTIFICIAL, 'Grass': PlayingSurface.GRASS});

// ignore: constant_identifier_names
enum Type { RETRACTABLE_DOME, OUTDOOR, DOME }

final typeValues = EnumValues({
  'Dome': Type.DOME,
  'Outdoor': Type.OUTDOOR,
  'RetractableDome': Type.RETRACTABLE_DOME
});

class EnumValues<T> {
  EnumValues(this.map);
  Map<String, T> map;
  Map<T, String> reverseMap;

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
