// To parse this JSON data, do
//
//     final raceResults = raceResultsFromMap(jsonString);

import 'dart:convert';

class RaceResults {
  RaceResults({
    this.race,
    this.driverRaces,
  });

  final RaceList? race;
  final List<DriverRace>? driverRaces;

  RaceResults copyWith({
    RaceList? race,
    List<DriverRace>? driverRaces,
  }) =>
      RaceResults(
        race: race ?? this.race,
        driverRaces: driverRaces ?? this.driverRaces,
      );

  factory RaceResults.fromJson(String str) =>
      RaceResults.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory RaceResults.fromMap(Map<String, dynamic> json) => RaceResults(
        race: RaceList.fromMap(json['Race'] as Map<String, dynamic>),
        driverRaces: List<DriverRace>.from(
          // ignore: unnecessary_cast
          (json['DriverRaces'] as List).map(
                  (dynamic x) => DriverRace.fromMap(x as Map<String, dynamic>))
              as Iterable<dynamic>,
        ),
      );

  Map<String, Object> toMap() => {
        'Race': race!.toMap(),
        'DriverRaces': List<dynamic>.from(
          driverRaces!.map(
            (x) => x.toMap(),
          ) as Iterable<dynamic>,
        ),
      };
}

class DriverRace {
  DriverRace({
    this.statId,
    this.driverId,
    this.season,
    this.name,
    this.number,
    this.numberDisplay,
    this.manufacturer,
    this.draftKingsSalary,
    this.raceId,
    this.day,
    this.dateTime,
    this.updated,
    this.created,
    this.fantasyPoints,
    this.fantasyPointsDraftKings,
    this.qualifyingSpeed,
    this.poleFinalPosition,
    this.startPosition,
    this.finalPosition,
    this.positionDifferential,
    this.laps,
    this.lapsLed,
    this.fastestLaps,
    this.points,
    this.bonus,
    this.penalty,
    this.wins,
    this.poles,
  });

  final int? statId;
  final int? driverId;
  final int? season;
  final String? name;
  final int? number;
  final String? numberDisplay;
  final String? manufacturer;
  final int? draftKingsSalary;
  final int? raceId;
  final DateTime? day;
  final DateTime? dateTime;
  final DateTime? updated;
  final DateTime? created;
  final double? fantasyPoints;
  final double? fantasyPointsDraftKings;
  final dynamic qualifyingSpeed;
  final double? poleFinalPosition;
  final double? startPosition;
  final double? finalPosition;
  final double? positionDifferential;
  final double? laps;
  final double? lapsLed;
  final double? fastestLaps;
  final double? points;
  final double? bonus;
  final double? penalty;
  final double? wins;
  final double? poles;

  DriverRace copyWith({
    int? statId,
    int? driverId,
    int? season,
    String? name,
    int? number,
    String? numberDisplay,
    String? manufacturer,
    int? draftKingsSalary,
    int? raceId,
    DateTime? day,
    DateTime? dateTime,
    DateTime? updated,
    DateTime? created,
    double? fantasyPoints,
    double? fantasyPointsDraftKings,
    dynamic qualifyingSpeed,
    double? poleFinalPosition,
    double? startPosition,
    double? finalPosition,
    double? positionDifferential,
    double? laps,
    double? lapsLed,
    double? fastestLaps,
    double? points,
    double? bonus,
    double? penalty,
    double? wins,
    double? poles,
  }) =>
      DriverRace(
        statId: statId ?? this.statId,
        driverId: driverId ?? this.driverId,
        season: season ?? this.season,
        name: name ?? this.name,
        number: number ?? this.number,
        numberDisplay: numberDisplay ?? this.numberDisplay,
        manufacturer: manufacturer ?? this.manufacturer,
        draftKingsSalary: draftKingsSalary ?? this.draftKingsSalary,
        raceId: raceId ?? this.raceId,
        day: day ?? this.day,
        dateTime: dateTime ?? this.dateTime,
        updated: updated ?? this.updated,
        created: created ?? this.created,
        fantasyPoints: fantasyPoints ?? this.fantasyPoints,
        fantasyPointsDraftKings:
            fantasyPointsDraftKings ?? this.fantasyPointsDraftKings,
        qualifyingSpeed: qualifyingSpeed ?? this.qualifyingSpeed,
        poleFinalPosition: poleFinalPosition ?? this.poleFinalPosition,
        startPosition: startPosition ?? this.startPosition,
        finalPosition: finalPosition ?? this.finalPosition,
        positionDifferential: positionDifferential ?? this.positionDifferential,
        laps: laps ?? this.laps,
        lapsLed: lapsLed ?? this.lapsLed,
        fastestLaps: fastestLaps ?? this.fastestLaps,
        points: points ?? this.points,
        bonus: bonus ?? this.bonus,
        penalty: penalty ?? this.penalty,
        wins: wins ?? this.wins,
        poles: poles ?? this.poles,
      );

