import 'dart:convert';

class NhlTeamStats {
  NhlTeamStats({
    this.statId,
    this.teamId,
    this.seasonType,
    this.season,
    this.name,
    this.team,
    this.wins,
    this.losses,
    this.overtimeLosses,
    this.opponentPosition,
    this.globalTeamId,
    this.updated,
    this.games,
    this.fantasyPoints,
    this.fantasyPointsFanDuel,
    this.fantasyPointsDraftKings,
    this.fantasyPointsYahoo,
    this.minutes,
    this.seconds,
    this.goals,
    this.assists,
    this.shotsOnGoal,
    this.powerPlayGoals,
    this.shortHandedGoals,
    this.emptyNetGoals,
    this.powerPlayAssists,
    this.shortHandedAssists,
    this.hatTricks,
    this.shootoutGoals,
    this.plusMinus,
    this.penaltyMinutes,
    this.blocks,
    this.hits,
    this.takeaways,
    this.giveaways,
    this.faceoffsWon,
    this.faceoffsLost,
    this.shifts,
    this.goaltendingMinutes,
    this.goaltendingSeconds,
    this.goaltendingShotsAgainst,
    this.goaltendingGoalsAgainst,
    this.goaltendingSaves,
    this.goaltendingWins,
    this.goaltendingLosses,
    this.goaltendingShutouts,
    this.started,
    this.benchPenaltyMinutes,
    this.goaltendingOvertimeLosses,
    this.fantasyPointsFantasyDraft,
    this.opponentStat,
  });

  factory NhlTeamStats.fromJson(String str) =>
      NhlTeamStats.fromMap(json.decode(str) as Map<String, dynamic>);
  factory NhlTeamStats.fromMap(Map<String, dynamic> json) => NhlTeamStats(
        statId: json['StatID']?.toInt() as int,
        teamId: json['TeamID']?.toInt() as int,
        seasonType: json['SeasonType']?.toInt() as int,
        season: json['Season']?.toInt() as int,
        name: json['Name'] as String,
        team: json['Team'] as String,
        wins: json['Wins']?.toInt() as int,
        losses: json['Losses']?.toInt() as int,
        overtimeLosses: json['OvertimeLosses']?.toInt() as int,
        opponentPosition: json['OpponentPosition'],
        globalTeamId: json['GlobalTeamID']?.toInt() as int,
        updated: DateTime.parse(json['Updated'] as String),
        games: json['Games']?.toInt() as int,
        fantasyPoints: json['FantasyPoints']?.toDouble() as double,
        fantasyPointsFanDuel:
            json['FantasyPointsFanDuel']?.toDouble() as double,
        fantasyPointsDraftKings:
            json['FantasyPointsDraftKings']?.toDouble() as double,
        fantasyPointsYahoo: json['FantasyPointsYahoo']?.toDouble() as double,
        minutes: json['Minutes']?.toInt() as int,
        seconds: json['Seconds']?.toInt() as int,
        goals: json['Goals']?.toInt() as int,
        assists: json['Assists']?.toInt() as int,
        shotsOnGoal: json['ShotsOnGoal']?.toInt() as int,
        powerPlayGoals: json['PowerPlayGoals']?.toInt() as int,
        shortHandedGoals: json['ShortHandedGoals']?.toInt() as int,
        emptyNetGoals: json['EmptyNetGoals']?.toInt() as int,
        powerPlayAssists: json['PowerPlayAssists']?.toInt() as int,
        shortHandedAssists: json['ShortHandedAssists']?.toInt() as int,
        hatTricks: json['HatTricks']?.toInt() as int,
        shootoutGoals: json['ShootoutGoals']?.toInt() as int,
        plusMinus: json['PlusMinus']?.toInt() as int,
        penaltyMinutes: json['PenaltyMinutes']?.toInt() as int,
        blocks: json['Blocks']?.toInt() as int,
        hits: json['Hits']?.toInt() as int,
        takeaways: json['Takeaways']?.toInt() as int,
        giveaways: json['Giveaways']?.toInt() as int,
        faceoffsWon: json['FaceoffsWon']?.toInt() as int,
        faceoffsLost: json['FaceoffsLost']?.toInt() as int,
        shifts: json['Shifts']?.toInt() as int,
        goaltendingMinutes: json['GoaltendingMinutes']?.toInt() as int,
        goaltendingSeconds: json['GoaltendingSeconds']?.toInt() as int,
        goaltendingShotsAgainst:
            json['GoaltendingShotsAgainst']?.toInt() as int,
        goaltendingGoalsAgainst:
            json['GoaltendingGoalsAgainst']?.toInt() as int,
        goaltendingSaves: json['GoaltendingSaves']?.toInt() as int,
        goaltendingWins: json['GoaltendingWins']?.toInt() as int,
        goaltendingLosses: json['GoaltendingLosses']?.toInt() as int,
        goaltendingShutouts: json['GoaltendingShutouts']?.toInt() as int,
        started: json['Started'],
        benchPenaltyMinutes: json['BenchPenaltyMinutes']?.toInt() as int,
        goaltendingOvertimeLosses:
            json['GoaltendingOvertimeLosses']?.toInt() as int,
        fantasyPointsFantasyDraft:
            json['FantasyPointsFantasyDraft']?.toDouble() as double,
        opponentStat: json['OpponentStat'] == null
            ? null
            : NhlTeamStats.fromMap(
                json['OpponentStat'] as Map<String, dynamic>),
      );

