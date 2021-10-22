import 'dart:convert';

class MlbTeamStats {
  MlbTeamStats({
    this.statId,
    this.teamId,
    this.seasonType,
    this.season,
    this.name,
    this.team,
    this.globalTeamId,
    this.updated,
    this.games,
    this.fantasyPoints,
    this.atBats,
    this.runs,
    this.hits,
    this.singles,
    this.doubles,
    this.triples,
    this.homeRuns,
    this.runsBattedIn,
    this.battingAverage,
    this.outs,
    this.strikeouts,
    this.walks,
    this.hitByPitch,
    this.sacrifices,
    this.sacrificeFlies,
    this.groundIntoDoublePlay,
    this.stolenBases,
    this.caughtStealing,
    this.pitchesSeen,
    this.onBasePercentage,
    this.sluggingPercentage,
    this.onBasePlusSlugging,
    this.errors,
    this.wins,
    this.losses,
    this.saves,
    this.inningsPitchedDecimal,
    this.totalOutsPitched,
    this.inningsPitchedFull,
    this.inningsPitchedOuts,
    this.earnedRunAverage,
    this.pitchingHits,
    this.pitchingRuns,
    this.pitchingEarnedRuns,
    this.pitchingWalks,
    this.pitchingStrikeouts,
    this.pitchingHomeRuns,
    this.pitchesThrown,
    this.pitchesThrownStrikes,
    this.walksHitsPerInningsPitched,
    this.pitchingBattingAverageAgainst,
    this.grandSlams,
    this.fantasyPointsFanDuel,
    this.fantasyPointsDraftKings,
    this.fantasyPointsYahoo,
    this.plateAppearances,
    this.totalBases,
    this.flyOuts,
    this.groundOuts,
    this.lineOuts,
    this.popOuts,
    this.intentionalWalks,
    this.reachedOnError,
    this.ballsInPlay,
    this.battingAverageOnBallsInPlay,
    this.weightedOnBasePercentage,
    this.pitchingSingles,
    this.pitchingDoubles,
    this.pitchingTriples,
    this.pitchingGrandSlams,
    this.pitchingHitByPitch,
    this.pitchingSacrifices,
    this.pitchingSacrificeFlies,
    this.pitchingGroundIntoDoublePlay,
    this.pitchingCompleteGames,
    this.pitchingShutOuts,
    this.pitchingNoHitters,
    this.pitchingPerfectGames,
    this.pitchingPlateAppearances,
    this.pitchingTotalBases,
    this.pitchingFlyOuts,
    this.pitchingGroundOuts,
    this.pitchingLineOuts,
    this.pitchingPopOuts,
    this.pitchingIntentionalWalks,
    this.pitchingReachedOnError,
    this.pitchingCatchersInterference,
    this.pitchingBallsInPlay,
    this.pitchingOnBasePercentage,
    this.pitchingSluggingPercentage,
    this.pitchingOnBasePlusSlugging,
    this.pitchingStrikeoutsPerNineInnings,
    this.pitchingWalksPerNineInnings,
    this.pitchingBattingAverageOnBallsInPlay,
    this.pitchingWeightedOnBasePercentage,
    this.doublePlays,
    this.pitchingDoublePlays,
    this.battingOrderConfirmed,
    this.isolatedPower,
    this.fieldingIndependentPitching,
    this.pitchingQualityStarts,
    this.pitchingInningStarted,
    this.leftOnBase,
    this.pitchingHolds,
    this.pitchingBlownSaves,
    this.substituteBattingOrder,
    this.substituteBattingOrderSequence,
    this.fantasyPointsFantasyDraft,
  });
  factory MlbTeamStats.fromJson(String str) =>
      MlbTeamStats.fromMap(json.decode(str) as Map<String, dynamic>);