  factory DriverRace.fromJson(String str) =>
      DriverRace.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory DriverRace.fromMap(Map<String, dynamic> json) => DriverRace(
        statId: json['StatID'] as int?,
        driverId: json['DriverID'] as int?,
        season: json['Season'] as int?,
        name: json['Name'] as String?,
        number: json['Number'] as int?,
        numberDisplay: json['NumberDisplay'] as String?,
        manufacturer: json['Manufacturer'] as String?,
        draftKingsSalary: json['DraftKingsSalary'] as int?,
        raceId: json['RaceID'] as int?,
        day: DateTime.parse(json['Day'] as String),
        dateTime: DateTime.parse(json['DateTime'] as String),
        updated: DateTime.parse(json['Updated'] as String),
        created: DateTime.parse(json['Created'] as String),
        fantasyPoints: json['FantasyPoints'] as double?,
        fantasyPointsDraftKings: json['FantasyPointsDraftKings'] as double?,
        qualifyingSpeed: json['QualifyingSpeed'],
        poleFinalPosition: json['PoleFinalPosition'] as double?,
        startPosition: json['StartPosition'] as double?,
        finalPosition: json['FinalPosition'] as double?,
        positionDifferential: json['PositionDifferential'] as double?,
        laps: json['Laps'] as double?,
        lapsLed: json['LapsLed'] as double?,
        fastestLaps: json['FastestLaps'] as double?,
        points: json['Points'] as double?,
        bonus: json['Bonus'] as double?,
        penalty: json['Penalty'] as double?,
        wins: json['Wins'] as double?,
        poles: json['Poles'] as double?,
      );

  Map<String, Object?> toMap() => {
        'StatID': statId,
        'DriverID': driverId,
        'Season': season,
        'Name': name,
        'Number': number,
        'NumberDisplay': numberDisplay,
        'Manufacturer': manufacturer,
        'DraftKingsSalary': draftKingsSalary,
        'RaceID': raceId,
        'Day': day!.toIso8601String(),
        'DateTime': dateTime!.toIso8601String(),
        'Updated': updated!.toIso8601String(),
        'Created': created!.toIso8601String(),
        'FantasyPoints': fantasyPoints,
        'FantasyPointsDraftKings': fantasyPointsDraftKings,
        'QualifyingSpeed': qualifyingSpeed,
        'PoleFinalPosition': poleFinalPosition,
        'StartPosition': startPosition,
        'FinalPosition': finalPosition,
        'PositionDifferential': positionDifferential,
        'Laps': laps,
        'LapsLed': lapsLed,
        'FastestLaps': fastestLaps,
        'Points': points,
        'Bonus': bonus,
        'Penalty': penalty,
        'Wins': wins,
        'Poles': poles,
      };
}

