

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

  factory NflTeamStats.fromJson(String str) => NflTeamStats.fromMap(
        json.decode(str) as Map<String, dynamic>,
      );
  factory NflTeamStats.fromMap(Map<String, dynamic> json) => NflTeamStats(
        seasonType: json['SeasonType']?.toInt() as int?,
        season: json['Season']?.toInt() as int?,
        team: json['Team'] as String?,
        score: json['Score']?.toInt() as int?,
        opponentScore: json['OpponentScore']?.toInt() as int?,
        totalScore: json['TotalScore']?.toInt() as int?,
        temperature: json['Temperature']?.toInt() as int?,
        humidity: json['Humidity']?.toInt() as int?,
        windSpeed: json['WindSpeed']?.toInt() as int?,
        overUnder: json['OverUnder']?.toDouble() as double?,
        pointSpread: json['PointSpread']?.toDouble() as double?,
        scoreQuarter1: json['ScoreQuarter1']?.toInt() as int?,
        scoreQuarter2: json['ScoreQuarter2']?.toInt() as int?,
        scoreQuarter3: json['ScoreQuarter3']?.toInt() as int?,
        scoreQuarter4: json['ScoreQuarter4']?.toInt() as int?,
        scoreOvertime: json['ScoreOvertime']?.toInt() as int?,
        timeOfPossession: json['TimeOfPossession'] as String?,
        firstDowns: json['FirstDowns']?.toInt() as int?,
        firstDownsByRushing: json['FirstDownsByRushing']?.toInt() as int?,
        firstDownsByPassing: json['FirstDownsByPassing']?.toInt() as int?,
        firstDownsByPenalty: json['FirstDownsByPenalty']?.toInt() as int?,
        offensivePlays: json['OffensivePlays']?.toInt() as int?,
        offensiveYards: json['OffensiveYards']?.toInt() as int?,
        offensiveYardsPerPlay:
            json['OffensiveYardsPerPlay']?.toDouble() as double?,
        touchdowns: json['Touchdowns']?.toInt() as int?,
        rushingAttempts: json['RushingAttempts']?.toInt() as int?,
        rushingYards: json['RushingYards']?.toInt() as int?,
        rushingYardsPerAttempt:
            json['RushingYardsPerAttempt']?.toDouble() as double?,
        rushingTouchdowns: json['RushingTouchdowns']?.toInt() as int?,
        passingAttempts: json['PassingAttempts']?.toInt() as int?,
        passingCompletions: json['PassingCompletions']?.toInt() as int?,
        passingYards: json['PassingYards']?.toInt() as int?,
        passingTouchdowns: json['PassingTouchdowns']?.toInt() as int?,
        passingInterceptions: json['PassingInterceptions']?.toInt() as int?,
        passingYardsPerAttempt:
            json['PassingYardsPerAttempt']?.toDouble() as double?,
        passingYardsPerCompletion:
            json['PassingYardsPerCompletion']?.toDouble() as double?,
        completionPercentage:
            json['CompletionPercentage']?.toDouble() as double?,
        passerRating: json['PasserRating']?.toDouble() as double?,
        thirdDownAttempts: json['ThirdDownAttempts']?.toInt() as int?,
        thirdDownConversions: json['ThirdDownConversions']?.toInt() as int?,
        thirdDownPercentage: json['ThirdDownPercentage']?.toDouble() as double?,
        fourthDownAttempts: json['FourthDownAttempts']?.toInt() as int?,
        fourthDownConversions: json['FourthDownConversions']?.toInt() as int?,
        fourthDownPercentage:
            json['FourthDownPercentage']?.toDouble() as double?,
        redZoneAttempts: json['RedZoneAttempts']?.toInt() as int?,
        redZoneConversions: json['RedZoneConversions']?.toInt() as int?,
        goalToGoAttempts: json['GoalToGoAttempts']?.toInt() as int?,
        goalToGoConversions: json['GoalToGoConversions']?.toInt() as int?,
        returnYards: json['ReturnYards']?.toInt() as int?,
        penalties: json['Penalties']?.toInt() as int?,
        penaltyYards: json['PenaltyYards']?.toInt() as int?,
        fumbles: json['Fumbles']?.toInt() as int?,
        fumblesLost: json['FumblesLost']?.toInt() as int?,
        timesSacked: json['TimesSacked']?.toInt() as int?,
        timesSackedYards: json['TimesSackedYards']?.toInt() as int?,
        quarterbackHits: json['QuarterbackHits']?.toInt() as int?,
        tacklesForLoss: json['TacklesForLoss']?.toInt() as int?,
        safeties: json['Safeties']?.toInt() as int?,
        punts: json['Punts']?.toInt() as int?,
        puntYards: json['PuntYards']?.toInt() as int?,
        puntAverage: json['PuntAverage']?.toDouble() as double?,
        giveaways: json['Giveaways']?.toInt() as int?,
        takeaways: json['Takeaways']?.toInt() as int?,
        turnoverDifferential: json['TurnoverDifferential']?.toInt() as int?,
        opponentScoreQuarter1: json['OpponentScoreQuarter1']?.toInt() as int?,
        opponentScoreQuarter2: json['OpponentScoreQuarter2']?.toInt() as int?,
        opponentScoreQuarter3: json['OpponentScoreQuarter3']?.toInt() as int?,
        opponentScoreQuarter4: json['OpponentScoreQuarter4']?.toInt() as int?,
        opponentScoreOvertime: json['OpponentScoreOvertime']?.toInt() as int?,
        opponentTimeOfPossession: json['OpponentTimeOfPossession'] as String?,
        opponentFirstDowns: json['OpponentFirstDowns']?.toInt() as int?,
        opponentFirstDownsByRushing:
            json['OpponentFirstDownsByRushing']?.toInt() as int?,
        opponentFirstDownsByPassing:
            json['OpponentFirstDownsByPassing']?.toInt() as int?,
        opponentFirstDownsByPenalty:
            json['OpponentFirstDownsByPenalty']?.toInt() as int?,
        opponentOffensivePlays: json['OpponentOffensivePlays']?.toInt() as int?,
        opponentOffensiveYards: json['OpponentOffensiveYards']?.toInt() as int?,
        opponentOffensiveYardsPerPlay:
            json['OpponentOffensiveYardsPerPlay']?.toDouble() as double?,
        opponentTouchdowns: json['OpponentTouchdowns']?.toInt() as int?,
        opponentRushingAttempts:
            json['OpponentRushingAttempts']?.toInt() as int?,
        opponentRushingYards: json['OpponentRushingYards']?.toInt() as int?,
        opponentRushingYardsPerAttempt:
            json['OpponentRushingYardsPerAttempt']?.toDouble() as double?,
        opponentRushingTouchdowns:
            json['OpponentRushingTouchdowns']?.toInt() as int?,
        opponentPassingAttempts:
            json['OpponentPassingAttempts']?.toInt() as int?,
        opponentPassingCompletions:
            json['OpponentPassingCompletions']?.toInt() as int?,
        opponentPassingYards: json['OpponentPassingYards']?.toInt() as int?,
        opponentPassingTouchdowns:
            json['OpponentPassingTouchdowns']?.toInt() as int?,
        opponentPassingInterceptions:
            json['OpponentPassingInterceptions']?.toInt() as int?,
        opponentPassingYardsPerAttempt:
            json['OpponentPassingYardsPerAttempt']?.toDouble() as double?,
        opponentPassingYardsPerCompletion:
            json['OpponentPassingYardsPerCompletion']?.toDouble() as double?,
        opponentCompletionPercentage:
            json['OpponentCompletionPercentage']?.toDouble() as double?,
        opponentPasserRating:
            json['OpponentPasserRating']?.toDouble() as double?,
        opponentThirdDownAttempts:
            json['OpponentThirdDownAttempts']?.toInt() as int?,
        opponentThirdDownConversions:
            json['OpponentThirdDownConversions']?.toInt() as int?,
        opponentThirdDownPercentage:
            json['OpponentThirdDownPercentage']?.toDouble() as double?,
        opponentFourthDownAttempts:
            json['OpponentFourthDownAttempts']?.toInt() as int?,
        opponentFourthDownConversions:
            json['OpponentFourthDownConversions']?.toInt() as int?,
        opponentFourthDownPercentage:
            json['OpponentFourthDownPercentage']?.toDouble() as double?,
        opponentRedZoneAttempts:
            json['OpponentRedZoneAttempts']?.toInt() as int?,
        opponentRedZoneConversions:
            json['OpponentRedZoneConversions']?.toInt() as int?,
        opponentGoalToGoAttempts:
            json['OpponentGoalToGoAttempts']?.toInt() as int?,
        opponentGoalToGoConversions:
            json['OpponentGoalToGoConversions']?.toInt() as int?,
        opponentReturnYards: json['OpponentReturnYards']?.toInt() as int?,
        opponentPenalties: json['OpponentPenalties']?.toInt() as int?,
        opponentPenaltyYards: json['OpponentPenaltyYards']?.toInt() as int?,
        opponentFumbles: json['OpponentFumbles']?.toInt() as int?,
        opponentFumblesLost: json['OpponentFumblesLost']?.toInt() as int?,
        opponentTimesSacked: json['OpponentTimesSacked']?.toInt() as int?,
        opponentTimesSackedYards:
            json['OpponentTimesSackedYards']?.toInt() as int?,
        opponentQuarterbackHits:
            json['OpponentQuarterbackHits']?.toInt() as int?,
        opponentTacklesForLoss: json['OpponentTacklesForLoss']?.toInt() as int?,
        opponentSafeties: json['OpponentSafeties']?.toInt() as int?,
        opponentPunts: json['OpponentPunts']?.toInt() as int?,
        opponentPuntYards: json['OpponentPuntYards']?.toInt() as int?,
        opponentPuntAverage: json['OpponentPuntAverage']?.toDouble() as double?,
        opponentGiveaways: json['OpponentGiveaways']?.toInt() as int?,
        opponentTakeaways: json['OpponentTakeaways']?.toInt() as int?,
        opponentTurnoverDifferential:
            json['OpponentTurnoverDifferential']?.toInt() as int?,
        redZonePercentage: json['RedZonePercentage']?.toDouble() as double?,
        goalToGoPercentage: json['GoalToGoPercentage']?.toInt() as int?,
        quarterbackHitsDifferential:
            json['QuarterbackHitsDifferential']?.toInt() as int?,
        tacklesForLossDifferential:
            json['TacklesForLossDifferential']?.toInt() as int?,
        quarterbackSacksDifferential:
            json['QuarterbackSacksDifferential']?.toInt() as int?,
        tacklesForLossPercentage:
            json['TacklesForLossPercentage']?.toDouble() as double?,
        quarterbackHitsPercentage:
            json['QuarterbackHitsPercentage']?.toDouble() as double?,
        timesSackedPercentage:
            json['TimesSackedPercentage']?.toDouble() as double?,
        opponentRedZonePercentage:
            json['OpponentRedZonePercentage']?.toDouble() as double?,
        opponentGoalToGoPercentage:
            json['OpponentGoalToGoPercentage']?.toInt() as int?,
        opponentQuarterbackHitsDifferential:
            json['OpponentQuarterbackHitsDifferential']?.toInt() as int?,
        opponentTacklesForLossDifferential:
            json['OpponentTacklesForLossDifferential']?.toInt() as int?,
        opponentQuarterbackSacksDifferential:
            json['OpponentQuarterbackSacksDifferential']?.toInt() as int?,
        opponentTacklesForLossPercentage:
            json['OpponentTacklesForLossPercentage']?.toDouble() as double?,
        opponentQuarterbackHitsPercentage:
            json['OpponentQuarterbackHitsPercentage']?.toDouble() as double?,
        opponentTimesSackedPercentage:
            json['OpponentTimesSackedPercentage']?.toDouble() as double?,
        kickoffs: json['Kickoffs'] as int?,
        kickoffsInEndZone: json['KickoffsInEndZone']?.toInt() as int?,
        kickoffTouchbacks: json['KickoffTouchbacks']?.toInt() as int?,
        puntsHadBlocked: json['PuntsHadBlocked']?.toInt() as int?,
        puntNetAverage: json['PuntNetAverage']?.toDouble() as double?,
        extraPointKickingAttempts:
            json['ExtraPointKickingAttempts']?.toInt() as int?,
        extraPointKickingConversions:
            json['ExtraPointKickingConversions']?.toInt() as int?,
        extraPointsHadBlocked: json['ExtraPointsHadBlocked']?.toInt() as int?,
        extraPointPassingAttempts:
            json['ExtraPointPassingAttempts']?.toInt() as int?,
        extraPointPassingConversions:
            json['ExtraPointPassingConversions']?.toInt() as int?,
        extraPointRushingAttempts:
            json['ExtraPointRushingAttempts']?.toInt() as int?,
        extraPointRushingConversions:
            json['ExtraPointRushingConversions']?.toInt() as int?,
        fieldGoalAttempts: json['FieldGoalAttempts']?.toInt() as int?,
        fieldGoalsMade: json['FieldGoalsMade']?.toInt() as int?,
        fieldGoalsHadBlocked: json['FieldGoalsHadBlocked']?.toInt() as int?,
        puntReturns: json['PuntReturns']?.toInt() as int?,
        puntReturnYards: json['PuntReturnYards']?.toInt() as int?,
        kickReturns: json['KickReturns']?.toInt() as int?,
        kickReturnYards: json['KickReturnYards']?.toInt() as int?,
        interceptionReturns: json['InterceptionReturns']?.toInt() as int?,
        interceptionReturnYards:
            json['InterceptionReturnYards']?.toInt() as int?,
        opponentKickoffs: json['OpponentKickoffs']?.toInt() as int?,
        opponentKickoffsInEndZone:
            json['OpponentKickoffsInEndZone']?.toInt() as int?,
        opponentKickoffTouchbacks:
            json['OpponentKickoffTouchbacks']?.toInt() as int?,
        opponentPuntsHadBlocked:
            json['OpponentPuntsHadBlocked']?.toInt() as int?,
        opponentPuntNetAverage:
            json['OpponentPuntNetAverage']?.toDouble() as double?,
        opponentExtraPointKickingAttempts:
            json['OpponentExtraPointKickingAttempts']?.toInt() as int?,
        opponentExtraPointKickingConversions:
            json['OpponentExtraPointKickingConversions']?.toInt() as int?,
        opponentExtraPointsHadBlocked:
            json['OpponentExtraPointsHadBlocked']?.toInt() as int?,
        opponentExtraPointPassingAttempts:
            json['OpponentExtraPointPassingAttempts']?.toInt() as int?,
        opponentExtraPointPassingConversions:
            json['OpponentExtraPointPassingConversions']?.toInt() as int?,
        opponentExtraPointRushingAttempts:
            json['OpponentExtraPointRushingAttempts']?.toInt() as int?,
        opponentExtraPointRushingConversions:
            json['OpponentExtraPointRushingConversions']?.toInt() as int?,
        opponentFieldGoalAttempts:
            json['OpponentFieldGoalAttempts']?.toInt() as int?,
        opponentFieldGoalsMade: json['OpponentFieldGoalsMade'] as int?,
        opponentFieldGoalsHadBlocked:
            json['OpponentFieldGoalsHadBlocked']?.toInt() as int?,
        opponentPuntReturns: json['OpponentPuntReturns']?.toInt() as int?,
        opponentPuntReturnYards:
            json['OpponentPuntReturnYards']?.toInt() as int?,
        opponentKickReturns: json['OpponentKickReturns']?.toInt() as int?,
        opponentKickReturnYards:
            json['OpponentKickReturnYards']?.toInt() as int?,
        opponentInterceptionReturns:
            json['OpponentInterceptionReturns']?.toInt() as int?,
        opponentInterceptionReturnYards:
            json['OpponentInterceptionReturnYards']?.toInt() as int?,
        soloTackles: json['SoloTackles']?.toInt() as int?,
        assistedTackles: json['AssistedTackles']?.toInt() as int?,
        sacks: json['Sacks']?.toInt() as int?,
        sackYards: json['SackYards']?.toInt() as int?,
        passesDefended: json['PassesDefended']?.toInt() as int?,
        fumblesForced: json['FumblesForced']?.toInt() as int?,
        fumblesRecovered: json['FumblesRecovered']?.toInt() as int?,
        fumbleReturnYards: json['FumbleReturnYards']?.toInt() as int?,
        fumbleReturnTouchdowns: json['FumbleReturnTouchdowns']?.toInt() as int?,
        interceptionReturnTouchdowns:
            json['InterceptionReturnTouchdowns']?.toInt() as int?,
        blockedKicks: json['BlockedKicks']?.toInt() as int?,
        puntReturnTouchdowns: json['PuntReturnTouchdowns']?.toInt() as int?,
        puntReturnLong: json['PuntReturnLong']?.toInt() as int?,
        kickReturnTouchdowns: json['KickReturnTouchdowns']?.toInt() as int?,
        kickReturnLong: json['KickReturnLong']?.toInt() as int?,
        blockedKickReturnYards: json['BlockedKickReturnYards']?.toInt() as int?,
        blockedKickReturnTouchdowns:
            json['BlockedKickReturnTouchdowns']?.toInt() as int?,
        fieldGoalReturnYards: json['FieldGoalReturnYards']?.toInt() as int?,
        fieldGoalReturnTouchdowns:
            json['FieldGoalReturnTouchdowns']?.toInt() as int?,
        puntNetYards: json['PuntNetYards']?.toInt() as int?,
        opponentSoloTackles: json['OpponentSoloTackles']?.toInt() as int?,
        opponentAssistedTackles:
            json['OpponentAssistedTackles']?.toInt() as int?,
        opponentSacks: json['OpponentSacks']?.toInt() as int?,
        opponentSackYards: json['OpponentSackYards']?.toInt() as int?,
        opponentPassesDefended: json['OpponentPassesDefended']?.toInt() as int?,
        opponentFumblesForced: json['OpponentFumblesForced']?.toInt() as int?,
        opponentFumblesRecovered:
            json['OpponentFumblesRecovered']?.toInt() as int?,
        opponentFumbleReturnYards:
            json['OpponentFumbleReturnYards']?.toInt() as int?,
        opponentFumbleReturnTouchdowns:
            json['OpponentFumbleReturnTouchdowns']?.toInt() as int?,
        opponentInterceptionReturnTouchdowns:
            json['OpponentInterceptionReturnTouchdowns']?.toInt() as int?,
        opponentBlockedKicks: json['OpponentBlockedKicks']?.toInt() as int?,
        opponentPuntReturnTouchdowns:
            json['OpponentPuntReturnTouchdowns']?.toInt() as int?,
        opponentPuntReturnLong: json['OpponentPuntReturnLong']?.toInt() as int?,
        opponentKickReturnTouchdowns:
            json['OpponentKickReturnTouchdowns']?.toInt() as int?,
        opponentKickReturnLong: json['OpponentKickReturnLong']?.toInt() as int?,
        opponentBlockedKickReturnYards:
            json['OpponentBlockedKickReturnYards']?.toInt() as int?,
        opponentBlockedKickReturnTouchdowns:
            json['OpponentBlockedKickReturnTouchdowns']?.toInt() as int?,
        opponentFieldGoalReturnYards:
            json['OpponentFieldGoalReturnYards']?.toInt() as int?,
        opponentFieldGoalReturnTouchdowns:
            json['OpponentFieldGoalReturnTouchdowns']?.toInt() as int?,
        opponentPuntNetYards: json['OpponentPuntNetYards']?.toInt() as int?,
        teamName: json['TeamName'] as String?,
        games: json['Games']?.toInt() as int?,
        passingDropbacks: json['PassingDropbacks']?.toInt() as int?,
        opponentPassingDropbacks:
            json['OpponentPassingDropbacks']?.toInt() as int?,
        teamSeasonId: json['TeamSeasonID']?.toInt() as int?,
        twoPointConversionReturns:
            json['TwoPointConversionReturns']?.toInt() as int?,
        opponentTwoPointConversionReturns:
            json['OpponentTwoPointConversionReturns']?.toInt() as int?,
        teamId: json['TeamID']?.toInt() as int?,
        globalTeamId: json['GlobalTeamID']?.toInt() as int?,
        teamStatId: json['TeamStatID']?.toInt() as int?,
      );

  final int? seasonType;
  final int? season;
  final String? team;
  final int? score;
  final int? opponentScore;
  final int? totalScore;
  final int? temperature;
  final int? humidity;
  final int? windSpeed;
  final double? overUnder;
  final double? pointSpread;
  final int? scoreQuarter1;
  final int? scoreQuarter2;
  final int? scoreQuarter3;
  final int? scoreQuarter4;
  final int? scoreOvertime;
  final String? timeOfPossession;
  final int? firstDowns;
  final int? firstDownsByRushing;
  final int? firstDownsByPassing;
  final int? firstDownsByPenalty;
  final int? offensivePlays;
  final int? offensiveYards;
  final double? offensiveYardsPerPlay;
  final int? touchdowns;
  final int? rushingAttempts;
  final int? rushingYards;
  final double? rushingYardsPerAttempt;
  final int? rushingTouchdowns;
  final int? passingAttempts;
  final int? passingCompletions;
  final int? passingYards;
  final int? passingTouchdowns;
  final int? passingInterceptions;
  final double? passingYardsPerAttempt;
  final double? passingYardsPerCompletion;
  final double? completionPercentage;
  final double? passerRating;
  final int? thirdDownAttempts;
  final int? thirdDownConversions;
  final double? thirdDownPercentage;
  final int? fourthDownAttempts;
  final int? fourthDownConversions;
  final double? fourthDownPercentage;
  final int? redZoneAttempts;
  final int? redZoneConversions;
  final int? goalToGoAttempts;
  final int? goalToGoConversions;
  final int? returnYards;
  final int? penalties;
  final int? penaltyYards;
  final int? fumbles;
  final int? fumblesLost;
  final int? timesSacked;
  final int? timesSackedYards;
  final int? quarterbackHits;
  final int? tacklesForLoss;
  final int? safeties;
  final int? punts;
  final int? puntYards;
  final double? puntAverage;
  final int? giveaways;
  final int? takeaways;
  final int? turnoverDifferential;
  final int? opponentScoreQuarter1;
  final int? opponentScoreQuarter2;
  final int? opponentScoreQuarter3;
  final int? opponentScoreQuarter4;
  final int? opponentScoreOvertime;
  final String? opponentTimeOfPossession;
  final int? opponentFirstDowns;
  final int? opponentFirstDownsByRushing;
  final int? opponentFirstDownsByPassing;
  final int? opponentFirstDownsByPenalty;
  final int? opponentOffensivePlays;
  final int? opponentOffensiveYards;
  final double? opponentOffensiveYardsPerPlay;
  final int? opponentTouchdowns;
  final int? opponentRushingAttempts;
  final int? opponentRushingYards;
  final double? opponentRushingYardsPerAttempt;
  final int? opponentRushingTouchdowns;
  final int? opponentPassingAttempts;
  final int? opponentPassingCompletions;
  final int? opponentPassingYards;
  final int? opponentPassingTouchdowns;
  final int? opponentPassingInterceptions;
  final double? opponentPassingYardsPerAttempt;
  final double? opponentPassingYardsPerCompletion;
  final double? opponentCompletionPercentage;
  final double? opponentPasserRating;
  final int? opponentThirdDownAttempts;
  final int? opponentThirdDownConversions;
  final double? opponentThirdDownPercentage;
  final int? opponentFourthDownAttempts;
  final int? opponentFourthDownConversions;
  final double? opponentFourthDownPercentage;
  final int? opponentRedZoneAttempts;
  final int? opponentRedZoneConversions;
  final int? opponentGoalToGoAttempts;
  final int? opponentGoalToGoConversions;
  final int? opponentReturnYards;
  final int? opponentPenalties;
  final int? opponentPenaltyYards;
  final int? opponentFumbles;
  final int? opponentFumblesLost;
  final int? opponentTimesSacked;
  final int? opponentTimesSackedYards;
  final int? opponentQuarterbackHits;
  final int? opponentTacklesForLoss;
  final int? opponentSafeties;
  final int? opponentPunts;
  final int? opponentPuntYards;
  final double? opponentPuntAverage;
  final int? opponentGiveaways;
  final int? opponentTakeaways;
  final int? opponentTurnoverDifferential;
  final double? redZonePercentage;
  final int? goalToGoPercentage;
  final int? quarterbackHitsDifferential;
  final int? tacklesForLossDifferential;
  final int? quarterbackSacksDifferential;
  final double? tacklesForLossPercentage;
  final double? quarterbackHitsPercentage;
  final double? timesSackedPercentage;
  final double? opponentRedZonePercentage;
  final int? opponentGoalToGoPercentage;
  final int? opponentQuarterbackHitsDifferential;
  final int? opponentTacklesForLossDifferential;
  final int? opponentQuarterbackSacksDifferential;
  final double? opponentTacklesForLossPercentage;
  final double? opponentQuarterbackHitsPercentage;
  final double? opponentTimesSackedPercentage;
  final int? kickoffs;
  final int? kickoffsInEndZone;
  final int? kickoffTouchbacks;
  final int? puntsHadBlocked;
  final double? puntNetAverage;
  final int? extraPointKickingAttempts;
  final int? extraPointKickingConversions;
  final int? extraPointsHadBlocked;
  final int? extraPointPassingAttempts;
  final int? extraPointPassingConversions;
  final int? extraPointRushingAttempts;
  final int? extraPointRushingConversions;
  final int? fieldGoalAttempts;
  final int? fieldGoalsMade;
  final int? fieldGoalsHadBlocked;
  final int? puntReturns;
  final int? puntReturnYards;
  final int? kickReturns;
  final int? kickReturnYards;
  final int? interceptionReturns;
  final int? interceptionReturnYards;
  final int? opponentKickoffs;
  final int? opponentKickoffsInEndZone;
  final int? opponentKickoffTouchbacks;
  final int? opponentPuntsHadBlocked;
  final double? opponentPuntNetAverage;
  final int? opponentExtraPointKickingAttempts;
  final int? opponentExtraPointKickingConversions;
  final int? opponentExtraPointsHadBlocked;
  final int? opponentExtraPointPassingAttempts;
  final int? opponentExtraPointPassingConversions;
  final int? opponentExtraPointRushingAttempts;
  final int? opponentExtraPointRushingConversions;
  final int? opponentFieldGoalAttempts;
  final int? opponentFieldGoalsMade;
  final int? opponentFieldGoalsHadBlocked;
  final int? opponentPuntReturns;
  final int? opponentPuntReturnYards;
  final int? opponentKickReturns;
  final int? opponentKickReturnYards;
  final int? opponentInterceptionReturns;
  final int? opponentInterceptionReturnYards;
  final int? soloTackles;
  final int? assistedTackles;
  final int? sacks;
  final int? sackYards;
  final int? passesDefended;
  final int? fumblesForced;
  final int? fumblesRecovered;
  final int? fumbleReturnYards;
  final int? fumbleReturnTouchdowns;
  final int? interceptionReturnTouchdowns;
  final int? blockedKicks;
  final int? puntReturnTouchdowns;
  final int? puntReturnLong;
  final int? kickReturnTouchdowns;
  final int? kickReturnLong;
  final int? blockedKickReturnYards;
  final int? blockedKickReturnTouchdowns;
  final int? fieldGoalReturnYards;
  final int? fieldGoalReturnTouchdowns;
  final int? puntNetYards;
  final int? opponentSoloTackles;
  final int? opponentAssistedTackles;
  final int? opponentSacks;
  final int? opponentSackYards;
  final int? opponentPassesDefended;
  final int? opponentFumblesForced;
  final int? opponentFumblesRecovered;
  final int? opponentFumbleReturnYards;
  final int? opponentFumbleReturnTouchdowns;
  final int? opponentInterceptionReturnTouchdowns;
  final int? opponentBlockedKicks;
  final int? opponentPuntReturnTouchdowns;
  final int? opponentPuntReturnLong;
  final int? opponentKickReturnTouchdowns;
  final int? opponentKickReturnLong;
  final int? opponentBlockedKickReturnYards;
  final int? opponentBlockedKickReturnTouchdowns;
  final int? opponentFieldGoalReturnYards;
  final int? opponentFieldGoalReturnTouchdowns;
  final int? opponentPuntNetYards;
  final String? teamName;
  final int? games;
  final int? passingDropbacks;
  final int? opponentPassingDropbacks;
  final int? teamSeasonId;
  final int? twoPointConversionReturns;
  final int? opponentTwoPointConversionReturns;
  final int? teamId;
  final int? globalTeamId;
  final int? teamStatId;

  NflTeamStats copyWith({
    int? seasonType,
    int? season,
    String? team,
    int? score,
    int? opponentScore,
    int? totalScore,
    int? temperature,
    int? humidity,
    int? windSpeed,
    double? overUnder,
    double? pointSpread,
    int? scoreQuarter1,
    int? scoreQuarter2,
    int? scoreQuarter3,
    int? scoreQuarter4,
    int? scoreOvertime,
    String? timeOfPossession,
    int? firstDowns,
    int? firstDownsByRushing,
    int? firstDownsByPassing,
    int? firstDownsByPenalty,
    int? offensivePlays,
    int? offensiveYards,
    double? offensiveYardsPerPlay,
    int? touchdowns,
    int? rushingAttempts,
    int? rushingYards,
    double? rushingYardsPerAttempt,
    int? rushingTouchdowns,
    int? passingAttempts,
    int? passingCompletions,
    int? passingYards,
    int? passingTouchdowns,
    int? passingInterceptions,
    double? passingYardsPerAttempt,
    double? passingYardsPerCompletion,
    double? completionPercentage,
    double? passerRating,
    int? thirdDownAttempts,
    int? thirdDownConversions,
    double? thirdDownPercentage,
    int? fourthDownAttempts,
    int? fourthDownConversions,
    double? fourthDownPercentage,
    int? redZoneAttempts,
    int? redZoneConversions,
    int? goalToGoAttempts,
    int? goalToGoConversions,
    int? returnYards,
    int? penalties,
    int? penaltyYards,
    int? fumbles,
    int? fumblesLost,
    int? timesSacked,
    int? timesSackedYards,
    int? quarterbackHits,
    int? tacklesForLoss,
    int? safeties,
    int? punts,
    int? puntYards,
    double? puntAverage,
    int? giveaways,
    int? takeaways,
    int? turnoverDifferential,
    int? opponentScoreQuarter1,
    int? opponentScoreQuarter2,
    int? opponentScoreQuarter3,
    int? opponentScoreQuarter4,
    int? opponentScoreOvertime,
    String? opponentTimeOfPossession,
    int? opponentFirstDowns,
    int? opponentFirstDownsByRushing,
    int? opponentFirstDownsByPassing,
    int? opponentFirstDownsByPenalty,
    int? opponentOffensivePlays,
    int? opponentOffensiveYards,
    double? opponentOffensiveYardsPerPlay,
    int? opponentTouchdowns,
    int? opponentRushingAttempts,
    int? opponentRushingYards,
    double? opponentRushingYardsPerAttempt,
    int? opponentRushingTouchdowns,
    int? opponentPassingAttempts,
    int? opponentPassingCompletions,
    int? opponentPassingYards,
    int? opponentPassingTouchdowns,
    int? opponentPassingInterceptions,
    double? opponentPassingYardsPerAttempt,
    double? opponentPassingYardsPerCompletion,
    double? opponentCompletionPercentage,
    double? opponentPasserRating,
    int? opponentThirdDownAttempts,
    int? opponentThirdDownConversions,
    double? opponentThirdDownPercentage,
    int? opponentFourthDownAttempts,
    int? opponentFourthDownConversions,
    double? opponentFourthDownPercentage,
    int? opponentRedZoneAttempts,
    int? opponentRedZoneConversions,
    int? opponentGoalToGoAttempts,
    int? opponentGoalToGoConversions,
    int? opponentReturnYards,
    int? opponentPenalties,
    int? opponentPenaltyYards,
    int? opponentFumbles,
    int? opponentFumblesLost,
    int? opponentTimesSacked,
    int? opponentTimesSackedYards,
    int? opponentQuarterbackHits,
    int? opponentTacklesForLoss,
    int? opponentSafeties,
    int? opponentPunts,
    int? opponentPuntYards,
    double? opponentPuntAverage,
    int? opponentGiveaways,
    int? opponentTakeaways,
    int? opponentTurnoverDifferential,
    double? redZonePercentage,
    int? goalToGoPercentage,
    int? quarterbackHitsDifferential,
    int? tacklesForLossDifferential,
    int? quarterbackSacksDifferential,
    double? tacklesForLossPercentage,
    double? quarterbackHitsPercentage,
    double? timesSackedPercentage,
    double? opponentRedZonePercentage,
    int? opponentGoalToGoPercentage,
    int? opponentQuarterbackHitsDifferential,
    int? opponentTacklesForLossDifferential,
    int? opponentQuarterbackSacksDifferential,
    double? opponentTacklesForLossPercentage,
    double? opponentQuarterbackHitsPercentage,
    double? opponentTimesSackedPercentage,
    int? kickoffs,
    int? kickoffsInEndZone,
    int? kickoffTouchbacks,
    int? puntsHadBlocked,
    double? puntNetAverage,
    int? extraPointKickingAttempts,
    int? extraPointKickingConversions,
    int? extraPointsHadBlocked,
    int? extraPointPassingAttempts,
    int? extraPointPassingConversions,
    int? extraPointRushingAttempts,
    int? extraPointRushingConversions,
    int? fieldGoalAttempts,
    int? fieldGoalsMade,
    int? fieldGoalsHadBlocked,
    int? puntReturns,
    int? puntReturnYards,
    int? kickReturns,
    int? kickReturnYards,
    int? interceptionReturns,
    int? interceptionReturnYards,
    int? opponentKickoffs,
    int? opponentKickoffsInEndZone,
    int? opponentKickoffTouchbacks,
    int? opponentPuntsHadBlocked,
    double? opponentPuntNetAverage,
    int? opponentExtraPointKickingAttempts,
    int? opponentExtraPointKickingConversions,
    int? opponentExtraPointsHadBlocked,
    int? opponentExtraPointPassingAttempts,
    int? opponentExtraPointPassingConversions,
    int? opponentExtraPointRushingAttempts,
    int? opponentExtraPointRushingConversions,
    int? opponentFieldGoalAttempts,
    int? opponentFieldGoalsMade,
    int? opponentFieldGoalsHadBlocked,
    int? opponentPuntReturns,
    int? opponentPuntReturnYards,
    int? opponentKickReturns,
    int? opponentKickReturnYards,
    int? opponentInterceptionReturns,
    int? opponentInterceptionReturnYards,
    int? soloTackles,
    int? assistedTackles,
    int? sacks,
    int? sackYards,
    int? passesDefended,
    int? fumblesForced,
    int? fumblesRecovered,
    int? fumbleReturnYards,
    int? fumbleReturnTouchdowns,
    int? interceptionReturnTouchdowns,
    int? blockedKicks,
    int? puntReturnTouchdowns,
    int? puntReturnLong,
    int? kickReturnTouchdowns,
    int? kickReturnLong,
    int? blockedKickReturnYards,
    int? blockedKickReturnTouchdowns,
    int? fieldGoalReturnYards,
    int? fieldGoalReturnTouchdowns,
    int? puntNetYards,
    int? opponentSoloTackles,
    int? opponentAssistedTackles,
    int? opponentSacks,
    int? opponentSackYards,
    int? opponentPassesDefended,
    int? opponentFumblesForced,
    int? opponentFumblesRecovered,
    int? opponentFumbleReturnYards,
    int? opponentFumbleReturnTouchdowns,
    int? opponentInterceptionReturnTouchdowns,
    int? opponentBlockedKicks,
    int? opponentPuntReturnTouchdowns,
    int? opponentPuntReturnLong,
    int? opponentKickReturnTouchdowns,
    int? opponentKickReturnLong,
    int? opponentBlockedKickReturnYards,
    int? opponentBlockedKickReturnTouchdowns,
    int? opponentFieldGoalReturnYards,
    int? opponentFieldGoalReturnTouchdowns,
    int? opponentPuntNetYards,
    String? teamName,
    int? games,
    int? passingDropbacks,
    int? opponentPassingDropbacks,
    int? teamSeasonId,
    int? twoPointConversionReturns,
    int? opponentTwoPointConversionReturns,
    int? teamId,
    int? globalTeamId,
    int? teamStatId,
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

  Map<String, Object?> toMap() => {
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

  Map<String, Object?> toStatOnlyMap() => {
        'Over Under': overUnder,
        'Point Spread': pointSpread,
        'Score Overtime': scoreOvertime,
        'Time Of Possession': timeOfPossession,
        'First Downs': firstDowns,
        'First Downs By Rushing': firstDownsByRushing,
        'First Downs By Passing': firstDownsByPassing,
        'First Downs By Penalty': firstDownsByPenalty,
        'Offensive Plays': offensivePlays,
        'Offensive Yards': offensiveYards,
        'Offensive Yards Per Play': offensiveYardsPerPlay,
        'Touchdowns': touchdowns,
        'Rushing Attempts': rushingAttempts,
        'Rushing Yards': rushingYards,
        'Rushing Yards Per Attempt': rushingYardsPerAttempt,
        'Rushing Touchdowns': rushingTouchdowns,
        'Passing Attempts': passingAttempts,
        'Passing Completions': passingCompletions,
        'Passing Yards': passingYards,
        'Passing Touchdowns': passingTouchdowns,
        'Passing Interceptions': passingInterceptions,
        'Passing Yards Per Attempt': passingYardsPerAttempt,
        'Passing Yards Per Completion': passingYardsPerCompletion,
        'Completion Percentage': completionPercentage,
        'Passer Rating': passerRating,
        'Third Down Attempts': thirdDownAttempts,
        'Third Down Conversions': thirdDownConversions,
        'Third Down Percentage': thirdDownPercentage,
        'Fourth Down Attempts': fourthDownAttempts,
        'Fourth Down Conversions': fourthDownConversions,
        'Fourth Down Percentage': fourthDownPercentage,
        'Red Zone Attempts': redZoneAttempts,
        'Red Zone Conversions': redZoneConversions,
        'Goal To Go Attempts': goalToGoAttempts,
        'Goal To Go Conversions': goalToGoConversions,
        'Return Yards': returnYards,
        'Penalties': penalties,
        'Penalty Yards': penaltyYards,
        'Fumbles': fumbles,
        'Fumbles Lost': fumblesLost,
        'Times Sacked': timesSacked,
        'Times Sacked Yards': timesSackedYards,
        'Quarterback Hits': quarterbackHits,
        'Tackles For Loss': tacklesForLoss,
        'Safeties': safeties,
        'Punts': punts,
        'Punt Yards': puntYards,
        'Punt Average': puntAverage,
        'Giveaways': giveaways,
        'Takeaways': takeaways,
        'Turnover Differential': turnoverDifferential,
        'Opponent Score Quarter1': opponentScoreQuarter1,
        'Opponent Score Quarter2': opponentScoreQuarter2,
        'Opponent Score Quarter3': opponentScoreQuarter3,
        'Opponent Score Quarter4': opponentScoreQuarter4,
        'Opponent Score Overtime': opponentScoreOvertime,
        'Opponent Time Of Possession': opponentTimeOfPossession,
        'Opponent First Downs': opponentFirstDowns,
        'Opponent First Downs By Rushing': opponentFirstDownsByRushing,
        'Opponent First Downs By Passing': opponentFirstDownsByPassing,
        'Opponent First Downs By Penalty': opponentFirstDownsByPenalty,
        'Opponent Offensive Plays': opponentOffensivePlays,
        'Opponent Offensive Yards': opponentOffensiveYards,
        'Opponent Offensive Yards Per Play': opponentOffensiveYardsPerPlay,
        'Opponent Touchdowns': opponentTouchdowns,
        'Opponent Rushing Attempts': opponentRushingAttempts,
        'Opponent Rushing Yards': opponentRushingYards,
        'Opponent Rushing Yards Per Attempt': opponentRushingYardsPerAttempt,
        'Opponent Rushing Touchdowns': opponentRushingTouchdowns,
        'Opponent Passing Attempts': opponentPassingAttempts,
        'Opponent Passing Completions': opponentPassingCompletions,
        'Opponent Passing Yards': opponentPassingYards,
        'Opponent Passing Touchdowns': opponentPassingTouchdowns,
        'Opponent Passing Interceptions': opponentPassingInterceptions,
        'Opponent Passing Yards Per Attempt': opponentPassingYardsPerAttempt,
        'Opponent Passing Yards Per Completion':
            opponentPassingYardsPerCompletion,
        'Opponent Completion Percentage': opponentCompletionPercentage,
        'Opponent Passer Rating': opponentPasserRating,
        'Opponent Third Down Attempts': opponentThirdDownAttempts,
        'Opponent Third Down Conversions': opponentThirdDownConversions,
        'Opponent Third Down Percentage': opponentThirdDownPercentage,
        'Opponent Fourth Down Attempts': opponentFourthDownAttempts,
        'Opponent Fourth Down Conversions': opponentFourthDownConversions,
        'Opponent Fourth Down Percentage': opponentFourthDownPercentage,
        'Opponent Red Zone Attempts': opponentRedZoneAttempts,
        'Opponent Red Zone Conversions': opponentRedZoneConversions,
        'Opponent Goal To Go Attempts': opponentGoalToGoAttempts,
        'Opponent Goal To Go Conversions': opponentGoalToGoConversions,
        'Opponent Return Yards': opponentReturnYards,
        'Opponent Penalties': opponentPenalties,
        'Opponent Penalty Yards': opponentPenaltyYards,
        'Opponent Fumbles': opponentFumbles,
        'Opponent Fumbles Lost': opponentFumblesLost,
        'Opponent Times Sacked': opponentTimesSacked,
        'Opponent Times Sacked Yards': opponentTimesSackedYards,
        'Opponent Quarterback Hits': opponentQuarterbackHits,
        'Opponent Tackles For Loss': opponentTacklesForLoss,
        'Opponent Safeties': opponentSafeties,
        'Opponent Punts': opponentPunts,
        'Opponent Punt Yards': opponentPuntYards,
        'Opponent Punt Average': opponentPuntAverage,
        'Opponent Giveaways': opponentGiveaways,
        'Opponent Takeaways': opponentTakeaways,
        'Opponent Turnover Differential': opponentTurnoverDifferential,
        'Red Zone Percentage': redZonePercentage,
        'Goal To Go Percentage': goalToGoPercentage,
        'Quarterback Hits Differential': quarterbackHitsDifferential,
        'Tackles For Loss Differential': tacklesForLossDifferential,
        'Quarterback Sacks Differential': quarterbackSacksDifferential,
        'Tackles For Loss Percentage': tacklesForLossPercentage,
        'Quarterback Hits Percentage': quarterbackHitsPercentage,
        'Times Sacked Percentage': timesSackedPercentage,
        'Opponent Red Zone Percentage': opponentRedZonePercentage,
        'Opponent Goal To Go Percentage': opponentGoalToGoPercentage,
        'Opponent Quarterback Hits Differential':
            opponentQuarterbackHitsDifferential,
        'Opponent Tackles For Loss Differential':
            opponentTacklesForLossDifferential,
        'Opponent Quarterback Sacks Differential':
            opponentQuarterbackSacksDifferential,
        'Opponent Tackles For Loss Percentage':
            opponentTacklesForLossPercentage,
        'Opponent Quarterback Hits Percentage':
            opponentQuarterbackHitsPercentage,
        'Opponent Times Sacked Percentage': opponentTimesSackedPercentage,
        'Kickoffs': kickoffs,
        'Kickoffs In End Zone': kickoffsInEndZone,
        'Kickoff Touchbacks': kickoffTouchbacks,
        'Punts Had Blocked': puntsHadBlocked,
        'Punt Net Average': puntNetAverage,
        'Extra Point Kicking Attempts': extraPointKickingAttempts,
        'Extra Point Kicking Conversions': extraPointKickingConversions,
        'Extra Points Had Blocked': extraPointsHadBlocked,
        'Extra Point Passing Attempts': extraPointPassingAttempts,
        'Extra Point Passing Conversions': extraPointPassingConversions,
        'Extra Point Rushing Attempts': extraPointRushingAttempts,
        'Extra Point Rushing Conversions': extraPointRushingConversions,
        'Field Goal Attempts': fieldGoalAttempts,
        'Field Goals Made': fieldGoalsMade,
        'Field Goals Had Blocked': fieldGoalsHadBlocked,
        'Punt Returns': puntReturns,
        'Punt Return Yards': puntReturnYards,
        'Kick Returns': kickReturns,
        'Kick Return Yards': kickReturnYards,
        'Interception Returns': interceptionReturns,
        'Interception Return Yards': interceptionReturnYards,
        'Opponent Kickoffs': opponentKickoffs,
        'Opponent Kickoffs In End Zone': opponentKickoffsInEndZone,
        'Opponent Kickoff Touchbacks': opponentKickoffTouchbacks,
        'Opponent Punts Had Blocked': opponentPuntsHadBlocked,
        'Opponent Punt Net Average': opponentPuntNetAverage,
        'Opponent Extra Point Kicking Attempts':
            opponentExtraPointKickingAttempts,
        'Opponent Extra Point Kicking Conversions':
            opponentExtraPointKickingConversions,
        'Opponent Extra Points Had Blocked': opponentExtraPointsHadBlocked,
        'Opponent Extra Point Passing Attempts':
            opponentExtraPointPassingAttempts,
        'Opponent Extra Point Passing Conversions':
            opponentExtraPointPassingConversions,
        'Opponent Extra Point Rushing Attempts':
            opponentExtraPointRushingAttempts,
        'Opponent Extra Point Rushing Conversions':
            opponentExtraPointRushingConversions,
        'Opponent Field Goal Attempts': opponentFieldGoalAttempts,
        'Opponent Field Goals Made': opponentFieldGoalsMade,
        'Opponent Field Goals Had Blocked': opponentFieldGoalsHadBlocked,
        'Opponent Punt Returns': opponentPuntReturns,
        'Opponent Punt Return Yards': opponentPuntReturnYards,
        'Opponent Kick Returns': opponentKickReturns,
        'Opponent Kick Return Yards': opponentKickReturnYards,
        'Opponent Interception Returns': opponentInterceptionReturns,
        'Opponent Interception Return Yards': opponentInterceptionReturnYards,
        'Solo Tackles': soloTackles,
        'Assisted Tackles': assistedTackles,
        'Sacks': sacks,
        'Sack Yards': sackYards,
        'Passes Defended': passesDefended,
        'Fumbles Forced': fumblesForced,
        'Fumbles Recovered': fumblesRecovered,
        'Fumble Return Yards': fumbleReturnYards,
        'Fumble Return Touchdowns': fumbleReturnTouchdowns,
        'Interception Return Touchdowns': interceptionReturnTouchdowns,
        'Blocked Kicks': blockedKicks,
        'Punt Return Touchdowns': puntReturnTouchdowns,
        'Punt Return Long': puntReturnLong,
        'Kick Return Touchdowns': kickReturnTouchdowns,
        'Kick Return Long': kickReturnLong,
        'Blocked Kick Return Yards': blockedKickReturnYards,
        'Blocked Kick Return Touchdowns': blockedKickReturnTouchdowns,
        'Field Goal Return Yards': fieldGoalReturnYards,
        'Field Goal Return Touchdowns': fieldGoalReturnTouchdowns,
        'Punt Net Yards': puntNetYards,
        'Opponent Solo Tackles': opponentSoloTackles,
        'Opponent Assisted Tackles': opponentAssistedTackles,
        'Opponent Sacks': opponentSacks,
        'Opponent Sack Yards': opponentSackYards,
        'Opponent Passes Defended': opponentPassesDefended,
        'Opponent Fumbles Forced': opponentFumblesForced,
        'Opponent Fumbles Recovered': opponentFumblesRecovered,
        'Opponent Fumble Return Yards': opponentFumbleReturnYards,
        'Opponent Fumble Return Touchdowns': opponentFumbleReturnTouchdowns,
        'Opponent Interception Return Touchdowns':
            opponentInterceptionReturnTouchdowns,
        'Opponent Blocked Kicks': opponentBlockedKicks,
        'Opponent Punt Return Touchdowns': opponentPuntReturnTouchdowns,
        'Opponent Punt Return Long': opponentPuntReturnLong,
        'Opponent Kick Return Touchdowns': opponentKickReturnTouchdowns,
        'Opponent Kick Return Long': opponentKickReturnLong,
        'Opponent Blocked Kick Return Yards': opponentBlockedKickReturnYards,
        'Opponent Blocked Kick Return Touchdowns':
            opponentBlockedKickReturnTouchdowns,
        'Opponent Field Goal Return Yards': opponentFieldGoalReturnYards,
        'Opponent Field Goal Return Touchdowns':
            opponentFieldGoalReturnTouchdowns,
        'Opponent Punt Net Yards': opponentPuntNetYards,
        'Passing Dropbacks': passingDropbacks,
        'Opponent Passing Dropbacks': opponentPassingDropbacks,
        'Two Point Conversion Returns': twoPointConversionReturns,
        'Opponent Two Point Conversion Returns':
            opponentTwoPointConversionReturns,
      };
}
