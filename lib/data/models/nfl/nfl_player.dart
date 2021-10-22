

import 'dart:convert';

class NflPlayer {
  NflPlayer({
    this.playerId,
    this.team,
    this.number,
    this.firstName,
    this.lastName,
    this.position,
    this.status,
    this.height,
    this.weight,
    this.birthDate,
    this.college,
    this.experience,
    this.fantasyPosition,
    this.active,
    this.positionCategory,
    this.name,
    this.age,
    this.experienceString,
    this.birthDateString,
    this.photoUrl,
    this.byeWeek,
    this.upcomingGameOpponent,
    this.upcomingGameWeek,
    this.shortName,
    this.averageDraftPosition,
    this.depthPositionCategory,
    this.depthPosition,
    this.depthOrder,
    this.depthDisplayOrder,
    this.currentTeam,
    this.collegeDraftTeam,
    this.collegeDraftYear,
    this.collegeDraftRound,
    this.collegeDraftPick,
    this.isUndraftedFreeAgent,
    this.heightFeet,
    this.heightInches,
    this.upcomingOpponentRank,
    this.upcomingOpponentPositionRank,
    this.currentStatus,
    this.upcomingSalary,
    this.fantasyAlarmPlayerId,
    this.sportRadarPlayerId,
    this.rotoworldPlayerId,
    this.rotoWirePlayerId,
    this.statsPlayerId,
    this.sportsDirectPlayerId,
    this.xmlTeamPlayerId,
    this.fanDuelPlayerId,
    this.draftKingsPlayerId,
    this.yahooPlayerId,
    this.injuryStatus,
    this.injuryBodyPart,
    this.injuryStartDate,
    this.injuryNotes,
    this.fanDuelName,
    this.draftKingsName,
    this.yahooName,
    this.fantasyPositionDepthOrder,
    this.injuryPractice,
    this.injuryPracticeDescription,
    this.declaredInactive,
    this.upcomingFanDuelSalary,
    this.upcomingDraftKingsSalary,
    this.upcomingYahooSalary,
    this.teamId,
    this.globalTeamId,
    this.fantasyDraftPlayerId,
    this.fantasyDraftName,
    this.usaTodayPlayerId,
    this.usaTodayHeadshotUrl,
    this.usaTodayHeadshotNoBackgroundUrl,
    this.usaTodayHeadshotUpdated,
    this.usaTodayHeadshotNoBackgroundUpdated,
    this.playerSeason,
    this.latestNews,
  });
  factory NflPlayer.fromJson(String str) =>
      NflPlayer.fromMap(json.decode(str) as Map<String, dynamic>);
  factory NflPlayer.fromMap(Map<String, dynamic> json) => NflPlayer(
        playerId: json['PlayerID'] as int?,
        team: teamValues.map[json['Team']],
        number: json['Number'] as int?,
        firstName: json['FirstName'] as String?,
        lastName: json['LastName'] as String?,
        position: json['Position'] as String?,
        status: statusEnumValues.map[json['Status']],
        height: json['Height'] as String?,
        weight: json['Weight'] as int?,
        birthDate: json['BirthDate'] == null
            ? null
            : DateTime.parse(json['BirthDate'] as String),
        college: json['College'] as String?,
        experience: json['Experience'] as int?,
        fantasyPosition: json['FantasyPosition'] as String?,
        active: json['Active'] as bool?,
        positionCategory: positionCategoryValues.map[json['PositionCategory']],
        name: json['Name'] as String?,
        age: json['Age'] as int?,
        experienceString: json['ExperienceString'] as String?,
        birthDateString: json['BirthDateString'] as String?,
        photoUrl: json['PhotoUrl'] as String?,
        byeWeek: json['ByeWeek'] as int?,
        upcomingGameOpponent:
            upcomingGameOpponentValues.map[json['UpcomingGameOpponent']],
        upcomingGameWeek: json['UpcomingGameWeek'] as int?,
        shortName: json['ShortName'] as String?,
        averageDraftPosition: json['AverageDraftPosition'] == null
            ? null
            : json['AverageDraftPosition'].toDouble() as double?,
        depthPositionCategory: json['DepthPositionCategory'] == null
            ? null
            : positionCategoryValues.map[json['DepthPositionCategory']],
        depthPosition: json['DepthPosition'] as String?,
        depthOrder: json['DepthOrder'] as int?,
        depthDisplayOrder: json['DepthDisplayOrder'] as int?,
        currentTeam: teamValues.map[json['CurrentTeam']],
        collegeDraftTeam: json['CollegeDraftTeam'] as String?,
        collegeDraftYear: json['CollegeDraftYear'] as int?,
        collegeDraftRound: json['CollegeDraftRound'] as int?,
        collegeDraftPick: json['CollegeDraftPick'] as int?,
        isUndraftedFreeAgent: json['IsUndraftedFreeAgent'] as bool?,
        heightFeet: json['HeightFeet'] as int?,
        heightInches: json['HeightInches'] as int?,
        upcomingOpponentRank: json['UpcomingOpponentRank'] as int?,
        upcomingOpponentPositionRank:
            json['UpcomingOpponentPositionRank'] as int?,
        currentStatus: statusValues.map[json['CurrentStatus']],
        upcomingSalary: json['UpcomingSalary'] as int?,
        fantasyAlarmPlayerId: json['FantasyAlarmPlayerID'] as int?,
        sportRadarPlayerId: json['SportRadarPlayerID'] as String?,
        rotoworldPlayerId: json['RotoworldPlayerID'] as int?,
        rotoWirePlayerId: json['RotoWirePlayerID'] as int?,
        statsPlayerId: json['StatsPlayerID'] as int?,
        sportsDirectPlayerId: json['SportsDirectPlayerID'] as int?,
        xmlTeamPlayerId: json['XmlTeamPlayerID'] as int?,
        fanDuelPlayerId: json['FanDuelPlayerID'] as int?,
        draftKingsPlayerId: json['DraftKingsPlayerID'] as int?,
        yahooPlayerId: json['YahooPlayerID'] as int?,
        injuryStatus: json['InjuryStatus'] == null
            ? null
            : statusValues.map[json['InjuryStatus']],
        injuryBodyPart: json['InjuryBodyPart'] as String?,
        injuryStartDate: json['InjuryStartDate'] == null
            ? null
            : DateTime.parse(json['InjuryStartDate'] as String),
        injuryNotes: json['InjuryNotes'] as String?,
        fanDuelName: json['FanDuelName'] as String?,
        draftKingsName: json['DraftKingsName'] as String?,
        yahooName: json['YahooName'] as String?,
        fantasyPositionDepthOrder: json['FantasyPositionDepthOrder'] as int?,
        injuryPractice: json['InjuryPractice'],
        injuryPracticeDescription: json['InjuryPracticeDescription'],
        declaredInactive: json['DeclaredInactive'] as bool?,
        upcomingFanDuelSalary: json['UpcomingFanDuelSalary'],
        upcomingDraftKingsSalary: json['UpcomingDraftKingsSalary'],
        upcomingYahooSalary: json['UpcomingYahooSalary'],
        teamId: json['TeamID'] as int?,
        globalTeamId: json['GlobalTeamID'] as int?,
        fantasyDraftPlayerId: json['FantasyDraftPlayerID'] as int?,
        fantasyDraftName: json['FantasyDraftName'] as String?,
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
                    json['UsaTodayHeadshotNoBackgroundUpdated'] as String,
                  ),
        playerSeason: json['PlayerSeason'],
        latestNews: List<dynamic>.from(
          json['LatestNews'].map((dynamic x) => x) as List,
        ),
      );

  final int? playerId;
  final Team? team;
  final int? number;
  final String? firstName;
  final String? lastName;
  final String? position;
  final StatusEnum? status;
  final String? height;
  final int? weight;
  final DateTime? birthDate;
  final String? college;
  final int? experience;
  final String? fantasyPosition;
  final bool? active;
  final PositionCategory? positionCategory;
  final String? name;
  final int? age;
  final String? experienceString;
  final String? birthDateString;
  final String? photoUrl;
  final int? byeWeek;
  final UpcomingGameOpponent? upcomingGameOpponent;
  final int? upcomingGameWeek;
  final String? shortName;
  final double? averageDraftPosition;
  final PositionCategory? depthPositionCategory;
  final String? depthPosition;
  final int? depthOrder;
  final int? depthDisplayOrder;
  final Team? currentTeam;
  final String? collegeDraftTeam;
  final int? collegeDraftYear;
  final int? collegeDraftRound;
  final int? collegeDraftPick;
  final bool? isUndraftedFreeAgent;
  final int? heightFeet;
  final int? heightInches;
  final int? upcomingOpponentRank;
  final int? upcomingOpponentPositionRank;
  final Status? currentStatus;
  final int? upcomingSalary;
  final int? fantasyAlarmPlayerId;
  final String? sportRadarPlayerId;
  final int? rotoworldPlayerId;
  final int? rotoWirePlayerId;
  final int? statsPlayerId;
  final int? sportsDirectPlayerId;
  final int? xmlTeamPlayerId;
  final int? fanDuelPlayerId;
  final int? draftKingsPlayerId;
  final int? yahooPlayerId;
  final Status? injuryStatus;
  final String? injuryBodyPart;
  final DateTime? injuryStartDate;
  final String? injuryNotes;
  final String? fanDuelName;
  final String? draftKingsName;
  final String? yahooName;
  final int? fantasyPositionDepthOrder;
  final dynamic injuryPractice;
  final dynamic injuryPracticeDescription;
  final bool? declaredInactive;
  final dynamic upcomingFanDuelSalary;
  final dynamic upcomingDraftKingsSalary;
  final dynamic upcomingYahooSalary;
  final int? teamId;
  final int? globalTeamId;
  final int? fantasyDraftPlayerId;
  final String? fantasyDraftName;
  final int? usaTodayPlayerId;
  final String? usaTodayHeadshotUrl;
  final String? usaTodayHeadshotNoBackgroundUrl;
  final DateTime? usaTodayHeadshotUpdated;
  final DateTime? usaTodayHeadshotNoBackgroundUpdated;
  final dynamic playerSeason;
  final List<dynamic>? latestNews;

  NflPlayer copyWith({
    int? playerId,
    Team? team,
    int? number,
    String? firstName,
    String? lastName,
    String? position,
    StatusEnum? status,
    String? height,
    int? weight,
    DateTime? birthDate,
    String? college,
    int? experience,
    String? fantasyPosition,
    bool? active,
    PositionCategory? positionCategory,
    String? name,
    int? age,
    String? experienceString,
    String? birthDateString,
    String? photoUrl,
    int? byeWeek,
    UpcomingGameOpponent? upcomingGameOpponent,
    int? upcomingGameWeek,
    String? shortName,
    double? averageDraftPosition,
    PositionCategory? depthPositionCategory,
    String? depthPosition,
    int? depthOrder,
    int? depthDisplayOrder,
    Team? currentTeam,
    String? collegeDraftTeam,
    int? collegeDraftYear,
    int? collegeDraftRound,
    int? collegeDraftPick,
    bool? isUndraftedFreeAgent,
    int? heightFeet,
    int? heightInches,
    int? upcomingOpponentRank,
    int? upcomingOpponentPositionRank,
    Status? currentStatus,
    int? upcomingSalary,
    int? fantasyAlarmPlayerId,
    String? sportRadarPlayerId,
    int? rotoworldPlayerId,
    int? rotoWirePlayerId,
    int? statsPlayerId,
    int? sportsDirectPlayerId,
    int? xmlTeamPlayerId,
    int? fanDuelPlayerId,
    int? draftKingsPlayerId,
    int? yahooPlayerId,
    Status? injuryStatus,
    String? injuryBodyPart,
    DateTime? injuryStartDate,
    String? injuryNotes,
    String? fanDuelName,
    String? draftKingsName,
    String? yahooName,
    int? fantasyPositionDepthOrder,
    dynamic injuryPractice,
    dynamic injuryPracticeDescription,
    bool? declaredInactive,
    dynamic upcomingFanDuelSalary,
    dynamic upcomingDraftKingsSalary,
    dynamic upcomingYahooSalary,
    int? teamId,
    int? globalTeamId,
    int? fantasyDraftPlayerId,
    String? fantasyDraftName,
    int? usaTodayPlayerId,
    String? usaTodayHeadshotUrl,
    String? usaTodayHeadshotNoBackgroundUrl,
    DateTime? usaTodayHeadshotUpdated,
    DateTime? usaTodayHeadshotNoBackgroundUpdated,
    dynamic playerSeason,
    List<dynamic>? latestNews,
  }) =>
      NflPlayer(
        playerId: playerId ?? this.playerId,
        team: team ?? this.team,
        number: number ?? this.number,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        position: position ?? this.position,
        status: status ?? this.status,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        birthDate: birthDate ?? this.birthDate,
        college: college ?? this.college,
        experience: experience ?? this.experience,
        fantasyPosition: fantasyPosition ?? this.fantasyPosition,
        active: active ?? this.active,
        positionCategory: positionCategory ?? this.positionCategory,
        name: name ?? this.name,
        age: age ?? this.age,
        experienceString: experienceString ?? this.experienceString,
        birthDateString: birthDateString ?? this.birthDateString,
        photoUrl: photoUrl ?? this.photoUrl,
        byeWeek: byeWeek ?? this.byeWeek,
        upcomingGameOpponent: upcomingGameOpponent ?? this.upcomingGameOpponent,
        upcomingGameWeek: upcomingGameWeek ?? this.upcomingGameWeek,
        shortName: shortName ?? this.shortName,
        averageDraftPosition: averageDraftPosition ?? this.averageDraftPosition,
        depthPositionCategory:
            depthPositionCategory ?? this.depthPositionCategory,
        depthPosition: depthPosition ?? this.depthPosition,
        depthOrder: depthOrder ?? this.depthOrder,
        depthDisplayOrder: depthDisplayOrder ?? this.depthDisplayOrder,
        currentTeam: currentTeam ?? this.currentTeam,
        collegeDraftTeam: collegeDraftTeam ?? this.collegeDraftTeam,
        collegeDraftYear: collegeDraftYear ?? this.collegeDraftYear,
        collegeDraftRound: collegeDraftRound ?? this.collegeDraftRound,
        collegeDraftPick: collegeDraftPick ?? this.collegeDraftPick,
        isUndraftedFreeAgent: isUndraftedFreeAgent ?? this.isUndraftedFreeAgent,
        heightFeet: heightFeet ?? this.heightFeet,
        heightInches: heightInches ?? this.heightInches,
        upcomingOpponentRank: upcomingOpponentRank ?? this.upcomingOpponentRank,
        upcomingOpponentPositionRank:
            upcomingOpponentPositionRank ?? this.upcomingOpponentPositionRank,
        currentStatus: currentStatus ?? this.currentStatus,
        upcomingSalary: upcomingSalary ?? this.upcomingSalary,
        fantasyAlarmPlayerId: fantasyAlarmPlayerId ?? this.fantasyAlarmPlayerId,
        sportRadarPlayerId: sportRadarPlayerId ?? this.sportRadarPlayerId,
        rotoworldPlayerId: rotoworldPlayerId ?? this.rotoworldPlayerId,
        rotoWirePlayerId: rotoWirePlayerId ?? this.rotoWirePlayerId,
        statsPlayerId: statsPlayerId ?? this.statsPlayerId,
        sportsDirectPlayerId: sportsDirectPlayerId ?? this.sportsDirectPlayerId,
        xmlTeamPlayerId: xmlTeamPlayerId ?? this.xmlTeamPlayerId,
        fanDuelPlayerId: fanDuelPlayerId ?? this.fanDuelPlayerId,
        draftKingsPlayerId: draftKingsPlayerId ?? this.draftKingsPlayerId,
        yahooPlayerId: yahooPlayerId ?? this.yahooPlayerId,
        injuryStatus: injuryStatus ?? this.injuryStatus,
        injuryBodyPart: injuryBodyPart ?? this.injuryBodyPart,
        injuryStartDate: injuryStartDate ?? this.injuryStartDate,
        injuryNotes: injuryNotes ?? this.injuryNotes,
        fanDuelName: fanDuelName ?? this.fanDuelName,
        draftKingsName: draftKingsName ?? this.draftKingsName,
        yahooName: yahooName ?? this.yahooName,
        fantasyPositionDepthOrder:
            fantasyPositionDepthOrder ?? this.fantasyPositionDepthOrder,
        injuryPractice: injuryPractice ?? this.injuryPractice,
        injuryPracticeDescription:
            injuryPracticeDescription ?? this.injuryPracticeDescription,
        declaredInactive: declaredInactive ?? this.declaredInactive,
        upcomingFanDuelSalary:
            upcomingFanDuelSalary ?? this.upcomingFanDuelSalary,
        upcomingDraftKingsSalary:
            upcomingDraftKingsSalary ?? this.upcomingDraftKingsSalary,
        upcomingYahooSalary: upcomingYahooSalary ?? this.upcomingYahooSalary,
        teamId: teamId ?? this.teamId,
        globalTeamId: globalTeamId ?? this.globalTeamId,
        fantasyDraftPlayerId: fantasyDraftPlayerId ?? this.fantasyDraftPlayerId,
        fantasyDraftName: fantasyDraftName ?? this.fantasyDraftName,
        usaTodayPlayerId: usaTodayPlayerId ?? this.usaTodayPlayerId,
        usaTodayHeadshotUrl: usaTodayHeadshotUrl ?? this.usaTodayHeadshotUrl,
        usaTodayHeadshotNoBackgroundUrl: usaTodayHeadshotNoBackgroundUrl ??
            this.usaTodayHeadshotNoBackgroundUrl,
        usaTodayHeadshotUpdated:
            usaTodayHeadshotUpdated ?? this.usaTodayHeadshotUpdated,
        usaTodayHeadshotNoBackgroundUpdated:
            usaTodayHeadshotNoBackgroundUpdated ??
                this.usaTodayHeadshotNoBackgroundUpdated,
        playerSeason: playerSeason ?? this.playerSeason,
        latestNews: latestNews ?? this.latestNews,
      );

  String toJson() => json.encode(toMap());

  Map<String, Object?> toMap() => {
        'PlayerID': playerId,
        'Team': teamValues.reverse![team!],
        'Number': number,
        'FirstName': firstName,
        'LastName': lastName,
        'Position': position,
        'Status': statusEnumValues.reverse![status!],
        'Height': height,
        'Weight': weight,
        'BirthDate': birthDate?.toIso8601String(),
        'College': college,
        'Experience': experience,
        'FantasyPosition': fantasyPosition,
        'Active': active,
        'PositionCategory': positionCategoryValues.reverse![positionCategory!],
        'Name': name,
        'Age': age,
        'ExperienceString': experienceString,
        'BirthDateString': birthDateString,
        'PhotoUrl': photoUrl,
        'ByeWeek': byeWeek,
        'UpcomingGameOpponent':
            upcomingGameOpponentValues.reverse![upcomingGameOpponent!],
        'UpcomingGameWeek': upcomingGameWeek,
        'ShortName': shortName,
        'AverageDraftPosition': averageDraftPosition,
        'DepthPositionCategory': depthPositionCategory == null
            ? null
            : positionCategoryValues.reverse![depthPositionCategory!],
        'DepthPosition': depthPosition,
        'DepthOrder': depthOrder,
        'DepthDisplayOrder': depthDisplayOrder,
        'CurrentTeam': teamValues.reverse![currentTeam!],
        'CollegeDraftTeam': collegeDraftTeam,
        'CollegeDraftYear': collegeDraftYear,
        'CollegeDraftRound': collegeDraftRound,
        'CollegeDraftPick': collegeDraftPick,
        'IsUndraftedFreeAgent': isUndraftedFreeAgent,
        'HeightFeet': heightFeet,
        'HeightInches': heightInches,
        'UpcomingOpponentRank': upcomingOpponentRank,
        'UpcomingOpponentPositionRank': upcomingOpponentPositionRank,
        'CurrentStatus': statusValues.reverse![currentStatus!],
        'UpcomingSalary': upcomingSalary,
        'FantasyAlarmPlayerID': fantasyAlarmPlayerId,
        'SportRadarPlayerID': sportRadarPlayerId,
        'RotoworldPlayerID': rotoworldPlayerId,
        'RotoWirePlayerID': rotoWirePlayerId,
        'StatsPlayerID': statsPlayerId,
        'SportsDirectPlayerID': sportsDirectPlayerId,
        'XmlTeamPlayerID': xmlTeamPlayerId,
        'FanDuelPlayerID': fanDuelPlayerId,
        'DraftKingsPlayerID': draftKingsPlayerId,
        'YahooPlayerID': yahooPlayerId,
        'InjuryStatus':
            injuryStatus == null ? null : statusValues.reverse![injuryStatus!],
        'InjuryBodyPart': injuryBodyPart,
        'InjuryStartDate': injuryStartDate?.toIso8601String(),
        'InjuryNotes': injuryNotes,
        'FanDuelName': fanDuelName,
        'DraftKingsName': draftKingsName,
        'YahooName': yahooName,
        'FantasyPositionDepthOrder': fantasyPositionDepthOrder,
        'InjuryPractice': injuryPractice,
        'InjuryPracticeDescription': injuryPracticeDescription,
        'DeclaredInactive': declaredInactive,
        'UpcomingFanDuelSalary': upcomingFanDuelSalary,
        'UpcomingDraftKingsSalary': upcomingDraftKingsSalary,
        'UpcomingYahooSalary': upcomingYahooSalary,
        'TeamID': teamId,
        'GlobalTeamID': globalTeamId,
        'FantasyDraftPlayerID': fantasyDraftPlayerId,
        'FantasyDraftName': fantasyDraftName,
        'UsaTodayPlayerID': usaTodayPlayerId,
        'UsaTodayHeadshotUrl': usaTodayHeadshotUrl,
        'UsaTodayHeadshotNoBackgroundUrl': usaTodayHeadshotNoBackgroundUrl,
        'UsaTodayHeadshotUpdated': usaTodayHeadshotUpdated?.toIso8601String(),
        'UsaTodayHeadshotNoBackgroundUpdated':
            usaTodayHeadshotNoBackgroundUpdated?.toIso8601String(),
        'PlayerSeason': playerSeason,
        'LatestNews':
            List<dynamic>.from(latestNews!.map<dynamic>((dynamic x) => x)),
      };
}

