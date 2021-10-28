

import 'dart:convert';

class NbaPlayer {
  NbaPlayer({
    this.playerId,
    this.sportsDataId,
    this.status,
    this.teamId,
    this.team,
    this.jersey,
    this.positionCategory,
    this.position,
    this.firstName,
    this.lastName,
    this.height,
    this.weight,
    this.birthDate,
    this.birthCity,
    this.birthState,
    this.birthCountry,
    this.highSchool,
    this.college,
    this.salary,
    this.photoUrl,
    this.experience,
    this.sportRadarPlayerId,
    this.rotoworldPlayerId,
    this.rotoWirePlayerId,
    this.fantasyAlarmPlayerId,
    this.statsPlayerId,
    this.sportsDirectPlayerId,
    this.xmlTeamPlayerId,
    this.injuryStatus,
    this.injuryBodyPart,
    this.injuryStartDate,
    this.injuryNotes,
    this.fanDuelPlayerId,
    this.draftKingsPlayerId,
    this.yahooPlayerId,
    this.fanDuelName,
    this.draftKingsName,
    this.yahooName,
    this.depthChartPosition,
    this.depthChartOrder,
    this.globalTeamId,
    this.fantasyDraftName,
    this.fantasyDraftPlayerId,
    this.usaTodayPlayerId,
    this.usaTodayHeadshotUrl,
    this.usaTodayHeadshotNoBackgroundUrl,
    this.usaTodayHeadshotUpdated,
    this.usaTodayHeadshotNoBackgroundUpdated,
    this.nbaDotComPlayerId,
  });
  factory NbaPlayer.fromJson(String str) =>
      NbaPlayer.fromMap(json.decode(str) as Map<String, dynamic>);

  factory NbaPlayer.fromMap(Map<String, dynamic> json) => NbaPlayer(
        playerId: json['PlayerID'] as int?,
        sportsDataId: json['SportsDataID'] as String?,
        status:
            json['Status'] == null ? null : statusValues.map[json['Status']],
        teamId: json['TeamID'] as int?,
        team: json['Team'] == null ? null : teamValues.map[json['Team']],
        jersey: json['Jersey'] as int?,
        positionCategory: json['PositionCategory'] == null
            ? null
            : positionCategoryValues.map[json['PositionCategory']],
        position: json['Position'] as String?,
        firstName: json['FirstName'] as String?,
        lastName: json['LastName'] as String?,
        height: json['Height'] as int?,
        weight: json['Weight'] as int?,
        birthDate: json['BirthDate'] == null
            ? null
            : DateTime.parse(json['BirthDate'] as String),
        birthCity: json['BirthCity'] as String?,
        birthState: json['BirthState'] as String?,
        birthCountry: json['BirthCountry'] == null
            ? null
            : birthCountryValues.map[json['BirthCountry']],
        highSchool: json['HighSchool'] as String?,
        college: json['College'] as String?,
        salary: json['Salary'] as int?,
        photoUrl: json['PhotoUrl'] as String?,
        experience: json['Experience'] as int?,
        sportRadarPlayerId: json['SportRadarPlayerID'] as String?,
        rotoworldPlayerId: json['RotoworldPlayerID'] as int?,
        rotoWirePlayerId: json['RotoWirePlayerID'] as int?,
        fantasyAlarmPlayerId: json['FantasyAlarmPlayerID'] as int?,
        statsPlayerId: json['StatsPlayerID'] as int?,
        sportsDirectPlayerId: json['SportsDirectPlayerID'] as int?,
        xmlTeamPlayerId: json['XmlTeamPlayerID'] as int?,
        injuryStatus: json['InjuryStatus'] as String?,
        injuryBodyPart: json['InjuryBodyPart'] as String?,
        injuryStartDate: json['InjuryStartDate'],
        injuryNotes: json['InjuryNotes'] as String?,
        fanDuelPlayerId: json['FanDuelPlayerID'] as int?,
        draftKingsPlayerId: json['DraftKingsPlayerID'] as int?,
        yahooPlayerId: json['YahooPlayerID'] as int?,
        fanDuelName: json['FanDuelName'] as String?,
        draftKingsName: json['DraftKingsName'] as String?,
        yahooName: json['YahooName'] as String?,
        depthChartPosition: json['DepthChartPosition'] as String?,
        depthChartOrder: json['DepthChartOrder'] as int?,
        globalTeamId: json['GlobalTeamID'] as int?,
        fantasyDraftName: json['FantasyDraftName'] as String?,
        fantasyDraftPlayerId: json['FantasyDraftPlayerID'] as int?,
        usaTodayPlayerId: json['UsaTodayPlayerID'] as int?,
        usaTodayHeadshotUrl: json['UsaTodayHeadshotUrl'] as String?,
        usaTodayHeadshotNoBackgroundUrl:
            json['UsaTodayHeadshotNoBackgroundUrl'] as String?,
        usaTodayHeadshotUpdated: json['UsaTodayHeadshotUpdated'] == null
            ? null
            : DateTime.parse(json['UsaTodayHeadshotUpdated'] as String),
        usaTodayHeadshotNoBackgroundUpdated:
            json['UsaTodayHeadshotNoBackgroundUpdated'] == null
                ? null
                : DateTime.parse(
                    json['UsaTodayHeadshotNoBackgroundUpdated'] as String),
        nbaDotComPlayerId: json['NbaDotComPlayerID'] as int?,
      );

