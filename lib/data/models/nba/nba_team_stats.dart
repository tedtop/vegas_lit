import 'dart:convert';

class NbaTeamStats {
  NbaTeamStats({
    this.statId,
    this.teamId,
    this.seasonType,
    this.season,
    this.name,
    this.team,
    this.wins,
    this.losses,
    this.opponentPosition,
    this.possessions,
    this.globalTeamId,
    this.updated,
    this.games,
    this.fantasyPoints,
    this.minutes,
    this.seconds,
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
    this.plusMinus,
    this.doubleDoubles,
    this.tripleDoubles,
    this.fantasyPointsFantasyDraft,
    this.isClosed,
    this.lineupConfirmed,
    this.lineupStatus,
    this.opponentStat,
  });

  factory NbaTeamStats.fromJson(String str) =>
      NbaTeamStats.fromMap(json.decode(str));

  factory NbaTeamStats.fromMap(Map<String, dynamic> json) => NbaTeamStats(
        statId: json['StatID'].toInt(),
        teamId: json['TeamID'].toInt(),
        seasonType: json['SeasonType'].toInt(),
        season: json['Season'].toInt(),
        name: json['Name'],
        team: json['Team'],
        wins: json['Wins'].toInt(),
        losses: json['Losses'].toInt(),
        opponentPosition: json['OpponentPosition'],
        possessions: json['Possessions'].toDouble(),
        globalTeamId: json['GlobalTeamID'].toInt(),
        updated: DateTime.parse(json['Updated']),
        games: json['Games'].toInt(),
        fantasyPoints: json['FantasyPoints'].toDouble(),
        minutes: json['Minutes'].toInt(),
        seconds: json['Seconds'].toInt(),
        fieldGoalsMade: json['FieldGoalsMade'].toInt(),
        fieldGoalsAttempted: json['FieldGoalsAttempted'].toInt(),
        fieldGoalsPercentage: json['FieldGoalsPercentage'].toDouble(),
        effectiveFieldGoalsPercentage:
            json['EffectiveFieldGoalsPercentage'].toDouble(),
        twoPointersMade: json['TwoPointersMade'].toInt(),
        twoPointersAttempted: json['TwoPointersAttempted'].toInt(),
        twoPointersPercentage: json['TwoPointersPercentage'].toDouble(),
        threePointersMade: json['ThreePointersMade'].toInt(),
        threePointersAttempted: json['ThreePointersAttempted'].toInt(),
        threePointersPercentage: json['ThreePointersPercentage'].toDouble(),
        freeThrowsMade: json['FreeThrowsMade'].toInt(),
        freeThrowsAttempted: json['FreeThrowsAttempted'].toInt(),
        freeThrowsPercentage: json['FreeThrowsPercentage'].toDouble(),
        offensiveRebounds: json['OffensiveRebounds'].toInt(),
        defensiveRebounds: json['DefensiveRebounds'].toInt(),
        rebounds: json['Rebounds'].toInt(),
        offensiveReboundsPercentage: json['OffensiveReboundsPercentage'],
        defensiveReboundsPercentage: json['DefensiveReboundsPercentage'],
        totalReboundsPercentage: json['TotalReboundsPercentage'],
        assists: json['Assists'].toInt(),
        steals: json['Steals'].toInt(),
        blockedShots: json['BlockedShots'].toInt(),
        turnovers: json['Turnovers'].toInt(),
        personalFouls: json['PersonalFouls'].toInt(),
        points: json['Points'].toInt(),
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
        fantasyPointsYahoo: json['FantasyPointsYahoo'].toDouble(),
        plusMinus: json['PlusMinus'].toInt(),
        doubleDoubles: json['DoubleDoubles'].toInt(),
        tripleDoubles: json['TripleDoubles'].toInt(),
        fantasyPointsFantasyDraft: json['FantasyPointsFantasyDraft'].toDouble(),
        isClosed: json['IsClosed'],
        lineupConfirmed: json['LineupConfirmed'],
        lineupStatus: json['LineupStatus'],
        opponentStat: json['OpponentStat'] == null
            ? null
            : NbaTeamStats.fromMap(json['OpponentStat']),
      );