  factory MlbTeamStats.fromMap(Map<String, dynamic> json) => MlbTeamStats(
        statId: json['StatID']?.toInt() as int,
        teamId: json['TeamID']?.toInt() as int,
        seasonType: json['SeasonType']?.toInt() as int,
        season: json['Season']?.toInt() as int,
        name: json['Name'] as String,
        team: json['Team'] as String,
        globalTeamId: json['GlobalTeamID']?.toInt() as int,
        updated: DateTime.parse(json['Updated'] as String),
        games: json['Games']?.toInt() as int,
        fantasyPoints: json['FantasyPoints']?.toDouble() as double,
        atBats: json['AtBats']?.toInt() as int,
        runs: json['Runs']?.toInt() as int,
        hits: json['Hits']?.toInt() as int,
        singles: json['Singles']?.toInt() as int,
        doubles: json['Doubles']?.toInt() as int,
        triples: json['Triples']?.toInt() as int,
        homeRuns: json['HomeRuns']?.toInt() as int,
        runsBattedIn: json['RunsBattedIn']?.toInt() as int,
        battingAverage: json['BattingAverage']?.toDouble() as double,
        outs: json['Outs']?.toInt() as int,
        strikeouts: json['Strikeouts']?.toInt() as int,
        walks: json['Walks']?.toInt() as int,
        hitByPitch: json['HitByPitch']?.toInt() as int,
        sacrifices: json['Sacrifices']?.toInt() as int,
        sacrificeFlies: json['SacrificeFlies']?.toInt() as int,
        groundIntoDoublePlay: json['GroundIntoDoublePlay']?.toInt() as int,
        stolenBases: json['StolenBases']?.toInt() as int,
        caughtStealing: json['CaughtStealing']?.toInt() as int,
        pitchesSeen: json['PitchesSeen']?.toInt() as int,
        onBasePercentage: json['OnBasePercentage']?.toDouble() as double,
        sluggingPercentage: json['SluggingPercentage']?.toDouble() as double,
        onBasePlusSlugging: json['OnBasePlusSlugging']?.toDouble() as double,
        errors: json['Errors']?.toInt() as int,
        wins: json['Wins']?.toInt() as int,
        losses: json['Losses']?.toInt() as int,
        saves: json['Saves']?.toInt() as int,
        inningsPitchedDecimal:
            json['InningsPitchedDecimal']?.toDouble() as double,
        totalOutsPitched: json['TotalOutsPitched']?.toInt() as int,
        inningsPitchedFull: json['InningsPitchedFull']?.toInt() as int,
        inningsPitchedOuts: json['InningsPitchedOuts']?.toInt() as int,
        earnedRunAverage: json['EarnedRunAverage']?.toDouble() as double,
        pitchingHits: json['PitchingHits']?.toInt() as int,
        pitchingRuns: json['PitchingRuns']?.toInt() as int,
        pitchingEarnedRuns: json['PitchingEarnedRuns']?.toInt() as int,
        pitchingWalks: json['PitchingWalks']?.toInt() as int,
        pitchingStrikeouts: json['PitchingStrikeouts']?.toInt() as int,
        pitchingHomeRuns: json['PitchingHomeRuns']?.toInt() as int,
        pitchesThrown: json['PitchesThrown']?.toInt() as int,
        pitchesThrownStrikes: json['PitchesThrownStrikes']?.toInt() as int,
        walksHitsPerInningsPitched:
            json['WalksHitsPerInningsPitched']?.toDouble() as double,
        pitchingBattingAverageAgainst:
            json['PitchingBattingAverageAgainst']?.toDouble() as double,
        grandSlams: json['GrandSlams']?.toInt() as int,
        fantasyPointsFanDuel:
            json['FantasyPointsFanDuel']?.toDouble() as double,
        fantasyPointsDraftKings:
            json['FantasyPointsDraftKings']?.toDouble() as double,
        fantasyPointsYahoo: json['FantasyPointsYahoo']?.toDouble() as double,
        plateAppearances: json['PlateAppearances']?.toInt() as int,
        totalBases: json['TotalBases']?.toInt() as int,
        flyOuts: json['FlyOuts']?.toInt() as int,
        groundOuts: json['GroundOuts']?.toInt() as int,
        lineOuts: json['LineOuts']?.toInt() as int,
        popOuts: json['PopOuts']?.toInt() as int,
        intentionalWalks: json['IntentionalWalks']?.toInt() as int,
        reachedOnError: json['ReachedOnError']?.toInt() as int,
        ballsInPlay: json['BallsInPlay']?.toInt() as int,
        battingAverageOnBallsInPlay:
            json['BattingAverageOnBallsInPlay']?.toDouble() as double,
        weightedOnBasePercentage:
            json['WeightedOnBasePercentage']?.toDouble() as double,
        pitchingSingles: json['PitchingSingles']?.toInt() as int,
        pitchingDoubles: json['PitchingDoubles']?.toInt() as int,
        pitchingTriples: json['PitchingTriples']?.toInt() as int,
        pitchingGrandSlams: json['PitchingGrandSlams']?.toInt() as int,
        pitchingHitByPitch: json['PitchingHitByPitch']?.toInt() as int,
        pitchingSacrifices: json['PitchingSacrifices']?.toInt() as int,
        pitchingSacrificeFlies: json['PitchingSacrificeFlies']?.toInt() as int,
        pitchingGroundIntoDoublePlay:
            json['PitchingGroundIntoDoublePlay']?.toInt() as int,
        pitchingCompleteGames: json['PitchingCompleteGames']?.toInt() as int,
        pitchingShutOuts: json['PitchingShutOuts']?.toInt() as int,
        pitchingNoHitters: json['PitchingNoHitters']?.toInt() as int,
        pitchingPerfectGames: json['PitchingPerfectGames']?.toInt() as int,
        pitchingPlateAppearances:
            json['PitchingPlateAppearances']?.toInt() as int,
        pitchingTotalBases: json['PitchingTotalBases']?.toInt() as int,
        pitchingFlyOuts: json['PitchingFlyOuts']?.toInt() as int,
        pitchingGroundOuts: json['PitchingGroundOuts']?.toInt() as int,
        pitchingLineOuts: json['PitchingLineOuts']?.toInt() as int,
        pitchingPopOuts: json['PitchingPopOuts']?.toInt() as int,
        pitchingIntentionalWalks:
            json['PitchingIntentionalWalks']?.toInt() as int,
        pitchingReachedOnError: json['PitchingReachedOnError']?.toInt() as int,
        pitchingCatchersInterference:
            json['PitchingCatchersInterference']?.toInt() as int,
        pitchingBallsInPlay: json['PitchingBallsInPlay']?.toInt() as int,
        pitchingOnBasePercentage:
            json['PitchingOnBasePercentage']?.toDouble() as double,
        pitchingSluggingPercentage:
            json['PitchingSluggingPercentage']?.toDouble() as double,
        pitchingOnBasePlusSlugging:
            json['PitchingOnBasePlusSlugging']?.toDouble() as double,
        pitchingStrikeoutsPerNineInnings:
            json['PitchingStrikeoutsPerNineInnings']?.toDouble() as double,
        pitchingWalksPerNineInnings:
            json['PitchingWalksPerNineInnings']?.toDouble() as double,
        pitchingBattingAverageOnBallsInPlay:
            json['PitchingBattingAverageOnBallsInPlay']?.toDouble() as double,
        pitchingWeightedOnBasePercentage:
            json['PitchingWeightedOnBasePercentage']?.toDouble() as double,
        doublePlays: json['DoublePlays']?.toInt() as int,
        pitchingDoublePlays: json['PitchingDoublePlays']?.toInt() as int,
        battingOrderConfirmed: json['BattingOrderConfirmed'] as bool,
        isolatedPower: json['IsolatedPower']?.toDouble() as double,
        fieldingIndependentPitching:
            json['FieldingIndependentPitching']?.toDouble() as double,
        pitchingQualityStarts: json['PitchingQualityStarts']?.toInt() as int,
        pitchingInningStarted: json['PitchingInningStarted'],
        leftOnBase: json['LeftOnBase']?.toInt() as int,
        pitchingHolds: json['PitchingHolds']?.toInt() as int,
        pitchingBlownSaves: json['PitchingBlownSaves']?.toInt() as int,
        substituteBattingOrder: json['SubstituteBattingOrder'],
        substituteBattingOrderSequence: json['SubstituteBattingOrderSequence'],
        fantasyPointsFantasyDraft:
            json['FantasyPointsFantasyDraft']?.toDouble() as double,
      );

