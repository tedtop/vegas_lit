import 'dart:convert';

class NflTeamStats {
  NflTeamStats({
    this.seasonType,
    this.season,
    this.team,
    this.score,
    this.opponentScore,
    this.totalScore,
    this.temperature,
    this.humidity,
    this.windSpeed,
    this.overUnder,
    this.pointSpread,
    this.scoreQuarter1,
    this.scoreQuarter2,
    this.scoreQuarter3,
    this.scoreQuarter4,
    this.scoreOvertime,
    this.timeOfPossession,
    this.firstDowns,
    this.firstDownsByRushing,
    this.firstDownsByPassing,
    this.firstDownsByPenalty,
    this.offensivePlays,
    this.offensiveYards,
    this.offensiveYardsPerPlay,
    this.touchdowns,
    this.rushingAttempts,
    this.rushingYards,
    this.rushingYardsPerAttempt,
    this.rushingTouchdowns,
    this.passingAttempts,
    this.passingCompletions,
    this.passingYards,
    this.passingTouchdowns,
    this.passingInterceptions,
    this.passingYardsPerAttempt,
    this.passingYardsPerCompletion,
    this.completionPercentage,
    this.passerRating,
    this.thirdDownAttempts,
    this.thirdDownConversions,
    this.thirdDownPercentage,
    this.fourthDownAttempts,
    this.fourthDownConversions,
    this.fourthDownPercentage,
    this.redZoneAttempts,
    this.redZoneConversions,
    this.goalToGoAttempts,
    this.goalToGoConversions,
    this.returnYards,
    this.penalties,
    this.penaltyYards,
    this.fumbles,
    this.fumblesLost,
    this.timesSacked,
    this.timesSackedYards,
    this.quarterbackHits,
    this.tacklesForLoss,
    this.safeties,
    this.punts,
    this.puntYards,
    this.puntAverage,
    this.giveaways,
    this.takeaways,
    this.turnoverDifferential,
    this.opponentScoreQuarter1,
    this.opponentScoreQuarter2,
    this.opponentScoreQuarter3,
    this.opponentScoreQuarter4,
    this.opponentScoreOvertime,
    this.opponentTimeOfPossession,
    this.opponentFirstDowns,
    this.opponentFirstDownsByRushing,
    this.opponentFirstDownsByPassing,
    this.opponentFirstDownsByPenalty,
    this.opponentOffensivePlays,
    this.opponentOffensiveYards,
    this.opponentOffensiveYardsPerPlay,
    this.opponentTouchdowns,
    this.opponentRushingAttempts,
    this.opponentRushingYards,
    this.opponentRushingYardsPerAttempt,
    this.opponentRushingTouchdowns,
    this.opponentPassingAttempts,
    this.opponentPassingCompletions,
    this.opponentPassingYards,
    this.opponentPassingTouchdowns,
    this.opponentPassingInterceptions,
    this.opponentPassingYardsPerAttempt,
    this.opponentPassingYardsPerCompletion,
    this.opponentCompletionPercentage,
    this.opponentPasserRating,
    this.opponentThirdDownAttempts,
    this.opponentThirdDownConversions,
    this.opponentThirdDownPercentage,
    this.opponentFourthDownAttempts,
    this.opponentFourthDownConversions,
    this.opponentFourthDownPercentage,
    this.opponentRedZoneAttempts,
    this.opponentRedZoneConversions,
    this.opponentGoalToGoAttempts,
    this.opponentGoalToGoConversions,
    this.opponentReturnYards,
    this.opponentPenalties,
    this.opponentPenaltyYards,
    this.opponentFumbles,
    this.opponentFumblesLost,
    this.opponentTimesSacked,
    this.opponentTimesSackedYards,
    this.opponentQuarterbackHits,
    this.opponentTacklesForLoss,
    this.opponentSafeties,
    this.opponentPunts,
    this.opponentPuntYards,
    this.opponentPuntAverage,
    this.opponentGiveaways,
    this.opponentTakeaways,
    this.opponentTurnoverDifferential,
    this.redZonePercentage,
    this.goalToGoPercentage,
    this.quarterbackHitsDifferential,
    this.tacklesForLossDifferential,
    this.quarterbackSacksDifferential,
    this.tacklesForLossPercentage,
    this.quarterbackHitsPercentage,
    this.timesSackedPercentage,
    this.opponentRedZonePercentage,
    this.opponentGoalToGoPercentage,
    this.opponentQuarterbackHitsDifferential,
    this.opponentTacklesForLossDifferential,
    this.opponentQuarterbackSacksDifferential,
    this.opponentTacklesForLossPercentage,
    this.opponentQuarterbackHitsPercentage,
    this.opponentTimesSackedPercentage,
    this.kickoffs,
    this.kickoffsInEndZone,
    this.kickoffTouchbacks,
    this.puntsHadBlocked,
    this.puntNetAverage,
    this.extraPointKickingAttempts,
    this.extraPointKickingConversions,
    this.extraPointsHadBlocked,
    this.extraPointPassingAttempts,
    this.extraPointPassingConversions,
    this.extraPointRushingAttempts,
    this.extraPointRushingConversions,
    this.fieldGoalAttempts,
    this.fieldGoalsMade,
    this.fieldGoalsHadBlocked,
    this.puntReturns,
    this.puntReturnYards,
    this.kickReturns,
    this.kickReturnYards,
    this.interceptionReturns,
    this.interceptionReturnYards,
    this.opponentKickoffs,
    this.opponentKickoffsInEndZone,
    this.opponentKickoffTouchbacks,
    this.opponentPuntsHadBlocked,
    this.opponentPuntNetAverage,
    this.opponentExtraPointKickingAttempts,
    this.opponentExtraPointKickingConversions,
    this.opponentExtraPointsHadBlocked,
    this.opponentExtraPointPassingAttempts,
    this.opponentExtraPointPassingConversions,
    this.opponentExtraPointRushingAttempts,
    this.opponentExtraPointRushingConversions,
    this.opponentFieldGoalAttempts,
    this.opponentFieldGoalsMade,
    this.opponentFieldGoalsHadBlocked,
    this.opponentPuntReturns,
    this.opponentPuntReturnYards,
    this.opponentKickReturns,
    this.opponentKickReturnYards,
    this.opponentInterceptionReturns,
    this.opponentInterceptionReturnYards,
    this.soloTackles,
    this.assistedTackles,
    this.sacks,
    this.sackYards,
    this.passesDefended,
    this.fumblesForced,
    this.fumblesRecovered,
    this.fumbleReturnYards,
    this.fumbleReturnTouchdowns,
    this.interceptionReturnTouchdowns,
    this.blockedKicks,
    this.puntReturnTouchdowns,
    this.puntReturnLong,
    this.kickReturnTouchdowns,
    this.kickReturnLong,
    this.blockedKickReturnYards,
    this.blockedKickReturnTouchdowns,
    this.fieldGoalReturnYards,
    this.fieldGoalReturnTouchdowns,
    this.puntNetYards,
    this.opponentSoloTackles,
    this.opponentAssistedTackles,
    this.opponentSacks,
    this.opponentSackYards,
    this.opponentPassesDefended,
    this.opponentFumblesForced,
    this.opponentFumblesRecovered,
    this.opponentFumbleReturnYards,
    this.opponentFumbleReturnTouchdowns,
    this.opponentInterceptionReturnTouchdowns,
    this.opponentBlockedKicks,
    this.opponentPuntReturnTouchdowns,
    this.opponentPuntReturnLong,
    this.opponentKickReturnTouchdowns,
    this.opponentKickReturnLong,
    this.opponentBlockedKickReturnYards,
    this.opponentBlockedKickReturnTouchdowns,
    this.opponentFieldGoalReturnYards,
    this.opponentFieldGoalReturnTouchdowns,
    this.opponentPuntNetYards,
    this.teamName,
    this.games,
    this.passingDropbacks,
    this.opponentPassingDropbacks,
    this.teamSeasonId,
    this.twoPointConversionReturns,
    this.opponentTwoPointConversionReturns,
    this.teamId,
    this.globalTeamId,
    this.teamStatId,
  });