// ignore: constant_identifier_names
enum Status { HEALTHY, PHYSICALLY_UNABLE_TO_PERFORM, INJURED_RESERVE, OUT }

final statusValues = EnumValues({
  'Healthy': Status.HEALTHY,
  'Injured Reserve': Status.INJURED_RESERVE,
  'Out': Status.OUT,
  'Physically Unable To Perform': Status.PHYSICALLY_UNABLE_TO_PERFORM
});

// ignore: constant_identifier_names
enum Team { WAS }

final teamValues = EnumValues({'WAS': Team.WAS});

// ignore: constant_identifier_names
enum PositionCategory { OFF, ST, DEF }

final positionCategoryValues = EnumValues({
  'DEF': PositionCategory.DEF,
  'OFF': PositionCategory.OFF,
  'ST': PositionCategory.ST
});

enum StatusEnum {
  // ignore: constant_identifier_names
  ACTIVE,
  // ignore: constant_identifier_names
  PHYSICALLY_UNABLE_TO_PERFORM,
  // ignore: constant_identifier_names
  INJURED_RESERVE,
  // ignore: constant_identifier_names
  DID_NOT_REPORT,
  // ignore: constant_identifier_names
  RESERVE_COVID_19
}

final statusEnumValues = EnumValues({
  'Active': StatusEnum.ACTIVE,
  'Did Not Report': StatusEnum.DID_NOT_REPORT,
  'Injured Reserve': StatusEnum.INJURED_RESERVE,
  'Physically Unable to Perform': StatusEnum.PHYSICALLY_UNABLE_TO_PERFORM,
  'Reserve/COVID-19': StatusEnum.RESERVE_COVID_19
});

// ignore: constant_identifier_names
enum UpcomingGameOpponent { CIN }

final upcomingGameOpponentValues =
    EnumValues({'CIN': UpcomingGameOpponent.CIN});

class EnumValues<T> {
  EnumValues(this.map);
  Map<String, T> map;
  Map<T, String>? reverseMap;

  Map<T, String>? get reverse {
    // ignore: join_return_with_assignment
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