  final int statId;
  final int teamId;
  final int seasonType;
  final int season;
  final String name;
  final String team;
  final int wins;
  final int losses;
  final int overtimeLosses;
  final dynamic opponentPosition;
  final int globalTeamId;
  final DateTime updated;
  final int games;
  final double fantasyPoints;
  final double fantasyPointsFanDuel;
  final double fantasyPointsDraftKings;
  final double fantasyPointsYahoo;
  final int minutes;
  final int seconds;
  final int goals;
  final int assists;
  final int shotsOnGoal;
  final int powerPlayGoals;
  final int shortHandedGoals;
  final int emptyNetGoals;
  final int powerPlayAssists;
  final int shortHandedAssists;
  final int hatTricks;
  final int shootoutGoals;
  final int plusMinus;
  final int penaltyMinutes;
  final int blocks;
  final int hits;
  final int takeaways;
  final int giveaways;
  final int faceoffsWon;
  final int faceoffsLost;
  final int shifts;
  final int goaltendingMinutes;
  final int goaltendingSeconds;
  final int goaltendingShotsAgainst;
  final int goaltendingGoalsAgainst;
  final int goaltendingSaves;
  final int goaltendingWins;
  final int goaltendingLosses;
  final int goaltendingShutouts;
  final dynamic started;
  final int benchPenaltyMinutes;
  final int goaltendingOvertimeLosses;
  final double fantasyPointsFantasyDraft;
  final NhlTeamStats opponentStat;