  factory NflTeamStats.fromJson(String str) =>
      NflTeamStats.fromMap(json.decode(str));
  factory NflTeamStats.fromMap(Map<String, dynamic> json) => NflTeamStats(
        seasonType: json['SeasonType'],
        season: json['Season'],
        team: json['Team'],
        score: json['Score'],
        opponentScore: json['OpponentScore'],
        totalScore: json['TotalScore'],
        temperature: json['Temperature'],
        humidity: json['Humidity'],
        windSpeed: json['WindSpeed'],
        overUnder: json['OverUnder'].toDouble(),
        pointSpread: json['PointSpread'].toDouble(),
        scoreQuarter1: json['ScoreQuarter1'],
        scoreQuarter2: json['ScoreQuarter2'],
        scoreQuarter3: json['ScoreQuarter3'],
        scoreQuarter4: json['ScoreQuarter4'],
        scoreOvertime: json['ScoreOvertime'],
        timeOfPossession: json['TimeOfPossession'],
        firstDowns: json['FirstDowns'],
        firstDownsByRushing: json['FirstDownsByRushing'],
        firstDownsByPassing: json['FirstDownsByPassing'],
        firstDownsByPenalty: json['FirstDownsByPenalty'],
        offensivePlays: json['OffensivePlays'],
        offensiveYards: json['OffensiveYards'],
        offensiveYardsPerPlay: json['OffensiveYardsPerPlay'].toDouble(),
        touchdowns: json['Touchdowns'],
        rushingAttempts: json['RushingAttempts'],
        rushingYards: json['RushingYards'],
        rushingYardsPerAttempt: json['RushingYardsPerAttempt'].toDouble(),
        rushingTouchdowns: json['RushingTouchdowns'],
        passingAttempts: json['PassingAttempts'],
        passingCompletions: json['PassingCompletions'],
        passingYards: json['PassingYards'],
        passingTouchdowns: json['PassingTouchdowns'],
        passingInterceptions: json['PassingInterceptions'],
        passingYardsPerAttempt: json['PassingYardsPerAttempt'].toDouble(),
        passingYardsPerCompletion: json['PassingYardsPerCompletion'].toDouble(),
        completionPercentage: json['CompletionPercentage'].toDouble(),
        passerRating: json['PasserRating'].toDouble(),
        thirdDownAttempts: json['ThirdDownAttempts'],
        thirdDownConversions: json['ThirdDownConversions'],
        thirdDownPercentage: json['ThirdDownPercentage'].toDouble(),
        fourthDownAttempts: json['FourthDownAttempts'],
        fourthDownConversions: json['FourthDownConversions'],
        fourthDownPercentage: json['FourthDownPercentage'].toDouble(),
        redZoneAttempts: json['RedZoneAttempts'],
        redZoneConversions: json['RedZoneConversions'],
        goalToGoAttempts: json['GoalToGoAttempts'],
        goalToGoConversions: json['GoalToGoConversions'],
        returnYards: json['ReturnYards'],
        penalties: json['Penalties'],
        penaltyYards: json['PenaltyYards'],
        fumbles: json['Fumbles'],
        fumblesLost: json['FumblesLost'],
        timesSacked: json['TimesSacked'],
        timesSackedYards: json['TimesSackedYards'],
        quarterbackHits: json['QuarterbackHits'],
        tacklesForLoss: json['TacklesForLoss'],
        safeties: json['Safeties'],
        punts: json['Punts'],
        puntYards: json['PuntYards'],
        puntAverage: json['PuntAverage'].toDouble(),
        giveaways: json['Giveaways'],
        takeaways: json['Takeaways'],
        turnoverDifferential: json['TurnoverDifferential'],
        opponentScoreQuarter1: json['OpponentScoreQuarter1'],
        opponentScoreQuarter2: json['OpponentScoreQuarter2'],
        opponentScoreQuarter3: json['OpponentScoreQuarter3'],
        opponentScoreQuarter4: json['OpponentScoreQuarter4'],
        opponentScoreOvertime: json['OpponentScoreOvertime'],
        opponentTimeOfPossession: json['OpponentTimeOfPossession'],
        opponentFirstDowns: json['OpponentFirstDowns'],
        opponentFirstDownsByRushing: json['OpponentFirstDownsByRushing'],
        opponentFirstDownsByPassing: json['OpponentFirstDownsByPassing'],
        opponentFirstDownsByPenalty: json['OpponentFirstDownsByPenalty'],
        opponentOffensivePlays: json['OpponentOffensivePlays'],
        opponentOffensiveYards: json['OpponentOffensiveYards'],
        opponentOffensiveYardsPerPlay:
            json['OpponentOffensiveYardsPerPlay'].toDouble(),
        opponentTouchdowns: json['OpponentTouchdowns'],
        opponentRushingAttempts: json['OpponentRushingAttempts'],
        opponentRushingYards: json['OpponentRushingYards'],
        opponentRushingYardsPerAttempt:
            json['OpponentRushingYardsPerAttempt'].toDouble(),
        opponentRushingTouchdowns: json['OpponentRushingTouchdowns'],
        opponentPassingAttempts: json['OpponentPassingAttempts'],
        opponentPassingCompletions: json['OpponentPassingCompletions'],
        opponentPassingYards: json['OpponentPassingYards'],
        opponentPassingTouchdowns: json['OpponentPassingTouchdowns'],
        opponentPassingInterceptions: json['OpponentPassingInterceptions'],
        opponentPassingYardsPerAttempt:
            json['OpponentPassingYardsPerAttempt'].toDouble(),
        opponentPassingYardsPerCompletion:
            json['OpponentPassingYardsPerCompletion'].toDouble(),
        opponentCompletionPercentage:
            json['OpponentCompletionPercentage'].toDouble(),
        opponentPasserRating: json['OpponentPasserRating'].toDouble(),
        opponentThirdDownAttempts: json['OpponentThirdDownAttempts'],
        opponentThirdDownConversions: json['OpponentThirdDownConversions'],
        opponentThirdDownPercentage:
            json['OpponentThirdDownPercentage'].toDouble(),
        opponentFourthDownAttempts: json['OpponentFourthDownAttempts'],
        opponentFourthDownConversions: json['OpponentFourthDownConversions'],
        opponentFourthDownPercentage:
            json['OpponentFourthDownPercentage'].toDouble(),
        opponentRedZoneAttempts: json['OpponentRedZoneAttempts'],
        opponentRedZoneConversions: json['OpponentRedZoneConversions'],
        opponentGoalToGoAttempts: json['OpponentGoalToGoAttempts'],
        opponentGoalToGoConversions: json['OpponentGoalToGoConversions'],
        opponentReturnYards: json['OpponentReturnYards'],
        opponentPenalties: json['OpponentPenalties'],
        opponentPenaltyYards: json['OpponentPenaltyYards'],
        opponentFumbles: json['OpponentFumbles'],
        opponentFumblesLost: json['OpponentFumblesLost'],
        opponentTimesSacked: json['OpponentTimesSacked'],
        opponentTimesSackedYards: json['OpponentTimesSackedYards'],
        opponentQuarterbackHits: json['OpponentQuarterbackHits'],
        opponentTacklesForLoss: json['OpponentTacklesForLoss'],
        opponentSafeties: json['OpponentSafeties'],
        opponentPunts: json['OpponentPunts'],
        opponentPuntYards: json['OpponentPuntYards'],
        opponentPuntAverage: json['OpponentPuntAverage'].toDouble(),
        opponentGiveaways: json['OpponentGiveaways'],
        opponentTakeaways: json['OpponentTakeaways'],
        opponentTurnoverDifferential: json['OpponentTurnoverDifferential'],
        redZonePercentage: json['RedZonePercentage'].toDouble(),
        goalToGoPercentage: json['GoalToGoPercentage'],
        quarterbackHitsDifferential: json['QuarterbackHitsDifferential'],
        tacklesForLossDifferential: json['TacklesForLossDifferential'],
        quarterbackSacksDifferential: json['QuarterbackSacksDifferential'],
        tacklesForLossPercentage: json['TacklesForLossPercentage'].toDouble(),
        quarterbackHitsPercentage: json['QuarterbackHitsPercentage'].toDouble(),
        timesSackedPercentage: json['TimesSackedPercentage'].toDouble(),
        opponentRedZonePercentage: json['OpponentRedZonePercentage'].toDouble(),
        opponentGoalToGoPercentage: json['OpponentGoalToGoPercentage'],
        opponentQuarterbackHitsDifferential:
            json['OpponentQuarterbackHitsDifferential'],
        opponentTacklesForLossDifferential:
            json['OpponentTacklesForLossDifferential'],
        opponentQuarterbackSacksDifferential:
            json['OpponentQuarterbackSacksDifferential'],
        opponentTacklesForLossPercentage:
            json['OpponentTacklesForLossPercentage'].toDouble(),
        opponentQuarterbackHitsPercentage:
            json['OpponentQuarterbackHitsPercentage'].toDouble(),
        opponentTimesSackedPercentage:
            json['OpponentTimesSackedPercentage'].toDouble(),
        kickoffs: json['Kickoffs'],
        kickoffsInEndZone: json['KickoffsInEndZone'],
        kickoffTouchbacks: json['KickoffTouchbacks'],
        puntsHadBlocked: json['PuntsHadBlocked'],
        puntNetAverage: json['PuntNetAverage'].toDouble(),
        extraPointKickingAttempts: json['ExtraPointKickingAttempts'],
        extraPointKickingConversions: json['ExtraPointKickingConversions'],
        extraPointsHadBlocked: json['ExtraPointsHadBlocked'],
        extraPointPassingAttempts: json['ExtraPointPassingAttempts'],
        extraPointPassingConversions: json['ExtraPointPassingConversions'],
        extraPointRushingAttempts: json['ExtraPointRushingAttempts'],
        extraPointRushingConversions: json['ExtraPointRushingConversions'],
        fieldGoalAttempts: json['FieldGoalAttempts'],
        fieldGoalsMade: json['FieldGoalsMade'],
        fieldGoalsHadBlocked: json['FieldGoalsHadBlocked'],
        puntReturns: json['PuntReturns'],
        puntReturnYards: json['PuntReturnYards'],
        kickReturns: json['KickReturns'],
        kickReturnYards: json['KickReturnYards'],
        interceptionReturns: json['InterceptionReturns'],
        interceptionReturnYards: json['InterceptionReturnYards'],
        opponentKickoffs: json['OpponentKickoffs'],
        opponentKickoffsInEndZone: json['OpponentKickoffsInEndZone'],
        opponentKickoffTouchbacks: json['OpponentKickoffTouchbacks'],
        opponentPuntsHadBlocked: json['OpponentPuntsHadBlocked'],
        opponentPuntNetAverage: json['OpponentPuntNetAverage'].toDouble(),
        opponentExtraPointKickingAttempts:
            json['OpponentExtraPointKickingAttempts'],
        opponentExtraPointKickingConversions:
            json['OpponentExtraPointKickingConversions'],
        opponentExtraPointsHadBlocked: json['OpponentExtraPointsHadBlocked'],
        opponentExtraPointPassingAttempts:
            json['OpponentExtraPointPassingAttempts'],
        opponentExtraPointPassingConversions:
            json['OpponentExtraPointPassingConversions'],
        opponentExtraPointRushingAttempts:
            json['OpponentExtraPointRushingAttempts'],
        opponentExtraPointRushingConversions:
            json['OpponentExtraPointRushingConversions'],
        opponentFieldGoalAttempts: json['OpponentFieldGoalAttempts'],
        opponentFieldGoalsMade: json['OpponentFieldGoalsMade'],
        opponentFieldGoalsHadBlocked: json['OpponentFieldGoalsHadBlocked'],
        opponentPuntReturns: json['OpponentPuntReturns'],
        opponentPuntReturnYards: json['OpponentPuntReturnYards'],
        opponentKickReturns: json['OpponentKickReturns'],
        opponentKickReturnYards: json['OpponentKickReturnYards'],
        opponentInterceptionReturns: json['OpponentInterceptionReturns'],
        opponentInterceptionReturnYards:
            json['OpponentInterceptionReturnYards'],
        soloTackles: json['SoloTackles'],
        assistedTackles: json['AssistedTackles'],
        sacks: json['Sacks'],
        sackYards: json['SackYards'],
        passesDefended: json['PassesDefended'],
        fumblesForced: json['FumblesForced'],
        fumblesRecovered: json['FumblesRecovered'],
        fumbleReturnYards: json['FumbleReturnYards'],
        fumbleReturnTouchdowns: json['FumbleReturnTouchdowns'],
        interceptionReturnTouchdowns: json['InterceptionReturnTouchdowns'],
        blockedKicks: json['BlockedKicks'],
        puntReturnTouchdowns: json['PuntReturnTouchdowns'],
        puntReturnLong: json['PuntReturnLong'],
        kickReturnTouchdowns: json['KickReturnTouchdowns'],
        kickReturnLong: json['KickReturnLong'],
        blockedKickReturnYards: json['BlockedKickReturnYards'],
        blockedKickReturnTouchdowns: json['BlockedKickReturnTouchdowns'],
        fieldGoalReturnYards: json['FieldGoalReturnYards'],
        fieldGoalReturnTouchdowns: json['FieldGoalReturnTouchdowns'],
        puntNetYards: json['PuntNetYards'],
        opponentSoloTackles: json['OpponentSoloTackles'],
        opponentAssistedTackles: json['OpponentAssistedTackles'],
        opponentSacks: json['OpponentSacks'],
        opponentSackYards: json['OpponentSackYards'],
        opponentPassesDefended: json['OpponentPassesDefended'],
        opponentFumblesForced: json['OpponentFumblesForced'],
        opponentFumblesRecovered: json['OpponentFumblesRecovered'],
        opponentFumbleReturnYards: json['OpponentFumbleReturnYards'],
        opponentFumbleReturnTouchdowns: json['OpponentFumbleReturnTouchdowns'],
        opponentInterceptionReturnTouchdowns:
            json['OpponentInterceptionReturnTouchdowns'],
        opponentBlockedKicks: json['OpponentBlockedKicks'],
        opponentPuntReturnTouchdowns: json['OpponentPuntReturnTouchdowns'],
        opponentPuntReturnLong: json['OpponentPuntReturnLong'],
        opponentKickReturnTouchdowns: json['OpponentKickReturnTouchdowns'],
        opponentKickReturnLong: json['OpponentKickReturnLong'],
        opponentBlockedKickReturnYards: json['OpponentBlockedKickReturnYards'],
        opponentBlockedKickReturnTouchdowns:
            json['OpponentBlockedKickReturnTouchdowns'],
        opponentFieldGoalReturnYards: json['OpponentFieldGoalReturnYards'],
        opponentFieldGoalReturnTouchdowns:
            json['OpponentFieldGoalReturnTouchdowns'],
        opponentPuntNetYards: json['OpponentPuntNetYards'],
        teamName: json['TeamName'],
        games: json['Games'],
        passingDropbacks: json['PassingDropbacks'],
        opponentPassingDropbacks: json['OpponentPassingDropbacks'],
        teamSeasonId: json['TeamSeasonID'],
        twoPointConversionReturns: json['TwoPointConversionReturns'],
        opponentTwoPointConversionReturns:
            json['OpponentTwoPointConversionReturns'],
        teamId: json['TeamID'],
        globalTeamId: json['GlobalTeamID'],
        teamStatId: json['TeamStatID'],
      );

