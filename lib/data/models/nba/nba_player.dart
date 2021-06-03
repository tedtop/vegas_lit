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
        playerId: json['PlayerID'],
        sportsDataId: json['SportsDataID'],
        status:
            json['Status'] == null ? null : statusValues.map[json['Status']],
        teamId: json['TeamID'],
        team: json['Team'] == null ? null : teamValues.map[json['Team']],
        jersey: json['Jersey'],
        positionCategory: json['PositionCategory'] == null
            ? null
            : positionCategoryValues.map[json['PositionCategory']],
        position: json['Position'],
        firstName: json['FirstName'],
        lastName: json['LastName'],
        height: json['Height'],
        weight: json['Weight'],
        birthDate: json['BirthDate'] == null
            ? null
            : DateTime.parse(json['BirthDate']),
        birthCity: json['BirthCity'],
        birthState: json['BirthState'],
        birthCountry: json['BirthCountry'] == null
            ? null
            : birthCountryValues.map[json['BirthCountry']],
        highSchool: json['HighSchool'],
        college: json['College'],
        salary: json['Salary'],
        photoUrl: json['PhotoUrl'],
        experience: json['Experience'],
        sportRadarPlayerId: json['SportRadarPlayerID'],
        rotoworldPlayerId: json['RotoworldPlayerID'],
        rotoWirePlayerId: json['RotoWirePlayerID'],
        fantasyAlarmPlayerId: json['FantasyAlarmPlayerID'],
        statsPlayerId: json['StatsPlayerID'],
        sportsDirectPlayerId: json['SportsDirectPlayerID'],
        xmlTeamPlayerId: json['XmlTeamPlayerID'],
        injuryStatus: json['InjuryStatus'],
        injuryBodyPart: json['InjuryBodyPart'],
        injuryStartDate: json['InjuryStartDate'],
        injuryNotes: json['InjuryNotes'],
        fanDuelPlayerId: json['FanDuelPlayerID'],
        draftKingsPlayerId: json['DraftKingsPlayerID'],
        yahooPlayerId: json['YahooPlayerID'],
        fanDuelName: json['FanDuelName'],
        draftKingsName: json['DraftKingsName'],
        yahooName: json['YahooName'],
        depthChartPosition: json['DepthChartPosition'],
        depthChartOrder: json['DepthChartOrder'],
        globalTeamId: json['GlobalTeamID'],
        fantasyDraftName: json['FantasyDraftName'],
        fantasyDraftPlayerId: json['FantasyDraftPlayerID'],
        usaTodayPlayerId: json['UsaTodayPlayerID'],
        usaTodayHeadshotUrl: json['UsaTodayHeadshotUrl'],
        usaTodayHeadshotNoBackgroundUrl:
            json['UsaTodayHeadshotNoBackgroundUrl'],
        usaTodayHeadshotUpdated: json['UsaTodayHeadshotUpdated'] == null
            ? null
            : DateTime.parse(json['UsaTodayHeadshotUpdated']),
        usaTodayHeadshotNoBackgroundUpdated:
            json['UsaTodayHeadshotNoBackgroundUpdated'] == null
                ? null
                : DateTime.parse(json['UsaTodayHeadshotNoBackgroundUpdated']),
        nbaDotComPlayerId: json['NbaDotComPlayerID'],
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
        'PlayerID': playerId,
        'SportsDataID': sportsDataId,
        'Status': status == null ? null : statusValues.reverse[status],
        'TeamID': teamId,
        'Team': team == null ? null : teamValues.reverse[team],
        'Jersey': jersey,
        'PositionCategory': positionCategory == null
            ? null
            : positionCategoryValues.reverse[positionCategory],
        'Position': position,
        'FirstName': firstName,
        'LastName': lastName,
        'Height': height,
        'Weight': weight,
        'BirthDate': birthDate == null ? null : birthDate.toIso8601String(),
        'BirthCity': birthCity,
        'BirthState': birthState,
        'BirthCountry': birthCountry == null
            ? null
            : birthCountryValues.reverse[birthCountry],
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
        'UsaTodayHeadshotUpdated': usaTodayHeadshotUpdated == null
            ? null
            : usaTodayHeadshotUpdated.toIso8601String(),
        'UsaTodayHeadshotNoBackgroundUpdated':
            usaTodayHeadshotNoBackgroundUpdated == null
                ? null
                : usaTodayHeadshotNoBackgroundUpdated.toIso8601String(),
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
  Map<T, String> reverseMap;

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