  final int statId;
  final int teamId;
  final int seasonType;
  final int season;
  final String name;
  final String team;
  final int wins;
  final int losses;
  final dynamic opponentPosition;
  final double possessions;
  final int globalTeamId;
  final DateTime updated;
  final int games;
  final double fantasyPoints;
  final int minutes;
  final int seconds;
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
  final double fantasyPointsYahoo;
  final int plusMinus;
  final int doubleDoubles;
  final int tripleDoubles;
  final double fantasyPointsFantasyDraft;
  final bool isClosed;
  final dynamic lineupConfirmed;
  final dynamic lineupStatus;
  final NbaTeamStats opponentStat;

  NbaTeamStats copyWith({
    int statId,
    int teamId,
    int seasonType,
    int season,
    String name,
    String team,
    int wins,
    int losses,
    dynamic opponentPosition,
    double possessions,
    int globalTeamId,
    DateTime updated,
    int games,
    double fantasyPoints,
    int minutes,
    int seconds,
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
    double fantasyPointsYahoo,
    int plusMinus,
    int doubleDoubles,
    int tripleDoubles,
    double fantasyPointsFantasyDraft,
    bool isClosed,
    dynamic lineupConfirmed,
    dynamic lineupStatus,
    NbaTeamStats opponentStat,
  }) =>
      NbaTeamStats(
        statId: statId ?? this.statId,
        teamId: teamId ?? this.teamId,
        seasonType: seasonType ?? this.seasonType,
        season: season ?? this.season,
        name: name ?? this.name,
        team: team ?? this.team,
        wins: wins ?? this.wins,
        losses: losses ?? this.losses,
        opponentPosition: opponentPosition ?? this.opponentPosition,
        possessions: possessions ?? this.possessions,
        globalTeamId: globalTeamId ?? this.globalTeamId,
        updated: updated ?? this.updated,
        games: games ?? this.games,
        fantasyPoints: fantasyPoints ?? this.fantasyPoints,
        minutes: minutes ?? this.minutes,
        seconds: seconds ?? this.seconds,
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
        plusMinus: plusMinus ?? this.plusMinus,
        doubleDoubles: doubleDoubles ?? this.doubleDoubles,
        tripleDoubles: tripleDoubles ?? this.tripleDoubles,
        fantasyPointsFantasyDraft:
            fantasyPointsFantasyDraft ?? this.fantasyPointsFantasyDraft,
        isClosed: isClosed ?? this.isClosed,
        lineupConfirmed: lineupConfirmed ?? this.lineupConfirmed,
        lineupStatus: lineupStatus ?? this.lineupStatus,
        opponentStat: opponentStat ?? this.opponentStat,
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
        'OpponentPosition': opponentPosition,
        'Possessions': possessions,
        'GlobalTeamID': globalTeamId,
        'Updated': updated.toIso8601String(),
        'Games': games,
        'FantasyPoints': fantasyPoints,
        'Minutes': minutes,
        'Seconds': seconds,
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
        'PlusMinus': plusMinus,
        'DoubleDoubles': doubleDoubles,
        'TripleDoubles': tripleDoubles,
        'FantasyPointsFantasyDraft': fantasyPointsFantasyDraft,
        'IsClosed': isClosed,
        'LineupConfirmed': lineupConfirmed,
        'LineupStatus': lineupStatus,
        'OpponentStat': opponentStat == null ? null : opponentStat.toMap(),
      };

  Map<String, dynamic> toStatOnlyMap() => {
        'Minutes': minutes,
        'Seconds': seconds,
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
        'Plus Minus': plusMinus,
        'Double Doubles': doubleDoubles,
        'Triple Doubles': tripleDoubles,
        'Fantasy Points Fantasy Draft': fantasyPointsFantasyDraft,
        'Is Closed': isClosed,
        'Lineup Confirmed': lineupConfirmed,
        'Lineup Status': lineupStatus,
      };
}
