import 'dart:convert';

class NcaafPlayer {
  NcaafPlayer({
    this.playerId,
    this.firstName,
    this.lastName,
    this.teamId,
    this.team,
    this.jersey,
    this.position,
    this.positionCategory,
    this.ncaafPlayerClass,
    this.height,
    this.weight,
    this.birthCity,
    this.birthState,
    this.updated,
    this.created,
    this.globalTeamId,
    this.injuryStatus,
    this.injuryBodyPart,
    this.injuryStartDate,
    this.injuryNotes,
  });
  factory NcaafPlayer.fromJson(String str) =>
      NcaafPlayer.fromMap(json.decode(str) as Map<String, dynamic>);

  factory NcaafPlayer.fromMap(Map<String, dynamic> json) => NcaafPlayer(
        playerId: json['PlayerID'] == null ? null : json['PlayerID'] as int,
        firstName:
            json['FirstName'] == null ? null : json['FirstName'] as String,
        lastName: json['LastName'] == null ? null : json['LastName'] as String,
        teamId: json['TeamID'] == null ? null : json['TeamID'] as int,
        team: json['Team'] == null ? null : json['Team'] as String,
        jersey: json['Jersey'] == null ? null : json['Jersey'] as int,
        position: json['Position'] == null ? null : json['Position'] as String,
        positionCategory: json['PositionCategory'] == null
            ? null
            : json['PositionCategory'] as String,
        ncaafPlayerClass:
            json['Class'] == null ? null : json['Class'] as String,
        height: json['Height'] == null ? null : json['Height'] as int,
        weight: json['Weight'] == null ? null : json['Weight'] as int,
        birthCity:
            json['BirthCity'] == null ? null : json['BirthCity'] as String,
        birthState:
            json['BirthState'] == null ? null : json['BirthState'] as String,
        updated: json['Updated'] == null
            ? null
            : DateTime.parse(json['Updated'] as String),
        created: json['Created'] == null
            ? null
            : DateTime.parse(json['Created'] as String),
        globalTeamId:
            json['GlobalTeamID'] == null ? null : json['GlobalTeamID'] as int,
        injuryStatus: json['InjuryStatus'],
        injuryBodyPart: json['InjuryBodyPart'],
        injuryStartDate: json['InjuryStartDate'],
        injuryNotes: json['InjuryNotes'],
      );

  final int? playerId;
  final String? firstName;
  final String? lastName;
  final int? teamId;
  final String? team;
  final int? jersey;
  final String? position;
  final String? positionCategory;
  final String? ncaafPlayerClass;
  final int? height;
  final int? weight;
  final String? birthCity;
  final String? birthState;
  final DateTime? updated;
  final DateTime? created;
  final int? globalTeamId;
  final dynamic injuryStatus;
  final dynamic injuryBodyPart;
  final dynamic injuryStartDate;
  final dynamic injuryNotes;

  NcaafPlayer copyWith({
    int? playerId,
    String? firstName,
    String? lastName,
    int? teamId,
    String? team,
    int? jersey,
    String? position,
    String? positionCategory,
    String? ncaafPlayerClass,
    int? height,
    int? weight,
    String? birthCity,
    String? birthState,
    DateTime? updated,
    DateTime? created,
    int? globalTeamId,
    dynamic injuryStatus,
    dynamic injuryBodyPart,
    dynamic injuryStartDate,
    dynamic injuryNotes,
  }) =>
      NcaafPlayer(
        playerId: playerId ?? this.playerId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        teamId: teamId ?? this.teamId,
        team: team ?? this.team,
        jersey: jersey ?? this.jersey,
        position: position ?? this.position,
        positionCategory: positionCategory ?? this.positionCategory,
        ncaafPlayerClass: ncaafPlayerClass ?? this.ncaafPlayerClass,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        birthCity: birthCity ?? this.birthCity,
        birthState: birthState ?? this.birthState,
        updated: updated ?? this.updated,
        created: created ?? this.created,
        globalTeamId: globalTeamId ?? this.globalTeamId,
        injuryStatus: injuryStatus ?? this.injuryStatus,
        injuryBodyPart: injuryBodyPart ?? this.injuryBodyPart,
        injuryStartDate: injuryStartDate ?? this.injuryStartDate,
        injuryNotes: injuryNotes ?? this.injuryNotes,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        'PlayerID': playerId,
        'FirstName': firstName,
        'LastName': lastName,
        'TeamID': teamId,
        'Team': team,
        'Jersey': jersey,
        'Position': position,
        'PositionCategory': positionCategory,
        'Class': ncaafPlayerClass,
        'Height': height,
        'Weight': weight,
        'BirthCity': birthCity,
        'BirthState': birthState,
        'Updated': updated?.toIso8601String(),
        'Created': created?.toIso8601String(),
        'GlobalTeamID': globalTeamId,
        'InjuryStatus': injuryStatus,
        'InjuryBodyPart': injuryBodyPart,
        'InjuryStartDate': injuryStartDate,
        'InjuryNotes': injuryNotes,
      };
}