  final int statId;
  final int teamId;
  final int seasonType;
  final int season;
  final String name;
  final String team;
  final int globalTeamId;
  final DateTime updated;
  final int games;
  final double fantasyPoints;
  final int atBats;
  final int runs;
  final int hits;
  final int singles;
  final int doubles;
  final int triples;
  final int homeRuns;
  final int runsBattedIn;
  final double battingAverage;
  final int outs;
  final int strikeouts;
  final int walks;
  final int hitByPitch;
  final int sacrifices;
  final int sacrificeFlies;
  final int groundIntoDoublePlay;
  final int stolenBases;
  final int caughtStealing;
  final int pitchesSeen;
  final double onBasePercentage;
  final double sluggingPercentage;
  final double onBasePlusSlugging;
  final int errors;
  final int wins;
  final int losses;
  final int saves;
  final double inningsPitchedDecimal;
  final int totalOutsPitched;
  final int inningsPitchedFull;
  final int inningsPitchedOuts;
  final double earnedRunAverage;
  final int pitchingHits;
  final int pitchingRuns;
  final int pitchingEarnedRuns;
  final int pitchingWalks;
  final int pitchingStrikeouts;
  final int pitchingHomeRuns;
  final int pitchesThrown;
  final int pitchesThrownStrikes;
  final double walksHitsPerInningsPitched;
  final double pitchingBattingAverageAgainst;
  final int grandSlams;
  final double fantasyPointsFanDuel;
  final double fantasyPointsDraftKings;
  final double fantasyPointsYahoo;
  final int plateAppearances;
  final int totalBases;
  final int flyOuts;
  final int groundOuts;
  final int lineOuts;
  final int popOuts;
  final int intentionalWalks;
  final int reachedOnError;
  final int ballsInPlay;
  final double battingAverageOnBallsInPlay;
  final double weightedOnBasePercentage;
  final int pitchingSingles;
  final int pitchingDoubles;
  final int pitchingTriples;
  final int pitchingGrandSlams;
  final int pitchingHitByPitch;
  final int pitchingSacrifices;
  final int pitchingSacrificeFlies;
  final int pitchingGroundIntoDoublePlay;
  final int pitchingCompleteGames;
  final int pitchingShutOuts;
  final int pitchingNoHitters;
  final int pitchingPerfectGames;
  final int pitchingPlateAppearances;
  final int pitchingTotalBases;
  final int pitchingFlyOuts;
  final int pitchingGroundOuts;
  final int pitchingLineOuts;
  final int pitchingPopOuts;
  final int pitchingIntentionalWalks;
  final int pitchingReachedOnError;
  final int pitchingCatchersInterference;
  final int pitchingBallsInPlay;
  final double pitchingOnBasePercentage;
  final double pitchingSluggingPercentage;
  final double pitchingOnBasePlusSlugging;
  final double pitchingStrikeoutsPerNineInnings;
  final double pitchingWalksPerNineInnings;
  final double pitchingBattingAverageOnBallsInPlay;
  final double pitchingWeightedOnBasePercentage;
  final int doublePlays;
  final int pitchingDoublePlays;
  final bool battingOrderConfirmed;
  final double isolatedPower;
  final double fieldingIndependentPitching;
  final int pitchingQualityStarts;
  final dynamic pitchingInningStarted;
  final int leftOnBase;
  final int pitchingHolds;
  final int pitchingBlownSaves;
  final dynamic substituteBattingOrder;
  final dynamic substituteBattingOrderSequence;
  final double fantasyPointsFantasyDraft;

