

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
      NcaabTeamStats.fromMap(json.decode(str) as Map<String, dynamic>);

  factory NcaabTeamStats.fromMap(Map<String, dynamic> json) => NcaabTeamStats(
        statId: json['StatID']?.toInt() as int?,
        teamId: json['TeamID']?.toInt() as int?,
        seasonType: json['SeasonType']?.toInt() as int?,
        season: json['Season']?.toInt() as int?,
        name: json['Name'] as String?,
        team: json['Team'] as String?,
        wins: json['Wins']?.toInt() as int?,
        losses: json['Losses']?.toInt() as int?,
        conferenceWins: json['ConferenceWins']?.toInt() as int?,
        conferenceLosses: json['ConferenceLosses']?.toInt() as int?,
        globalTeamId: json['GlobalTeamID']?.toInt() as int?,
        possessions: json['Possessions']?.toDouble() as double?,
        updated: DateTime.parse(json['Updated'] as String),
        games: json['Games']?.toInt() as int?,
        fantasyPoints: json['FantasyPoints']?.toDouble() as double?,
        minutes: json['Minutes']?.toInt() as int?,
        fieldGoalsMade: json['FieldGoalsMade']?.toInt() as int?,
        fieldGoalsAttempted: json['FieldGoalsAttempted']?.toInt() as int?,
        fieldGoalsPercentage:
            json['FieldGoalsPercentage']?.toDouble() as double?,
        effectiveFieldGoalsPercentage:
            json['EffectiveFieldGoalsPercentage']?.toDouble() as double?,
        twoPointersMade: json['TwoPointersMade']?.toInt() as int?,
        twoPointersAttempted: json['TwoPointersAttempted']?.toInt() as int?,
        twoPointersPercentage:
            json['TwoPointersPercentage']?.toDouble() as double?,
        threePointersMade: json['ThreePointersMade']?.toInt() as int?,
        threePointersAttempted: json['ThreePointersAttempted']?.toInt() as int?,
        threePointersPercentage:
            json['ThreePointersPercentage']?.toDouble() as double?,
        freeThrowsMade: json['FreeThrowsMade']?.toInt() as int?,
        freeThrowsAttempted: json['FreeThrowsAttempted']?.toInt() as int?,
        freeThrowsPercentage:
            json['FreeThrowsPercentage']?.toDouble() as double?,
        offensiveRebounds: json['OffensiveRebounds']?.toInt() as int?,
        defensiveRebounds: json['DefensiveRebounds']?.toInt() as int?,
        rebounds: json['Rebounds']?.toInt() as int?,
        offensiveReboundsPercentage:
            json['OffensiveReboundsPercentage']?.toInt() as int?,
        defensiveReboundsPercentage:
            json['DefensiveReboundsPercentage']?.toInt() as int?,
        totalReboundsPercentage:
            json['TotalReboundsPercentage']?.toInt() as int?,
        assists: json['Assists']?.toInt() as int?,
        steals: json['Steals']?.toInt() as int?,
        blockedShots: json['BlockedShots']?.toInt() as int?,
        turnovers: json['Turnovers']?.toInt() as int?,
        personalFouls: json['PersonalFouls']?.toInt() as int?,
        points: json['Points']?.toInt() as int?,
        trueShootingAttempts:
            json['TrueShootingAttempts']?.toDouble() as double?,
        trueShootingPercentage:
            json['TrueShootingPercentage']?.toDouble() as double?,
        playerEfficiencyRating: json['PlayerEfficiencyRating'],
        assistsPercentage: json['AssistsPercentage'],
        stealsPercentage: json['StealsPercentage'],
        blocksPercentage: json['BlocksPercentage'],
        turnOversPercentage: json['TurnOversPercentage'],
        usageRatePercentage: json['UsageRatePercentage'],
        fantasyPointsFanDuel:
            json['FantasyPointsFanDuel']?.toDouble() as double?,
        fantasyPointsDraftKings:
            json['FantasyPointsDraftKings']?.toDouble() as double?,
        fantasyPointsYahoo: json['FantasyPointsYahoo'],
      );

  final int? statId;
  final int? teamId;
  final int? seasonType;
  final int? season;
  final String? name;
  final String? team;
  final int? wins;
  final int? losses;
  final int? conferenceWins;
  final int? conferenceLosses;
  final int? globalTeamId;
  final double? possessions;
  final DateTime? updated;
  final int? games;
  final double? fantasyPoints;
  final int? minutes;
  final int? fieldGoalsMade;
  final int? fieldGoalsAttempted;
  final double? fieldGoalsPercentage;
  final double? effectiveFieldGoalsPercentage;
  final int? twoPointersMade;
  final int? twoPointersAttempted;
  final double? twoPointersPercentage;
  final int? threePointersMade;
  final int? threePointersAttempted;
  final double? threePointersPercentage;
  final int? freeThrowsMade;
  final int? freeThrowsAttempted;
  final double? freeThrowsPercentage;
  final int? offensiveRebounds;
  final int? defensiveRebounds;
  final int? rebounds;
  final dynamic offensiveReboundsPercentage;
  final dynamic defensiveReboundsPercentage;
  final dynamic totalReboundsPercentage;
  final int? assists;
  final int? steals;
  final int? blockedShots;
  final int? turnovers;
  final int? personalFouls;
  final int? points;
  final double? trueShootingAttempts;
  final double? trueShootingPercentage;
  final dynamic playerEfficiencyRating;
  final dynamic assistsPercentage;
  final dynamic stealsPercentage;
  final dynamic blocksPercentage;
  final dynamic turnOversPercentage;
  final dynamic usageRatePercentage;
  final double? fantasyPointsFanDuel;
  final double? fantasyPointsDraftKings;
  final dynamic fantasyPointsYahoo;

  NcaabTeamStats copyWith({
    int? statId,
    int? teamId,
    int? seasonType,
    int? season,
    String? name,
    String? team,
    int? wins,
    int? losses,
    int? conferenceWins,
    int? conferenceLosses,
    int? globalTeamId,
    double? possessions,
    DateTime? updated,
    int? games,
    double? fantasyPoints,
    int? minutes,
    int? fieldGoalsMade,
    int? fieldGoalsAttempted,
    double? fieldGoalsPercentage,
    double? effectiveFieldGoalsPercentage,
    int? twoPointersMade,
    int? twoPointersAttempted,
    double? twoPointersPercentage,
    int? threePointersMade,
    int? threePointersAttempted,
    double? threePointersPercentage,
    int? freeThrowsMade,
    int? freeThrowsAttempted,
    double? freeThrowsPercentage,
    int? offensiveRebounds,
    int? defensiveRebounds,
    int? rebounds,
    dynamic offensiveReboundsPercentage,
    dynamic defensiveReboundsPercentage,
    dynamic totalReboundsPercentage,
    int? assists,
    int? steals,
    int? blockedShots,
    int? turnovers,
    int? personalFouls,
    int? points,
    double? trueShootingAttempts,
    double? trueShootingPercentage,
    dynamic playerEfficiencyRating,
    dynamic assistsPercentage,
    dynamic stealsPercentage,
    dynamic blocksPercentage,
    dynamic turnOversPercentage,
    dynamic usageRatePercentage,
    double? fantasyPointsFanDuel,
    double? fantasyPointsDraftKings,
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

  Map<String, Object?> toMap() => {
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
        'Updated': updated!.toIso8601String(),
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

  Map<String, dynamic> toStatOnlyMap() => <String, dynamic>{
        'Minutes': minutes,
        'Field Goals Made': fieldGoalsMade,
        'Field Goals Attempted': fieldGoalsAttempted,
        'Field Goals Percentage': fieldGoalsPercentage,
        'Effective Field Goals Percentage': effectiveFieldGoalsPercentage,
        'Two Pointers Made': twoPointersMade,
        'Two Pointers Attempted': twoPointersAttempted,
        'Two Pointers Percentage': twoPointersPercentage,
        'Three Pointers Made': threePointersMade,
        'Three Pointers Attempted': threePointersAttempted,
        'Three Pointers Percentage': threePointersPercentage,
        'Free Throws Made': freeThrowsMade,
        'Free Throws Attempted': freeThrowsAttempted,
        'Free Throws Percentage': freeThrowsPercentage,
        'Offensive Rebounds': offensiveRebounds,
        'Defensive Rebounds': defensiveRebounds,
        'Rebounds': rebounds,
        'Offensive Rebounds Percentage': offensiveReboundsPercentage,
        'Defensive Rebounds Percentage': defensiveReboundsPercentage,
        'Total Rebounds Percentage': totalReboundsPercentage,
        'Assists': assists,
        'Steals': steals,
        'Blocked Shots': blockedShots,
        'Turnovers': turnovers,
        'Personal Fouls': personalFouls,
        'Points': points,
        'True Shooting Attempts': trueShootingAttempts,
        'True Shooting Percentage': trueShootingPercentage,
        'Player Efficiency Rating': playerEfficiencyRating,
        'Assists Percentage': assistsPercentage,
        'Steals Percentage': stealsPercentage,
        'Blocks Percentage': blocksPercentage,
        'Turn Overs Percentage': turnOversPercentage,
        'Usage Rate Percentage': usageRatePercentage,
        'Fantasy Points Fan Duel': fantasyPointsFanDuel,
        'Fantasy Points Draft Kings': fantasyPointsDraftKings,
        'Fantasy Points Yahoo': fantasyPointsYahoo,
      };
}