  final int? playerId;
  final String? sportsDataId;
  final Status? status;
  final int? teamId;
  final Team? team;
  final int? jersey;
  final PositionCategory? positionCategory;
  final String? position;
  final String? firstName;
  final String? lastName;
  final int? height;
  final int? weight;
  final DateTime? birthDate;
  final String? birthCity;
  final String? birthState;
  final BirthCountry? birthCountry;
  final String? highSchool;
  final String? college;
  final int? salary;
  final String? photoUrl;
  final int? experience;
  final String? sportRadarPlayerId;
  final int? rotoworldPlayerId;
  final int? rotoWirePlayerId;
  final int? fantasyAlarmPlayerId;
  final int? statsPlayerId;
  final int? sportsDirectPlayerId;
  final int? xmlTeamPlayerId;
  final dynamic injuryStatus;
  final dynamic injuryBodyPart;
  final dynamic injuryStartDate;
  final dynamic injuryNotes;
  final int? fanDuelPlayerId;
  final int? draftKingsPlayerId;
  final int? yahooPlayerId;
  final String? fanDuelName;
  final String? draftKingsName;
  final String? yahooName;
  final String? depthChartPosition;
  final int? depthChartOrder;
  final int? globalTeamId;
  final String? fantasyDraftName;
  final int? fantasyDraftPlayerId;
  final int? usaTodayPlayerId;
  final String? usaTodayHeadshotUrl;
  final String? usaTodayHeadshotNoBackgroundUrl;
  final DateTime? usaTodayHeadshotUpdated;
  final DateTime? usaTodayHeadshotNoBackgroundUpdated;
  final int? nbaDotComPlayerId;

