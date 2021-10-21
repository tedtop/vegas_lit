import 'dart:convert';

class NcaabPlayer {
  NcaabPlayer({
    this.playerId,
    this.sportsDataId,
    this.status,
    this.teamId,
    this.team,
    this.jersey,
    this.positionCategory,
    this.position,
    this.mlbamid,
    this.firstName,
    this.lastName,
    this.batHand,
    this.throwHand,
    this.height,
    this.weight,
    this.birthDate,
    this.birthCity,
    this.birthState,
    this.birthCountry,
    this.highSchool,
    this.college,
    this.proDebut,
    this.salary,
    this.photoUrl,
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
    this.upcomingGameId,
    this.fanDuelName,
    this.draftKingsName,
    this.yahooName,
    this.globalTeamId,
    this.fantasyDraftName,
    this.fantasyDraftPlayerId,
    this.experience,
    this.usaTodayPlayerId,
    this.usaTodayHeadshotUrl,
    this.usaTodayHeadshotNoBackgroundUrl,
    this.usaTodayHeadshotUpdated,
    this.usaTodayHeadshotNoBackgroundUpdated,
  });
  factory NcaabPlayer.fromJson(String str) =>
      NcaabPlayer.fromMap(json.decode(str));

  factory NcaabPlayer.fromMap(Map<String, dynamic> json) => NcaabPlayer(
        playerId: json['PlayerID'],
        sportsDataId: json['SportsDataID'],
        status: json['Status'],
        teamId: json['TeamID'],
        team: json['Team'],
        jersey: json['Jersey'],
        positionCategory: json['PositionCategory'],
        position: json['Position'],
        mlbamid: json['MLBAMID'],
        firstName: json['FirstName'],
        lastName: json['LastName'],
        batHand: json['BatHand'],
        throwHand: json['ThrowHand'],
        height: json['Height'],
        weight: json['Weight'],
        birthDate: json['BirthDate'] == null
            ? null
            : DateTime.parse(json['BirthDate']),
        birthCity: json['BirthCity'],
        birthState: json['BirthState'],
        birthCountry: json['BirthCountry'],
        highSchool: json['HighSchool'],
        college: json['College'],
        proDebut:
            json['ProDebut'] == null ? null : DateTime.parse(json['ProDebut']),
        salary: json['Salary'],
        photoUrl: json['PhotoUrl'],
        sportRadarPlayerId: json['SportRadarPlayerID'],
        rotoworldPlayerId: json['RotoworldPlayerID'],
        rotoWirePlayerId: json['RotoWirePlayerID'],
        fantasyAlarmPlayerId: json['FantasyAlarmPlayerID'],
        statsPlayerId: json['StatsPlayerID'],
        sportsDirectPlayerId: json['SportsDirectPlayerID'],
        xmlTeamPlayerId: json['XmlTeamPlayerID'],
        injuryStatus: json['InjuryStatus'],
        injuryBodyPart: json['InjuryBodyPart'],
        injuryStartDate: json['InjuryStartDate'] == null
            ? null
            : DateTime.parse(json['InjuryStartDate']),
        injuryNotes: json['InjuryNotes'],
        fanDuelPlayerId: json['FanDuelPlayerID'],
        draftKingsPlayerId: json['DraftKingsPlayerID'],
        yahooPlayerId: json['YahooPlayerID'],
        upcomingGameId: json['UpcomingGameID'],
        fanDuelName: json['FanDuelName'],
        draftKingsName: json['DraftKingsName'],
        yahooName: json['YahooName'],
        globalTeamId: json['GlobalTeamID'],
        fantasyDraftName: json['FantasyDraftName'],
        fantasyDraftPlayerId: json['FantasyDraftPlayerID'],
        experience: json['Experience'],
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
      );

  final int playerId;
  final String sportsDataId;
  final String status;
  final int teamId;
  final String team;
  final int jersey;
  final String positionCategory;
  final String position;
  final int mlbamid;
  final String firstName;
  final String lastName;
  final String batHand;
  final String throwHand;
  final int height;
  final int weight;
  final DateTime birthDate;
  final String birthCity;
  final String birthState;
  final String birthCountry;
  final dynamic highSchool;
  final String college;
  final DateTime proDebut;
  final dynamic salary;
  final String photoUrl;
  final String sportRadarPlayerId;
  final int rotoworldPlayerId;
  final int rotoWirePlayerId;
  final int fantasyAlarmPlayerId;
  final int statsPlayerId;
  final int sportsDirectPlayerId;
  final int xmlTeamPlayerId;
  final String injuryStatus;
  final String injuryBodyPart;
  final DateTime injuryStartDate;
  final String injuryNotes;
  final int fanDuelPlayerId;
  final int draftKingsPlayerId;
  final int yahooPlayerId;
  final int upcomingGameId;
  final String fanDuelName;
  final String draftKingsName;
  final String yahooName;
  final int globalTeamId;
  final String fantasyDraftName;
  final int fantasyDraftPlayerId;
  final String experience;
  final int usaTodayPlayerId;
  final String usaTodayHeadshotUrl;
  final String usaTodayHeadshotNoBackgroundUrl;
  final DateTime usaTodayHeadshotUpdated;
  final DateTime usaTodayHeadshotNoBackgroundUpdated;

