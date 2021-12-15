import 'dart:convert';

class NcaabPlayer {
  NcaabPlayer({
    this.playerId,
    this.firstName,
    this.lastName,
    this.teamId,
    this.team,
    this.jersey,
    this.position,
    this.ncaabPlayerClass,
    this.height,
    this.weight,
    this.birthCity,
    this.birthState,
    this.highSchool,
    this.sportRadarPlayerId,
    this.rotoworldPlayerId,
    this.rotoWirePlayerId,
    this.fantasyAlarmPlayerId,
    this.globalTeamId,
    this.injuryStatus,
    this.injuryBodyPart,
    this.injuryNotes,
    this.injuryStartDate,
  });
  factory NcaabPlayer.fromJson(String str) =>
      NcaabPlayer.fromMap(json.decode(str) as Map<String, dynamic>);
  factory NcaabPlayer.fromMap(Map<String, dynamic> json) => NcaabPlayer(
        playerId: json['PlayerID'] == null ? null : json['PlayerID'] as int,
        firstName:
            json['FirstName'] == null ? null : json['FirstName'] as String,
        lastName: json['LastName'] == null ? null : json['LastName'] as String,
        teamId: json['TeamID'] == null ? null : json['TeamID'] as int,
        team: json['Team'] == null ? null : json['Team'] as String,
        jersey: json['Jersey'] == null ? null : json['Jersey'] as int,
        position: json['Position'] == null ? null : json['Position'] as String,
        ncaabPlayerClass:
            json['Class'] == null ? null : json['Class'] as String,
        height: json['Height'] == null ? null : json['Height'] as int,
        weight: json['Weight'] == null ? null : json['Weight'] as int,
        birthCity:
            json['BirthCity'] == null ? null : json['BirthCity'] as String,
        birthState:
            json['BirthState'] == null ? null : json['BirthState'] as String,
        highSchool:
            json['HighSchool'] == null ? null : json['HighSchool'] as String,
        sportRadarPlayerId: json['SportRadarPlayerID'] == null
            ? null
            : json['SportRadarPlayerID'] as String,
        rotoworldPlayerId: json['RotoworldPlayerID'],
        rotoWirePlayerId: json['RotoWirePlayerID'],
        fantasyAlarmPlayerId: json['FantasyAlarmPlayerID'],
        globalTeamId:
            json['GlobalTeamID'] == null ? null : json['GlobalTeamID'] as int,
        injuryStatus: json['InjuryStatus'],
        injuryBodyPart: json['InjuryBodyPart'],
        injuryNotes: json['InjuryNotes'],
        injuryStartDate: json['InjuryStartDate'],
      );

  final int? playerId;
  final String? firstName;
  final String? lastName;
  final int? teamId;
  final String? team;
  final int? jersey;
  final String? position;
  final String? ncaabPlayerClass;
  final int? height;
  final int? weight;
  final String? birthCity;
  final String? birthState;
  final String? highSchool;
  final String? sportRadarPlayerId;
  final dynamic rotoworldPlayerId;
  final dynamic rotoWirePlayerId;
  final dynamic fantasyAlarmPlayerId;
  final int? globalTeamId;
  final dynamic injuryStatus;
  final dynamic injuryBodyPart;
  final dynamic injuryNotes;
  final dynamic injuryStartDate;

  NcaabPlayer copyWith({
    int? playerId,
    String? firstName,
    String? lastName,
    int? teamId,
    String? team,
    int? jersey,
    String? position,
    String? ncaabPlayerClass,
    int? height,
    int? weight,
    String? birthCity,
    String? birthState,
    String? highSchool,
    String? sportRadarPlayerId,
    dynamic rotoworldPlayerId,
    dynamic rotoWirePlayerId,
    dynamic fantasyAlarmPlayerId,
    int? globalTeamId,
    dynamic injuryStatus,
    dynamic injuryBodyPart,
    dynamic injuryNotes,
    dynamic injuryStartDate,
  }) =>
      NcaabPlayer(
        playerId: playerId ?? this.playerId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        teamId: teamId ?? this.teamId,
        team: team ?? this.team,
        jersey: jersey ?? this.jersey,
        position: position ?? this.position,
        ncaabPlayerClass: ncaabPlayerClass ?? this.ncaabPlayerClass,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        birthCity: birthCity ?? this.birthCity,
        birthState: birthState ?? this.birthState,
        highSchool: highSchool ?? this.highSchool,
        sportRadarPlayerId: sportRadarPlayerId ?? this.sportRadarPlayerId,
        rotoworldPlayerId: rotoworldPlayerId ?? this.rotoworldPlayerId,
        rotoWirePlayerId: rotoWirePlayerId ?? this.rotoWirePlayerId,
        fantasyAlarmPlayerId: fantasyAlarmPlayerId ?? this.fantasyAlarmPlayerId,
        globalTeamId: globalTeamId ?? this.globalTeamId,
        injuryStatus: injuryStatus ?? this.injuryStatus,
        injuryBodyPart: injuryBodyPart ?? this.injuryBodyPart,
        injuryNotes: injuryNotes ?? this.injuryNotes,
        injuryStartDate: injuryStartDate ?? this.injuryStartDate,
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
        'Class': ncaabPlayerClass,
        'Height': height,
        'Weight': weight,
        'BirthCity': birthCity,
        'BirthState': birthState,
        'HighSchool': highSchool,
        'SportRadarPlayerID': sportRadarPlayerId,
        'RotoworldPlayerID': rotoworldPlayerId,
        'RotoWirePlayerID': rotoWirePlayerId,
        'FantasyAlarmPlayerID': fantasyAlarmPlayerId,
        'GlobalTeamID': globalTeamId,
        'InjuryStatus': injuryStatus,
        'InjuryBodyPart': injuryBodyPart,
        'InjuryNotes': injuryNotes,
        'InjuryStartDate': injuryStartDate,
      };
}