  final int seasonType;
  final int season;
  final String team;
  final int score;
  final int opponentScore;
  final int totalScore;
  final int temperature;
  final int humidity;
  final int windSpeed;
  final double overUnder;
  final double pointSpread;
  final int scoreQuarter1;
  final int scoreQuarter2;
  final int scoreQuarter3;
  final int scoreQuarter4;
  final int scoreOvertime;
  final String timeOfPossession;
  final int firstDowns;
  final int firstDownsByRushing;
  final int firstDownsByPassing;
  final int firstDownsByPenalty;
  final int offensivePlays;
  final int offensiveYards;
  final double offensiveYardsPerPlay;
  final int touchdowns;
  final int rushingAttempts;
  final int rushingYards;
  final double rushingYardsPerAttempt;
  final int rushingTouchdowns;
  final int passingAttempts;
  final int passingCompletions;
  final int passingYards;
  final int passingTouchdowns;
  final int passingInterceptions;
  final double passingYardsPerAttempt;
  final double passingYardsPerCompletion;
  final double completionPercentage;
  final double passerRating;
  final int thirdDownAttempts;
  final int thirdDownConversions;
  final double thirdDownPercentage;
  final int fourthDownAttempts;
  final int fourthDownConversions;
  final double fourthDownPercentage;
  final int redZoneAttempts;
  final int redZoneConversions;
  final int goalToGoAttempts;
  final int goalToGoConversions;
  final int returnYards;
  final int penalties;
  final int penaltyYards;
  final int fumbles;
  final int fumblesLost;
  final int timesSacked;
  final int timesSackedYards;
  final int quarterbackHits;
  final int tacklesForLoss;
  final int safeties;
  final int punts;
  final int puntYards;
  final double puntAverage;
  final int giveaways;
  final int takeaways;
  final int turnoverDifferential;
  final int opponentScoreQuarter1;
  final int opponentScoreQuarter2;
  final int opponentScoreQuarter3;
  final int opponentScoreQuarter4;
  final int opponentScoreOvertime;
  final String opponentTimeOfPossession;
  final int opponentFirstDowns;
  final int opponentFirstDownsByRushing;
  final int opponentFirstDownsByPassing;
  final int opponentFirstDownsByPenalty;
  final int opponentOffensivePlays;
  final int opponentOffensiveYards;
  final double opponentOffensiveYardsPerPlay;
  final int opponentTouchdowns;
  final int opponentRushingAttempts;
  final int opponentRushingYards;
  final double opponentRushingYardsPerAttempt;
  final int opponentRushingTouchdowns;
  final int opponentPassingAttempts;
  final int opponentPassingCompletions;
  final int opponentPassingYards;
  final int opponentPassingTouchdowns;
  final int opponentPassingInterceptions;
  final double opponentPassingYardsPerAttempt;
  final double opponentPassingYardsPerCompletion;
  final double opponentCompletionPercentage;
  final double opponentPasserRating;
  final int opponentThirdDownAttempts;
  final int opponentThirdDownConversions;
  final double opponentThirdDownPercentage;
  final int opponentFourthDownAttempts;
  final int opponentFourthDownConversions;
  final double opponentFourthDownPercentage;
  final int opponentRedZoneAttempts;
  final int opponentRedZoneConversions;
  final int opponentGoalToGoAttempts;
  final int opponentGoalToGoConversions;
  final int opponentReturnYards;
  final int opponentPenalties;
  final int opponentPenaltyYards;
  final int opponentFumbles;
  final int opponentFumblesLost;
  final int opponentTimesSacked;
  final int opponentTimesSackedYards;
  final int opponentQuarterbackHits;
  final int opponentTacklesForLoss;
  final int opponentSafeties;
  final int opponentPunts;
  final int opponentPuntYards;
  final double opponentPuntAverage;
  final int opponentGiveaways;
  final int opponentTakeaways;
  final int opponentTurnoverDifferential;
  final double redZonePercentage;
  final int goalToGoPercentage;
  final int quarterbackHitsDifferential;
  final int tacklesForLossDifferential;
  final int quarterbackSacksDifferential;
  final double tacklesForLossPercentage;
  final double quarterbackHitsPercentage;
  final double timesSackedPercentage;
  final double opponentRedZonePercentage;
  final int opponentGoalToGoPercentage;
  final int opponentQuarterbackHitsDifferential;
  final int opponentTacklesForLossDifferential;
  final int opponentQuarterbackSacksDifferential;
  final double opponentTacklesForLossPercentage;
  final double opponentQuarterbackHitsPercentage;
  final double opponentTimesSackedPercentage;
  final int kickoffs;
  final int kickoffsInEndZone;
  final int kickoffTouchbacks;
  final int puntsHadBlocked;
  final double puntNetAverage;
  final int extraPointKickingAttempts;
  final int extraPointKickingConversions;
  final int extraPointsHadBlocked;
  final int extraPointPassingAttempts;
  final int extraPointPassingConversions;
  final int extraPointRushingAttempts;
  final int extraPointRushingConversions;
  final int fieldGoalAttempts;
  final int fieldGoalsMade;
  final int fieldGoalsHadBlocked;
  final int puntReturns;
  final int puntReturnYards;
  final int kickReturns;
  final int kickReturnYards;
  final int interceptionReturns;
  final int interceptionReturnYards;
  final int opponentKickoffs;
  final int opponentKickoffsInEndZone;
  final int opponentKickoffTouchbacks;
  final int opponentPuntsHadBlocked;
  final double opponentPuntNetAverage;
  final int opponentExtraPointKickingAttempts;
  final int opponentExtraPointKickingConversions;
  final int opponentExtraPointsHadBlocked;
  final int opponentExtraPointPassingAttempts;
  final int opponentExtraPointPassingConversions;
  final int opponentExtraPointRushingAttempts;
  final int opponentExtraPointRushingConversions;
  final int opponentFieldGoalAttempts;
  final int opponentFieldGoalsMade;
  final int opponentFieldGoalsHadBlocked;
  final int opponentPuntReturns;
  final int opponentPuntReturnYards;
  final int opponentKickReturns;
  final int opponentKickReturnYards;
  final int opponentInterceptionReturns;
  final int opponentInterceptionReturnYards;
  final int soloTackles;
  final int assistedTackles;
  final int sacks;
  final int sackYards;
  final int passesDefended;
  final int fumblesForced;
  final int fumblesRecovered;
  final int fumbleReturnYards;
  final int fumbleReturnTouchdowns;
  final int interceptionReturnTouchdowns;
  final int blockedKicks;
  final int puntReturnTouchdowns;
  final int puntReturnLong;
  final int kickReturnTouchdowns;
  final int kickReturnLong;
  final int blockedKickReturnYards;
  final int blockedKickReturnTouchdowns;
  final int fieldGoalReturnYards;
  final int fieldGoalReturnTouchdowns;
  final int puntNetYards;
  final int opponentSoloTackles;
  final int opponentAssistedTackles;
  final int opponentSacks;
  final int opponentSackYards;
  final int opponentPassesDefended;
  final int opponentFumblesForced;
  final int opponentFumblesRecovered;
  final int opponentFumbleReturnYards;
  final int opponentFumbleReturnTouchdowns;
  final int opponentInterceptionReturnTouchdowns;
  final int opponentBlockedKicks;
  final int opponentPuntReturnTouchdowns;
  final int opponentPuntReturnLong;
  final int opponentKickReturnTouchdowns;
  final int opponentKickReturnLong;
  final int opponentBlockedKickReturnYards;
  final int opponentBlockedKickReturnTouchdowns;
  final int opponentFieldGoalReturnYards;
  final int opponentFieldGoalReturnTouchdowns;
  final int opponentPuntNetYards;
  final String teamName;
  final int games;
  final int passingDropbacks;
  final int opponentPassingDropbacks;
  final int teamSeasonId;
  final int twoPointConversionReturns;
  final int opponentTwoPointConversionReturns;
  final int teamId;
  final int globalTeamId;
  final int teamStatId;