  NcaabPlayer copyWith({
    int playerId,
    String sportsDataId,
    String status,
    int teamId,
    String team,
    int jersey,
    String positionCategory,
    String position,
    int mlbamid,
    String firstName,
    String lastName,
    String batHand,
    String throwHand,
    int height,
    int weight,
    DateTime birthDate,
    String birthCity,
    String birthState,
    String birthCountry,
    dynamic highSchool,
    String college,
    DateTime proDebut,
    dynamic salary,
    String photoUrl,
    String sportRadarPlayerId,
    int rotoworldPlayerId,
    int rotoWirePlayerId,
    int fantasyAlarmPlayerId,
    int statsPlayerId,
    int sportsDirectPlayerId,
    int xmlTeamPlayerId,
    String injuryStatus,
    String injuryBodyPart,
    DateTime injuryStartDate,
    String injuryNotes,
    int fanDuelPlayerId,
    int draftKingsPlayerId,
    int yahooPlayerId,
    int upcomingGameId,
    String fanDuelName,
    String draftKingsName,
    String yahooName,
    int globalTeamId,
    String fantasyDraftName,
    int fantasyDraftPlayerId,
    String experience,
    int usaTodayPlayerId,
    String usaTodayHeadshotUrl,
    String usaTodayHeadshotNoBackgroundUrl,
    DateTime usaTodayHeadshotUpdated,
    DateTime usaTodayHeadshotNoBackgroundUpdated,
  }) =>
      NcaabPlayer(
        playerId: playerId ?? this.playerId,
        sportsDataId: sportsDataId ?? this.sportsDataId,
        status: status ?? this.status,
        teamId: teamId ?? this.teamId,
        team: team ?? this.team,
        jersey: jersey ?? this.jersey,
        positionCategory: positionCategory ?? this.positionCategory,
        position: position ?? this.position,
        mlbamid: mlbamid ?? this.mlbamid,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        batHand: batHand ?? this.batHand,
        throwHand: throwHand ?? this.throwHand,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        birthDate: birthDate ?? this.birthDate,
        birthCity: birthCity ?? this.birthCity,
        birthState: birthState ?? this.birthState,
        birthCountry: birthCountry ?? this.birthCountry,
        highSchool: highSchool ?? this.highSchool,
        college: college ?? this.college,
        proDebut: proDebut ?? this.proDebut,
        salary: salary ?? this.salary,
        photoUrl: photoUrl ?? this.photoUrl,
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
        upcomingGameId: upcomingGameId ?? this.upcomingGameId,
        fanDuelName: fanDuelName ?? this.fanDuelName,
        draftKingsName: draftKingsName ?? this.draftKingsName,
        yahooName: yahooName ?? this.yahooName,
        globalTeamId: globalTeamId ?? this.globalTeamId,
        fantasyDraftName: fantasyDraftName ?? this.fantasyDraftName,
        fantasyDraftPlayerId: fantasyDraftPlayerId ?? this.fantasyDraftPlayerId,
        experience: experience ?? this.experience,
        usaTodayPlayerId: usaTodayPlayerId ?? this.usaTodayPlayerId,
        usaTodayHeadshotUrl: usaTodayHeadshotUrl ?? this.usaTodayHeadshotUrl,
        usaTodayHeadshotNoBackgroundUrl: usaTodayHeadshotNoBackgroundUrl ??
            this.usaTodayHeadshotNoBackgroundUrl,
        usaTodayHeadshotUpdated:
            usaTodayHeadshotUpdated ?? this.usaTodayHeadshotUpdated,
        usaTodayHeadshotNoBackgroundUpdated:
            usaTodayHeadshotNoBackgroundUpdated ??
                this.usaTodayHeadshotNoBackgroundUpdated,
      );

  String toJson() => json.encode(toMap());
  Map<String, Object> toMap() => {
        'PlayerID': playerId,
        'SportsDataID': sportsDataId,
        'Status': status,
        'TeamID': teamId,
        'Team': team,
        'Jersey': jersey,
        'PositionCategory': positionCategory,
        'Position': position,
        'MLBAMID': mlbamid,
        'FirstName': firstName,
        'LastName': lastName,
        'BatHand': batHand,
        'ThrowHand': throwHand,
        'Height': height,
        'Weight': weight,
        'BirthDate': birthDate == null ? null : birthDate.toIso8601String(),
        'BirthCity': birthCity,
        'BirthState': birthState,
        'BirthCountry': birthCountry,
        'HighSchool': highSchool,
        'College': college,
        'ProDebut': proDebut == null ? null : proDebut.toIso8601String(),
        'Salary': salary,
        'PhotoUrl': photoUrl,
        'SportRadarPlayerID': sportRadarPlayerId,
        'RotoworldPlayerID': rotoworldPlayerId,
        'RotoWirePlayerID': rotoWirePlayerId,
        'FantasyAlarmPlayerID': fantasyAlarmPlayerId,
        'StatsPlayerID': statsPlayerId,
        'SportsDirectPlayerID': sportsDirectPlayerId,
        'XmlTeamPlayerID': xmlTeamPlayerId,
        'InjuryStatus': injuryStatus,
        'InjuryBodyPart': injuryBodyPart,
        'InjuryStartDate':
            injuryStartDate == null ? null : injuryStartDate.toIso8601String(),
        'InjuryNotes': injuryNotes,
        'FanDuelPlayerID': fanDuelPlayerId,
        'DraftKingsPlayerID': draftKingsPlayerId,
        'YahooPlayerID': yahooPlayerId,
        'UpcomingGameID': upcomingGameId,
        'FanDuelName': fanDuelName,
        'DraftKingsName': draftKingsName,
        'YahooName': yahooName,
        'GlobalTeamID': globalTeamId,
        'FantasyDraftName': fantasyDraftName,
        'FantasyDraftPlayerID': fantasyDraftPlayerId,
        'Experience': experience,
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
      };
}
