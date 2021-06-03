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
  factory NbaPlayer.fromJson(String str) => NbaPlayer.fromMap(json.decode(str));

  factory NbaPlayer.fromMap(Map<String, dynamic> json) => NbaPlayer(
        playerId: json['PlayerID'] ?? null,
        sportsDataId: json['SportsDataID'] ?? null,
        status:
            json['Status'] == null ? null : statusValues.map[json['Status']],
        teamId: json['TeamID'] ?? null,
        team: json['Team'] == null ? null : teamValues.map[json['Team']],
        jersey: json['Jersey'] ?? null,
        positionCategory: json['PositionCategory'] == null
            ? null
            : positionCategoryValues.map[json['PositionCategory']],
        position: json['Position'] ?? null,
        firstName: json['FirstName'] ?? null,
        lastName: json['LastName'] ?? null,
        height: json['Height'] ?? null,
        weight: json['Weight'] ?? null,
        birthDate: json['BirthDate'] == null
            ? null
            : DateTime.parse(json['BirthDate']),
        birthCity: json['BirthCity'] ?? null,
        birthState: json['BirthState'] ?? null,
        birthCountry: json['BirthCountry'] == null
            ? null
            : birthCountryValues.map[json['BirthCountry']],
        highSchool: json['HighSchool'] ?? null,
        college: json['College'] ?? null,
        salary: json['Salary'] ?? null,
        photoUrl: json['PhotoUrl'] ?? null,
        experience: json['Experience'] ?? null,
        sportRadarPlayerId: json['SportRadarPlayerID'] ?? null,
        rotoworldPlayerId: json['RotoworldPlayerID'] ?? null,
        rotoWirePlayerId: json['RotoWirePlayerID'] ?? null,
        fantasyAlarmPlayerId: json['FantasyAlarmPlayerID'] ?? null,
        statsPlayerId: json['StatsPlayerID'] ?? null,
        sportsDirectPlayerId: json['SportsDirectPlayerID'] ?? null,
        xmlTeamPlayerId: json['XmlTeamPlayerID'] ?? null,
        injuryStatus: json['InjuryStatus'],
        injuryBodyPart: json['InjuryBodyPart'],
        injuryStartDate: json['InjuryStartDate'],
        injuryNotes: json['InjuryNotes'],
        fanDuelPlayerId: json['FanDuelPlayerID'] ?? null,
        draftKingsPlayerId: json['DraftKingsPlayerID'] ?? null,
        yahooPlayerId: json['YahooPlayerID'] ?? null,
        fanDuelName: json['FanDuelName'] ?? null,
        draftKingsName: json['DraftKingsName'] ?? null,
        yahooName: json['YahooName'] ?? null,
        depthChartPosition: json['DepthChartPosition'] ?? null,
        depthChartOrder: json['DepthChartOrder'] ?? null,
        globalTeamId: json['GlobalTeamID'] ?? null,
        fantasyDraftName: json['FantasyDraftName'] ?? null,
        fantasyDraftPlayerId: json['FantasyDraftPlayerID'] ?? null,
        usaTodayPlayerId: json['UsaTodayPlayerID'] ?? null,
        usaTodayHeadshotUrl: json['UsaTodayHeadshotUrl'] ?? null,
        usaTodayHeadshotNoBackgroundUrl:
            json['UsaTodayHeadshotNoBackgroundUrl'] ?? null,
        usaTodayHeadshotUpdated: json['UsaTodayHeadshotUpdated'] == null
            ? null
            : DateTime.parse(json['UsaTodayHeadshotUpdated']),
        usaTodayHeadshotNoBackgroundUpdated:
            json['UsaTodayHeadshotNoBackgroundUpdated'] == null
                ? null
                : DateTime.parse(json['UsaTodayHeadshotNoBackgroundUpdated']),
        nbaDotComPlayerId: json['NbaDotComPlayerID'] ?? null,
      );

  final int playerId;
  final String sportsDataId;
  final Status status;
  final int teamId;
  final Team team;
  final int jersey;
  final PositionCategory positionCategory;
  final String position;
  final String firstName;
  final String lastName;
  final int height;
  final int weight;
  final DateTime birthDate;
  final String birthCity;
  final String birthState;
  final BirthCountry birthCountry;
  final String highSchool;
  final String college;
  final int salary;
  final String photoUrl;
  final int experience;
  final String sportRadarPlayerId;
  final int rotoworldPlayerId;
  final int rotoWirePlayerId;
  final int fantasyAlarmPlayerId;
  final int statsPlayerId;
  final int sportsDirectPlayerId;
  final int xmlTeamPlayerId;
  final dynamic injuryStatus;
  final dynamic injuryBodyPart;
  final dynamic injuryStartDate;
  final dynamic injuryNotes;
  final int fanDuelPlayerId;
  final int draftKingsPlayerId;
  final int yahooPlayerId;
  final String fanDuelName;
  final String draftKingsName;
  final String yahooName;
  final String depthChartPosition;
  final int depthChartOrder;
  final int globalTeamId;
  final String fantasyDraftName;
  final int fantasyDraftPlayerId;
  final int usaTodayPlayerId;
  final String usaTodayHeadshotUrl;
  final String usaTodayHeadshotNoBackgroundUrl;
  final DateTime usaTodayHeadshotUpdated;
  final DateTime usaTodayHeadshotNoBackgroundUpdated;
  final int nbaDotComPlayerId;

  NbaPlayer copyWith({
    int playerId,
    String sportsDataId,
    Status status,
    int teamId,
    Team team,
    int jersey,
    PositionCategory positionCategory,
    String position,
    String firstName,
    String lastName,
    int height,
    int weight,
    DateTime birthDate,
    String birthCity,
    String birthState,
    BirthCountry birthCountry,
    String highSchool,
    String college,
    int salary,
    String photoUrl,
    int experience,
    String sportRadarPlayerId,
    int rotoworldPlayerId,
    int rotoWirePlayerId,
    int fantasyAlarmPlayerId,
    int statsPlayerId,
    int sportsDirectPlayerId,
    int xmlTeamPlayerId,
    dynamic injuryStatus,
    dynamic injuryBodyPart,
    dynamic injuryStartDate,
    dynamic injuryNotes,
    int fanDuelPlayerId,
    int draftKingsPlayerId,
    int yahooPlayerId,
    String fanDuelName,
    String draftKingsName,
    String yahooName,
    String depthChartPosition,
    int depthChartOrder,
    int globalTeamId,
    String fantasyDraftName,
    int fantasyDraftPlayerId,
    int usaTodayPlayerId,
    String usaTodayHeadshotUrl,
    String usaTodayHeadshotNoBackgroundUrl,
    DateTime usaTodayHeadshotUpdated,
    DateTime usaTodayHeadshotNoBackgroundUpdated,
    int nbaDotComPlayerId,
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
  Map<String, dynamic> toMap() => {
        'PlayerID': playerId ?? null,
        'SportsDataID': sportsDataId ?? null,
        'Status': status == null ? null : statusValues.reverse[status],
        'TeamID': teamId ?? null,
        'Team': team == null ? null : teamValues.reverse[team],
        'Jersey': jersey ?? null,
        'PositionCategory': positionCategory == null
            ? null
            : positionCategoryValues.reverse[positionCategory],
        'Position': position ?? null,
        'FirstName': firstName ?? null,
        'LastName': lastName ?? null,
        'Height': height ?? null,
        'Weight': weight ?? null,
        'BirthDate': birthDate == null ? null : birthDate.toIso8601String(),
        'BirthCity': birthCity ?? null,
        'BirthState': birthState ?? null,
        'BirthCountry': birthCountry == null
            ? null
            : birthCountryValues.reverse[birthCountry],
        'HighSchool': highSchool ?? null,
        'College': college ?? null,
        'Salary': salary ?? null,
        'PhotoUrl': photoUrl ?? null,
        'Experience': experience ?? null,
        'SportRadarPlayerID': sportRadarPlayerId ?? null,
        'RotoworldPlayerID': rotoworldPlayerId ?? null,
        'RotoWirePlayerID': rotoWirePlayerId ?? null,
        'FantasyAlarmPlayerID': fantasyAlarmPlayerId ?? null,
        'StatsPlayerID': statsPlayerId ?? null,
        'SportsDirectPlayerID': sportsDirectPlayerId ?? null,
        'XmlTeamPlayerID': xmlTeamPlayerId ?? null,
        'InjuryStatus': injuryStatus,
        'InjuryBodyPart': injuryBodyPart,
        'InjuryStartDate': injuryStartDate,
        'InjuryNotes': injuryNotes,
        'FanDuelPlayerID': fanDuelPlayerId ?? null,
        'DraftKingsPlayerID': draftKingsPlayerId ?? null,
        'YahooPlayerID': yahooPlayerId ?? null,
        'FanDuelName': fanDuelName ?? null,
        'DraftKingsName': draftKingsName ?? null,
        'YahooName': yahooName ?? null,
        'DepthChartPosition': depthChartPosition ?? null,
        'DepthChartOrder': depthChartOrder ?? null,
        'GlobalTeamID': globalTeamId ?? null,
        'FantasyDraftName': fantasyDraftName ?? null,
        'FantasyDraftPlayerID': fantasyDraftPlayerId ?? null,
        'UsaTodayPlayerID': usaTodayPlayerId ?? null,
        'UsaTodayHeadshotUrl': usaTodayHeadshotUrl ?? null,
        'UsaTodayHeadshotNoBackgroundUrl':
            usaTodayHeadshotNoBackgroundUrl ?? null,
        'UsaTodayHeadshotUpdated': usaTodayHeadshotUpdated == null
            ? null
            : usaTodayHeadshotUpdated.toIso8601String(),
        'UsaTodayHeadshotNoBackgroundUpdated':
            usaTodayHeadshotNoBackgroundUpdated == null
                ? null
                : usaTodayHeadshotNoBackgroundUpdated.toIso8601String(),
        'NbaDotComPlayerID': nbaDotComPlayerId ?? null,
      };
}

enum BirthCountry { USA, GERMANY, LITHUANIA }

final birthCountryValues = EnumValues({
  'Germany': BirthCountry.GERMANY,
  'Lithuania': BirthCountry.LITHUANIA,
  'USA': BirthCountry.USA
});

enum PositionCategory { F, G, C }

final positionCategoryValues = EnumValues({
  'C': PositionCategory.C,
  'F': PositionCategory.F,
  'G': PositionCategory.G
});

enum Status { ACTIVE }

final statusValues = EnumValues({'Active': Status.ACTIVE});

enum Team { ORL }

final teamValues = EnumValues({'ORL': Team.ORL});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