  NbaPlayer copyWith({
    int? playerId,
    String? sportsDataId,
    Status? status,
    int? teamId,
    Team? team,
    int? jersey,
    PositionCategory? positionCategory,
    String? position,
    String? firstName,
    String? lastName,
    int? height,
    int? weight,
    DateTime? birthDate,
    String? birthCity,
    String? birthState,
    BirthCountry? birthCountry,
    String? highSchool,
    String? college,
    int? salary,
    String? photoUrl,
    int? experience,
    String? sportRadarPlayerId,
    int? rotoworldPlayerId,
    int? rotoWirePlayerId,
    int? fantasyAlarmPlayerId,
    int? statsPlayerId,
    int? sportsDirectPlayerId,
    int? xmlTeamPlayerId,
    dynamic injuryStatus,
    dynamic injuryBodyPart,
    dynamic injuryStartDate,
    dynamic injuryNotes,
    int? fanDuelPlayerId,
    int? draftKingsPlayerId,
    int? yahooPlayerId,
    String? fanDuelName,
    String? draftKingsName,
    String? yahooName,
    String? depthChartPosition,
    int? depthChartOrder,
    int? globalTeamId,
    String? fantasyDraftName,
    int? fantasyDraftPlayerId,
    int? usaTodayPlayerId,
    String? usaTodayHeadshotUrl,
    String? usaTodayHeadshotNoBackgroundUrl,
    DateTime? usaTodayHeadshotUpdated,
    DateTime? usaTodayHeadshotNoBackgroundUpdated,
    int? nbaDotComPlayerId,
  }) =>
      NbaPlayer(
        playerId: playerId ?? this.playerId,
        sportsDataId: sportsDataId ?? this.sportsDataId,
        status: status ?? this.status,
        teamId: teamId ?? this.teamId,
        team: team ?? this.team,
        jersey: jersey ?? this.jersey,
        positionCategory: positionCategory ?? this.positionCategory,
        position: position ?? this.position,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        birthDate: birthDate ?? this.birthDate,
        birthCity: birthCity ?? this.birthCity,
        birthState: birthState ?? this.birthState,
        birthCountry: birthCountry ?? this.birthCountry,
        highSchool: highSchool ?? this.highSchool,
        college: college ?? this.college,
        salary: salary ?? this.salary,
        photoUrl: photoUrl ?? this.photoUrl,
        experience: experience ?? this.experience,
        sportRadarPlayerId: sportRadarPlayerId ?? this.sportRadarPlayerId,
        rotoworldPlayerId: rotoworldPlayerId ?? this.rotoworldPlayerId,
        rotoWirePlayerId: rotoWirePlayerId ?? this.rotoWirePlayerId,
        fantasyAlarmPlayerId: fantasyAlarmPlayerId ?? this.fantasyAlarmPlayerId,
        statsPlayerId: statsPlayerId ?? this.statsPlayerId,
        sportsDirectPlayerId: sportsDirectPlayerId ?? this.sportsDirectPlayerId,
        xmlTeamPlayerId: xmlTeamPlayerId ?? this.xmlTeamPlayerId,
        injuryStatus: injuryStatus ?? this.injuryStatus,
        injuryBodyPart: injuryBodyPart ?? this.injuryBodyPart,
        injuryStartDate: injuryStartDate ?? this.injuryStartDate,
        injuryNotes: injuryNotes ?? this.injuryNotes,
        fanDuelPlayerId: fanDuelPlayerId ?? this.fanDuelPlayerId,
        draftKingsPlayerId: draftKingsPlayerId ?? this.draftKingsPlayerId,
        yahooPlayerId: yahooPlayerId ?? this.yahooPlayerId,
        fanDuelName: fanDuelName ?? this.fanDuelName,
        draftKingsName: draftKingsName ?? this.draftKingsName,
        yahooName: yahooName ?? this.yahooName,
        depthChartPosition: depthChartPosition ?? this.depthChartPosition,
        depthChartOrder: depthChartOrder ?? this.depthChartOrder,
        globalTeamId: globalTeamId ?? this.globalTeamId,
        fantasyDraftName: fantasyDraftName ?? this.fantasyDraftName,
        fantasyDraftPlayerId: fantasyDraftPlayerId ?? this.fantasyDraftPlayerId,
        usaTodayPlayerId: usaTodayPlayerId ?? this.usaTodayPlayerId,
        usaTodayHeadshotUrl: usaTodayHeadshotUrl ?? this.usaTodayHeadshotUrl,
        usaTodayHeadshotNoBackgroundUrl: usaTodayHeadshotNoBackgroundUrl ??
            this.usaTodayHeadshotNoBackgroundUrl,
        usaTodayHeadshotUpdated:
            usaTodayHeadshotUpdated ?? this.usaTodayHeadshotUpdated,
        usaTodayHeadshotNoBackgroundUpdated:
            usaTodayHeadshotNoBackgroundUpdated ??
                this.usaTodayHeadshotNoBackgroundUpdated,
        nbaDotComPlayerId: nbaDotComPlayerId ?? this.nbaDotComPlayerId,
      );

