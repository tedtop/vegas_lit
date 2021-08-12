import 'dart:convert';

class NflPlayerStats {
  NflPlayerStats({
    this.playerId,
    this.seasonType,
    this.season,
    this.team,
    this.number,
    this.name,
    this.position,
    this.positionCategory,
    this.activated,
    this.played,
    this.started,
    this.passingAttempts,
    this.passingCompletions,
    this.passingYards,
    this.passingCompletionPercentage,
    this.passingYardsPerAttempt,
    this.passingYardsPerCompletion,
    this.passingTouchdowns,
    this.passingInterceptions,
    this.passingRating,
    this.passingLong,
    this.passingSacks,
    this.passingSackYards,
    this.rushingAttempts,
    this.rushingYards,
    this.rushingYardsPerAttempt,
    this.rushingTouchdowns,
    this.rushingLong,
    this.receivingTargets,
    this.receptions,
    this.receivingYards,
    this.receivingYardsPerReception,
    this.receivingTouchdowns,
    this.receivingLong,
    this.fumbles,
    this.fumblesLost,
    this.puntReturns,
    this.puntReturnYards,
    this.puntReturnYardsPerAttempt,
    this.puntReturnTouchdowns,
    this.puntReturnLong,
    this.kickReturns,
    this.kickReturnYards,
    this.kickReturnYardsPerAttempt,
    this.kickReturnTouchdowns,
    this.kickReturnLong,
    this.soloTackles,
    this.assistedTackles,
    this.tacklesForLoss,
    this.sacks,
    this.sackYards,
    this.quarterbackHits,
    this.passesDefended,
    this.fumblesForced,
    this.fumblesRecovered,
    this.fumbleReturnYards,
    this.fumbleReturnTouchdowns,
    this.interceptions,
    this.interceptionReturnYards,
    this.interceptionReturnTouchdowns,
    this.blockedKicks,
    this.specialTeamsSoloTackles,
    this.specialTeamsAssistedTackles,
    this.miscSoloTackles,
    this.miscAssistedTackles,
    this.punts,
    this.puntYards,
    this.puntAverage,
    this.fieldGoalsAttempted,
    this.fieldGoalsMade,
    this.fieldGoalsLongestMade,
    this.extraPointsMade,
    this.twoPointConversionPasses,
    this.twoPointConversionRuns,
    this.twoPointConversionReceptions,
    this.fantasyPoints,
    this.fantasyPointsPpr,
    this.receptionPercentage,
    this.receivingYardsPerTarget,
    this.tackles,
    this.offensiveTouchdowns,
    this.defensiveTouchdowns,
    this.specialTeamsTouchdowns,
    this.touchdowns,
    this.fantasyPosition,
    this.fieldGoalPercentage,
    this.playerSeasonId,
    this.fumblesOwnRecoveries,
    this.fumblesOutOfBounds,
    this.kickReturnFairCatches,
    this.puntReturnFairCatches,
    this.puntTouchbacks,
    this.puntInside20,
    this.puntNetAverage,
    this.extraPointsAttempted,
    this.blockedKickReturnTouchdowns,
    this.fieldGoalReturnTouchdowns,
    this.safeties,
    this.fieldGoalsHadBlocked,
    this.puntsHadBlocked,
    this.extraPointsHadBlocked,
    this.puntLong,
    this.blockedKickReturnYards,
    this.fieldGoalReturnYards,
    this.puntNetYards,
    this.specialTeamsFumblesForced,
    this.specialTeamsFumblesRecovered,
    this.miscFumblesForced,
    this.miscFumblesRecovered,
    this.shortName,
    this.safetiesAllowed,
    this.temperature,
    this.humidity,
    this.windSpeed,
    this.offensiveSnapsPlayed,
    this.defensiveSnapsPlayed,
    this.specialTeamsSnapsPlayed,
    this.offensiveTeamSnaps,
    this.defensiveTeamSnaps,
    this.specialTeamsTeamSnaps,
    this.auctionValue,
    this.auctionValuePpr,
    this.twoPointConversionReturns,
    this.fantasyPointsFanDuel,
    this.fieldGoalsMade0To19,
    this.fieldGoalsMade20To29,
    this.fieldGoalsMade30To39,
    this.fieldGoalsMade40To49,
    this.fieldGoalsMade50Plus,
    this.fantasyPointsDraftKings,
    this.fantasyPointsYahoo,
    this.averageDraftPosition,
    this.averageDraftPositionPpr,
    this.teamId,
    this.globalTeamId,
    this.fantasyPointsFantasyDraft,
    this.averageDraftPositionRookie,
    this.averageDraftPositionDynasty,
    this.averageDraftPosition2Qb,
    this.scoringDetails,
  });

  factory NflPlayerStats.fromJson(String str) =>
      NflPlayerStats.fromMap(json.decode(str));