  NflTeamStats copyWith({
    int seasonType,
    int season,
    String team,
    int score,
    int opponentScore,
    int totalScore,
    int temperature,
    int humidity,
    int windSpeed,
    double overUnder,
    double pointSpread,
    int scoreQuarter1,
    int scoreQuarter2,
    int scoreQuarter3,
    int scoreQuarter4,
    int scoreOvertime,
    String timeOfPossession,
    int firstDowns,
    int firstDownsByRushing,
    int firstDownsByPassing,
    int firstDownsByPenalty,
    int offensivePlays,
    int offensiveYards,
    double offensiveYardsPerPlay,
    int touchdowns,
    int rushingAttempts,
    int rushingYards,
    double rushingYardsPerAttempt,
    int rushingTouchdowns,
    int passingAttempts,
    int passingCompletions,
    int passingYards,
    int passingTouchdowns,
    int passingInterceptions,
    double passingYardsPerAttempt,
    double passingYardsPerCompletion,
    double completionPercentage,
    double passerRating,
    int thirdDownAttempts,
    int thirdDownConversions,
    double thirdDownPercentage,
    int fourthDownAttempts,
    int fourthDownConversions,
    double fourthDownPercentage,
    int redZoneAttempts,
    int redZoneConversions,
    int goalToGoAttempts,
    int goalToGoConversions,
    int returnYards,
    int penalties,
    int penaltyYards,
    int fumbles,
    int fumblesLost,
    int timesSacked,
    int timesSackedYards,
    int quarterbackHits,
    int tacklesForLoss,
    int safeties,
    int punts,
    int puntYards,
    double puntAverage,
    int giveaways,
    int takeaways,
    int turnoverDifferential,
    int opponentScoreQuarter1,
    int opponentScoreQuarter2,
    int opponentScoreQuarter3,
    int opponentScoreQuarter4,
    int opponentScoreOvertime,
    String opponentTimeOfPossession,
    int opponentFirstDowns,
    int opponentFirstDownsByRushing,
    int opponentFirstDownsByPassing,
    int opponentFirstDownsByPenalty,
    int opponentOffensivePlays,
    int opponentOffensiveYards,
    double opponentOffensiveYardsPerPlay,
    int opponentTouchdowns,
    int opponentRushingAttempts,
    int opponentRushingYards,
    double opponentRushingYardsPerAttempt,
    int opponentRushingTouchdowns,
    int opponentPassingAttempts,
    int opponentPassingCompletions,
    int opponentPassingYards,
    int opponentPassingTouchdowns,
    int opponentPassingInterceptions,
    double opponentPassingYardsPerAttempt,
    double opponentPassingYardsPerCompletion,
    double opponentCompletionPercentage,
    double opponentPasserRating,
    int opponentThirdDownAttempts,
    int opponentThirdDownConversions,
    double opponentThirdDownPercentage,
    int opponentFourthDownAttempts,
    int opponentFourthDownConversions,
    double opponentFourthDownPercentage,
    int opponentRedZoneAttempts,
    int opponentRedZoneConversions,
    int opponentGoalToGoAttempts,
    int opponentGoalToGoConversions,
    int opponentReturnYards,
    int opponentPenalties,
    int opponentPenaltyYards,
    int opponentFumbles,
    int opponentFumblesLost,
    int opponentTimesSacked,
    int opponentTimesSackedYards,
    int opponentQuarterbackHits,
    int opponentTacklesForLoss,
    int opponentSafeties,
    int opponentPunts,
    int opponentPuntYards,
    double opponentPuntAverage,
    int opponentGiveaways,
    int opponentTakeaways,
    int opponentTurnoverDifferential,
    double redZonePercentage,
    int goalToGoPercentage,
    int quarterbackHitsDifferential,
    int tacklesForLossDifferential,
    int quarterbackSacksDifferential,
    double tacklesForLossPercentage,
    double quarterbackHitsPercentage,
    double timesSackedPercentage,
    double opponentRedZonePercentage,
    int opponentGoalToGoPercentage,
    int opponentQuarterbackHitsDifferential,
    int opponentTacklesForLossDifferential,
    int opponentQuarterbackSacksDifferential,
    double opponentTacklesForLossPercentage,
    double opponentQuarterbackHitsPercentage,
    double opponentTimesSackedPercentage,
    int kickoffs,
    int kickoffsInEndZone,
    int kickoffTouchbacks,
    int puntsHadBlocked,
    double puntNetAverage,
    int extraPointKickingAttempts,
    int extraPointKickingConversions,
    int extraPointsHadBlocked,
    int extraPointPassingAttempts,
    int extraPointPassingConversions,
    int extraPointRushingAttempts,
    int extraPointRushingConversions,
    int fieldGoalAttempts,
    int fieldGoalsMade,
    int fieldGoalsHadBlocked,
    int puntReturns,
    int puntReturnYards,
    int kickReturns,
    int kickReturnYards,
    int interceptionReturns,
    int interceptionReturnYards,
    int opponentKickoffs,
    int opponentKickoffsInEndZone,
    int opponentKickoffTouchbacks,
    int opponentPuntsHadBlocked,
    double opponentPuntNetAverage,
    int opponentExtraPointKickingAttempts,
    int opponentExtraPointKickingConversions,
    int opponentExtraPointsHadBlocked,
    int opponentExtraPointPassingAttempts,
    int opponentExtraPointPassingConversions,
    int opponentExtraPointRushingAttempts,
    int opponentExtraPointRushingConversions,
    int opponentFieldGoalAttempts,
    int opponentFieldGoalsMade,
    int opponentFieldGoalsHadBlocked,
    int opponentPuntReturns,
    int opponentPuntReturnYards,
    int opponentKickReturns,
    int opponentKickReturnYards,
    int opponentInterceptionReturns,
    int opponentInterceptionReturnYards,
    int soloTackles,
    int assistedTackles,
    int sacks,
    int sackYards,
    int passesDefended,
    int fumblesForced,
    int fumblesRecovered,
    int fumbleReturnYards,
    int fumbleReturnTouchdowns,
    int interceptionReturnTouchdowns,
    int blockedKicks,
    int puntReturnTouchdowns,
    int puntReturnLong,
    int kickReturnTouchdowns,
    int kickReturnLong,
    int blockedKickReturnYards,
    int blockedKickReturnTouchdowns,
    int fieldGoalReturnYards,
    int fieldGoalReturnTouchdowns,
    int puntNetYards,
    int opponentSoloTackles,
    int opponentAssistedTackles,
    int opponentSacks,
    int opponentSackYards,
    int opponentPassesDefended,
    int opponentFumblesForced,
    int opponentFumblesRecovered,
    int opponentFumbleReturnYards,
    int opponentFumbleReturnTouchdowns,
    int opponentInterceptionReturnTouchdowns,
    int opponentBlockedKicks,
    int opponentPuntReturnTouchdowns,
    int opponentPuntReturnLong,
    int opponentKickReturnTouchdowns,
    int opponentKickReturnLong,
    int opponentBlockedKickReturnYards,
    int opponentBlockedKickReturnTouchdowns,
    int opponentFieldGoalReturnYards,
    int opponentFieldGoalReturnTouchdowns,
    int opponentPuntNetYards,
    String teamName,
    int games,
    int passingDropbacks,
    int opponentPassingDropbacks,
    int teamSeasonId,
    int twoPointConversionReturns,
    int opponentTwoPointConversionReturns,
    int teamId,
    int globalTeamId,
    int teamStatId,
  }) =>
      NflTeamStats(
        seasonType: seasonType ?? this.seasonType,
        season: season ?? this.season,
        team: team ?? this.team,
        score: score ?? this.score,
        opponentScore: opponentScore ?? this.opponentScore,
        totalScore: totalScore ?? this.totalScore,
        temperature: temperature ?? this.temperature,
        humidity: humidity ?? this.humidity,
        windSpeed: windSpeed ?? this.windSpeed,
        overUnder: overUnder ?? this.overUnder,
        pointSpread: pointSpread ?? this.pointSpread,
        scoreQuarter1: scoreQuarter1 ?? this.scoreQuarter1,
        scoreQuarter2: scoreQuarter2 ?? this.scoreQuarter2,
        scoreQuarter3: scoreQuarter3 ?? this.scoreQuarter3,
        scoreQuarter4: scoreQuarter4 ?? this.scoreQuarter4,
        scoreOvertime: scoreOvertime ?? this.scoreOvertime,
        timeOfPossession: timeOfPossession ?? this.timeOfPossession,
        firstDowns: firstDowns ?? this.firstDowns,
        firstDownsByRushing: firstDownsByRushing ?? this.firstDownsByRushing,
        firstDownsByPassing: firstDownsByPassing ?? this.firstDownsByPassing,
        firstDownsByPenalty: firstDownsByPenalty ?? this.firstDownsByPenalty,
        offensivePlays: offensivePlays ?? this.offensivePlays,
        offensiveYards: offensiveYards ?? this.offensiveYards,
        offensiveYardsPerPlay:
            offensiveYardsPerPlay ?? this.offensiveYardsPerPlay,
        touchdowns: touchdowns ?? this.touchdowns,
        rushingAttempts: rushingAttempts ?? this.rushingAttempts,
        rushingYards: rushingYards ?? this.rushingYards,
        rushingYardsPerAttempt:
            rushingYardsPerAttempt ?? this.rushingYardsPerAttempt,
        rushingTouchdowns: rushingTouchdowns ?? this.rushingTouchdowns,
        passingAttempts: passingAttempts ?? this.passingAttempts,
        passingCompletions: passingCompletions ?? this.passingCompletions,
        passingYards: passingYards ?? this.passingYards,
        passingTouchdowns: passingTouchdowns ?? this.passingTouchdowns,
        passingInterceptions: passingInterceptions ?? this.passingInterceptions,
        passingYardsPerAttempt:
            passingYardsPerAttempt ?? this.passingYardsPerAttempt,
        passingYardsPerCompletion:
            passingYardsPerCompletion ?? this.passingYardsPerCompletion,
        completionPercentage: completionPercentage ?? this.completionPercentage,
        passerRating: passerRating ?? this.passerRating,
        thirdDownAttempts: thirdDownAttempts ?? this.thirdDownAttempts,
        thirdDownConversions: thirdDownConversions ?? this.thirdDownConversions,
        thirdDownPercentage: thirdDownPercentage ?? this.thirdDownPercentage,
        fourthDownAttempts: fourthDownAttempts ?? this.fourthDownAttempts,
        fourthDownConversions:
            fourthDownConversions ?? this.fourthDownConversions,
        fourthDownPercentage: fourthDownPercentage ?? this.fourthDownPercentage,
        redZoneAttempts: redZoneAttempts ?? this.redZoneAttempts,
        redZoneConversions: redZoneConversions ?? this.redZoneConversions,
        goalToGoAttempts: goalToGoAttempts ?? this.goalToGoAttempts,
        goalToGoConversions: goalToGoConversions ?? this.goalToGoConversions,
        returnYards: returnYards ?? this.returnYards,
        penalties: penalties ?? this.penalties,
        penaltyYards: penaltyYards ?? this.penaltyYards,
        fumbles: fumbles ?? this.fumbles,
        fumblesLost: fumblesLost ?? this.fumblesLost,
        timesSacked: timesSacked ?? this.timesSacked,
        timesSackedYards: timesSackedYards ?? this.timesSackedYards,
        quarterbackHits: quarterbackHits ?? this.quarterbackHits,
        tacklesForLoss: tacklesForLoss ?? this.tacklesForLoss,
        safeties: safeties ?? this.safeties,
        punts: punts ?? this.punts,
        puntYards: puntYards ?? this.puntYards,
        puntAverage: puntAverage ?? this.puntAverage,
        giveaways: giveaways ?? this.giveaways,
        takeaways: takeaways ?? this.takeaways,
        turnoverDifferential: turnoverDifferential ?? this.turnoverDifferential,
        opponentScoreQuarter1:
            opponentScoreQuarter1 ?? this.opponentScoreQuarter1,
        opponentScoreQuarter2:
            opponentScoreQuarter2 ?? this.opponentScoreQuarter2,
        opponentScoreQuarter3:
            opponentScoreQuarter3 ?? this.opponentScoreQuarter3,
        opponentScoreQuarter4:
            opponentScoreQuarter4 ?? this.opponentScoreQuarter4,
        opponentScoreOvertime:
            opponentScoreOvertime ?? this.opponentScoreOvertime,
        opponentTimeOfPossession:
            opponentTimeOfPossession ?? this.opponentTimeOfPossession,
        opponentFirstDowns: opponentFirstDowns ?? this.opponentFirstDowns,
        opponentFirstDownsByRushing:
            opponentFirstDownsByRushing ?? this.opponentFirstDownsByRushing,
        opponentFirstDownsByPassing:
            opponentFirstDownsByPassing ?? this.opponentFirstDownsByPassing,
        opponentFirstDownsByPenalty:
            opponentFirstDownsByPenalty ?? this.opponentFirstDownsByPenalty,
        opponentOffensivePlays:
            opponentOffensivePlays ?? this.opponentOffensivePlays,
        opponentOffensiveYards:
            opponentOffensiveYards ?? this.opponentOffensiveYards,
        opponentOffensiveYardsPerPlay:
            opponentOffensiveYardsPerPlay ?? this.opponentOffensiveYardsPerPlay,
        opponentTouchdowns: opponentTouchdowns ?? this.opponentTouchdowns,
        opponentRushingAttempts:
            opponentRushingAttempts ?? this.opponentRushingAttempts,
        opponentRushingYards: opponentRushingYards ?? this.opponentRushingYards,
        opponentRushingYardsPerAttempt: opponentRushingYardsPerAttempt ??
            this.opponentRushingYardsPerAttempt,
        opponentRushingTouchdowns:
            opponentRushingTouchdowns ?? this.opponentRushingTouchdowns,
        opponentPassingAttempts:
            opponentPassingAttempts ?? this.opponentPassingAttempts,
        opponentPassingCompletions:
            opponentPassingCompletions ?? this.opponentPassingCompletions,
        opponentPassingYards: opponentPassingYards ?? this.opponentPassingYards,
        opponentPassingTouchdowns:
            opponentPassingTouchdowns ?? this.opponentPassingTouchdowns,
        opponentPassingInterceptions:
            opponentPassingInterceptions ?? this.opponentPassingInterceptions,
        opponentPassingYardsPerAttempt: opponentPassingYardsPerAttempt ??
            this.opponentPassingYardsPerAttempt,
        opponentPassingYardsPerCompletion: opponentPassingYardsPerCompletion ??
            this.opponentPassingYardsPerCompletion,
        opponentCompletionPercentage:
            opponentCompletionPercentage ?? this.opponentCompletionPercentage,
        opponentPasserRating: opponentPasserRating ?? this.opponentPasserRating,
        opponentThirdDownAttempts:
            opponentThirdDownAttempts ?? this.opponentThirdDownAttempts,
        opponentThirdDownConversions:
            opponentThirdDownConversions ?? this.opponentThirdDownConversions,
        opponentThirdDownPercentage:
            opponentThirdDownPercentage ?? this.opponentThirdDownPercentage,
        opponentFourthDownAttempts:
            opponentFourthDownAttempts ?? this.opponentFourthDownAttempts,
        opponentFourthDownConversions:
            opponentFourthDownConversions ?? this.opponentFourthDownConversions,
        opponentFourthDownPercentage:
            opponentFourthDownPercentage ?? this.opponentFourthDownPercentage,
        opponentRedZoneAttempts:
            opponentRedZoneAttempts ?? this.opponentRedZoneAttempts,
        opponentRedZoneConversions:
            opponentRedZoneConversions ?? this.opponentRedZoneConversions,
        opponentGoalToGoAttempts:
            opponentGoalToGoAttempts ?? this.opponentGoalToGoAttempts,
        opponentGoalToGoConversions:
            opponentGoalToGoConversions ?? this.opponentGoalToGoConversions,
        opponentReturnYards: opponentReturnYards ?? this.opponentReturnYards,
        opponentPenalties: opponentPenalties ?? this.opponentPenalties,
        opponentPenaltyYards: opponentPenaltyYards ?? this.opponentPenaltyYards,
        opponentFumbles: opponentFumbles ?? this.opponentFumbles,
        opponentFumblesLost: opponentFumblesLost ?? this.opponentFumblesLost,
        opponentTimesSacked: opponentTimesSacked ?? this.opponentTimesSacked,
        opponentTimesSackedYards:
            opponentTimesSackedYards ?? this.opponentTimesSackedYards,
        opponentQuarterbackHits:
            opponentQuarterbackHits ?? this.opponentQuarterbackHits,
        opponentTacklesForLoss:
            opponentTacklesForLoss ?? this.opponentTacklesForLoss,
        opponentSafeties: opponentSafeties ?? this.opponentSafeties,
        opponentPunts: opponentPunts ?? this.opponentPunts,
        opponentPuntYards: opponentPuntYards ?? this.opponentPuntYards,
        opponentPuntAverage: opponentPuntAverage ?? this.opponentPuntAverage,
        opponentGiveaways: opponentGiveaways ?? this.opponentGiveaways,
        opponentTakeaways: opponentTakeaways ?? this.opponentTakeaways,
        opponentTurnoverDifferential:
            opponentTurnoverDifferential ?? this.opponentTurnoverDifferential,
        redZonePercentage: redZonePercentage ?? this.redZonePercentage,
        goalToGoPercentage: goalToGoPercentage ?? this.goalToGoPercentage,
        quarterbackHitsDifferential:
            quarterbackHitsDifferential ?? this.quarterbackHitsDifferential,
        tacklesForLossDifferential:
            tacklesForLossDifferential ?? this.tacklesForLossDifferential,
        quarterbackSacksDifferential:
            quarterbackSacksDifferential ?? this.quarterbackSacksDifferential,
        tacklesForLossPercentage:
            tacklesForLossPercentage ?? this.tacklesForLossPercentage,
        quarterbackHitsPercentage:
            quarterbackHitsPercentage ?? this.quarterbackHitsPercentage,
        timesSackedPercentage:
            timesSackedPercentage ?? this.timesSackedPercentage,
        opponentRedZonePercentage:
            opponentRedZonePercentage ?? this.opponentRedZonePercentage,
        opponentGoalToGoPercentage:
            opponentGoalToGoPercentage ?? this.opponentGoalToGoPercentage,
        opponentQuarterbackHitsDifferential:
            opponentQuarterbackHitsDifferential ??
                this.opponentQuarterbackHitsDifferential,
        opponentTacklesForLossDifferential:
            opponentTacklesForLossDifferential ??
                this.opponentTacklesForLossDifferential,
        opponentQuarterbackSacksDifferential:
            opponentQuarterbackSacksDifferential ??
                this.opponentQuarterbackSacksDifferential,
        opponentTacklesForLossPercentage: opponentTacklesForLossPercentage ??
            this.opponentTacklesForLossPercentage,
        opponentQuarterbackHitsPercentage: opponentQuarterbackHitsPercentage ??
            this.opponentQuarterbackHitsPercentage,
        opponentTimesSackedPercentage:
            opponentTimesSackedPercentage ?? this.opponentTimesSackedPercentage,
        kickoffs: kickoffs ?? this.kickoffs,
        kickoffsInEndZone: kickoffsInEndZone ?? this.kickoffsInEndZone,
        kickoffTouchbacks: kickoffTouchbacks ?? this.kickoffTouchbacks,
        puntsHadBlocked: puntsHadBlocked ?? this.puntsHadBlocked,
        puntNetAverage: puntNetAverage ?? this.puntNetAverage,
        extraPointKickingAttempts:
            extraPointKickingAttempts ?? this.extraPointKickingAttempts,
        extraPointKickingConversions:
            extraPointKickingConversions ?? this.extraPointKickingConversions,
        extraPointsHadBlocked:
            extraPointsHadBlocked ?? this.extraPointsHadBlocked,
        extraPointPassingAttempts:
            extraPointPassingAttempts ?? this.extraPointPassingAttempts,
        extraPointPassingConversions:
            extraPointPassingConversions ?? this.extraPointPassingConversions,
        extraPointRushingAttempts:
            extraPointRushingAttempts ?? this.extraPointRushingAttempts,
        extraPointRushingConversions:
            extraPointRushingConversions ?? this.extraPointRushingConversions,
        fieldGoalAttempts: fieldGoalAttempts ?? this.fieldGoalAttempts,
        fieldGoalsMade: fieldGoalsMade ?? this.fieldGoalsMade,
        fieldGoalsHadBlocked: fieldGoalsHadBlocked ?? this.fieldGoalsHadBlocked,
        puntReturns: puntReturns ?? this.puntReturns,
        puntReturnYards: puntReturnYards ?? this.puntReturnYards,
        kickReturns: kickReturns ?? this.kickReturns,
        kickReturnYards: kickReturnYards ?? this.kickReturnYards,
        interceptionReturns: interceptionReturns ?? this.interceptionReturns,
        interceptionReturnYards:
            interceptionReturnYards ?? this.interceptionReturnYards,
        opponentKickoffs: opponentKickoffs ?? this.opponentKickoffs,
        opponentKickoffsInEndZone:
            opponentKickoffsInEndZone ?? this.opponentKickoffsInEndZone,
        opponentKickoffTouchbacks:
            opponentKickoffTouchbacks ?? this.opponentKickoffTouchbacks,
        opponentPuntsHadBlocked:
            opponentPuntsHadBlocked ?? this.opponentPuntsHadBlocked,
        opponentPuntNetAverage:
            opponentPuntNetAverage ?? this.opponentPuntNetAverage,
        opponentExtraPointKickingAttempts: opponentExtraPointKickingAttempts ??
            this.opponentExtraPointKickingAttempts,
        opponentExtraPointKickingConversions:
            opponentExtraPointKickingConversions ??
                this.opponentExtraPointKickingConversions,
        opponentExtraPointsHadBlocked:
            opponentExtraPointsHadBlocked ?? this.opponentExtraPointsHadBlocked,
        opponentExtraPointPassingAttempts: opponentExtraPointPassingAttempts ??
            this.opponentExtraPointPassingAttempts,
        opponentExtraPointPassingConversions:
            opponentExtraPointPassingConversions ??
                this.opponentExtraPointPassingConversions,
        opponentExtraPointRushingAttempts: opponentExtraPointRushingAttempts ??
            this.opponentExtraPointRushingAttempts,
        opponentExtraPointRushingConversions:
            opponentExtraPointRushingConversions ??
                this.opponentExtraPointRushingConversions,
        opponentFieldGoalAttempts:
            opponentFieldGoalAttempts ?? this.opponentFieldGoalAttempts,
        opponentFieldGoalsMade:
            opponentFieldGoalsMade ?? this.opponentFieldGoalsMade,
        opponentFieldGoalsHadBlocked:
            opponentFieldGoalsHadBlocked ?? this.opponentFieldGoalsHadBlocked,
        opponentPuntReturns: opponentPuntReturns ?? this.opponentPuntReturns,
        opponentPuntReturnYards:
            opponentPuntReturnYards ?? this.opponentPuntReturnYards,
        opponentKickReturns: opponentKickReturns ?? this.opponentKickReturns,
        opponentKickReturnYards:
            opponentKickReturnYards ?? this.opponentKickReturnYards,
        opponentInterceptionReturns:
            opponentInterceptionReturns ?? this.opponentInterceptionReturns,
        opponentInterceptionReturnYards: opponentInterceptionReturnYards ??
            this.opponentInterceptionReturnYards,
        soloTackles: soloTackles ?? this.soloTackles,
        assistedTackles: assistedTackles ?? this.assistedTackles,
        sacks: sacks ?? this.sacks,
        sackYards: sackYards ?? this.sackYards,
        passesDefended: passesDefended ?? this.passesDefended,
        fumblesForced: fumblesForced ?? this.fumblesForced,
        fumblesRecovered: fumblesRecovered ?? this.fumblesRecovered,
        fumbleReturnYards: fumbleReturnYards ?? this.fumbleReturnYards,
        fumbleReturnTouchdowns:
            fumbleReturnTouchdowns ?? this.fumbleReturnTouchdowns,
        interceptionReturnTouchdowns:
            interceptionReturnTouchdowns ?? this.interceptionReturnTouchdowns,
        blockedKicks: blockedKicks ?? this.blockedKicks,
        puntReturnTouchdowns: puntReturnTouchdowns ?? this.puntReturnTouchdowns,
        puntReturnLong: puntReturnLong ?? this.puntReturnLong,
        kickReturnTouchdowns: kickReturnTouchdowns ?? this.kickReturnTouchdowns,
        kickReturnLong: kickReturnLong ?? this.kickReturnLong,
        blockedKickReturnYards:
            blockedKickReturnYards ?? this.blockedKickReturnYards,
        blockedKickReturnTouchdowns:
            blockedKickReturnTouchdowns ?? this.blockedKickReturnTouchdowns,
        fieldGoalReturnYards: fieldGoalReturnYards ?? this.fieldGoalReturnYards,
        fieldGoalReturnTouchdowns:
            fieldGoalReturnTouchdowns ?? this.fieldGoalReturnTouchdowns,
        puntNetYards: puntNetYards ?? this.puntNetYards,
        opponentSoloTackles: opponentSoloTackles ?? this.opponentSoloTackles,
        opponentAssistedTackles:
            opponentAssistedTackles ?? this.opponentAssistedTackles,
        opponentSacks: opponentSacks ?? this.opponentSacks,
        opponentSackYards: opponentSackYards ?? this.opponentSackYards,
        opponentPassesDefended:
            opponentPassesDefended ?? this.opponentPassesDefended,
        opponentFumblesForced:
            opponentFumblesForced ?? this.opponentFumblesForced,
        opponentFumblesRecovered:
            opponentFumblesRecovered ?? this.opponentFumblesRecovered,
        opponentFumbleReturnYards:
            opponentFumbleReturnYards ?? this.opponentFumbleReturnYards,
        opponentFumbleReturnTouchdowns: opponentFumbleReturnTouchdowns ??
            this.opponentFumbleReturnTouchdowns,
        opponentInterceptionReturnTouchdowns:
            opponentInterceptionReturnTouchdowns ??
                this.opponentInterceptionReturnTouchdowns,
        opponentBlockedKicks: opponentBlockedKicks ?? this.opponentBlockedKicks,
        opponentPuntReturnTouchdowns:
            opponentPuntReturnTouchdowns ?? this.opponentPuntReturnTouchdowns,
        opponentPuntReturnLong:
            opponentPuntReturnLong ?? this.opponentPuntReturnLong,
        opponentKickReturnTouchdowns:
            opponentKickReturnTouchdowns ?? this.opponentKickReturnTouchdowns,
        opponentKickReturnLong:
            opponentKickReturnLong ?? this.opponentKickReturnLong,
        opponentBlockedKickReturnYards: opponentBlockedKickReturnYards ??
            this.opponentBlockedKickReturnYards,
        opponentBlockedKickReturnTouchdowns:
            opponentBlockedKickReturnTouchdowns ??
                this.opponentBlockedKickReturnTouchdowns,
        opponentFieldGoalReturnYards:
            opponentFieldGoalReturnYards ?? this.opponentFieldGoalReturnYards,
        opponentFieldGoalReturnTouchdowns: opponentFieldGoalReturnTouchdowns ??
            this.opponentFieldGoalReturnTouchdowns,
        opponentPuntNetYards: opponentPuntNetYards ?? this.opponentPuntNetYards,
        teamName: teamName ?? this.teamName,
        games: games ?? this.games,
        passingDropbacks: passingDropbacks ?? this.passingDropbacks,
        opponentPassingDropbacks:
            opponentPassingDropbacks ?? this.opponentPassingDropbacks,
        teamSeasonId: teamSeasonId ?? this.teamSeasonId,
        twoPointConversionReturns:
            twoPointConversionReturns ?? this.twoPointConversionReturns,
        opponentTwoPointConversionReturns: opponentTwoPointConversionReturns ??
            this.opponentTwoPointConversionReturns,
        teamId: teamId ?? this.teamId,
        globalTeamId: globalTeamId ?? this.globalTeamId,
        teamStatId: teamStatId ?? this.teamStatId,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'SeasonType': seasonType,
        'Season': season,
        'Team': team,
        'Score': score,
        'OpponentScore': opponentScore,
        'TotalScore': totalScore,
        'Temperature': temperature,
        'Humidity': humidity,
        'WindSpeed': windSpeed,
        'OverUnder': overUnder,
        'PointSpread': pointSpread,
        'ScoreQuarter1': scoreQuarter1,
        'ScoreQuarter2': scoreQuarter2,
        'ScoreQuarter3': scoreQuarter3,
        'ScoreQuarter4': scoreQuarter4,
        'ScoreOvertime': scoreOvertime,
        'TimeOfPossession': timeOfPossession,
        'FirstDowns': firstDowns,
        'FirstDownsByRushing': firstDownsByRushing,
        'FirstDownsByPassing': firstDownsByPassing,
        'FirstDownsByPenalty': firstDownsByPenalty,
        'OffensivePlays': offensivePlays,
        'OffensiveYards': offensiveYards,
        'OffensiveYardsPerPlay': offensiveYardsPerPlay,
        'Touchdowns': touchdowns,
        'RushingAttempts': rushingAttempts,
        'RushingYards': rushingYards,
        'RushingYardsPerAttempt': rushingYardsPerAttempt,
        'RushingTouchdowns': rushingTouchdowns,
        'PassingAttempts': passingAttempts,
        'PassingCompletions': passingCompletions,
        'PassingYards': passingYards,
        'PassingTouchdowns': passingTouchdowns,
        'PassingInterceptions': passingInterceptions,
        'PassingYardsPerAttempt': passingYardsPerAttempt,
        'PassingYardsPerCompletion': passingYardsPerCompletion,
        'CompletionPercentage': completionPercentage,
        'PasserRating': passerRating,
        'ThirdDownAttempts': thirdDownAttempts,
        'ThirdDownConversions': thirdDownConversions,
        'ThirdDownPercentage': thirdDownPercentage,
        'FourthDownAttempts': fourthDownAttempts,
        'FourthDownConversions': fourthDownConversions,
        'FourthDownPercentage': fourthDownPercentage,
        'RedZoneAttempts': redZoneAttempts,
        'RedZoneConversions': redZoneConversions,
        'GoalToGoAttempts': goalToGoAttempts,
        'GoalToGoConversions': goalToGoConversions,
        'ReturnYards': returnYards,
        'Penalties': penalties,
        'PenaltyYards': penaltyYards,
        'Fumbles': fumbles,
        'FumblesLost': fumblesLost,
        'TimesSacked': timesSacked,
        'TimesSackedYards': timesSackedYards,
        'QuarterbackHits': quarterbackHits,
        'TacklesForLoss': tacklesForLoss,
        'Safeties': safeties,
        'Punts': punts,
        'PuntYards': puntYards,
        'PuntAverage': puntAverage,
        'Giveaways': giveaways,
        'Takeaways': takeaways,
        'TurnoverDifferential': turnoverDifferential,
        'OpponentScoreQuarter1': opponentScoreQuarter1,
        'OpponentScoreQuarter2': opponentScoreQuarter2,
        'OpponentScoreQuarter3': opponentScoreQuarter3,
        'OpponentScoreQuarter4': opponentScoreQuarter4,
        'OpponentScoreOvertime': opponentScoreOvertime,
        'OpponentTimeOfPossession': opponentTimeOfPossession,
        'OpponentFirstDowns': opponentFirstDowns,
        'OpponentFirstDownsByRushing': opponentFirstDownsByRushing,
        'OpponentFirstDownsByPassing': opponentFirstDownsByPassing,
        'OpponentFirstDownsByPenalty': opponentFirstDownsByPenalty,
        'OpponentOffensivePlays': opponentOffensivePlays,
        'OpponentOffensiveYards': opponentOffensiveYards,
        'OpponentOffensiveYardsPerPlay': opponentOffensiveYardsPerPlay,
        'OpponentTouchdowns': opponentTouchdowns,
        'OpponentRushingAttempts': opponentRushingAttempts,
        'OpponentRushingYards': opponentRushingYards,
        'OpponentRushingYardsPerAttempt': opponentRushingYardsPerAttempt,
        'OpponentRushingTouchdowns': opponentRushingTouchdowns,
        'OpponentPassingAttempts': opponentPassingAttempts,
        'OpponentPassingCompletions': opponentPassingCompletions,
        'OpponentPassingYards': opponentPassingYards,
        'OpponentPassingTouchdowns': opponentPassingTouchdowns,
        'OpponentPassingInterceptions': opponentPassingInterceptions,
        'OpponentPassingYardsPerAttempt': opponentPassingYardsPerAttempt,
        'OpponentPassingYardsPerCompletion': opponentPassingYardsPerCompletion,
        'OpponentCompletionPercentage': opponentCompletionPercentage,
        'OpponentPasserRating': opponentPasserRating,
        'OpponentThirdDownAttempts': opponentThirdDownAttempts,
        'OpponentThirdDownConversions': opponentThirdDownConversions,
        'OpponentThirdDownPercentage': opponentThirdDownPercentage,
        'OpponentFourthDownAttempts': opponentFourthDownAttempts,
        'OpponentFourthDownConversions': opponentFourthDownConversions,
        'OpponentFourthDownPercentage': opponentFourthDownPercentage,
        'OpponentRedZoneAttempts': opponentRedZoneAttempts,
        'OpponentRedZoneConversions': opponentRedZoneConversions,
        'OpponentGoalToGoAttempts': opponentGoalToGoAttempts,
        'OpponentGoalToGoConversions': opponentGoalToGoConversions,
        'OpponentReturnYards': opponentReturnYards,
        'OpponentPenalties': opponentPenalties,
        'OpponentPenaltyYards': opponentPenaltyYards,
        'OpponentFumbles': opponentFumbles,
        'OpponentFumblesLost': opponentFumblesLost,
        'OpponentTimesSacked': opponentTimesSacked,
        'OpponentTimesSackedYards': opponentTimesSackedYards,
        'OpponentQuarterbackHits': opponentQuarterbackHits,
        'OpponentTacklesForLoss': opponentTacklesForLoss,
        'OpponentSafeties': opponentSafeties,
        'OpponentPunts': opponentPunts,
        'OpponentPuntYards': opponentPuntYards,
        'OpponentPuntAverage': opponentPuntAverage,
        'OpponentGiveaways': opponentGiveaways,
        'OpponentTakeaways': opponentTakeaways,
        'OpponentTurnoverDifferential': opponentTurnoverDifferential,
        'RedZonePercentage': redZonePercentage,
        'GoalToGoPercentage': goalToGoPercentage,
        'QuarterbackHitsDifferential': quarterbackHitsDifferential,
        'TacklesForLossDifferential': tacklesForLossDifferential,
        'QuarterbackSacksDifferential': quarterbackSacksDifferential,
        'TacklesForLossPercentage': tacklesForLossPercentage,
        'QuarterbackHitsPercentage': quarterbackHitsPercentage,
        'TimesSackedPercentage': timesSackedPercentage,
        'OpponentRedZonePercentage': opponentRedZonePercentage,
        'OpponentGoalToGoPercentage': opponentGoalToGoPercentage,
        'OpponentQuarterbackHitsDifferential':
            opponentQuarterbackHitsDifferential,
        'OpponentTacklesForLossDifferential':
            opponentTacklesForLossDifferential,
        'OpponentQuarterbackSacksDifferential':
            opponentQuarterbackSacksDifferential,
        'OpponentTacklesForLossPercentage': opponentTacklesForLossPercentage,
        'OpponentQuarterbackHitsPercentage': opponentQuarterbackHitsPercentage,
        'OpponentTimesSackedPercentage': opponentTimesSackedPercentage,
        'Kickoffs': kickoffs,
        'KickoffsInEndZone': kickoffsInEndZone,
        'KickoffTouchbacks': kickoffTouchbacks,
        'PuntsHadBlocked': puntsHadBlocked,
        'PuntNetAverage': puntNetAverage,
        'ExtraPointKickingAttempts': extraPointKickingAttempts,
        'ExtraPointKickingConversions': extraPointKickingConversions,
        'ExtraPointsHadBlocked': extraPointsHadBlocked,
        'ExtraPointPassingAttempts': extraPointPassingAttempts,
        'ExtraPointPassingConversions': extraPointPassingConversions,
        'ExtraPointRushingAttempts': extraPointRushingAttempts,
        'ExtraPointRushingConversions': extraPointRushingConversions,
        'FieldGoalAttempts': fieldGoalAttempts,
        'FieldGoalsMade': fieldGoalsMade,
        'FieldGoalsHadBlocked': fieldGoalsHadBlocked,
        'PuntReturns': puntReturns,
        'PuntReturnYards': puntReturnYards,
        'KickReturns': kickReturns,
        'KickReturnYards': kickReturnYards,
        'InterceptionReturns': interceptionReturns,
        'InterceptionReturnYards': interceptionReturnYards,
        'OpponentKickoffs': opponentKickoffs,
        'OpponentKickoffsInEndZone': opponentKickoffsInEndZone,
        'OpponentKickoffTouchbacks': opponentKickoffTouchbacks,
        'OpponentPuntsHadBlocked': opponentPuntsHadBlocked,
        'OpponentPuntNetAverage': opponentPuntNetAverage,
        'OpponentExtraPointKickingAttempts': opponentExtraPointKickingAttempts,
        'OpponentExtraPointKickingConversions':
            opponentExtraPointKickingConversions,
        'OpponentExtraPointsHadBlocked': opponentExtraPointsHadBlocked,
        'OpponentExtraPointPassingAttempts': opponentExtraPointPassingAttempts,
        'OpponentExtraPointPassingConversions':
            opponentExtraPointPassingConversions,
        'OpponentExtraPointRushingAttempts': opponentExtraPointRushingAttempts,
        'OpponentExtraPointRushingConversions':
            opponentExtraPointRushingConversions,
        'OpponentFieldGoalAttempts': opponentFieldGoalAttempts,
        'OpponentFieldGoalsMade': opponentFieldGoalsMade,
        'OpponentFieldGoalsHadBlocked': opponentFieldGoalsHadBlocked,
        'OpponentPuntReturns': opponentPuntReturns,
        'OpponentPuntReturnYards': opponentPuntReturnYards,
        'OpponentKickReturns': opponentKickReturns,
        'OpponentKickReturnYards': opponentKickReturnYards,
        'OpponentInterceptionReturns': opponentInterceptionReturns,
        'OpponentInterceptionReturnYards': opponentInterceptionReturnYards,
        'SoloTackles': soloTackles,
        'AssistedTackles': assistedTackles,
        'Sacks': sacks,
        'SackYards': sackYards,
        'PassesDefended': passesDefended,
        'FumblesForced': fumblesForced,
        'FumblesRecovered': fumblesRecovered,
        'FumbleReturnYards': fumbleReturnYards,
        'FumbleReturnTouchdowns': fumbleReturnTouchdowns,
        'InterceptionReturnTouchdowns': interceptionReturnTouchdowns,
        'BlockedKicks': blockedKicks,
        'PuntReturnTouchdowns': puntReturnTouchdowns,
        'PuntReturnLong': puntReturnLong,
        'KickReturnTouchdowns': kickReturnTouchdowns,
        'KickReturnLong': kickReturnLong,
        'BlockedKickReturnYards': blockedKickReturnYards,
        'BlockedKickReturnTouchdowns': blockedKickReturnTouchdowns,
        'FieldGoalReturnYards': fieldGoalReturnYards,
        'FieldGoalReturnTouchdowns': fieldGoalReturnTouchdowns,
        'PuntNetYards': puntNetYards,
        'OpponentSoloTackles': opponentSoloTackles,
        'OpponentAssistedTackles': opponentAssistedTackles,
        'OpponentSacks': opponentSacks,
        'OpponentSackYards': opponentSackYards,
        'OpponentPassesDefended': opponentPassesDefended,
        'OpponentFumblesForced': opponentFumblesForced,
        'OpponentFumblesRecovered': opponentFumblesRecovered,
        'OpponentFumbleReturnYards': opponentFumbleReturnYards,
        'OpponentFumbleReturnTouchdowns': opponentFumbleReturnTouchdowns,
        'OpponentInterceptionReturnTouchdowns':
            opponentInterceptionReturnTouchdowns,
        'OpponentBlockedKicks': opponentBlockedKicks,
        'OpponentPuntReturnTouchdowns': opponentPuntReturnTouchdowns,
        'OpponentPuntReturnLong': opponentPuntReturnLong,
        'OpponentKickReturnTouchdowns': opponentKickReturnTouchdowns,
        'OpponentKickReturnLong': opponentKickReturnLong,
        'OpponentBlockedKickReturnYards': opponentBlockedKickReturnYards,
        'OpponentBlockedKickReturnTouchdowns':
            opponentBlockedKickReturnTouchdowns,
        'OpponentFieldGoalReturnYards': opponentFieldGoalReturnYards,
        'OpponentFieldGoalReturnTouchdowns': opponentFieldGoalReturnTouchdowns,
        'OpponentPuntNetYards': opponentPuntNetYards,
        'TeamName': teamName,
        'Games': games,
        'PassingDropbacks': passingDropbacks,
        'OpponentPassingDropbacks': opponentPassingDropbacks,
        'TeamSeasonID': teamSeasonId,
        'TwoPointConversionReturns': twoPointConversionReturns,
        'OpponentTwoPointConversionReturns': opponentTwoPointConversionReturns,
        'TeamID': teamId,
        'GlobalTeamID': globalTeamId,
        'TeamStatID': teamStatId,
      };
}