  String toJson() => json.encode(toMap());
  Map<String, Object?> toMap() => {
        'PlayerID': playerId,
        'SportsDataID': sportsDataId,
        'Status': status == null ? null : statusValues.reverse![status!],
        'TeamID': teamId,
        'Team': team == null ? null : teamValues.reverse![team!],
        'Jersey': jersey,
        'PositionCategory': positionCategory == null
            ? null
            : positionCategoryValues.reverse![positionCategory!],
        'Position': position,
        'FirstName': firstName,
        'LastName': lastName,
        'Height': height,
        'Weight': weight,
        'BirthDate': birthDate?.toIso8601String(),
        'BirthCity': birthCity,
        'BirthState': birthState,
        'BirthCountry': birthCountry == null
            ? null
            : birthCountryValues.reverse![birthCountry!],
        'HighSchool': highSchool,
        'College': college,
        'Salary': salary,
        'PhotoUrl': photoUrl,
        'Experience': experience,
        'SportRadarPlayerID': sportRadarPlayerId,
        'RotoworldPlayerID': rotoworldPlayerId,
        'RotoWirePlayerID': rotoWirePlayerId,
        'FantasyAlarmPlayerID': fantasyAlarmPlayerId,
        'StatsPlayerID': statsPlayerId,
        'SportsDirectPlayerID': sportsDirectPlayerId,
        'XmlTeamPlayerID': xmlTeamPlayerId,
        'InjuryStatus': injuryStatus,
        'InjuryBodyPart': injuryBodyPart,
        'InjuryStartDate': injuryStartDate,
        'InjuryNotes': injuryNotes,
        'FanDuelPlayerID': fanDuelPlayerId,
        'DraftKingsPlayerID': draftKingsPlayerId,
        'YahooPlayerID': yahooPlayerId,
        'FanDuelName': fanDuelName,
        'DraftKingsName': draftKingsName,
        'YahooName': yahooName,
        'DepthChartPosition': depthChartPosition,
        'DepthChartOrder': depthChartOrder,
        'GlobalTeamID': globalTeamId,
        'FantasyDraftName': fantasyDraftName,
        'FantasyDraftPlayerID': fantasyDraftPlayerId,
        'UsaTodayPlayerID': usaTodayPlayerId,
        'UsaTodayHeadshotUrl': usaTodayHeadshotUrl,
        'UsaTodayHeadshotNoBackgroundUrl': usaTodayHeadshotNoBackgroundUrl,
        'UsaTodayHeadshotUpdated': usaTodayHeadshotUpdated?.toIso8601String(),
        'UsaTodayHeadshotNoBackgroundUpdated':
            usaTodayHeadshotNoBackgroundUpdated?.toIso8601String(),
        'NbaDotComPlayerID': nbaDotComPlayerId,
      };
}

enum BirthCountry { usa, germany, lithuania }

final birthCountryValues = EnumValues({
  'Germany': BirthCountry.germany,
  'Lithuania': BirthCountry.lithuania,
  'USA': BirthCountry.usa
});

enum PositionCategory { F, G, C }

final positionCategoryValues = EnumValues({
  'C': PositionCategory.C,
  'F': PositionCategory.F,
  'G': PositionCategory.G
});

enum Status { active }

final statusValues = EnumValues({'Active': Status.active});

enum Team { orl }

final teamValues = EnumValues({'ORL': Team.orl});

class EnumValues<T> {
  EnumValues(this.map);

  Map<String, T> map;
  Map<T, String>? reverseMap;

  Map<T, String>? get reverse {
    // ignore: join_return_with_assignment
    // ignore: join_return_with_assignment
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