  factory NflPlayerStats.fromMap(Map<String, dynamic> json) => NflPlayerStats(
        playerId: json['PlayerID'],
        seasonType: json['SeasonType'],
        season: json['Season'],
        team: json['Team'],
        number: json['Number'],
        name: json['Name'],
        position: json['Position'],
        positionCategory: json['PositionCategory'],
        activated: json['Activated'],
        played: json['Played'],
        started: json['Started'],
        passingAttempts: json['PassingAttempts'],
        passingCompletions: json['PassingCompletions'],
        passingYards: json['PassingYards'],
        passingCompletionPercentage: json['PassingCompletionPercentage'],
        passingYardsPerAttempt: json['PassingYardsPerAttempt'],
        passingYardsPerCompletion: json['PassingYardsPerCompletion'],
        passingTouchdowns: json['PassingTouchdowns'],
        passingInterceptions: json['PassingInterceptions'],
        passingRating: json['PassingRating'],
        passingLong: json['PassingLong'],
        passingSacks: json['PassingSacks'],
        passingSackYards: json['PassingSackYards'],
        rushingAttempts: json['RushingAttempts'],
        rushingYards: json['RushingYards'],
        rushingYardsPerAttempt: json['RushingYardsPerAttempt'],
        rushingTouchdowns: json['RushingTouchdowns'],
        rushingLong: json['RushingLong'],
        receivingTargets: json['ReceivingTargets'],
        receptions: json['Receptions'],
        receivingYards: json['ReceivingYards'],
        receivingYardsPerReception: json['ReceivingYardsPerReception'],
        receivingTouchdowns: json['ReceivingTouchdowns'],
        receivingLong: json['ReceivingLong'],
        fumbles: json['Fumbles'],
        fumblesLost: json['FumblesLost'],
        puntReturns: json['PuntReturns'],
        puntReturnYards: json['PuntReturnYards'],
        puntReturnYardsPerAttempt: json['PuntReturnYardsPerAttempt'],
        puntReturnTouchdowns: json['PuntReturnTouchdowns'],
        puntReturnLong: json['PuntReturnLong'],
        kickReturns: json['KickReturns'],
        kickReturnYards: json['KickReturnYards'],
        kickReturnYardsPerAttempt: json['KickReturnYardsPerAttempt'],
        kickReturnTouchdowns: json['KickReturnTouchdowns'],
        kickReturnLong: json['KickReturnLong'],
        soloTackles: json['SoloTackles'],
        assistedTackles: json['AssistedTackles'],
        tacklesForLoss: json['TacklesForLoss'],
        sacks: json['Sacks'],
        sackYards: json['SackYards'],
        quarterbackHits: json['QuarterbackHits'],
        passesDefended: json['PassesDefended'],
        fumblesForced: json['FumblesForced'],
        fumblesRecovered: json['FumblesRecovered'],
        fumbleReturnYards: json['FumbleReturnYards'],
        fumbleReturnTouchdowns: json['FumbleReturnTouchdowns'],
        interceptions: json['Interceptions'],
        interceptionReturnYards: json['InterceptionReturnYards'],
        interceptionReturnTouchdowns: json['InterceptionReturnTouchdowns'],
        blockedKicks: json['BlockedKicks'],
        specialTeamsSoloTackles: json['SpecialTeamsSoloTackles'],
        specialTeamsAssistedTackles: json['SpecialTeamsAssistedTackles'],
        miscSoloTackles: json['MiscSoloTackles'],
        miscAssistedTackles: json['MiscAssistedTackles'],
        punts: json['Punts'],
        puntYards: json['PuntYards'],
        puntAverage: json['PuntAverage'],
        fieldGoalsAttempted: json['FieldGoalsAttempted'],
        fieldGoalsMade: json['FieldGoalsMade'],
        fieldGoalsLongestMade: json['FieldGoalsLongestMade'],
        extraPointsMade: json['ExtraPointsMade'],
        twoPointConversionPasses: json['TwoPointConversionPasses'],
        twoPointConversionRuns: json['TwoPointConversionRuns'],
        twoPointConversionReceptions: json['TwoPointConversionReceptions'],
        fantasyPoints: json['FantasyPoints'].toDouble(),
        fantasyPointsPpr: json['FantasyPointsPPR'].toDouble(),
        receptionPercentage: json['ReceptionPercentage'],
        receivingYardsPerTarget: json['ReceivingYardsPerTarget'],
        tackles: json['Tackles'],
        offensiveTouchdowns: json['OffensiveTouchdowns'],
        defensiveTouchdowns: json['DefensiveTouchdowns'],
        specialTeamsTouchdowns: json['SpecialTeamsTouchdowns'],
        touchdowns: json['Touchdowns'],
        fantasyPosition: json['FantasyPosition'],
        fieldGoalPercentage: json['FieldGoalPercentage'],
        playerSeasonId: json['PlayerSeasonID'],
        fumblesOwnRecoveries: json['FumblesOwnRecoveries'],
        fumblesOutOfBounds: json['FumblesOutOfBounds'],
        kickReturnFairCatches: json['KickReturnFairCatches'],
        puntReturnFairCatches: json['PuntReturnFairCatches'],
        puntTouchbacks: json['PuntTouchbacks'],
        puntInside20: json['PuntInside20'],
        puntNetAverage: json['PuntNetAverage'],
        extraPointsAttempted: json['ExtraPointsAttempted'],
        blockedKickReturnTouchdowns: json['BlockedKickReturnTouchdowns'],
        fieldGoalReturnTouchdowns: json['FieldGoalReturnTouchdowns'],
        safeties: json['Safeties'],
        fieldGoalsHadBlocked: json['FieldGoalsHadBlocked'],
        puntsHadBlocked: json['PuntsHadBlocked'],
        extraPointsHadBlocked: json['ExtraPointsHadBlocked'],
        puntLong: json['PuntLong'],
        blockedKickReturnYards: json['BlockedKickReturnYards'],
        fieldGoalReturnYards: json['FieldGoalReturnYards'],
        puntNetYards: json['PuntNetYards'],
        specialTeamsFumblesForced: json['SpecialTeamsFumblesForced'],
        specialTeamsFumblesRecovered: json['SpecialTeamsFumblesRecovered'],
        miscFumblesForced: json['MiscFumblesForced'],
        miscFumblesRecovered: json['MiscFumblesRecovered'],
        shortName: json['ShortName'],
        safetiesAllowed: json['SafetiesAllowed'],
        temperature: json['Temperature'],
        humidity: json['Humidity'],
        windSpeed: json['WindSpeed'],
        offensiveSnapsPlayed: json['OffensiveSnapsPlayed'],
        defensiveSnapsPlayed: json['DefensiveSnapsPlayed'],
        specialTeamsSnapsPlayed: json['SpecialTeamsSnapsPlayed'],
        offensiveTeamSnaps: json['OffensiveTeamSnaps'],
        defensiveTeamSnaps: json['DefensiveTeamSnaps'],
        specialTeamsTeamSnaps: json['SpecialTeamsTeamSnaps'],
        auctionValue: json['AuctionValue'],
        auctionValuePpr: json['AuctionValuePPR'],
        twoPointConversionReturns: json['TwoPointConversionReturns'],
        fantasyPointsFanDuel: json['FantasyPointsFanDuel'].toDouble(),
        fieldGoalsMade0To19: json['FieldGoalsMade0to19'],
        fieldGoalsMade20To29: json['FieldGoalsMade20to29'],
        fieldGoalsMade30To39: json['FieldGoalsMade30to39'],
        fieldGoalsMade40To49: json['FieldGoalsMade40to49'],
        fieldGoalsMade50Plus: json['FieldGoalsMade50Plus'],
        fantasyPointsDraftKings: json['FantasyPointsDraftKings'].toDouble(),
        fantasyPointsYahoo: json['FantasyPointsYahoo'].toDouble(),
        averageDraftPosition: json['AverageDraftPosition'],
        averageDraftPositionPpr: json['AverageDraftPositionPPR'],
        teamId: json['TeamID'],
        globalTeamId: json['GlobalTeamID'],
        fantasyPointsFantasyDraft: json['FantasyPointsFantasyDraft'].toDouble(),
        averageDraftPositionRookie: json['AverageDraftPositionRookie'],
        averageDraftPositionDynasty: json['AverageDraftPositionDynasty'],
        averageDraftPosition2Qb: json['AverageDraftPosition2QB'],
        scoringDetails:
            List<dynamic>.from(json['ScoringDetails'].map((x) => x)),
      );

