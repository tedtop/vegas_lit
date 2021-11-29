// To parse this JSON data, do
//
//     final raceResults = raceResultsFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

import 'nascar_race.dart';

class RaceResults {
  RaceResults({
    this.race,
    this.driverRaces,
  });

  RaceResults copyWith({
    Race? race,
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
        race: json['Race'] == null
            ? null
            : Race.fromMap(json['Race'] as Map<String, dynamic>),
        driverRaces: json['DriverRaces'] == null
            ? null
            : List<DriverRace>.from(
                json['DriverRaces'].map(
                  (Map<String, dynamic> x) => DriverRace.fromMap(x),
                ) as Iterable,
              ),
      );

  final Race? race;
  final List<DriverRace?>? driverRaces;

  Map<String, Object?> toMap() => {
        'Race': race == null ? null : race!.toMap(),
        'DriverRaces': driverRaces == null
            ? null
            : List<DriverRace>.from(
                driverRaces!.map((x) => x!.toMap()) as Iterable<DriverRace>),
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
    double? qualifyingSpeed,
    int? poleFinalPosition,
    int? startPosition,
    int? finalPosition,
    int? positionDifferential,
    int? laps,
    int? lapsLed,
    int? fastestLaps,
    int? points,
    int? bonus,
    int? penalty,
    int? wins,
    int? poles,
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

  factory DriverRace.fromJson(String str) => DriverRace.fromMap(
        json.decode(str) as Map<String, dynamic>,
      );

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
        day: json['Day'] == null ? null : DateTime.parse(json['Day'] as String),
        dateTime: json['DateTime'] == null
            ? null
            : DateTime.parse(json['DateTime'] as String),
        updated: json['Updated'] == null
            ? null
            : DateTime.parse(json['Updated'] as String),
        created: json['Created'] == null
            ? null
            : DateTime.parse(json['Created'] as String),
        fantasyPoints: json['FantasyPoints'] as double?,
        fantasyPointsDraftKings: json['FantasyPointsDraftKings'] as double?,
        qualifyingSpeed: json['QualifyingSpeed'] as double?,
        poleFinalPosition: json['PoleFinalPosition'] as int?,
        startPosition: json['StartPosition'] as int?,
        finalPosition: json['FinalPosition'] as int?,
        positionDifferential: json['PositionDifferential'] as int?,
        laps: json['Laps'] as int?,
        lapsLed: json['LapsLed'] as int?,
        fastestLaps: json['FastestLaps'] as int?,
        points: json['Points'] as int?,
        bonus: json['Bonus'] as int?,
        penalty: json['Penalty'] as int?,
        wins: json['Wins'] as int?,
        poles: json['Poles'] as int?,
      );

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
  final double? qualifyingSpeed;
  final int? poleFinalPosition;
  final int? startPosition;
  final int? finalPosition;
  final int? positionDifferential;
  final int? laps;
  final int? lapsLed;
  final int? fastestLaps;
  final int? points;
  final int? bonus;
  final int? penalty;
  final int? wins;
  final int? poles;

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
        'Day': day == null ? null : day!.toIso8601String(),
        'DateTime': dateTime == null ? null : dateTime!.toIso8601String(),
        'Updated': updated == null ? null : updated!.toIso8601String(),
        'Created': created == null ? null : created!.toIso8601String(),
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