  MlbTeamStats copyWith({
    int statId,
    int teamId,
    int seasonType,
    int season,
    String name,
    String team,
    int globalTeamId,
    DateTime updated,
    int games,
    double fantasyPoints,
    int atBats,
    int runs,
    int hits,
    int singles,
    int doubles,
    int triples,
    int homeRuns,
    int runsBattedIn,
    double battingAverage,
    int outs,
    int strikeouts,
    int walks,
    int hitByPitch,
    int sacrifices,
    int sacrificeFlies,
    int groundIntoDoublePlay,
    int stolenBases,
    int caughtStealing,
    int pitchesSeen,
    double onBasePercentage,
    double sluggingPercentage,
    double onBasePlusSlugging,
    int errors,
    int wins,
    int losses,
    int saves,
    double inningsPitchedDecimal,
    int totalOutsPitched,
    int inningsPitchedFull,
    int inningsPitchedOuts,
    double earnedRunAverage,
    int pitchingHits,
    int pitchingRuns,
    int pitchingEarnedRuns,
    int pitchingWalks,
    int pitchingStrikeouts,
    int pitchingHomeRuns,
    int pitchesThrown,
    int pitchesThrownStrikes,
    double walksHitsPerInningsPitched,
    double pitchingBattingAverageAgainst,
    int grandSlams,
    double fantasyPointsFanDuel,
    double fantasyPointsDraftKings,
    double fantasyPointsYahoo,
    int plateAppearances,
    int totalBases,
    int flyOuts,
    int groundOuts,
    int lineOuts,
    int popOuts,
    int intentionalWalks,
    int reachedOnError,
    int ballsInPlay,
    double battingAverageOnBallsInPlay,
    double weightedOnBasePercentage,
    int pitchingSingles,
    int pitchingDoubles,
    int pitchingTriples,
    int pitchingGrandSlams,
    int pitchingHitByPitch,
    int pitchingSacrifices,
    int pitchingSacrificeFlies,
    int pitchingGroundIntoDoublePlay,
    int pitchingCompleteGames,
    int pitchingShutOuts,
    int pitchingNoHitters,
    int pitchingPerfectGames,
    int pitchingPlateAppearances,
    int pitchingTotalBases,
    int pitchingFlyOuts,
    int pitchingGroundOuts,
    int pitchingLineOuts,
    int pitchingPopOuts,
    int pitchingIntentionalWalks,
    int pitchingReachedOnError,
    int pitchingCatchersInterference,
    int pitchingBallsInPlay,
    double pitchingOnBasePercentage,
    double pitchingSluggingPercentage,
    double pitchingOnBasePlusSlugging,
    double pitchingStrikeoutsPerNineInnings,
    double pitchingWalksPerNineInnings,
    double pitchingBattingAverageOnBallsInPlay,
    double pitchingWeightedOnBasePercentage,
    int doublePlays,
    int pitchingDoublePlays,
    bool battingOrderConfirmed,
    double isolatedPower,
    double fieldingIndependentPitching,
    int pitchingQualityStarts,
    dynamic pitchingInningStarted,
    int leftOnBase,
    int pitchingHolds,
    int pitchingBlownSaves,
    dynamic substituteBattingOrder,
    dynamic substituteBattingOrderSequence,
    double fantasyPointsFantasyDraft,
  }) =>
      MlbTeamStats(
        statId: statId ?? this.statId,
        teamId: teamId ?? this.teamId,
        seasonType: seasonType ?? this.seasonType,
        season: season ?? this.season,
        name: name ?? this.name,
        team: team ?? this.team,
        globalTeamId: globalTeamId ?? this.globalTeamId,
        updated: updated ?? this.updated,
        games: games ?? this.games,
        fantasyPoints: fantasyPoints ?? this.fantasyPoints,
        atBats: atBats ?? this.atBats,
        runs: runs ?? this.runs,
        hits: hits ?? this.hits,
        singles: singles ?? this.singles,
        doubles: doubles ?? this.doubles,
        triples: triples ?? this.triples,
        homeRuns: homeRuns ?? this.homeRuns,
        runsBattedIn: runsBattedIn ?? this.runsBattedIn,
        battingAverage: battingAverage ?? this.battingAverage,
        outs: outs ?? this.outs,
        strikeouts: strikeouts ?? this.strikeouts,
        walks: walks ?? this.walks,
        hitByPitch: hitByPitch ?? this.hitByPitch,
        sacrifices: sacrifices ?? this.sacrifices,
        sacrificeFlies: sacrificeFlies ?? this.sacrificeFlies,
        groundIntoDoublePlay: groundIntoDoublePlay ?? this.groundIntoDoublePlay,
        stolenBases: stolenBases ?? this.stolenBases,
        caughtStealing: caughtStealing ?? this.caughtStealing,
        pitchesSeen: pitchesSeen ?? this.pitchesSeen,
        onBasePercentage: onBasePercentage ?? this.onBasePercentage,
        sluggingPercentage: sluggingPercentage ?? this.sluggingPercentage,
        onBasePlusSlugging: onBasePlusSlugging ?? this.onBasePlusSlugging,
        errors: errors ?? this.errors,
        wins: wins ?? this.wins,
        losses: losses ?? this.losses,
        saves: saves ?? this.saves,
        inningsPitchedDecimal:
            inningsPitchedDecimal ?? this.inningsPitchedDecimal,
        totalOutsPitched: totalOutsPitched ?? this.totalOutsPitched,
        inningsPitchedFull: inningsPitchedFull ?? this.inningsPitchedFull,
        inningsPitchedOuts: inningsPitchedOuts ?? this.inningsPitchedOuts,
        earnedRunAverage: earnedRunAverage ?? this.earnedRunAverage,
        pitchingHits: pitchingHits ?? this.pitchingHits,
        pitchingRuns: pitchingRuns ?? this.pitchingRuns,
        pitchingEarnedRuns: pitchingEarnedRuns ?? this.pitchingEarnedRuns,
        pitchingWalks: pitchingWalks ?? this.pitchingWalks,
        pitchingStrikeouts: pitchingStrikeouts ?? this.pitchingStrikeouts,
        pitchingHomeRuns: pitchingHomeRuns ?? this.pitchingHomeRuns,
        pitchesThrown: pitchesThrown ?? this.pitchesThrown,
        pitchesThrownStrikes: pitchesThrownStrikes ?? this.pitchesThrownStrikes,
        walksHitsPerInningsPitched:
            walksHitsPerInningsPitched ?? this.walksHitsPerInningsPitched,
        pitchingBattingAverageAgainst:
            pitchingBattingAverageAgainst ?? this.pitchingBattingAverageAgainst,
        grandSlams: grandSlams ?? this.grandSlams,
        fantasyPointsFanDuel: fantasyPointsFanDuel ?? this.fantasyPointsFanDuel,
        fantasyPointsDraftKings:
            fantasyPointsDraftKings ?? this.fantasyPointsDraftKings,
        fantasyPointsYahoo: fantasyPointsYahoo ?? this.fantasyPointsYahoo,
        plateAppearances: plateAppearances ?? this.plateAppearances,
        totalBases: totalBases ?? this.totalBases,
        flyOuts: flyOuts ?? this.flyOuts,
        groundOuts: groundOuts ?? this.groundOuts,
        lineOuts: lineOuts ?? this.lineOuts,
        popOuts: popOuts ?? this.popOuts,
        intentionalWalks: intentionalWalks ?? this.intentionalWalks,
        reachedOnError: reachedOnError ?? this.reachedOnError,
        ballsInPlay: ballsInPlay ?? this.ballsInPlay,
        battingAverageOnBallsInPlay:
            battingAverageOnBallsInPlay ?? this.battingAverageOnBallsInPlay,
        weightedOnBasePercentage:
            weightedOnBasePercentage ?? this.weightedOnBasePercentage,
        pitchingSingles: pitchingSingles ?? this.pitchingSingles,
        pitchingDoubles: pitchingDoubles ?? this.pitchingDoubles,
        pitchingTriples: pitchingTriples ?? this.pitchingTriples,
        pitchingGrandSlams: pitchingGrandSlams ?? this.pitchingGrandSlams,
        pitchingHitByPitch: pitchingHitByPitch ?? this.pitchingHitByPitch,
        pitchingSacrifices: pitchingSacrifices ?? this.pitchingSacrifices,
        pitchingSacrificeFlies:
            pitchingSacrificeFlies ?? this.pitchingSacrificeFlies,
        pitchingGroundIntoDoublePlay:
            pitchingGroundIntoDoublePlay ?? this.pitchingGroundIntoDoublePlay,
        pitchingCompleteGames:
            pitchingCompleteGames ?? this.pitchingCompleteGames,
        pitchingShutOuts: pitchingShutOuts ?? this.pitchingShutOuts,
        pitchingNoHitters: pitchingNoHitters ?? this.pitchingNoHitters,
        pitchingPerfectGames: pitchingPerfectGames ?? this.pitchingPerfectGames,
        pitchingPlateAppearances:
            pitchingPlateAppearances ?? this.pitchingPlateAppearances,
        pitchingTotalBases: pitchingTotalBases ?? this.pitchingTotalBases,
        pitchingFlyOuts: pitchingFlyOuts ?? this.pitchingFlyOuts,
        pitchingGroundOuts: pitchingGroundOuts ?? this.pitchingGroundOuts,
        pitchingLineOuts: pitchingLineOuts ?? this.pitchingLineOuts,
        pitchingPopOuts: pitchingPopOuts ?? this.pitchingPopOuts,
        pitchingIntentionalWalks:
            pitchingIntentionalWalks ?? this.pitchingIntentionalWalks,
        pitchingReachedOnError:
            pitchingReachedOnError ?? this.pitchingReachedOnError,
        pitchingCatchersInterference:
            pitchingCatchersInterference ?? this.pitchingCatchersInterference,
        pitchingBallsInPlay: pitchingBallsInPlay ?? this.pitchingBallsInPlay,
        pitchingOnBasePercentage:
            pitchingOnBasePercentage ?? this.pitchingOnBasePercentage,
        pitchingSluggingPercentage:
            pitchingSluggingPercentage ?? this.pitchingSluggingPercentage,
        pitchingOnBasePlusSlugging:
            pitchingOnBasePlusSlugging ?? this.pitchingOnBasePlusSlugging,
        pitchingStrikeoutsPerNineInnings: pitchingStrikeoutsPerNineInnings ??
            this.pitchingStrikeoutsPerNineInnings,
        pitchingWalksPerNineInnings:
            pitchingWalksPerNineInnings ?? this.pitchingWalksPerNineInnings,
        pitchingBattingAverageOnBallsInPlay:
            pitchingBattingAverageOnBallsInPlay ??
                this.pitchingBattingAverageOnBallsInPlay,
        pitchingWeightedOnBasePercentage: pitchingWeightedOnBasePercentage ??
            this.pitchingWeightedOnBasePercentage,
        doublePlays: doublePlays ?? this.doublePlays,
        pitchingDoublePlays: pitchingDoublePlays ?? this.pitchingDoublePlays,
        battingOrderConfirmed:
            battingOrderConfirmed ?? this.battingOrderConfirmed,
        isolatedPower: isolatedPower ?? this.isolatedPower,
        fieldingIndependentPitching:
            fieldingIndependentPitching ?? this.fieldingIndependentPitching,
        pitchingQualityStarts:
            pitchingQualityStarts ?? this.pitchingQualityStarts,
        pitchingInningStarted:
            pitchingInningStarted ?? this.pitchingInningStarted,
        leftOnBase: leftOnBase ?? this.leftOnBase,
        pitchingHolds: pitchingHolds ?? this.pitchingHolds,
        pitchingBlownSaves: pitchingBlownSaves ?? this.pitchingBlownSaves,
        substituteBattingOrder:
            substituteBattingOrder ?? this.substituteBattingOrder,
        substituteBattingOrderSequence: substituteBattingOrderSequence ??
            this.substituteBattingOrderSequence,
        fantasyPointsFantasyDraft:
            fantasyPointsFantasyDraft ?? this.fantasyPointsFantasyDraft,
      );