  final int playerId;
  final int seasonType;
  final int season;
  final String team;
  final int number;
  final String name;
  final String position;
  final String positionCategory;
  final int activated;
  final int played;
  final int started;
  final int passingAttempts;
  final int passingCompletions;
  final int passingYards;
  final int passingCompletionPercentage;
  final int passingYardsPerAttempt;
  final int passingYardsPerCompletion;
  final int passingTouchdowns;
  final int passingInterceptions;
  final int passingRating;
  final int passingLong;
  final int passingSacks;
  final int passingSackYards;
  final int rushingAttempts;
  final int rushingYards;
  final int rushingYardsPerAttempt;
  final int rushingTouchdowns;
  final int rushingLong;
  final int receivingTargets;
  final int receptions;
  final int receivingYards;
  final int receivingYardsPerReception;
  final int receivingTouchdowns;
  final int receivingLong;
  final int fumbles;
  final int fumblesLost;
  final int puntReturns;
  final int puntReturnYards;
  final int puntReturnYardsPerAttempt;
  final int puntReturnTouchdowns;
  final int puntReturnLong;
  final int kickReturns;
  final int kickReturnYards;
  final int kickReturnYardsPerAttempt;
  final int kickReturnTouchdowns;
  final int kickReturnLong;
  final int soloTackles;
  final int assistedTackles;
  final int tacklesForLoss;
  final int sacks;
  final int sackYards;
  final int quarterbackHits;
  final int passesDefended;
  final int fumblesForced;
  final int fumblesRecovered;
  final int fumbleReturnYards;
  final int fumbleReturnTouchdowns;
  final int interceptions;
  final int interceptionReturnYards;
  final int interceptionReturnTouchdowns;
  final int blockedKicks;
  final int specialTeamsSoloTackles;
  final int specialTeamsAssistedTackles;
  final int miscSoloTackles;
  final int miscAssistedTackles;
  final int punts;
  final int puntYards;
  final int puntAverage;
  final int fieldGoalsAttempted;
  final int fieldGoalsMade;
  final int fieldGoalsLongestMade;
  final int extraPointsMade;
  final int twoPointConversionPasses;
  final int twoPointConversionRuns;
  final int twoPointConversionReceptions;
  final double fantasyPoints;
  final double fantasyPointsPpr;
  final int receptionPercentage;
  final int receivingYardsPerTarget;
  final int tackles;
  final int offensiveTouchdowns;
  final int defensiveTouchdowns;
  final int specialTeamsTouchdowns;
  final int touchdowns;
  final String fantasyPosition;
  final int fieldGoalPercentage;
  final int playerSeasonId;
  final int fumblesOwnRecoveries;
  final int fumblesOutOfBounds;
  final int kickReturnFairCatches;
  final int puntReturnFairCatches;
  final int puntTouchbacks;
  final int puntInside20;
  final int puntNetAverage;
  final int extraPointsAttempted;
  final int blockedKickReturnTouchdowns;
  final int fieldGoalReturnTouchdowns;
  final int safeties;
  final int fieldGoalsHadBlocked;
  final int puntsHadBlocked;
  final int extraPointsHadBlocked;
  final int puntLong;
  final int blockedKickReturnYards;
  final int fieldGoalReturnYards;
  final int puntNetYards;
  final int specialTeamsFumblesForced;
  final int specialTeamsFumblesRecovered;
  final int miscFumblesForced;
  final int miscFumblesRecovered;
  final String shortName;
  final int safetiesAllowed;
  final int temperature;
  final int humidity;
  final int windSpeed;
  final int offensiveSnapsPlayed;
  final int defensiveSnapsPlayed;
  final int specialTeamsSnapsPlayed;
  final int offensiveTeamSnaps;
  final int defensiveTeamSnaps;
  final int specialTeamsTeamSnaps;
  final dynamic auctionValue;
  final dynamic auctionValuePpr;
  final int twoPointConversionReturns;
  final double fantasyPointsFanDuel;
  final int fieldGoalsMade0To19;
  final int fieldGoalsMade20To29;
  final int fieldGoalsMade30To39;
  final int fieldGoalsMade40To49;
  final int fieldGoalsMade50Plus;
  final double fantasyPointsDraftKings;
  final double fantasyPointsYahoo;
  final dynamic averageDraftPosition;
  final dynamic averageDraftPositionPpr;
  final int teamId;
  final int globalTeamId;
  final double fantasyPointsFantasyDraft;
  final dynamic averageDraftPositionRookie;
  final dynamic averageDraftPositionDynasty;
  final dynamic averageDraftPosition2Qb;
  final List<dynamic> scoringDetails;