  NhlTeamStats copyWith({
    int statId,
    int teamId,
    int seasonType,
    int season,
    String name,
    String team,
    int wins,
    int losses,
    int overtimeLosses,
    dynamic opponentPosition,
    int globalTeamId,
    DateTime updated,
    int games,
    double fantasyPoints,
    double fantasyPointsFanDuel,
    double fantasyPointsDraftKings,
    double fantasyPointsYahoo,
    int minutes,
    int seconds,
    int goals,
    int assists,
    int shotsOnGoal,
    int powerPlayGoals,
    int shortHandedGoals,
    int emptyNetGoals,
    int powerPlayAssists,
    int shortHandedAssists,
    int hatTricks,
    int shootoutGoals,
    int plusMinus,
    int penaltyMinutes,
    int blocks,
    int hits,
    int takeaways,
    int giveaways,
    int faceoffsWon,
    int faceoffsLost,
    int shifts,
    int goaltendingMinutes,
    int goaltendingSeconds,
    int goaltendingShotsAgainst,
    int goaltendingGoalsAgainst,
    int goaltendingSaves,
    int goaltendingWins,
    int goaltendingLosses,
    int goaltendingShutouts,
    dynamic started,
    int benchPenaltyMinutes,
    int goaltendingOvertimeLosses,
    double fantasyPointsFantasyDraft,
    NhlTeamStats opponentStat,
  }) =>
      NhlTeamStats(
        statId: statId ?? this.statId,
        teamId: teamId ?? this.teamId,
        seasonType: seasonType ?? this.seasonType,
        season: season ?? this.season,
        name: name ?? this.name,
        team: team ?? this.team,
        wins: wins ?? this.wins,
        losses: losses ?? this.losses,
        overtimeLosses: overtimeLosses ?? this.overtimeLosses,
        opponentPosition: opponentPosition ?? this.opponentPosition,
        globalTeamId: globalTeamId ?? this.globalTeamId,
        updated: updated ?? this.updated,
        games: games ?? this.games,
        fantasyPoints: fantasyPoints ?? this.fantasyPoints,
        fantasyPointsFanDuel: fantasyPointsFanDuel ?? this.fantasyPointsFanDuel,
        fantasyPointsDraftKings:
            fantasyPointsDraftKings ?? this.fantasyPointsDraftKings,
        fantasyPointsYahoo: fantasyPointsYahoo ?? this.fantasyPointsYahoo,
        minutes: minutes ?? this.minutes,
        seconds: seconds ?? this.seconds,
        goals: goals ?? this.goals,
        assists: assists ?? this.assists,
        shotsOnGoal: shotsOnGoal ?? this.shotsOnGoal,
        powerPlayGoals: powerPlayGoals ?? this.powerPlayGoals,
        shortHandedGoals: shortHandedGoals ?? this.shortHandedGoals,
        emptyNetGoals: emptyNetGoals ?? this.emptyNetGoals,
        powerPlayAssists: powerPlayAssists ?? this.powerPlayAssists,
        shortHandedAssists: shortHandedAssists ?? this.shortHandedAssists,
        hatTricks: hatTricks ?? this.hatTricks,
        shootoutGoals: shootoutGoals ?? this.shootoutGoals,
        plusMinus: plusMinus ?? this.plusMinus,
        penaltyMinutes: penaltyMinutes ?? this.penaltyMinutes,
        blocks: blocks ?? this.blocks,
        hits: hits ?? this.hits,
        takeaways: takeaways ?? this.takeaways,
        giveaways: giveaways ?? this.giveaways,
        faceoffsWon: faceoffsWon ?? this.faceoffsWon,
        faceoffsLost: faceoffsLost ?? this.faceoffsLost,
        shifts: shifts ?? this.shifts,
        goaltendingMinutes: goaltendingMinutes ?? this.goaltendingMinutes,
        goaltendingSeconds: goaltendingSeconds ?? this.goaltendingSeconds,
        goaltendingShotsAgainst:
            goaltendingShotsAgainst ?? this.goaltendingShotsAgainst,
        goaltendingGoalsAgainst:
            goaltendingGoalsAgainst ?? this.goaltendingGoalsAgainst,
        goaltendingSaves: goaltendingSaves ?? this.goaltendingSaves,
        goaltendingWins: goaltendingWins ?? this.goaltendingWins,
        goaltendingLosses: goaltendingLosses ?? this.goaltendingLosses,
        goaltendingShutouts: goaltendingShutouts ?? this.goaltendingShutouts,
        started: started ?? this.started,
        benchPenaltyMinutes: benchPenaltyMinutes ?? this.benchPenaltyMinutes,
        goaltendingOvertimeLosses:
            goaltendingOvertimeLosses ?? this.goaltendingOvertimeLosses,
        fantasyPointsFantasyDraft:
            fantasyPointsFantasyDraft ?? this.fantasyPointsFantasyDraft,
        opponentStat: opponentStat ?? this.opponentStat,
      );

  String toJson() => json.encode(toMap());

