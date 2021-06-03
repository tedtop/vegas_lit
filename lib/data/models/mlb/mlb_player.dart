import 'dart:convert';

class MlbPlayer {
  MlbPlayer({
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
  factory MlbPlayer.fromJson(String str) => MlbPlayer.fromMap(json.decode(str));

  factory MlbPlayer.fromMap(Map<String, dynamic> json) => MlbPlayer(
        playerId: json['PlayerID'] ?? null,
        sportsDataId: json['SportsDataID'] ?? null,
        status: json['Status'] ?? null,
        teamId: json['TeamID'] ?? null,
        team: json['Team'] ?? null,
        jersey: json['Jersey'] ?? null,
        positionCategory: json['PositionCategory'] ?? null,
        position: json['Position'] ?? null,
        mlbamid: json['MLBAMID'] ?? null,
        firstName: json['FirstName'] ?? null,
        lastName: json['LastName'] ?? null,
        batHand: json['BatHand'] ?? null,
        throwHand: json['ThrowHand'] ?? null,
        height: json['Height'] ?? null,
        weight: json['Weight'] ?? null,
        birthDate: json['BirthDate'] == null
            ? null
            : DateTime.parse(json['BirthDate']),
        birthCity: json['BirthCity'] ?? null,
        birthState: json['BirthState'] ?? null,
        birthCountry: json['BirthCountry'] ?? null,
        highSchool: json['HighSchool'],
        college: json['College'] ?? null,
        proDebut:
            json['ProDebut'] == null ? null : DateTime.parse(json['ProDebut']),
        salary: json['Salary'],
        photoUrl: json['PhotoUrl'] ?? null,
        sportRadarPlayerId: json['SportRadarPlayerID'] ?? null,
        rotoworldPlayerId: json['RotoworldPlayerID'] ?? null,
        rotoWirePlayerId: json['RotoWirePlayerID'] ?? null,
        fantasyAlarmPlayerId: json['FantasyAlarmPlayerID'] ?? null,
        statsPlayerId: json['StatsPlayerID'] ?? null,
        sportsDirectPlayerId: json['SportsDirectPlayerID'] ?? null,
        xmlTeamPlayerId: json['XmlTeamPlayerID'] ?? null,
        injuryStatus: json['InjuryStatus'] ?? null,
        injuryBodyPart: json['InjuryBodyPart'] ?? null,
        injuryStartDate: json['InjuryStartDate'] == null
            ? null
            : DateTime.parse(json['InjuryStartDate']),
        injuryNotes: json['InjuryNotes'] ?? null,
        fanDuelPlayerId: json['FanDuelPlayerID'] ?? null,
        draftKingsPlayerId: json['DraftKingsPlayerID'] ?? null,
        yahooPlayerId: json['YahooPlayerID'] ?? null,
        upcomingGameId: json['UpcomingGameID'] ?? null,
        fanDuelName: json['FanDuelName'] ?? null,
        draftKingsName: json['DraftKingsName'] ?? null,
        yahooName: json['YahooName'] ?? null,
        globalTeamId: json['GlobalTeamID'] ?? null,
        fantasyDraftName: json['FantasyDraftName'] ?? null,
        fantasyDraftPlayerId: json['FantasyDraftPlayerID'] ?? null,
        experience: json['Experience'] ?? null,
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

  MlbPlayer copyWith({
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
      MlbPlayer(
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
  Map<String, dynamic> toMap() => {
        'PlayerID': playerId ?? null,
        'SportsDataID': sportsDataId ?? null,
        'Status': status ?? null,
        'TeamID': teamId ?? null,
        'Team': team ?? null,
        'Jersey': jersey ?? null,
        'PositionCategory': positionCategory ?? null,
        'Position': position ?? null,
        'MLBAMID': mlbamid ?? null,
        'FirstName': firstName ?? null,
        'LastName': lastName ?? null,
        'BatHand': batHand ?? null,
        'ThrowHand': throwHand ?? null,
        'Height': height ?? null,
        'Weight': weight ?? null,
        'BirthDate': birthDate == null ? null : birthDate.toIso8601String(),
        'BirthCity': birthCity ?? null,
        'BirthState': birthState ?? null,
        'BirthCountry': birthCountry ?? null,
        'HighSchool': highSchool,
        'College': college ?? null,
        'ProDebut': proDebut == null ? null : proDebut.toIso8601String(),
        'Salary': salary,
        'PhotoUrl': photoUrl ?? null,
        'SportRadarPlayerID': sportRadarPlayerId ?? null,
        'RotoworldPlayerID': rotoworldPlayerId ?? null,
        'RotoWirePlayerID': rotoWirePlayerId ?? null,
        'FantasyAlarmPlayerID': fantasyAlarmPlayerId ?? null,
        'StatsPlayerID': statsPlayerId ?? null,
        'SportsDirectPlayerID': sportsDirectPlayerId ?? null,
        'XmlTeamPlayerID': xmlTeamPlayerId ?? null,
        'InjuryStatus': injuryStatus ?? null,
        'InjuryBodyPart': injuryBodyPart ?? null,
        'InjuryStartDate':
            injuryStartDate == null ? null : injuryStartDate.toIso8601String(),
        'InjuryNotes': injuryNotes ?? null,
        'FanDuelPlayerID': fanDuelPlayerId ?? null,
        'DraftKingsPlayerID': draftKingsPlayerId ?? null,
        'YahooPlayerID': yahooPlayerId ?? null,
        'UpcomingGameID': upcomingGameId ?? null,
        'FanDuelName': fanDuelName ?? null,
        'DraftKingsName': draftKingsName ?? null,
        'YahooName': yahooName ?? null,
        'GlobalTeamID': globalTeamId ?? null,
        'FantasyDraftName': fantasyDraftName ?? null,
        'FantasyDraftPlayerID': fantasyDraftPlayerId ?? null,
        'Experience': experience ?? null,
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
      };
}