  NflPlayerStats copyWith({
    int playerId,
    int seasonType,
    int season,
    String team,
    int number,
    String name,
    String position,
    String positionCategory,
    int activated,
    int played,
    int started,
    int passingAttempts,
    int passingCompletions,
    int passingYards,
    int passingCompletionPercentage,
    int passingYardsPerAttempt,
    int passingYardsPerCompletion,
    int passingTouchdowns,
    int passingInterceptions,
    int passingRating,
    int passingLong,
    int passingSacks,
    int passingSackYards,
    int rushingAttempts,
    int rushingYards,
    int rushingYardsPerAttempt,
    int rushingTouchdowns,
    int rushingLong,
    int receivingTargets,
    int receptions,
    int receivingYards,
    int receivingYardsPerReception,
    int receivingTouchdowns,
    int receivingLong,
    int fumbles,
    int fumblesLost,
    int puntReturns,
    int puntReturnYards,
    int puntReturnYardsPerAttempt,
    int puntReturnTouchdowns,
    int puntReturnLong,
    int kickReturns,
    int kickReturnYards,
    int kickReturnYardsPerAttempt,
    int kickReturnTouchdowns,
    int kickReturnLong,
    int soloTackles,
    int assistedTackles,
    int tacklesForLoss,
    int sacks,
    int sackYards,
    int quarterbackHits,
    int passesDefended,
    int fumblesForced,
    int fumblesRecovered,
    int fumbleReturnYards,
    int fumbleReturnTouchdowns,
    int interceptions,
    int interceptionReturnYards,
    int interceptionReturnTouchdowns,
    int blockedKicks,
    int specialTeamsSoloTackles,
    int specialTeamsAssistedTackles,
    int miscSoloTackles,
    int miscAssistedTackles,
    int punts,
    int puntYards,
    int puntAverage,
    int fieldGoalsAttempted,
    int fieldGoalsMade,
    int fieldGoalsLongestMade,
    int extraPointsMade,
    int twoPointConversionPasses,
    int twoPointConversionRuns,
    int twoPointConversionReceptions,
    double fantasyPoints,
    double fantasyPointsPpr,
    int receptionPercentage,
    int receivingYardsPerTarget,
    int tackles,
    int offensiveTouchdowns,
    int defensiveTouchdowns,
    int specialTeamsTouchdowns,
    int touchdowns,
    String fantasyPosition,
    int fieldGoalPercentage,
    int playerSeasonId,
    int fumblesOwnRecoveries,
    int fumblesOutOfBounds,
    int kickReturnFairCatches,
    int puntReturnFairCatches,
    int puntTouchbacks,
    int puntInside20,
    int puntNetAverage,
    int extraPointsAttempted,
    int blockedKickReturnTouchdowns,
    int fieldGoalReturnTouchdowns,
    int safeties,
    int fieldGoalsHadBlocked,
    int puntsHadBlocked,
    int extraPointsHadBlocked,
    int puntLong,
    int blockedKickReturnYards,
    int fieldGoalReturnYards,
    int puntNetYards,
    int specialTeamsFumblesForced,
    int specialTeamsFumblesRecovered,
    int miscFumblesForced,
    int miscFumblesRecovered,
    String shortName,
    int safetiesAllowed,
    int temperature,
    int humidity,
    int windSpeed,
    int offensiveSnapsPlayed,
    int defensiveSnapsPlayed,
    int specialTeamsSnapsPlayed,
    int offensiveTeamSnaps,
    int defensiveTeamSnaps,
    int specialTeamsTeamSnaps,
    dynamic auctionValue,
    dynamic auctionValuePpr,
    int twoPointConversionReturns,
    double fantasyPointsFanDuel,
    int fieldGoalsMade0To19,
    int fieldGoalsMade20To29,
    int fieldGoalsMade30To39,
    int fieldGoalsMade40To49,
    int fieldGoalsMade50Plus,
    double fantasyPointsDraftKings,
    double fantasyPointsYahoo,
    dynamic averageDraftPosition,
    dynamic averageDraftPositionPpr,
    int teamId,
    int globalTeamId,
    double fantasyPointsFantasyDraft,
    dynamic averageDraftPositionRookie,
    dynamic averageDraftPositionDynasty,
    dynamic averageDraftPosition2Qb,
    List<dynamic> scoringDetails,
  }) =>
      NflPlayerStats(
        playerId: playerId ?? this.playerId,
        seasonType: seasonType ?? this.seasonType,
        season: season ?? this.season,
        team: team ?? this.team,
        number: number ?? this.number,
        name: name ?? this.name,
        position: position ?? this.position,
        positionCategory: positionCategory ?? this.positionCategory,
        activated: activated ?? this.activated,
        played: played ?? this.played,
        started: started ?? this.started,
        passingAttempts: passingAttempts ?? this.passingAttempts,
        passingCompletions: passingCompletions ?? this.passingCompletions,
        passingYards: passingYards ?? this.passingYards,
        passingCompletionPercentage:
            passingCompletionPercentage ?? this.passingCompletionPercentage,
        passingYardsPerAttempt:
            passingYardsPerAttempt ?? this.passingYardsPerAttempt,
        passingYardsPerCompletion:
            passingYardsPerCompletion ?? this.passingYardsPerCompletion,
        passingTouchdowns: passingTouchdowns ?? this.passingTouchdowns,
        passingInterceptions: passingInterceptions ?? this.passingInterceptions,
        passingRating: passingRating ?? this.passingRating,
        passingLong: passingLong ?? this.passingLong,
        passingSacks: passingSacks ?? this.passingSacks,
        passingSackYards: passingSackYards ?? this.passingSackYards,
        rushingAttempts: rushingAttempts ?? this.rushingAttempts,
        rushingYards: rushingYards ?? this.rushingYards,
        rushingYardsPerAttempt:
            rushingYardsPerAttempt ?? this.rushingYardsPerAttempt,
        rushingTouchdowns: rushingTouchdowns ?? this.rushingTouchdowns,
        rushingLong: rushingLong ?? this.rushingLong,
        receivingTargets: receivingTargets ?? this.receivingTargets,
        receptions: receptions ?? this.receptions,
        receivingYards: receivingYards ?? this.receivingYards,
        receivingYardsPerReception:
            receivingYardsPerReception ?? this.receivingYardsPerReception,
        receivingTouchdowns: receivingTouchdowns ?? this.receivingTouchdowns,
        receivingLong: receivingLong ?? this.receivingLong,
        fumbles: fumbles ?? this.fumbles,
        fumblesLost: fumblesLost ?? this.fumblesLost,
        puntReturns: puntReturns ?? this.puntReturns,
        puntReturnYards: puntReturnYards ?? this.puntReturnYards,
        puntReturnYardsPerAttempt:
            puntReturnYardsPerAttempt ?? this.puntReturnYardsPerAttempt,
        puntReturnTouchdowns: puntReturnTouchdowns ?? this.puntReturnTouchdowns,
        puntReturnLong: puntReturnLong ?? this.puntReturnLong,
        kickReturns: kickReturns ?? this.kickReturns,
        kickReturnYards: kickReturnYards ?? this.kickReturnYards,
        kickReturnYardsPerAttempt:
            kickReturnYardsPerAttempt ?? this.kickReturnYardsPerAttempt,
        kickReturnTouchdowns: kickReturnTouchdowns ?? this.kickReturnTouchdowns,
        kickReturnLong: kickReturnLong ?? this.kickReturnLong,
        soloTackles: soloTackles ?? this.soloTackles,
        assistedTackles: assistedTackles ?? this.assistedTackles,
        tacklesForLoss: tacklesForLoss ?? this.tacklesForLoss,
        sacks: sacks ?? this.sacks,
        sackYards: sackYards ?? this.sackYards,
        quarterbackHits: quarterbackHits ?? this.quarterbackHits,
        passesDefended: passesDefended ?? this.passesDefended,
        fumblesForced: fumblesForced ?? this.fumblesForced,
        fumblesRecovered: fumblesRecovered ?? this.fumblesRecovered,
        fumbleReturnYards: fumbleReturnYards ?? this.fumbleReturnYards,
        fumbleReturnTouchdowns:
            fumbleReturnTouchdowns ?? this.fumbleReturnTouchdowns,
        interceptions: interceptions ?? this.interceptions,
        interceptionReturnYards:
            interceptionReturnYards ?? this.interceptionReturnYards,
        interceptionReturnTouchdowns:
            interceptionReturnTouchdowns ?? this.interceptionReturnTouchdowns,
        blockedKicks: blockedKicks ?? this.blockedKicks,
        specialTeamsSoloTackles:
            specialTeamsSoloTackles ?? this.specialTeamsSoloTackles,
        specialTeamsAssistedTackles:
            specialTeamsAssistedTackles ?? this.specialTeamsAssistedTackles,
        miscSoloTackles: miscSoloTackles ?? this.miscSoloTackles,
        miscAssistedTackles: miscAssistedTackles ?? this.miscAssistedTackles,
        punts: punts ?? this.punts,
        puntYards: puntYards ?? this.puntYards,
        puntAverage: puntAverage ?? this.puntAverage,
        fieldGoalsAttempted: fieldGoalsAttempted ?? this.fieldGoalsAttempted,
        fieldGoalsMade: fieldGoalsMade ?? this.fieldGoalsMade,
        fieldGoalsLongestMade:
            fieldGoalsLongestMade ?? this.fieldGoalsLongestMade,
        extraPointsMade: extraPointsMade ?? this.extraPointsMade,
        twoPointConversionPasses:
            twoPointConversionPasses ?? this.twoPointConversionPasses,
        twoPointConversionRuns:
            twoPointConversionRuns ?? this.twoPointConversionRuns,
        twoPointConversionReceptions:
            twoPointConversionReceptions ?? this.twoPointConversionReceptions,
        fantasyPoints: fantasyPoints ?? this.fantasyPoints,
        fantasyPointsPpr: fantasyPointsPpr ?? this.fantasyPointsPpr,
        receptionPercentage: receptionPercentage ?? this.receptionPercentage,
        receivingYardsPerTarget:
            receivingYardsPerTarget ?? this.receivingYardsPerTarget,
        tackles: tackles ?? this.tackles,
        offensiveTouchdowns: offensiveTouchdowns ?? this.offensiveTouchdowns,
        defensiveTouchdowns: defensiveTouchdowns ?? this.defensiveTouchdowns,
        specialTeamsTouchdowns:
            specialTeamsTouchdowns ?? this.specialTeamsTouchdowns,
        touchdowns: touchdowns ?? this.touchdowns,
        fantasyPosition: fantasyPosition ?? this.fantasyPosition,
        fieldGoalPercentage: fieldGoalPercentage ?? this.fieldGoalPercentage,
        playerSeasonId: playerSeasonId ?? this.playerSeasonId,
        fumblesOwnRecoveries: fumblesOwnRecoveries ?? this.fumblesOwnRecoveries,
        fumblesOutOfBounds: fumblesOutOfBounds ?? this.fumblesOutOfBounds,
        kickReturnFairCatches:
            kickReturnFairCatches ?? this.kickReturnFairCatches,
        puntReturnFairCatches:
            puntReturnFairCatches ?? this.puntReturnFairCatches,
        puntTouchbacks: puntTouchbacks ?? this.puntTouchbacks,
        puntInside20: puntInside20 ?? this.puntInside20,
        puntNetAverage: puntNetAverage ?? this.puntNetAverage,
        extraPointsAttempted: extraPointsAttempted ?? this.extraPointsAttempted,
        blockedKickReturnTouchdowns:
            blockedKickReturnTouchdowns ?? this.blockedKickReturnTouchdowns,
        fieldGoalReturnTouchdowns:
            fieldGoalReturnTouchdowns ?? this.fieldGoalReturnTouchdowns,
        safeties: safeties ?? this.safeties,
        fieldGoalsHadBlocked: fieldGoalsHadBlocked ?? this.fieldGoalsHadBlocked,
        puntsHadBlocked: puntsHadBlocked ?? this.puntsHadBlocked,
        extraPointsHadBlocked:
            extraPointsHadBlocked ?? this.extraPointsHadBlocked,
        puntLong: puntLong ?? this.puntLong,
        blockedKickReturnYards:
            blockedKickReturnYards ?? this.blockedKickReturnYards,
        fieldGoalReturnYards: fieldGoalReturnYards ?? this.fieldGoalReturnYards,
        puntNetYards: puntNetYards ?? this.puntNetYards,
        specialTeamsFumblesForced:
            specialTeamsFumblesForced ?? this.specialTeamsFumblesForced,
        specialTeamsFumblesRecovered:
            specialTeamsFumblesRecovered ?? this.specialTeamsFumblesRecovered,
        miscFumblesForced: miscFumblesForced ?? this.miscFumblesForced,
        miscFumblesRecovered: miscFumblesRecovered ?? this.miscFumblesRecovered,
        shortName: shortName ?? this.shortName,
        safetiesAllowed: safetiesAllowed ?? this.safetiesAllowed,
        temperature: temperature ?? this.temperature,
        humidity: humidity ?? this.humidity,
        windSpeed: windSpeed ?? this.windSpeed,
        offensiveSnapsPlayed: offensiveSnapsPlayed ?? this.offensiveSnapsPlayed,
        defensiveSnapsPlayed: defensiveSnapsPlayed ?? this.defensiveSnapsPlayed,
        specialTeamsSnapsPlayed:
            specialTeamsSnapsPlayed ?? this.specialTeamsSnapsPlayed,
        offensiveTeamSnaps: offensiveTeamSnaps ?? this.offensiveTeamSnaps,
        defensiveTeamSnaps: defensiveTeamSnaps ?? this.defensiveTeamSnaps,
        specialTeamsTeamSnaps:
            specialTeamsTeamSnaps ?? this.specialTeamsTeamSnaps,
        auctionValue: auctionValue ?? this.auctionValue,
        auctionValuePpr: auctionValuePpr ?? this.auctionValuePpr,
        twoPointConversionReturns:
            twoPointConversionReturns ?? this.twoPointConversionReturns,
        fantasyPointsFanDuel: fantasyPointsFanDuel ?? this.fantasyPointsFanDuel,
        fieldGoalsMade0To19: fieldGoalsMade0To19 ?? this.fieldGoalsMade0To19,
        fieldGoalsMade20To29: fieldGoalsMade20To29 ?? this.fieldGoalsMade20To29,
        fieldGoalsMade30To39: fieldGoalsMade30To39 ?? this.fieldGoalsMade30To39,
        fieldGoalsMade40To49: fieldGoalsMade40To49 ?? this.fieldGoalsMade40To49,
        fieldGoalsMade50Plus: fieldGoalsMade50Plus ?? this.fieldGoalsMade50Plus,
        fantasyPointsDraftKings:
            fantasyPointsDraftKings ?? this.fantasyPointsDraftKings,
        fantasyPointsYahoo: fantasyPointsYahoo ?? this.fantasyPointsYahoo,
        averageDraftPosition: averageDraftPosition ?? this.averageDraftPosition,
        averageDraftPositionPpr:
            averageDraftPositionPpr ?? this.averageDraftPositionPpr,
        teamId: teamId ?? this.teamId,
        globalTeamId: globalTeamId ?? this.globalTeamId,
        fantasyPointsFantasyDraft:
            fantasyPointsFantasyDraft ?? this.fantasyPointsFantasyDraft,
        averageDraftPositionRookie:
            averageDraftPositionRookie ?? this.averageDraftPositionRookie,
        averageDraftPositionDynasty:
            averageDraftPositionDynasty ?? this.averageDraftPositionDynasty,
        averageDraftPosition2Qb:
            averageDraftPosition2Qb ?? this.averageDraftPosition2Qb,
        scoringDetails: scoringDetails ?? this.scoringDetails,
      );
  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'PlayerID': playerId,
        'SeasonType': seasonType,
        'Season': season,
        'Team': team,
        'Number': number,
        'Name': name,
        'Position': position,
        'PositionCategory': positionCategory,
        'Activated': activated,
        'Played': played,
        'Started': started,
        'PassingAttempts': passingAttempts,
        'PassingCompletions': passingCompletions,
        'PassingYards': passingYards,
        'PassingCompletionPercentage': passingCompletionPercentage,
        'PassingYardsPerAttempt': passingYardsPerAttempt,
        'PassingYardsPerCompletion': passingYardsPerCompletion,
        'PassingTouchdowns': passingTouchdowns,
        'PassingInterceptions': passingInterceptions,
        'PassingRating': passingRating,
        'PassingLong': passingLong,
        'PassingSacks': passingSacks,
        'PassingSackYards': passingSackYards,
        'RushingAttempts': rushingAttempts,
        'RushingYards': rushingYards,
        'RushingYardsPerAttempt': rushingYardsPerAttempt,
        'RushingTouchdowns': rushingTouchdowns,
        'RushingLong': rushingLong,
        'ReceivingTargets': receivingTargets,
        'Receptions': receptions,
        'ReceivingYards': receivingYards,
        'ReceivingYardsPerReception': receivingYardsPerReception,
        'ReceivingTouchdowns': receivingTouchdowns,
        'ReceivingLong': receivingLong,
        'Fumbles': fumbles,
        'FumblesLost': fumblesLost,
        'PuntReturns': puntReturns,
        'PuntReturnYards': puntReturnYards,
        'PuntReturnYardsPerAttempt': puntReturnYardsPerAttempt,
        'PuntReturnTouchdowns': puntReturnTouchdowns,
        'PuntReturnLong': puntReturnLong,
        'KickReturns': kickReturns,
        'KickReturnYards': kickReturnYards,
        'KickReturnYardsPerAttempt': kickReturnYardsPerAttempt,
        'KickReturnTouchdowns': kickReturnTouchdowns,
        'KickReturnLong': kickReturnLong,
        'SoloTackles': soloTackles,
        'AssistedTackles': assistedTackles,
        'TacklesForLoss': tacklesForLoss,
        'Sacks': sacks,
        'SackYards': sackYards,
        'QuarterbackHits': quarterbackHits,
        'PassesDefended': passesDefended,
        'FumblesForced': fumblesForced,
        'FumblesRecovered': fumblesRecovered,
        'FumbleReturnYards': fumbleReturnYards,
        'FumbleReturnTouchdowns': fumbleReturnTouchdowns,
        'Interceptions': interceptions,
        'InterceptionReturnYards': interceptionReturnYards,
        'InterceptionReturnTouchdowns': interceptionReturnTouchdowns,
        'BlockedKicks': blockedKicks,
        'SpecialTeamsSoloTackles': specialTeamsSoloTackles,
        'SpecialTeamsAssistedTackles': specialTeamsAssistedTackles,
        'MiscSoloTackles': miscSoloTackles,
        'MiscAssistedTackles': miscAssistedTackles,
        'Punts': punts,
        'PuntYards': puntYards,
        'PuntAverage': puntAverage,
        'FieldGoalsAttempted': fieldGoalsAttempted,
        'FieldGoalsMade': fieldGoalsMade,
        'FieldGoalsLongestMade': fieldGoalsLongestMade,
        'ExtraPointsMade': extraPointsMade,
        'TwoPointConversionPasses': twoPointConversionPasses,
        'TwoPointConversionRuns': twoPointConversionRuns,
        'TwoPointConversionReceptions': twoPointConversionReceptions,
        'FantasyPoints': fantasyPoints,
        'FantasyPointsPPR': fantasyPointsPpr,
        'ReceptionPercentage': receptionPercentage,
        'ReceivingYardsPerTarget': receivingYardsPerTarget,
        'Tackles': tackles,
        'OffensiveTouchdowns': offensiveTouchdowns,
        'DefensiveTouchdowns': defensiveTouchdowns,
        'SpecialTeamsTouchdowns': specialTeamsTouchdowns,
        'Touchdowns': touchdowns,
        'FantasyPosition': fantasyPosition,
        'FieldGoalPercentage': fieldGoalPercentage,
        'PlayerSeasonID': playerSeasonId,
        'FumblesOwnRecoveries': fumblesOwnRecoveries,
        'FumblesOutOfBounds': fumblesOutOfBounds,
        'KickReturnFairCatches': kickReturnFairCatches,
        'PuntReturnFairCatches': puntReturnFairCatches,
        'PuntTouchbacks': puntTouchbacks,
        'PuntInside20': puntInside20,
        'PuntNetAverage': puntNetAverage,
        'ExtraPointsAttempted': extraPointsAttempted,
        'BlockedKickReturnTouchdowns': blockedKickReturnTouchdowns,
        'FieldGoalReturnTouchdowns': fieldGoalReturnTouchdowns,
        'Safeties': safeties,
        'FieldGoalsHadBlocked': fieldGoalsHadBlocked,
        'PuntsHadBlocked': puntsHadBlocked,
        'ExtraPointsHadBlocked': extraPointsHadBlocked,
        'PuntLong': puntLong,
        'BlockedKickReturnYards': blockedKickReturnYards,
        'FieldGoalReturnYards': fieldGoalReturnYards,
        'PuntNetYards': puntNetYards,
        'SpecialTeamsFumblesForced': specialTeamsFumblesForced,
        'SpecialTeamsFumblesRecovered': specialTeamsFumblesRecovered,
        'MiscFumblesForced': miscFumblesForced,
        'MiscFumblesRecovered': miscFumblesRecovered,
        'ShortName': shortName,
        'SafetiesAllowed': safetiesAllowed,
        'Temperature': temperature,
        'Humidity': humidity,
        'WindSpeed': windSpeed,
        'OffensiveSnapsPlayed': offensiveSnapsPlayed,
        'DefensiveSnapsPlayed': defensiveSnapsPlayed,
        'SpecialTeamsSnapsPlayed': specialTeamsSnapsPlayed,
        'OffensiveTeamSnaps': offensiveTeamSnaps,
        'DefensiveTeamSnaps': defensiveTeamSnaps,
        'SpecialTeamsTeamSnaps': specialTeamsTeamSnaps,
        'AuctionValue': auctionValue,
        'AuctionValuePPR': auctionValuePpr,
        'TwoPointConversionReturns': twoPointConversionReturns,
        'FantasyPointsFanDuel': fantasyPointsFanDuel,
        'FieldGoalsMade0to19': fieldGoalsMade0To19,
        'FieldGoalsMade20to29': fieldGoalsMade20To29,
        'FieldGoalsMade30to39': fieldGoalsMade30To39,
        'FieldGoalsMade40to49': fieldGoalsMade40To49,
        'FieldGoalsMade50Plus': fieldGoalsMade50Plus,
        'FantasyPointsDraftKings': fantasyPointsDraftKings,
        'FantasyPointsYahoo': fantasyPointsYahoo,
        'AverageDraftPosition': averageDraftPosition,
        'AverageDraftPositionPPR': averageDraftPositionPpr,
        'TeamID': teamId,
        'GlobalTeamID': globalTeamId,
        'FantasyPointsFantasyDraft': fantasyPointsFantasyDraft,
        'AverageDraftPositionRookie': averageDraftPositionRookie,
        'AverageDraftPositionDynasty': averageDraftPositionDynasty,
        'AverageDraftPosition2QB': averageDraftPosition2Qb,
        'ScoringDetails': List<dynamic>.from(scoringDetails.map((x) => x)),
      };
}