  Map<String, Object> toMap() => {
        'StatID': statId,
        'TeamID': teamId,
        'SeasonType': seasonType,
        'Season': season,
        'Name': name,
        'Team': team,
        'Wins': wins,
        'Losses': losses,
        'OvertimeLosses': overtimeLosses,
        'OpponentPosition': opponentPosition,
        'GlobalTeamID': globalTeamId,
        'Updated': updated.toIso8601String(),
        'Games': games,
        'FantasyPoints': fantasyPoints,
        'FantasyPointsFanDuel': fantasyPointsFanDuel,
        'FantasyPointsDraftKings': fantasyPointsDraftKings,
        'FantasyPointsYahoo': fantasyPointsYahoo,
        'Minutes': minutes,
        'Seconds': seconds,
        'Goals': goals,
        'Assists': assists,
        'ShotsOnGoal': shotsOnGoal,
        'PowerPlayGoals': powerPlayGoals,
        'ShortHandedGoals': shortHandedGoals,
        'EmptyNetGoals': emptyNetGoals,
        'PowerPlayAssists': powerPlayAssists,
        'ShortHandedAssists': shortHandedAssists,
        'HatTricks': hatTricks,
        'ShootoutGoals': shootoutGoals,
        'PlusMinus': plusMinus,
        'PenaltyMinutes': penaltyMinutes,
        'Blocks': blocks,
        'Hits': hits,
        'Takeaways': takeaways,
        'Giveaways': giveaways,
        'FaceoffsWon': faceoffsWon,
        'FaceoffsLost': faceoffsLost,
        'Shifts': shifts,
        'GoaltendingMinutes': goaltendingMinutes,
        'GoaltendingSeconds': goaltendingSeconds,
        'GoaltendingShotsAgainst': goaltendingShotsAgainst,
        'GoaltendingGoalsAgainst': goaltendingGoalsAgainst,
        'GoaltendingSaves': goaltendingSaves,
        'GoaltendingWins': goaltendingWins,
        'GoaltendingLosses': goaltendingLosses,
        'GoaltendingShutouts': goaltendingShutouts,
        'Started': started,
        'BenchPenaltyMinutes': benchPenaltyMinutes,
        'GoaltendingOvertimeLosses': goaltendingOvertimeLosses,
        'FantasyPointsFantasyDraft': fantasyPointsFantasyDraft,
        'OpponentStat': opponentStat?.toMap(),
      };

  Map<String, Object> toStatOnlyMap() => {
        'Overtime Losses': overtimeLosses,
        'Opponent Position': opponentPosition,
        'Fantasy Points Fan Duel': fantasyPointsFanDuel,
        'Fantasy Points Draft Kings': fantasyPointsDraftKings,
        'Fantasy Points Yahoo': fantasyPointsYahoo,
        'Minutes': minutes,
        'Seconds': seconds,
        'Goals': goals,
        'Assists': assists,
        'Shots On Goal': shotsOnGoal,
        'Power Play Goals': powerPlayGoals,
        'Short Handed Goals': shortHandedGoals,
        'Empty Net Goals': emptyNetGoals,
        'Power Play Assists': powerPlayAssists,
        'Short Handed Assists': shortHandedAssists,
        'Hat Tricks': hatTricks,
        'Shootout Goals': shootoutGoals,
        'Plus Minus': plusMinus,
        'Penalty Minutes': penaltyMinutes,
        'Blocks': blocks,
        'Hits': hits,
        'Takeaways': takeaways,
        'Giveaways': giveaways,
        'Faceoffs Won': faceoffsWon,
        'Faceoffs Lost': faceoffsLost,
        'Shifts': shifts,
        'Goaltending Minutes': goaltendingMinutes,
        'Goaltending Seconds': goaltendingSeconds,
        'Goaltending Shots Against': goaltendingShotsAgainst,
        'Goaltending Goals Against': goaltendingGoalsAgainst,
        'Goaltending Saves': goaltendingSaves,
        'Goaltending Wins': goaltendingWins,
        'Goaltending Losses': goaltendingLosses,
        'Goaltending Shutouts': goaltendingShutouts,
        'Started': started,
        'Bench Penalty Minutes': benchPenaltyMinutes,
        'Goaltending Overtime Losses': goaltendingOvertimeLosses,
        'Fantasy Points Fantasy Draft': fantasyPointsFantasyDraft,
      };
}
