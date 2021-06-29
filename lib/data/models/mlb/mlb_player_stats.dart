import 'dart:convert';

class MlbPlayerStats {
  MlbPlayerStats({
    this.statId,
    this.teamId,
    this.playerId,
    this.seasonType,
    this.season,
    this.name,
    this.team,
    this.position,
    this.positionCategory,
    this.started,
    this.battingOrder,
    this.globalTeamId,
    this.averageDraftPosition,
    this.auctionValue,
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
  factory MlbPlayerStats.fromJson(String str) =>
      MlbPlayerStats.fromMap(json.decode(str));

  factory MlbPlayerStats.fromMap(Map<String, dynamic> json) => MlbPlayerStats(
        statId: json['StatID'],
        teamId: json['TeamID'],
        playerId: json['PlayerID'],
        seasonType: json['SeasonType'],
        season: json['Season'],
        name: json['Name'],
        team: json['Team'],
        position: json['Position'],
        positionCategory: json['PositionCategory'],
        started: json['Started'],
        battingOrder: json['BattingOrder'],
        globalTeamId: json['GlobalTeamID'],
        averageDraftPosition: json['AverageDraftPosition'],
        auctionValue: json['AuctionValue'],
        updated: DateTime.parse(json['Updated']),
        games: json['Games'],
        fantasyPoints: json['FantasyPoints'].toInt(),
        atBats: json['AtBats'].toInt(),
        runs: json['Runs'].toInt(),
        hits: json['Hits'].toInt(),
        singles: json['Singles'].toInt(),
        doubles: json['Doubles'].toInt(),
        triples: json['Triples'].toInt(),
        homeRuns: json['HomeRuns'].toInt(),
        runsBattedIn: json['RunsBattedIn'].toInt(),
        battingAverage: json['BattingAverage'].toDouble(),
        outs: json['Outs'].toInt(),
        strikeouts: json['Strikeouts'].toInt(),
        walks: json['Walks'].toInt(),
        hitByPitch: json['HitByPitch'].toInt(),
        sacrifices: json['Sacrifices'].toInt(),
        sacrificeFlies: json['SacrificeFlies'].toInt(),
        groundIntoDoublePlay: json['GroundIntoDoublePlay'].toInt(),
        stolenBases: json['StolenBases'].toInt(),
        caughtStealing: json['CaughtStealing'].toInt(),
        pitchesSeen: json['PitchesSeen'].toInt(),
        onBasePercentage: json['OnBasePercentage'].toDouble(),
        sluggingPercentage: json['SluggingPercentage'].toDouble(),
        onBasePlusSlugging: json['OnBasePlusSlugging'].toDouble(),
        errors: json['Errors'].toInt(),
        wins: json['Wins'].toInt(),
        losses: json['Losses'].toInt(),
        saves: json['Saves'].toInt(),
        inningsPitchedDecimal: json['InningsPitchedDecimal'].toInt(),
        totalOutsPitched: json['TotalOutsPitched'].toInt(),
        inningsPitchedFull: json['InningsPitchedFull'].toInt(),
        inningsPitchedOuts: json['InningsPitchedOuts'].toInt(),
        earnedRunAverage: json['EarnedRunAverage'].toInt(),
        pitchingHits: json['PitchingHits'].toInt(),
        pitchingRuns: json['PitchingRuns'].toInt(),
        pitchingEarnedRuns: json['PitchingEarnedRuns'].toInt(),
        pitchingWalks: json['PitchingWalks'].toInt(),
        pitchingStrikeouts: json['PitchingStrikeouts'].toInt(),
        pitchingHomeRuns: json['PitchingHomeRuns'].toInt(),
        pitchesThrown: json['PitchesThrown'].toInt(),
        pitchesThrownStrikes: json['PitchesThrownStrikes'].toInt(),
        walksHitsPerInningsPitched: json['WalksHitsPerInningsPitched'].toInt(),
        pitchingBattingAverageAgainst:
            json['PitchingBattingAverageAgainst'].toInt(),
        grandSlams: json['GrandSlams'].toInt(),
        fantasyPointsFanDuel: json['FantasyPointsFanDuel'].toDouble(),
        fantasyPointsDraftKings: json['FantasyPointsDraftKings'].toInt(),
        fantasyPointsYahoo: json['FantasyPointsYahoo'].toDouble(),
        plateAppearances: json['PlateAppearances'].toInt(),
        totalBases: json['TotalBases'].toInt(),
        flyOuts: json['FlyOuts'].toInt(),
        groundOuts: json['GroundOuts'].toInt(),
        lineOuts: json['LineOuts'].toInt(),
        popOuts: json['PopOuts'].toInt(),
        intentionalWalks: json['IntentionalWalks'].toInt(),
        reachedOnError: json['ReachedOnError'].toInt(),
        ballsInPlay: json['BallsInPlay'].toInt(),
        battingAverageOnBallsInPlay:
            json['BattingAverageOnBallsInPlay'].toDouble(),
        weightedOnBasePercentage: json['WeightedOnBasePercentage'].toDouble(),
        pitchingSingles: json['PitchingSingles'].toInt(),
        pitchingDoubles: json['PitchingDoubles'].toInt(),
        pitchingTriples: json['PitchingTriples'].toInt(),
        pitchingGrandSlams: json['PitchingGrandSlams'].toInt(),
        pitchingHitByPitch: json['PitchingHitByPitch'].toInt(),
        pitchingSacrifices: json['PitchingSacrifices'].toInt(),
        pitchingSacrificeFlies: json['PitchingSacrificeFlies'].toInt(),
        pitchingGroundIntoDoublePlay:
            json['PitchingGroundIntoDoublePlay'].toInt(),
        pitchingCompleteGames: json['PitchingCompleteGames'].toInt(),
        pitchingShutOuts: json['PitchingShutOuts'].toInt(),
        pitchingNoHitters: json['PitchingNoHitters'].toInt(),
        pitchingPerfectGames: json['PitchingPerfectGames'].toInt(),
        pitchingPlateAppearances: json['PitchingPlateAppearances'].toInt(),
        pitchingTotalBases: json['PitchingTotalBases'].toInt(),
        pitchingFlyOuts: json['PitchingFlyOuts'].toInt(),
        pitchingGroundOuts: json['PitchingGroundOuts'].toInt(),
        pitchingLineOuts: json['PitchingLineOuts'].toInt(),
        pitchingPopOuts: json['PitchingPopOuts'].toInt(),
        pitchingIntentionalWalks: json['PitchingIntentionalWalks'].toInt(),
        pitchingReachedOnError: json['PitchingReachedOnError'].toInt(),
        pitchingCatchersInterference:
            json['PitchingCatchersInterference'].toInt(),
        pitchingBallsInPlay: json['PitchingBallsInPlay'].toInt(),
        pitchingOnBasePercentage: json['PitchingOnBasePercentage'].toInt(),
        pitchingSluggingPercentage: json['PitchingSluggingPercentage'].toInt(),
        pitchingOnBasePlusSlugging: json['PitchingOnBasePlusSlugging'].toInt(),
        pitchingStrikeoutsPerNineInnings:
            json['PitchingStrikeoutsPerNineInnings'].toInt(),
        pitchingWalksPerNineInnings:
            json['PitchingWalksPerNineInnings'].toInt(),
        pitchingBattingAverageOnBallsInPlay:
            json['PitchingBattingAverageOnBallsInPlay'].toInt(),
        pitchingWeightedOnBasePercentage:
            json['PitchingWeightedOnBasePercentage'].toInt(),
        doublePlays: json['DoublePlays'].toInt(),
        pitchingDoublePlays: json['PitchingDoublePlays'].toInt(),
        battingOrderConfirmed: json['BattingOrderConfirmed'],
        isolatedPower: json['IsolatedPower'].toDouble(),
        fieldingIndependentPitching:
            json['FieldingIndependentPitching'].toInt(),
        pitchingQualityStarts: json['PitchingQualityStarts'].toInt(),
        pitchingInningStarted: json['PitchingInningStarted'],
        leftOnBase: json['LeftOnBase'].toInt(),
        pitchingHolds: json['PitchingHolds'].toInt(),
        pitchingBlownSaves: json['PitchingBlownSaves'].toInt(),
        substituteBattingOrder: json['SubstituteBattingOrder'],
        substituteBattingOrderSequence: json['SubstituteBattingOrderSequence'],
        fantasyPointsFantasyDraft: json['FantasyPointsFantasyDraft'].toInt(),
      );

  final int statId;
  final int teamId;
  final int playerId;
  final int seasonType;
  final int season;
  final String name;
  final String team;
  final String position;
  final String positionCategory;
  final int started;
  final dynamic battingOrder;
  final int globalTeamId;
  final dynamic averageDraftPosition;
  final dynamic auctionValue;
  final DateTime updated;
  final int games;
  final int fantasyPoints;
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
  final int inningsPitchedDecimal;
  final int totalOutsPitched;
  final int inningsPitchedFull;
  final int inningsPitchedOuts;
  final int earnedRunAverage;
  final int pitchingHits;
  final int pitchingRuns;
  final int pitchingEarnedRuns;
  final int pitchingWalks;
  final int pitchingStrikeouts;
  final int pitchingHomeRuns;
  final int pitchesThrown;
  final int pitchesThrownStrikes;
  final int walksHitsPerInningsPitched;
  final int pitchingBattingAverageAgainst;
  final int grandSlams;
  final double fantasyPointsFanDuel;
  final int fantasyPointsDraftKings;
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
  final int pitchingOnBasePercentage;
  final int pitchingSluggingPercentage;
  final int pitchingOnBasePlusSlugging;
  final int pitchingStrikeoutsPerNineInnings;
  final int pitchingWalksPerNineInnings;
  final int pitchingBattingAverageOnBallsInPlay;
  final int pitchingWeightedOnBasePercentage;
  final int doublePlays;
  final int pitchingDoublePlays;
  final bool battingOrderConfirmed;
  final double isolatedPower;
  final int fieldingIndependentPitching;
  final int pitchingQualityStarts;
  final dynamic pitchingInningStarted;
  final int leftOnBase;
  final int pitchingHolds;
  final int pitchingBlownSaves;
  final dynamic substituteBattingOrder;
  final dynamic substituteBattingOrderSequence;
  final int fantasyPointsFantasyDraft;

  MlbPlayerStats copyWith({
    int statId,
    int teamId,
    int playerId,
    int seasonType,
    int season,
    String name,
    String team,
    String position,
    String positionCategory,
    int started,
    dynamic battingOrder,
    int globalTeamId,
    dynamic averageDraftPosition,
    dynamic auctionValue,
    DateTime updated,
    int games,
    int fantasyPoints,
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
    int inningsPitchedDecimal,
    int totalOutsPitched,
    int inningsPitchedFull,
    int inningsPitchedOuts,
    int earnedRunAverage,
    int pitchingHits,
    int pitchingRuns,
    int pitchingEarnedRuns,
    int pitchingWalks,
    int pitchingStrikeouts,
    int pitchingHomeRuns,
    int pitchesThrown,
    int pitchesThrownStrikes,
    int walksHitsPerInningsPitched,
    int pitchingBattingAverageAgainst,
    int grandSlams,
    double fantasyPointsFanDuel,
    int fantasyPointsDraftKings,
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
    int pitchingOnBasePercentage,
    int pitchingSluggingPercentage,
    int pitchingOnBasePlusSlugging,
    int pitchingStrikeoutsPerNineInnings,
    int pitchingWalksPerNineInnings,
    int pitchingBattingAverageOnBallsInPlay,
    int pitchingWeightedOnBasePercentage,
    int doublePlays,
    int pitchingDoublePlays,
    bool battingOrderConfirmed,
    double isolatedPower,
    int fieldingIndependentPitching,
    int pitchingQualityStarts,
    dynamic pitchingInningStarted,
    int leftOnBase,
    int pitchingHolds,
    int pitchingBlownSaves,
    dynamic substituteBattingOrder,
    dynamic substituteBattingOrderSequence,
    int fantasyPointsFantasyDraft,
  }) =>
      MlbPlayerStats(
        statId: statId ?? this.statId,
        teamId: teamId ?? this.teamId,
        playerId: playerId ?? this.playerId,
        seasonType: seasonType ?? this.seasonType,
        season: season ?? this.season,
        name: name ?? this.name,
        team: team ?? this.team,
        position: position ?? this.position,
        positionCategory: positionCategory ?? this.positionCategory,
        started: started ?? this.started,
        battingOrder: battingOrder ?? this.battingOrder,
        globalTeamId: globalTeamId ?? this.globalTeamId,
        averageDraftPosition: averageDraftPosition ?? this.averageDraftPosition,
        auctionValue: auctionValue ?? this.auctionValue,
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

  Map<String, dynamic> toMap() => {
        'StatID': statId,
        'TeamID': teamId,
        'PlayerID': playerId,
        'SeasonType': seasonType,
        'Season': season,
        'Name': name,
        'Team': team,
        'Position': position,
        'PositionCategory': positionCategory,
        'Started': started,
        'BattingOrder': battingOrder,
        'GlobalTeamID': globalTeamId,
        'AverageDraftPosition': averageDraftPosition,
        'AuctionValue': auctionValue,
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
}