  String toJson() => json.encode(toMap());

  Map<String, Object> toMap() => {
        'StatID': statId,
        'TeamID': teamId,
        'SeasonType': seasonType,
        'Season': season,
        'Name': name,
        'Team': team,
        'GlobalTeamID': globalTeamId,
        'Updated': updated.toIso8601String(),
        'Games': games,
        'FantasyPoints': fantasyPoints,
        'AtBats': atBats,
        'Runs': runs,
        'Hits': hits,
        'Singles': singles,
        'Doubles': doubles,
        'Triples': triples,
        'HomeRuns': homeRuns,
        'RunsBattedIn': runsBattedIn,
        'BattingAverage': battingAverage,
        'Outs': outs,
        'Strikeouts': strikeouts,
        'Walks': walks,
        'HitByPitch': hitByPitch,
        'Sacrifices': sacrifices,
        'SacrificeFlies': sacrificeFlies,
        'GroundIntoDoublePlay': groundIntoDoublePlay,
        'StolenBases': stolenBases,
        'CaughtStealing': caughtStealing,
        'PitchesSeen': pitchesSeen,
        'OnBasePercentage': onBasePercentage,
        'SluggingPercentage': sluggingPercentage,
        'OnBasePlusSlugging': onBasePlusSlugging,
        'Errors': errors,
        'Wins': wins,
        'Losses': losses,
        'Saves': saves,
        'InningsPitchedDecimal': inningsPitchedDecimal,
        'TotalOutsPitched': totalOutsPitched,
        'InningsPitchedFull': inningsPitchedFull,
        'InningsPitchedOuts': inningsPitchedOuts,
        'EarnedRunAverage': earnedRunAverage,
        'PitchingHits': pitchingHits,
        'PitchingRuns': pitchingRuns,
        'PitchingEarnedRuns': pitchingEarnedRuns,
        'PitchingWalks': pitchingWalks,
        'PitchingStrikeouts': pitchingStrikeouts,
        'PitchingHomeRuns': pitchingHomeRuns,
        'PitchesThrown': pitchesThrown,
        'PitchesThrownStrikes': pitchesThrownStrikes,
        'WalksHitsPerInningsPitched': walksHitsPerInningsPitched,
        'PitchingBattingAverageAgainst': pitchingBattingAverageAgainst,
        'GrandSlams': grandSlams,
        'FantasyPointsFanDuel': fantasyPointsFanDuel,
        'FantasyPointsDraftKings': fantasyPointsDraftKings,
        'FantasyPointsYahoo': fantasyPointsYahoo,
        'PlateAppearances': plateAppearances,
        'TotalBases': totalBases,
        'FlyOuts': flyOuts,
        'GroundOuts': groundOuts,
        'LineOuts': lineOuts,
        'PopOuts': popOuts,
        'IntentionalWalks': intentionalWalks,
        'ReachedOnError': reachedOnError,
        'BallsInPlay': ballsInPlay,
        'BattingAverageOnBallsInPlay': battingAverageOnBallsInPlay,
        'WeightedOnBasePercentage': weightedOnBasePercentage,
        'PitchingSingles': pitchingSingles,
        'PitchingDoubles': pitchingDoubles,
        'PitchingTriples': pitchingTriples,
        'PitchingGrandSlams': pitchingGrandSlams,
        'PitchingHitByPitch': pitchingHitByPitch,
        'PitchingSacrifices': pitchingSacrifices,
        'PitchingSacrificeFlies': pitchingSacrificeFlies,
        'PitchingGroundIntoDoublePlay': pitchingGroundIntoDoublePlay,
        'PitchingCompleteGames': pitchingCompleteGames,
        'PitchingShutOuts': pitchingShutOuts,
        'PitchingNoHitters': pitchingNoHitters,
        'PitchingPerfectGames': pitchingPerfectGames,
        'PitchingPlateAppearances': pitchingPlateAppearances,
        'PitchingTotalBases': pitchingTotalBases,
        'PitchingFlyOuts': pitchingFlyOuts,
        'PitchingGroundOuts': pitchingGroundOuts,
        'PitchingLineOuts': pitchingLineOuts,
        'PitchingPopOuts': pitchingPopOuts,
        'PitchingIntentionalWalks': pitchingIntentionalWalks,
        'PitchingReachedOnError': pitchingReachedOnError,
        'PitchingCatchersInterference': pitchingCatchersInterference,
        'PitchingBallsInPlay': pitchingBallsInPlay,
        'PitchingOnBasePercentage': pitchingOnBasePercentage,
        'PitchingSluggingPercentage': pitchingSluggingPercentage,
        'PitchingOnBasePlusSlugging': pitchingOnBasePlusSlugging,
        'PitchingStrikeoutsPerNineInnings': pitchingStrikeoutsPerNineInnings,
        'PitchingWalksPerNineInnings': pitchingWalksPerNineInnings,
        'PitchingBattingAverageOnBallsInPlay':
            pitchingBattingAverageOnBallsInPlay,
        'PitchingWeightedOnBasePercentage': pitchingWeightedOnBasePercentage,
        'DoublePlays': doublePlays,
        'PitchingDoublePlays': pitchingDoublePlays,
        'BattingOrderConfirmed': battingOrderConfirmed,
        'IsolatedPower': isolatedPower,
        'FieldingIndependentPitching': fieldingIndependentPitching,
        'PitchingQualityStarts': pitchingQualityStarts,
        'PitchingInningStarted': pitchingInningStarted,
        'LeftOnBase': leftOnBase,
        'PitchingHolds': pitchingHolds,
        'PitchingBlownSaves': pitchingBlownSaves,
        'SubstituteBattingOrder': substituteBattingOrder,
        'SubstituteBattingOrderSequence': substituteBattingOrderSequence,
        'FantasyPointsFantasyDraft': fantasyPointsFantasyDraft,
      };

