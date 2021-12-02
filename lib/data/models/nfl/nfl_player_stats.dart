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
      NflPlayerStats.fromMap(json.decode(str) as Map<String, dynamic>);

  factory NflPlayerStats.fromMap(Map<String, dynamic> json) => NflPlayerStats(
        playerId: json['PlayerID']?.toInt() as int?,
        seasonType: json['SeasonType']?.toInt() as int?,
        season: json['Season']?.toInt() as int?,
        team: json['Team'] as String?,
        number: json['Number']?.toInt() as int?,
        name: json['Name'] as String?,
        position: json['Position'] as String?,
        positionCategory: json['PositionCategory'] as String?,
        activated: json['Activated']?.toInt() as int?,
        played: json['Played']?.toInt() as int?,
        started: json['Started']?.toInt() as int?,
        passingAttempts: json['PassingAttempts']?.toInt() as int?,
        passingCompletions: json['PassingCompletions']?.toInt() as int?,
        passingYards: json['PassingYards']?.toInt() as int?,
        passingCompletionPercentage:
            json['PassingCompletionPercentage']?.toInt() as int?,
        passingYardsPerAttempt: json['PassingYardsPerAttempt']?.toInt() as int?,
        passingYardsPerCompletion:
            json['PassingYardsPerCompletion']?.toInt() as int?,
        passingTouchdowns: json['PassingTouchdowns']?.toInt() as int?,
        passingInterceptions: json['PassingInterceptions']?.toInt() as int?,
        passingRating: json['PassingRating']?.toInt() as int?,
        passingLong: json['PassingLong']?.toInt() as int?,
        passingSacks: json['PassingSacks']?.toInt() as int?,
        passingSackYards: json['PassingSackYards']?.toInt() as int?,
        rushingAttempts: json['RushingAttempts']?.toInt() as int?,
        rushingYards: json['RushingYards']?.toInt() as int?,
        rushingYardsPerAttempt: json['RushingYardsPerAttempt']?.toInt() as int?,
        rushingTouchdowns: json['RushingTouchdowns']?.toInt() as int?,
        rushingLong: json['RushingLong']?.toInt() as int?,
        receivingTargets: json['ReceivingTargets']?.toInt() as int?,
        receptions: json['Receptions']?.toInt() as int?,
        receivingYards: json['ReceivingYards']?.toInt() as int?,
        receivingYardsPerReception:
            json['ReceivingYardsPerReception']?.toInt() as int?,
        receivingTouchdowns: json['ReceivingTouchdowns']?.toInt() as int?,
        receivingLong: json['ReceivingLong']?.toInt() as int?,
        fumbles: json['Fumbles']?.toInt() as int?,
        fumblesLost: json['FumblesLost']?.toInt() as int?,
        puntReturns: json['PuntReturns']?.toInt() as int?,
        puntReturnYards: json['PuntReturnYards']?.toInt() as int?,
        puntReturnYardsPerAttempt:
            json['PuntReturnYardsPerAttempt']?.toInt() as int?,
        puntReturnTouchdowns: json['PuntReturnTouchdowns']?.toInt() as int?,
        puntReturnLong: json['PuntReturnLong']?.toInt() as int?,
        kickReturns: json['KickReturns']?.toInt() as int?,
        kickReturnYards: json['KickReturnYards']?.toInt() as int?,
        kickReturnYardsPerAttempt:
            json['KickReturnYardsPerAttempt']?.toInt() as int?,
        kickReturnTouchdowns: json['KickReturnTouchdowns']?.toInt() as int?,
        kickReturnLong: json['KickReturnLong']?.toInt() as int?,
        soloTackles: json['SoloTackles']?.toInt() as int?,
        assistedTackles: json['AssistedTackles']?.toInt() as int?,
        tacklesForLoss: json['TacklesForLoss']?.toInt() as int?,
        sacks: json['Sacks']?.toInt() as int?,
        sackYards: json['SackYards']?.toInt() as int?,
        quarterbackHits: json['QuarterbackHits']?.toInt() as int?,
        passesDefended: json['PassesDefended']?.toInt() as int?,
        fumblesForced: json['FumblesForced']?.toInt() as int?,
        fumblesRecovered: json['FumblesRecovered']?.toInt() as int?,
        fumbleReturnYards: json['FumbleReturnYards']?.toInt() as int?,
        fumbleReturnTouchdowns: json['FumbleReturnTouchdowns']?.toInt() as int?,
        interceptions: json['Interceptions']?.toInt() as int?,
        interceptionReturnYards:
            json['InterceptionReturnYards']?.toInt() as int?,
        interceptionReturnTouchdowns:
            json['InterceptionReturnTouchdowns']?.toInt() as int?,
        blockedKicks: json['BlockedKicks']?.toInt() as int?,
        specialTeamsSoloTackles:
            json['SpecialTeamsSoloTackles']?.toInt() as int?,
        specialTeamsAssistedTackles:
            json['SpecialTeamsAssistedTackles']?.toInt() as int?,
        miscSoloTackles: json['MiscSoloTackles']?.toInt() as int?,
        miscAssistedTackles: json['MiscAssistedTackles']?.toInt() as int?,
        punts: json['Punts']?.toInt() as int?,
        puntYards: json['PuntYards']?.toInt() as int?,
        puntAverage: json['PuntAverage']?.toInt() as int?,
        fieldGoalsAttempted: json['FieldGoalsAttempted']?.toInt() as int?,
        fieldGoalsMade: json['FieldGoalsMade']?.toInt() as int?,
        fieldGoalsLongestMade: json['FieldGoalsLongestMade']?.toInt() as int?,
        extraPointsMade: json['ExtraPointsMade']?.toInt() as int?,
        twoPointConversionPasses:
            json['TwoPointConversionPasses']?.toInt() as int?,
        twoPointConversionRuns: json['TwoPointConversionRuns']?.toInt() as int?,
        twoPointConversionReceptions:
            json['TwoPointConversionReceptions']?.toInt() as int?,
        fantasyPoints: json['FantasyPoints']?.toDouble() as double?,
        fantasyPointsPpr: json['FantasyPointsPPR']?.toDouble() as double?,
        receptionPercentage: json['ReceptionPercentage']?.toInt() as int?,
        receivingYardsPerTarget:
            json['ReceivingYardsPerTarget']?.toInt() as int?,
        tackles: json['Tackles']?.toInt() as int?,
        offensiveTouchdowns: json['OffensiveTouchdowns']?.toInt() as int?,
        defensiveTouchdowns: json['DefensiveTouchdowns']?.toInt() as int?,
        specialTeamsTouchdowns: json['SpecialTeamsTouchdowns']?.toInt() as int?,
        touchdowns: json['Touchdowns']?.toInt() as int?,
        fantasyPosition: json['FantasyPosition'] as String?,
        fieldGoalPercentage: json['FieldGoalPercentage']?.toInt() as int?,
        playerSeasonId: json['PlayerSeasonID']?.toInt() as int?,
        fumblesOwnRecoveries: json['FumblesOwnRecoveries']?.toInt() as int?,
        fumblesOutOfBounds: json['FumblesOutOfBounds']?.toInt() as int?,
        kickReturnFairCatches: json['KickReturnFairCatches']?.toInt() as int?,
        puntReturnFairCatches: json['PuntReturnFairCatches']?.toInt() as int?,
        puntTouchbacks: json['PuntTouchbacks']?.toInt() as int?,
        puntInside20: json['PuntInside20']?.toInt() as int?,
        puntNetAverage: json['PuntNetAverage']?.toInt() as int?,
        extraPointsAttempted: json['ExtraPointsAttempted']?.toInt() as int?,
        blockedKickReturnTouchdowns:
            json['BlockedKickReturnTouchdowns']?.toInt() as int?,
        fieldGoalReturnTouchdowns:
            json['FieldGoalReturnTouchdowns']?.toInt() as int?,
        safeties: json['Safeties']?.toInt() as int?,
        fieldGoalsHadBlocked: json['FieldGoalsHadBlocked']?.toInt() as int?,
        puntsHadBlocked: json['PuntsHadBlocked']?.toInt() as int?,
        extraPointsHadBlocked: json['ExtraPointsHadBlocked']?.toInt() as int?,
        puntLong: json['PuntLong']?.toInt() as int?,
        blockedKickReturnYards: json['BlockedKickReturnYards']?.toInt() as int?,
        fieldGoalReturnYards: json['FieldGoalReturnYards']?.toInt() as int?,
        puntNetYards: json['PuntNetYards']?.toInt() as int?,
        specialTeamsFumblesForced:
            json['SpecialTeamsFumblesForced']?.toInt() as int?,
        specialTeamsFumblesRecovered:
            json['SpecialTeamsFumblesRecovered']?.toInt() as int?,
        miscFumblesForced: json['MiscFumblesForced']?.toInt() as int?,
        miscFumblesRecovered: json['MiscFumblesRecovered']?.toInt() as int?,
        shortName: json['ShortName'] as String?,
        safetiesAllowed: json['SafetiesAllowed']?.toInt() as int?,
        temperature: json['Temperature']?.toInt() as int?,
        humidity: json['Humidity']?.toInt() as int?,
        windSpeed: json['WindSpeed']?.toInt() as int?,
        offensiveSnapsPlayed: json['OffensiveSnapsPlayed']?.toInt() as int?,
        defensiveSnapsPlayed: json['DefensiveSnapsPlayed']?.toInt() as int?,
        specialTeamsSnapsPlayed:
            json['SpecialTeamsSnapsPlayed']?.toInt() as int?,
        offensiveTeamSnaps: json['OffensiveTeamSnaps']?.toInt() as int?,
        defensiveTeamSnaps: json['DefensiveTeamSnaps']?.toInt() as int?,
        specialTeamsTeamSnaps: json['SpecialTeamsTeamSnaps']?.toInt() as int?,
        auctionValue: json['AuctionValue'],
        auctionValuePpr: json['AuctionValuePPR'],
        twoPointConversionReturns:
            json['TwoPointConversionReturns']?.toInt() as int?,
        fantasyPointsFanDuel:
            json['FantasyPointsFanDuel']?.toDouble() as double?,
        fieldGoalsMade0To19: json['FieldGoalsMade0to19']?.toInt() as int?,
        fieldGoalsMade20To29: json['FieldGoalsMade20to29']?.toInt() as int?,
        fieldGoalsMade30To39: json['FieldGoalsMade30to39']?.toInt() as int?,
        fieldGoalsMade40To49: json['FieldGoalsMade40to49']?.toInt() as int?,
        fieldGoalsMade50Plus: json['FieldGoalsMade50Plus']?.toInt() as int?,
        fantasyPointsDraftKings:
            json['FantasyPointsDraftKings']?.toDouble() as double?,
        fantasyPointsYahoo: json['FantasyPointsYahoo']?.toDouble() as double?,
        averageDraftPosition: json['AverageDraftPosition'],
        averageDraftPositionPpr: json['AverageDraftPositionPPR'],
        teamId: json['TeamID']?.toInt() as int?,
        globalTeamId: json['GlobalTeamID']?.toInt() as int?,
        fantasyPointsFantasyDraft:
            json['FantasyPointsFantasyDraft']?.toDouble() as double?,
        averageDraftPositionRookie: json['AverageDraftPositionRookie'],
        averageDraftPositionDynasty: json['AverageDraftPositionDynasty'],
        averageDraftPosition2Qb: json['AverageDraftPosition2QB'],
        scoringDetails: List<dynamic>.from(
          json['ScoringDetails'] as List,
        ),
      );

  final int? playerId;
  final int? seasonType;
  final int? season;
  final String? team;
  final int? number;
  final String? name;
  final String? position;
  final String? positionCategory;
  final int? activated;
  final int? played;
  final int? started;
  final int? passingAttempts;
  final int? passingCompletions;
  final int? passingYards;
  final int? passingCompletionPercentage;
  final int? passingYardsPerAttempt;
  final int? passingYardsPerCompletion;
  final int? passingTouchdowns;
  final int? passingInterceptions;
  final int? passingRating;
  final int? passingLong;
  final int? passingSacks;
  final int? passingSackYards;
  final int? rushingAttempts;
  final int? rushingYards;
  final int? rushingYardsPerAttempt;
  final int? rushingTouchdowns;
  final int? rushingLong;
  final int? receivingTargets;
  final int? receptions;
  final int? receivingYards;
  final int? receivingYardsPerReception;
  final int? receivingTouchdowns;
  final int? receivingLong;
  final int? fumbles;
  final int? fumblesLost;
  final int? puntReturns;
  final int? puntReturnYards;
  final int? puntReturnYardsPerAttempt;
  final int? puntReturnTouchdowns;
  final int? puntReturnLong;
  final int? kickReturns;
  final int? kickReturnYards;
  final int? kickReturnYardsPerAttempt;
  final int? kickReturnTouchdowns;
  final int? kickReturnLong;
  final int? soloTackles;
  final int? assistedTackles;
  final int? tacklesForLoss;
  final int? sacks;
  final int? sackYards;
  final int? quarterbackHits;
  final int? passesDefended;
  final int? fumblesForced;
  final int? fumblesRecovered;
  final int? fumbleReturnYards;
  final int? fumbleReturnTouchdowns;
  final int? interceptions;
  final int? interceptionReturnYards;
  final int? interceptionReturnTouchdowns;
  final int? blockedKicks;
  final int? specialTeamsSoloTackles;
  final int? specialTeamsAssistedTackles;
  final int? miscSoloTackles;
  final int? miscAssistedTackles;
  final int? punts;
  final int? puntYards;
  final int? puntAverage;
  final int? fieldGoalsAttempted;
  final int? fieldGoalsMade;
  final int? fieldGoalsLongestMade;
  final int? extraPointsMade;
  final int? twoPointConversionPasses;
  final int? twoPointConversionRuns;
  final int? twoPointConversionReceptions;
  final double? fantasyPoints;
  final double? fantasyPointsPpr;
  final int? receptionPercentage;
  final int? receivingYardsPerTarget;
  final int? tackles;
  final int? offensiveTouchdowns;
  final int? defensiveTouchdowns;
  final int? specialTeamsTouchdowns;
  final int? touchdowns;
  final String? fantasyPosition;
  final int? fieldGoalPercentage;
  final int? playerSeasonId;
  final int? fumblesOwnRecoveries;
  final int? fumblesOutOfBounds;
  final int? kickReturnFairCatches;
  final int? puntReturnFairCatches;
  final int? puntTouchbacks;
  final int? puntInside20;
  final int? puntNetAverage;
  final int? extraPointsAttempted;
  final int? blockedKickReturnTouchdowns;
  final int? fieldGoalReturnTouchdowns;
  final int? safeties;
  final int? fieldGoalsHadBlocked;
  final int? puntsHadBlocked;
  final int? extraPointsHadBlocked;
  final int? puntLong;
  final int? blockedKickReturnYards;
  final int? fieldGoalReturnYards;
  final int? puntNetYards;
  final int? specialTeamsFumblesForced;
  final int? specialTeamsFumblesRecovered;
  final int? miscFumblesForced;
  final int? miscFumblesRecovered;
  final String? shortName;
  final int? safetiesAllowed;
  final int? temperature;
  final int? humidity;
  final int? windSpeed;
  final int? offensiveSnapsPlayed;
  final int? defensiveSnapsPlayed;
  final int? specialTeamsSnapsPlayed;
  final int? offensiveTeamSnaps;
  final int? defensiveTeamSnaps;
  final int? specialTeamsTeamSnaps;
  final dynamic auctionValue;
  final dynamic auctionValuePpr;
  final int? twoPointConversionReturns;
  final double? fantasyPointsFanDuel;
  final int? fieldGoalsMade0To19;
  final int? fieldGoalsMade20To29;
  final int? fieldGoalsMade30To39;
  final int? fieldGoalsMade40To49;
  final int? fieldGoalsMade50Plus;
  final double? fantasyPointsDraftKings;
  final double? fantasyPointsYahoo;
  final dynamic averageDraftPosition;
  final dynamic averageDraftPositionPpr;
  final int? teamId;
  final int? globalTeamId;
  final double? fantasyPointsFantasyDraft;
  final dynamic averageDraftPositionRookie;
  final dynamic averageDraftPositionDynasty;
  final dynamic averageDraftPosition2Qb;
  final List<dynamic>? scoringDetails;

  NflPlayerStats copyWith({
    int? playerId,
    int? seasonType,
    int? season,
    String? team,
    int? number,
    String? name,
    String? position,
    String? positionCategory,
    int? activated,
    int? played,
    int? started,
    int? passingAttempts,
    int? passingCompletions,
    int? passingYards,
    int? passingCompletionPercentage,
    int? passingYardsPerAttempt,
    int? passingYardsPerCompletion,
    int? passingTouchdowns,
    int? passingInterceptions,
    int? passingRating,
    int? passingLong,
    int? passingSacks,
    int? passingSackYards,
    int? rushingAttempts,
    int? rushingYards,
    int? rushingYardsPerAttempt,
    int? rushingTouchdowns,
    int? rushingLong,
    int? receivingTargets,
    int? receptions,
    int? receivingYards,
    int? receivingYardsPerReception,
    int? receivingTouchdowns,
    int? receivingLong,
    int? fumbles,
    int? fumblesLost,
    int? puntReturns,
    int? puntReturnYards,
    int? puntReturnYardsPerAttempt,
    int? puntReturnTouchdowns,
    int? puntReturnLong,
    int? kickReturns,
    int? kickReturnYards,
    int? kickReturnYardsPerAttempt,
    int? kickReturnTouchdowns,
    int? kickReturnLong,
    int? soloTackles,
    int? assistedTackles,
    int? tacklesForLoss,
    int? sacks,
    int? sackYards,
    int? quarterbackHits,
    int? passesDefended,
    int? fumblesForced,
    int? fumblesRecovered,
    int? fumbleReturnYards,
    int? fumbleReturnTouchdowns,
    int? interceptions,
    int? interceptionReturnYards,
    int? interceptionReturnTouchdowns,
    int? blockedKicks,
    int? specialTeamsSoloTackles,
    int? specialTeamsAssistedTackles,
    int? miscSoloTackles,
    int? miscAssistedTackles,
    int? punts,
    int? puntYards,
    int? puntAverage,
    int? fieldGoalsAttempted,
    int? fieldGoalsMade,
    int? fieldGoalsLongestMade,
    int? extraPointsMade,
    int? twoPointConversionPasses,
    int? twoPointConversionRuns,
    int? twoPointConversionReceptions,
    double? fantasyPoints,
    double? fantasyPointsPpr,
    int? receptionPercentage,
    int? receivingYardsPerTarget,
    int? tackles,
    int? offensiveTouchdowns,
    int? defensiveTouchdowns,
    int? specialTeamsTouchdowns,
    int? touchdowns,
    String? fantasyPosition,
    int? fieldGoalPercentage,
    int? playerSeasonId,
    int? fumblesOwnRecoveries,
    int? fumblesOutOfBounds,
    int? kickReturnFairCatches,
    int? puntReturnFairCatches,
    int? puntTouchbacks,
    int? puntInside20,
    int? puntNetAverage,
    int? extraPointsAttempted,
    int? blockedKickReturnTouchdowns,
    int? fieldGoalReturnTouchdowns,
    int? safeties,
    int? fieldGoalsHadBlocked,
    int? puntsHadBlocked,
    int? extraPointsHadBlocked,
    int? puntLong,
    int? blockedKickReturnYards,
    int? fieldGoalReturnYards,
    int? puntNetYards,
    int? specialTeamsFumblesForced,
    int? specialTeamsFumblesRecovered,
    int? miscFumblesForced,
    int? miscFumblesRecovered,
    String? shortName,
    int? safetiesAllowed,
    int? temperature,
    int? humidity,
    int? windSpeed,
    int? offensiveSnapsPlayed,
    int? defensiveSnapsPlayed,
    int? specialTeamsSnapsPlayed,
    int? offensiveTeamSnaps,
    int? defensiveTeamSnaps,
    int? specialTeamsTeamSnaps,
    dynamic auctionValue,
    dynamic auctionValuePpr,
    int? twoPointConversionReturns,
    double? fantasyPointsFanDuel,
    int? fieldGoalsMade0To19,
    int? fieldGoalsMade20To29,
    int? fieldGoalsMade30To39,
    int? fieldGoalsMade40To49,
    int? fieldGoalsMade50Plus,
    double? fantasyPointsDraftKings,
    double? fantasyPointsYahoo,
    dynamic averageDraftPosition,
    dynamic averageDraftPositionPpr,
    int? teamId,
    int? globalTeamId,
    double? fantasyPointsFantasyDraft,
    dynamic averageDraftPositionRookie,
    dynamic averageDraftPositionDynasty,
    dynamic averageDraftPosition2Qb,
    List<dynamic>? scoringDetails,
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

  Map<String, Object?> toMap() => {
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
        'ScoringDetails':
            List<dynamic>.from(scoringDetails!.map<dynamic>((dynamic x) => x)),
      };

  Map<String, dynamic> toStatOnlyMap() => <String, dynamic>{
        'Passing Attempts': passingAttempts,
        'Passing Completions': passingCompletions,
        'Passing Yards': passingYards,
        'Passing Completion Percentage': passingCompletionPercentage,
        'Passing Yards Per Attempt': passingYardsPerAttempt,
        'Passing Yards Per Completion': passingYardsPerCompletion,
        'Passing Touchdowns': passingTouchdowns,
        'Passing Interceptions': passingInterceptions,
        'Passing Rating': passingRating,
        'Passing Long': passingLong,
        'Passing Sacks': passingSacks,
        'Passing Sack Yards': passingSackYards,
        'Rushing Attempts': rushingAttempts,
        'Rushing Yards': rushingYards,
        'Rushing Yards Per Attempt': rushingYardsPerAttempt,
        'Rushing Touchdowns': rushingTouchdowns,
        'Rushing Long': rushingLong,
        'Receiving Targets': receivingTargets,
        'Receptions': receptions,
        'Receiving Yards': receivingYards,
        'Receiving Yards Per Reception': receivingYardsPerReception,
        'Receiving Touchdowns': receivingTouchdowns,
        'Receiving Long': receivingLong,
        'Fumbles': fumbles,
        'Fumbles Lost': fumblesLost,
        'Punt Returns': puntReturns,
        'Punt Return Yards': puntReturnYards,
        'Punt Return Yards Per Attempt': puntReturnYardsPerAttempt,
        'Punt Return Touchdowns': puntReturnTouchdowns,
        'Punt Return Long': puntReturnLong,
        'Kick Returns': kickReturns,
        'Kick Return Yards': kickReturnYards,
        'Kick Return Yards Per Attempt': kickReturnYardsPerAttempt,
        'Kick Return Touchdowns': kickReturnTouchdowns,
        'Kick Return Long': kickReturnLong,
        'Solo Tackles': soloTackles,
        'Assisted Tackles': assistedTackles,
        'Tackles For Loss': tacklesForLoss,
        'Sacks': sacks,
        'Sack Yards': sackYards,
        'Quarterback Hits': quarterbackHits,
        'Passes Defended': passesDefended,
        'Fumbles Forced': fumblesForced,
        'Fumbles Recovered': fumblesRecovered,
        'Fumble Return Yards': fumbleReturnYards,
        'Fumble Return Touchdowns': fumbleReturnTouchdowns,
        'Interceptions': interceptions,
        'Interception Return Yards': interceptionReturnYards,
        'Interception Return Touchdowns': interceptionReturnTouchdowns,
        'Blocked Kicks': blockedKicks,
        'Special Teams Solo Tackles': specialTeamsSoloTackles,
        'Special Teams Assisted Tackles': specialTeamsAssistedTackles,
        'Misc Solo Tackles': miscSoloTackles,
        'Misc Assisted Tackles': miscAssistedTackles,
        'Punts': punts,
        'Punt Yards': puntYards,
        'Punt Average': puntAverage,
        'Field Goals Attempted': fieldGoalsAttempted,
        'Field Goals Made': fieldGoalsMade,
        'Field Goals Longest Made': fieldGoalsLongestMade,
        'Extra Points Made': extraPointsMade,
        'Two Point Conversion Passes': twoPointConversionPasses,
        'Two Point Conversion Runs': twoPointConversionRuns,
        'Two Point Conversion Receptions': twoPointConversionReceptions,
        'Fantasy Points': fantasyPoints,
        'Fantasy Points P P R': fantasyPointsPpr,
        'Reception Percentage': receptionPercentage,
        'Receiving Yards Per Target': receivingYardsPerTarget,
        'Tackles': tackles,
        'Offensive Touchdowns': offensiveTouchdowns,
        'Defensive Touchdowns': defensiveTouchdowns,
        'Special Teams Touchdowns': specialTeamsTouchdowns,
        'Touchdowns': touchdowns,
        'Fantasy Position': fantasyPosition,
        'Field Goal Percentage': fieldGoalPercentage,
        'Player Season I D': playerSeasonId,
        'Fumbles Own Recoveries': fumblesOwnRecoveries,
        'Fumbles Out Of Bounds': fumblesOutOfBounds,
        'Kick Return Fair Catches': kickReturnFairCatches,
        'Punt Return Fair Catches': puntReturnFairCatches,
        'Punt Touchbacks': puntTouchbacks,
        'Punt Inside20': puntInside20,
        'Punt Net Average': puntNetAverage,
        'Extra Points Attempted': extraPointsAttempted,
        'Blocked Kick Return Touchdowns': blockedKickReturnTouchdowns,
        'Field Goal Return Touchdowns': fieldGoalReturnTouchdowns,
        'Safeties': safeties,
        'Field Goals Had Blocked': fieldGoalsHadBlocked,
        'Punts Had Blocked': puntsHadBlocked,
        'Extra Points Had Blocked': extraPointsHadBlocked,
        'Punt Long': puntLong,
        'Blocked Kick Return Yards': blockedKickReturnYards,
        'Field Goal Return Yards': fieldGoalReturnYards,
        'Punt Net Yards': puntNetYards,
        'Special Teams Fumbles Forced': specialTeamsFumblesForced,
        'Special Teams Fumbles Recovered': specialTeamsFumblesRecovered,
        'Misc Fumbles Forced': miscFumblesForced,
        'Misc Fumbles Recovered': miscFumblesRecovered,
        'Short Name': shortName,
        'Safeties Allowed': safetiesAllowed,
        'Temperature': temperature,
        'Humidity': humidity,
        'Wind Speed': windSpeed,
        'Offensive Snaps Played': offensiveSnapsPlayed,
        'Defensive Snaps Played': defensiveSnapsPlayed,
        'Special Teams Snaps Played': specialTeamsSnapsPlayed,
        'Offensive Team Snaps': offensiveTeamSnaps,
        'Defensive Team Snaps': defensiveTeamSnaps,
        'Special Teams Team Snaps': specialTeamsTeamSnaps,
        'Auction Value': auctionValue,
        'Auction Value P P R': auctionValuePpr,
        'Two Point Conversion Returns': twoPointConversionReturns,
        'Fantasy Points Fan Duel': fantasyPointsFanDuel,
        'Field Goals Made0to19': fieldGoalsMade0To19,
        'Field Goals Made20to29': fieldGoalsMade20To29,
        'Field Goals Made30to39': fieldGoalsMade30To39,
        'Field Goals Made40to49': fieldGoalsMade40To49,
        'Field Goals Made50 Plus': fieldGoalsMade50Plus,
        'Fantasy Points Draft Kings': fantasyPointsDraftKings,
        'Fantasy Points Yahoo': fantasyPointsYahoo,
        'Average Draft Position': averageDraftPosition,
        'Average Draft Position P P R': averageDraftPositionPpr,
        'Team I D': teamId,
        'Global Team I D': globalTeamId,
        'Fantasy Points Fantasy Draft': fantasyPointsFantasyDraft,
        'Average Draft Position Rookie': averageDraftPositionRookie,
        'Average Draft Position Dynasty': averageDraftPositionDynasty,
        'Average Draft Position2 Q B': averageDraftPosition2Qb,
      };
}
