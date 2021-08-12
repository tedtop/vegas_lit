import 'dart:convert';

class NcaabTeamStats {
  NcaabTeamStats({
    this.statId,
    this.teamId,
    this.seasonType,
    this.season,
    this.name,
    this.team,
    this.wins,
    this.losses,
    this.conferenceWins,
    this.conferenceLosses,
    this.globalTeamId,
    this.possessions,
    this.updated,
    this.games,
    this.fantasyPoints,
    this.minutes,
    this.fieldGoalsMade,
    this.fieldGoalsAttempted,
    this.fieldGoalsPercentage,
    this.effectiveFieldGoalsPercentage,
    this.twoPointersMade,
    this.twoPointersAttempted,
    this.twoPointersPercentage,
    this.threePointersMade,
    this.threePointersAttempted,
    this.threePointersPercentage,
    this.freeThrowsMade,
    this.freeThrowsAttempted,
    this.freeThrowsPercentage,
    this.offensiveRebounds,
    this.defensiveRebounds,
    this.rebounds,
    this.offensiveReboundsPercentage,
    this.defensiveReboundsPercentage,
    this.totalReboundsPercentage,
    this.assists,
    this.steals,
    this.blockedShots,
    this.turnovers,
    this.personalFouls,
    this.points,
    this.trueShootingAttempts,
    this.trueShootingPercentage,
    this.playerEfficiencyRating,
    this.assistsPercentage,
    this.stealsPercentage,
    this.blocksPercentage,
    this.turnOversPercentage,
    this.usageRatePercentage,
    this.fantasyPointsFanDuel,
    this.fantasyPointsDraftKings,
    this.fantasyPointsYahoo,
  });

  factory NcaabTeamStats.fromJson(String str) =>
      NcaabTeamStats.fromMap(json.decode(str));

  factory NcaabTeamStats.fromMap(Map<String, dynamic> json) => NcaabTeamStats(
        statId: json['StatID'],
        teamId: json['TeamID'],
        seasonType: json['SeasonType'],
        season: json['Season'],
        name: json['Name'],
        team: json['Team'],
        wins: json['Wins'],
        losses: json['Losses'],
        conferenceWins: json['ConferenceWins'],
        conferenceLosses: json['ConferenceLosses'],
        globalTeamId: json['GlobalTeamID'],
        possessions: json['Possessions'].toDouble(),
        updated: DateTime.parse(json['Updated']),
        games: json['Games'],
        fantasyPoints: json['FantasyPoints'].toDouble(),
        minutes: json['Minutes'],
        fieldGoalsMade: json['FieldGoalsMade'],
        fieldGoalsAttempted: json['FieldGoalsAttempted'],
        fieldGoalsPercentage: json['FieldGoalsPercentage'].toDouble(),
        effectiveFieldGoalsPercentage:
            json['EffectiveFieldGoalsPercentage'].toDouble(),
        twoPointersMade: json['TwoPointersMade'],
        twoPointersAttempted: json['TwoPointersAttempted'],
        twoPointersPercentage: json['TwoPointersPercentage'].toDouble(),
        threePointersMade: json['ThreePointersMade'],
        threePointersAttempted: json['ThreePointersAttempted'],
        threePointersPercentage: json['ThreePointersPercentage'].toDouble(),
        freeThrowsMade: json['FreeThrowsMade'],
        freeThrowsAttempted: json['FreeThrowsAttempted'],
        freeThrowsPercentage: json['FreeThrowsPercentage'].toDouble(),
        offensiveRebounds: json['OffensiveRebounds'],
        defensiveRebounds: json['DefensiveRebounds'],
        rebounds: json['Rebounds'],
        offensiveReboundsPercentage: json['OffensiveReboundsPercentage'],
        defensiveReboundsPercentage: json['DefensiveReboundsPercentage'],
        totalReboundsPercentage: json['TotalReboundsPercentage'],
        assists: json['Assists'],
        steals: json['Steals'],
        blockedShots: json['BlockedShots'],
        turnovers: json['Turnovers'],
        personalFouls: json['PersonalFouls'],
        points: json['Points'],
        trueShootingAttempts: json['TrueShootingAttempts'].toDouble(),
        trueShootingPercentage: json['TrueShootingPercentage'].toDouble(),
        playerEfficiencyRating: json['PlayerEfficiencyRating'],
        assistsPercentage: json['AssistsPercentage'],
        stealsPercentage: json['StealsPercentage'],
        blocksPercentage: json['BlocksPercentage'],
        turnOversPercentage: json['TurnOversPercentage'],
        usageRatePercentage: json['UsageRatePercentage'],
        fantasyPointsFanDuel: json['FantasyPointsFanDuel'].toDouble(),
        fantasyPointsDraftKings: json['FantasyPointsDraftKings'].toDouble(),
        fantasyPointsYahoo: json['FantasyPointsYahoo'],
      );