  Map<String, dynamic> toStatOnlyMap() => <String, dynamic>{
        'At Bats': atBats,
        'Runs': runs,
        'Hits': hits,
        'Singles': singles,
        'Doubles': doubles,
        'Triples': triples,
        'Home Runs': homeRuns,
        'Runs Batted In': runsBattedIn,
        'Batting Average': battingAverage,
        'Outs': outs,
        'Strikeouts': strikeouts,
        'Walks': walks,
        'Hit By Pitch': hitByPitch,
        'Sacrifices': sacrifices,
        'Sacrifice Flies': sacrificeFlies,
        'Ground Into Double Play': groundIntoDoublePlay,
        'Stolen Bases': stolenBases,
        'Caught Stealing': caughtStealing,
        'Pitches Seen': pitchesSeen,
        'On Base Percentage': onBasePercentage,
        'Slugging Percentage': sluggingPercentage,
        'On Base Plus Slugging': onBasePlusSlugging,
        'Errors': errors,
        'Wins': wins,
        'Losses': losses,
        'Saves': saves,
        'Total Outs Pitched': totalOutsPitched,
        'Innings Pitched Full': inningsPitchedFull,
        'Innings Pitched Outs': inningsPitchedOuts,
        'Earned Run Average': earnedRunAverage,
        'Pitching Hits': pitchingHits,
        'Pitching Runs': pitchingRuns,
        'Pitching Earned Runs': pitchingEarnedRuns,
        'Pitching Walks': pitchingWalks,
        'Pitching Strikeouts': pitchingStrikeouts,
        'Pitching Home Runs': pitchingHomeRuns,
        'Pitches Thrown': pitchesThrown,
        'Pitches Thrown Strikes': pitchesThrownStrikes,
        'Walks Hits Per Innings Pitched': walksHitsPerInningsPitched,
        'Pitching Batting Average Against': pitchingBattingAverageAgainst,
        'Grand Slams': grandSlams,
        'Fantasy Points Fan Duel': fantasyPointsFanDuel,
        'Fantasy Points DraftKings': fantasyPointsDraftKings,
        'Fantasy Points Yahoo': fantasyPointsYahoo,
        'Plate Appearances': plateAppearances,
        'Total Bases': totalBases,
        'Fly Outs': flyOuts,
        'Ground Outs': groundOuts,
        'Line Outs': lineOuts,
        'Pop Outs': popOuts,
        'Intentional Walks': intentionalWalks,
        'Reached On Error': reachedOnError,
        'Balls In Play': ballsInPlay,
        'Batting Average On Balls In Play': battingAverageOnBallsInPlay,
        'Weighted On Base Percentage': weightedOnBasePercentage,
        'Pitching Singles': pitchingSingles,
        'Pitching Doubles': pitchingDoubles,
        'Pitching Triples': pitchingTriples,
        'Pitching Grand Slams': pitchingGrandSlams,
        'Pitching Hit By Pitch': pitchingHitByPitch,
        'Pitching Sacrifices': pitchingSacrifices,
        'Pitching Sacrifice Flies': pitchingSacrificeFlies,
        'Pitching Ground Into Double Play': pitchingGroundIntoDoublePlay,
        'Pitching Complete Games': pitchingCompleteGames,
        'Pitching Shut Outs': pitchingShutOuts,
        'Pitching No Hitters': pitchingNoHitters,
        'Pitching Perfect Games': pitchingPerfectGames,
        'Pitching Plate Appearances': pitchingPlateAppearances,
        'Pitching Total Bases': pitchingTotalBases,
        'Pitching Fly Outs': pitchingFlyOuts,
        'Pitching Ground Outs': pitchingGroundOuts,
        'Pitching Line Outs': pitchingLineOuts,
        'Pitching Pop Outs': pitchingPopOuts,
        'Pitching Intentional Walks': pitchingIntentionalWalks,
        'Pitching Reached On Error': pitchingReachedOnError,
        'Pitching Catchers Interference': pitchingCatchersInterference,
        'Pitching Balls In Play': pitchingBallsInPlay,
        'Pitching On Base Percentage': pitchingOnBasePercentage,
        'Pitching Slugging Percentage': pitchingSluggingPercentage,
        'Pitching On Base Plus Slugging': pitchingOnBasePlusSlugging,
        'Pitching Strikeouts Per Nine Innings':
            pitchingStrikeoutsPerNineInnings,
        'Pitching Walks Per Nine Innings': pitchingWalksPerNineInnings,
        'Pitching Batting Average On Balls In Play':
            pitchingBattingAverageOnBallsInPlay,
        'Pitching Weighted On Base Percentage':
            pitchingWeightedOnBasePercentage,
        'Double Plays': doublePlays,
        'Pitching Double Plays': pitchingDoublePlays,
        'Batting Order Confirmed': battingOrderConfirmed,
        'Isolated Power': isolatedPower,
        'Fielding Independent Pitching': fieldingIndependentPitching,
        'Pitching Quality Starts': pitchingQualityStarts,
        'Pitching Inning Started': pitchingInningStarted,
        'Left On Base': leftOnBase,
        'Pitching Holds': pitchingHolds,
        'Pitching Blown Saves': pitchingBlownSaves,
        'Substitute Batting Order': substituteBattingOrder,
        'Substitute Batting Order Sequence': substituteBattingOrderSequence,
        'Fantasy Points Fantasy Draft': fantasyPointsFantasyDraft,
      };
}
