// To parse this JSON data, do
//
//     final race = raceFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

class Race {
  Race({
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

  Race copyWith({
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
    DateTime? rescheduledDay,
    DateTime? rescheduledDateTime,
    bool? canceled,
  }) =>
      Race(
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

  factory Race.fromJson(String str) =>
      Race.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory Race.fromMap(Map<String, dynamic> json) => Race(
        raceId: json['RaceID'] as int?,
        seriesId: json['SeriesID'] as int?,
        seriesName: json['SeriesName'] as String?,
        season: json['Season'] as int?,
        name: json['Name'] as String?,
        day: json['Day'] == null ? null : DateTime.parse(json['Day'] as String),
        dateTime: json['DateTime'] == null
            ? null
            : DateTime.parse(json['DateTime'] as String),
        track: json['Track'] as String?,
        broadcast: json['Broadcast'] as String?,
        winnerId: json['WinnerID'] as int?,
        poleWinnerId: json['PoleWinnerID'] as int?,
        isInProgress: json['IsInProgress'] as bool?,
        isOver: json['IsOver'] as bool?,
        updated: json['Updated'] == null
            ? null
            : DateTime.parse(json['Updated'] as String),
        created: json['Created'] == null
            ? null
            : DateTime.parse(json['Created'] as String),
        rescheduledDay: json['RescheduledDay'] == null
            ? null
            : DateTime.parse(json['RescheduledDay'] as String),
        rescheduledDateTime: json['RescheduledDateTime'] == null
            ? null
            : DateTime.parse(
                json['RescheduledDateTime'] as String,
              ),
        canceled: json['Canceled'] as bool?,
      );

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
  final DateTime? rescheduledDay;
  final DateTime? rescheduledDateTime;
  final bool? canceled;

  Map<String, Object?> toMap() => {
        'RaceID': raceId,
        'SeriesID': seriesId,
        'SeriesName': seriesName,
        'Season': season,
        'Name': name,
        'Day': day == null ? null : day!.toIso8601String(),
        'DateTime': dateTime == null ? null : dateTime!.toIso8601String(),
        'Track': track,
        'Broadcast': broadcast,
        'WinnerID': winnerId,
        'PoleWinnerID': poleWinnerId,
        'IsInProgress': isInProgress,
        'IsOver': isOver,
        'Updated': updated == null ? null : updated!.toIso8601String(),
        'Created': created == null ? null : created!.toIso8601String(),
        'RescheduledDay':
            rescheduledDay == null ? null : rescheduledDay!.toIso8601String(),
        'RescheduledDateTime': rescheduledDateTime,
        'Canceled': canceled,
      };
}