  final int statId;
  final int teamId;
  final int seasonType;
  final int season;
  final String name;
  final String team;
  final int wins;
  final int losses;
  final int conferenceWins;
  final int conferenceLosses;
  final int globalTeamId;
  final double possessions;
  final DateTime updated;
  final int games;
  final double fantasyPoints;
  final int minutes;
  final int fieldGoalsMade;
  final int fieldGoalsAttempted;
  final double fieldGoalsPercentage;
  final double effectiveFieldGoalsPercentage;
  final int twoPointersMade;
  final int twoPointersAttempted;
  final double twoPointersPercentage;
  final int threePointersMade;
  final int threePointersAttempted;
  final double threePointersPercentage;
  final int freeThrowsMade;
  final int freeThrowsAttempted;
  final double freeThrowsPercentage;
  final int offensiveRebounds;
  final int defensiveRebounds;
  final int rebounds;
  final dynamic offensiveReboundsPercentage;
  final dynamic defensiveReboundsPercentage;
  final dynamic totalReboundsPercentage;
  final int assists;
  final int steals;
  final int blockedShots;
  final int turnovers;
  final int personalFouls;
  final int points;
  final double trueShootingAttempts;
  final double trueShootingPercentage;
  final dynamic playerEfficiencyRating;
  final dynamic assistsPercentage;
  final dynamic stealsPercentage;
  final dynamic blocksPercentage;
  final dynamic turnOversPercentage;
  final dynamic usageRatePercentage;
  final double fantasyPointsFanDuel;
  final double fantasyPointsDraftKings;
  final dynamic fantasyPointsYahoo;

