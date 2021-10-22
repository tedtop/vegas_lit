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
      NcaabPlayer.fromMap(json.decode(str) as Map<String, dynamic>);

  factory NcaabPlayer.fromMap(Map<String, dynamic> json) => NcaabPlayer(
        playerId: json['PlayerID'] as int,
        sportsDataId: json['SportsDataID'] as String,
        status: json['Status'] as String,
        teamId: json['TeamID'] as int,
        team: json['Team'] as String,
        jersey: json['Jersey'] as int,
        positionCategory: json['PositionCategory'] as String,
        position: json['Position'] as String,
        mlbamid: json['MLBAMID'] as int,
        firstName: json['FirstName'] as String,
        lastName: json['LastName'] as String,
        batHand: json['BatHand'] as String,
        throwHand: json['ThrowHand'] as String,
        height: json['Height'] as int,
        weight: json['Weight'] as int,
        birthDate: json['BirthDate'] == null
            ? null
            : DateTime.parse(json['BirthDate'] as String),
        birthCity: json['BirthCity'] as String,
        birthState: json['BirthState'] as String,
        birthCountry: json['BirthCountry'] as String,
        highSchool: json['HighSchool'] as String,
        college: json['College'] as String,
        proDebut: json['ProDebut'] == null
            ? null
            : DateTime.parse(json['ProDebut'] as String),
        salary: json['Salary'] as int,
        photoUrl: json['PhotoUrl'] as String,
        sportRadarPlayerId: json['SportRadarPlayerID'] as String,
        rotoworldPlayerId: json['RotoworldPlayerID'] as int,
        rotoWirePlayerId: json['RotoWirePlayerID'] as int,
        fantasyAlarmPlayerId: json['FantasyAlarmPlayerID'] as int,
        statsPlayerId: json['StatsPlayerID'] as int,
        sportsDirectPlayerId: json['SportsDirectPlayerID'] as int,
        xmlTeamPlayerId: json['XmlTeamPlayerID'] as int,
        injuryStatus: json['InjuryStatus'] as String,
        injuryBodyPart: json['InjuryBodyPart'] as String,
        injuryStartDate: json['InjuryStartDate'] == null
            ? null
            : DateTime.parse(json['InjuryStartDate'] as String),
        injuryNotes: json['InjuryNotes'] as String,
        fanDuelPlayerId: json['FanDuelPlayerID'] as int,
        draftKingsPlayerId: json['DraftKingsPlayerID'] as int,
        yahooPlayerId: json['YahooPlayerID'] as int,
        upcomingGameId: json['UpcomingGameID'] as int,
        fanDuelName: json['FanDuelName'] as String,
        draftKingsName: json['DraftKingsName'] as String,
        yahooName: json['YahooName'] as String,
        globalTeamId: json['GlobalTeamID'] as int,
        fantasyDraftName: json['FantasyDraftName'] as String,
        fantasyDraftPlayerId: json['FantasyDraftPlayerID'] as int,
        experience: json['Experience'] as String,
        usaTodayPlayerId: json['UsaTodayPlayerID'] as int,
        usaTodayHeadshotUrl: json['UsaTodayHeadshotUrl'] as String,
        usaTodayHeadshotNoBackgroundUrl:
            json['UsaTodayHeadshotNoBackgroundUrl'] as String,
        usaTodayHeadshotUpdated: json['UsaTodayHeadshotUpdated'] == null
            ? null
            : DateTime.parse(json['UsaTodayHeadshotUpdated'] as String),
        usaTodayHeadshotNoBackgroundUpdated:
            json['UsaTodayHeadshotNoBackgroundUpdated'] == null
                ? null
                : DateTime.parse(
                    json['UsaTodayHeadshotNoBackgroundUpdated'] as String),
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
        'BirthDate': birthDate?.toIso8601String(),
        'BirthCity': birthCity,
        'BirthState': birthState,
        'BirthCountry': birthCountry,
        'HighSchool': highSchool,
        'College': college,
        'ProDebut': proDebut?.toIso8601String(),
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
        'InjuryStartDate': injuryStartDate?.toIso8601String(),
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
        'UsaTodayHeadshotUpdated': usaTodayHeadshotUpdated?.toIso8601String(),
        'UsaTodayHeadshotNoBackgroundUpdated':
            usaTodayHeadshotNoBackgroundUpdated?.toIso8601String(),
      };
}