class RaceList {
  RaceList({
    this.raceId,
    this.seriesId,
    this.seriesName,
    this.season,
    this.name,
    this.day,
    this.dateTime,
    this.track,
    this.broadcast,
    this.winnerId,
    this.poleWinnerId,
    this.isInProgress,
    this.isOver,
    this.updated,
    this.created,
    this.rescheduledDay,
    this.rescheduledDateTime,
    this.canceled,
  });

  final int? raceId;
  final int? seriesId;
  final String? seriesName;
  final int? season;
  final String? name;
  final DateTime? day;
  final DateTime? dateTime;
  final String? track;
  final String? broadcast;
  final int? winnerId;
  final int? poleWinnerId;
  final bool? isInProgress;
  final bool? isOver;
  final DateTime? updated;
  final DateTime? created;
  final dynamic rescheduledDay;
  final dynamic rescheduledDateTime;
  final bool? canceled;

  RaceList copyWith({
    int? raceId,
    int? seriesId,
    String? seriesName,
    int? season,
    String? name,
    DateTime? day,
    DateTime? dateTime,
    String? track,
    String? broadcast,
    int? winnerId,
    int? poleWinnerId,
    bool? isInProgress,
    bool? isOver,
    DateTime? updated,
    DateTime? created,
    dynamic rescheduledDay,
    dynamic rescheduledDateTime,
    bool? canceled,
  }) =>
      RaceList(
        raceId: raceId ?? this.raceId,
        seriesId: seriesId ?? this.seriesId,
        seriesName: seriesName ?? this.seriesName,
        season: season ?? this.season,
        name: name ?? this.name,
        day: day ?? this.day,
        dateTime: dateTime ?? this.dateTime,
        track: track ?? this.track,
        broadcast: broadcast ?? this.broadcast,
        winnerId: winnerId ?? this.winnerId,
        poleWinnerId: poleWinnerId ?? this.poleWinnerId,
        isInProgress: isInProgress ?? this.isInProgress,
        isOver: isOver ?? this.isOver,
        updated: updated ?? this.updated,
        created: created ?? this.created,
        rescheduledDay: rescheduledDay ?? this.rescheduledDay,
        rescheduledDateTime: rescheduledDateTime ?? this.rescheduledDateTime,
        canceled: canceled ?? this.canceled,
      );

  factory RaceList.fromJson(String str) =>
      RaceList.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory RaceList.fromMap(Map<String, dynamic> json) => RaceList(
        raceId: json['RaceID'] as int?,
        seriesId: json['SeriesID'] as int?,
        seriesName: json['SeriesName'] as String?,
        season: json['Season'] as int?,
        name: json['Name'] as String?,
        day: DateTime.parse(json['Day'] as String),
        dateTime: DateTime.parse(json['DateTime'] as String),
        track: json['Track'] as String?,
        broadcast: json['Broadcast'] as String?,
        winnerId: json['WinnerID'] as int?,
        poleWinnerId: json['PoleWinnerID'] as int?,
        isInProgress: json['IsInProgress'] as bool?,
        isOver: json['IsOver'] as bool?,
        updated: DateTime.parse(json['Updated'] as String),
        created: DateTime.parse(json['Created'] as String),
        rescheduledDay: json['RescheduledDay'],
        rescheduledDateTime: json['RescheduledDateTime'],
        canceled: json['Canceled'] as bool?,
      );

  Map<String, Object?> toMap() => {
        'RaceID': raceId,
        'SeriesID': seriesId,
        'SeriesName': seriesName,
        'Season': season,
        'Name': name,
        'Day': day!.toIso8601String(),
        'DateTime': dateTime!.toIso8601String(),
        'Track': track,
        'Broadcast': broadcast,
        'WinnerID': winnerId,
        'PoleWinnerID': poleWinnerId,
        'IsInProgress': isInProgress,
        'IsOver': isOver,
        'Updated': updated!.toIso8601String(),
        'Created': created!.toIso8601String(),
        'RescheduledDay': rescheduledDay,
        'RescheduledDateTime': rescheduledDateTime,
        'Canceled': canceled,
      };
}