  NcaabTeamStats copyWith({
    int statId,
    int teamId,
    int seasonType,
    int season,
    String name,
    String team,
    int wins,
    int losses,
    int conferenceWins,
    int conferenceLosses,
    int globalTeamId,
    double possessions,
    DateTime updated,
    int games,
    double fantasyPoints,
    int minutes,
    int fieldGoalsMade,
    int fieldGoalsAttempted,
    double fieldGoalsPercentage,
    double effectiveFieldGoalsPercentage,
    int twoPointersMade,
    int twoPointersAttempted,
    double twoPointersPercentage,
    int threePointersMade,
    int threePointersAttempted,
    double threePointersPercentage,
    int freeThrowsMade,
    int freeThrowsAttempted,
    double freeThrowsPercentage,
    int offensiveRebounds,
    int defensiveRebounds,
    int rebounds,
    dynamic offensiveReboundsPercentage,
    dynamic defensiveReboundsPercentage,
    dynamic totalReboundsPercentage,
    int assists,
    int steals,
    int blockedShots,
    int turnovers,
    int personalFouls,
    int points,
    double trueShootingAttempts,
    double trueShootingPercentage,
    dynamic playerEfficiencyRating,
    dynamic assistsPercentage,
    dynamic stealsPercentage,
    dynamic blocksPercentage,
    dynamic turnOversPercentage,
    dynamic usageRatePercentage,
    double fantasyPointsFanDuel,
    double fantasyPointsDraftKings,
    dynamic fantasyPointsYahoo,
  }) =>
      NcaabTeamStats(
        statId: statId ?? this.statId,
        teamId: teamId ?? this.teamId,
        seasonType: seasonType ?? this.seasonType,
        season: season ?? this.season,
        name: name ?? this.name,
        team: team ?? this.team,
        wins: wins ?? this.wins,
        losses: losses ?? this.losses,
        conferenceWins: conferenceWins ?? this.conferenceWins,
        conferenceLosses: conferenceLosses ?? this.conferenceLosses,
        globalTeamId: globalTeamId ?? this.globalTeamId,
        possessions: possessions ?? this.possessions,
        updated: updated ?? this.updated,
        games: games ?? this.games,
        fantasyPoints: fantasyPoints ?? this.fantasyPoints,
        minutes: minutes ?? this.minutes,
        fieldGoalsMade: fieldGoalsMade ?? this.fieldGoalsMade,
        fieldGoalsAttempted: fieldGoalsAttempted ?? this.fieldGoalsAttempted,
        fieldGoalsPercentage: fieldGoalsPercentage ?? this.fieldGoalsPercentage,
        effectiveFieldGoalsPercentage:
            effectiveFieldGoalsPercentage ?? this.effectiveFieldGoalsPercentage,
        twoPointersMade: twoPointersMade ?? this.twoPointersMade,
        twoPointersAttempted: twoPointersAttempted ?? this.twoPointersAttempted,
        twoPointersPercentage:
            twoPointersPercentage ?? this.twoPointersPercentage,
        threePointersMade: threePointersMade ?? this.threePointersMade,
        threePointersAttempted:
            threePointersAttempted ?? this.threePointersAttempted,
        threePointersPercentage:
            threePointersPercentage ?? this.threePointersPercentage,
        freeThrowsMade: freeThrowsMade ?? this.freeThrowsMade,
        freeThrowsAttempted: freeThrowsAttempted ?? this.freeThrowsAttempted,
        freeThrowsPercentage: freeThrowsPercentage ?? this.freeThrowsPercentage,
        offensiveRebounds: offensiveRebounds ?? this.offensiveRebounds,
        defensiveRebounds: defensiveRebounds ?? this.defensiveRebounds,
        rebounds: rebounds ?? this.rebounds,
        offensiveReboundsPercentage:
            offensiveReboundsPercentage ?? this.offensiveReboundsPercentage,
        defensiveReboundsPercentage:
            defensiveReboundsPercentage ?? this.defensiveReboundsPercentage,
        totalReboundsPercentage:
            totalReboundsPercentage ?? this.totalReboundsPercentage,
        assists: assists ?? this.assists,
        steals: steals ?? this.steals,
        blockedShots: blockedShots ?? this.blockedShots,
        turnovers: turnovers ?? this.turnovers,
        personalFouls: personalFouls ?? this.personalFouls,
        points: points ?? this.points,
        trueShootingAttempts: trueShootingAttempts ?? this.trueShootingAttempts,
        trueShootingPercentage:
            trueShootingPercentage ?? this.trueShootingPercentage,
        playerEfficiencyRating:
            playerEfficiencyRating ?? this.playerEfficiencyRating,
        assistsPercentage: assistsPercentage ?? this.assistsPercentage,
        stealsPercentage: stealsPercentage ?? this.stealsPercentage,
        blocksPercentage: blocksPercentage ?? this.blocksPercentage,
        turnOversPercentage: turnOversPercentage ?? this.turnOversPercentage,
        usageRatePercentage: usageRatePercentage ?? this.usageRatePercentage,
        fantasyPointsFanDuel: fantasyPointsFanDuel ?? this.fantasyPointsFanDuel,
        fantasyPointsDraftKings:
            fantasyPointsDraftKings ?? this.fantasyPointsDraftKings,
        fantasyPointsYahoo: fantasyPointsYahoo ?? this.fantasyPointsYahoo,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'StatID': statId,
        'TeamID': teamId,
        'SeasonType': seasonType,
        'Season': season,
        'Name': name,
        'Team': team,
        'Wins': wins,
        'Losses': losses,
        'ConferenceWins': conferenceWins,
        'ConferenceLosses': conferenceLosses,
        'GlobalTeamID': globalTeamId,
        'Possessions': possessions,
        'Updated': updated.toIso8601String(),
        'Games': games,
        'FantasyPoints': fantasyPoints,
        'Minutes': minutes,
        'FieldGoalsMade': fieldGoalsMade,
        'FieldGoalsAttempted': fieldGoalsAttempted,
        'FieldGoalsPercentage': fieldGoalsPercentage,
        'EffectiveFieldGoalsPercentage': effectiveFieldGoalsPercentage,
        'TwoPointersMade': twoPointersMade,
        'TwoPointersAttempted': twoPointersAttempted,
        'TwoPointersPercentage': twoPointersPercentage,
        'ThreePointersMade': threePointersMade,
        'ThreePointersAttempted': threePointersAttempted,
        'ThreePointersPercentage': threePointersPercentage,
        'FreeThrowsMade': freeThrowsMade,
        'FreeThrowsAttempted': freeThrowsAttempted,
        'FreeThrowsPercentage': freeThrowsPercentage,
        'OffensiveRebounds': offensiveRebounds,
        'DefensiveRebounds': defensiveRebounds,
        'Rebounds': rebounds,
        'OffensiveReboundsPercentage': offensiveReboundsPercentage,
        'DefensiveReboundsPercentage': defensiveReboundsPercentage,
        'TotalReboundsPercentage': totalReboundsPercentage,
        'Assists': assists,
        'Steals': steals,
        'BlockedShots': blockedShots,
        'Turnovers': turnovers,
        'PersonalFouls': personalFouls,
        'Points': points,
        'TrueShootingAttempts': trueShootingAttempts,
        'TrueShootingPercentage': trueShootingPercentage,
        'PlayerEfficiencyRating': playerEfficiencyRating,
        'AssistsPercentage': assistsPercentage,
        'StealsPercentage': stealsPercentage,
        'BlocksPercentage': blocksPercentage,
        'TurnOversPercentage': turnOversPercentage,
        'UsageRatePercentage': usageRatePercentage,
        'FantasyPointsFanDuel': fantasyPointsFanDuel,
        'FantasyPointsDraftKings': fantasyPointsDraftKings,
        'FantasyPointsYahoo': fantasyPointsYahoo,
      };
}
