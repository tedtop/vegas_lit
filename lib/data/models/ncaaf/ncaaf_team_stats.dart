import 'dart:convert';

class NcaafTeamStats {
  NcaafTeamStats({
    this.statId,
    this.teamId,
    this.seasonType,
    this.season,
    this.name,
    this.team,
    this.wins,
    this.losses,
    this.pointsFor,
    this.pointsAgainst,
    this.conferenceWins,
    this.conferenceLosses,
    this.conferencePointsFor,
    this.conferencePointsAgainst,
    this.homeWins,
    this.homeLosses,
    this.roadWins,
    this.roadLosses,
    this.streak,
    this.score,
    this.opponentScore,
    this.firstDowns,
    this.thirdDownConversions,
    this.thirdDownAttempts,
    this.fourthDownConversions,
    this.fourthDownAttempts,
    this.penalties,
    this.penaltyYards,
    this.timeOfPossessionMinutes,
    this.timeOfPossessionSeconds,
    this.globalTeamId,
    this.conferenceRank,
    this.divisionRank,
    this.updated,
    this.created,
    this.games,
    this.fantasyPoints,
    this.passingAttempts,
    this.passingCompletions,
    this.passingYards,
    this.passingCompletionPercentage,
    this.passingYardsPerAttempt,
    this.passingYardsPerCompletion,
    this.passingTouchdowns,
    this.passingInterceptions,
    this.passingRating,
    this.rushingAttempts,
    this.rushingYards,
    this.rushingYardsPerAttempt,
    this.rushingTouchdowns,
    this.rushingLong,
    this.receptions,
    this.receivingYards,
    this.receivingYardsPerReception,
    this.receivingTouchdowns,
    this.receivingLong,
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
    this.punts,
    this.puntYards,
    this.puntAverage,
    this.puntLong,
    this.fieldGoalsAttempted,
    this.fieldGoalsMade,
    this.fieldGoalPercentage,
    this.fieldGoalsLongestMade,
    this.extraPointsAttempted,
    this.extraPointsMade,
    this.interceptions,
    this.interceptionReturnYards,
    this.interceptionReturnTouchdowns,
    this.soloTackles,
    this.assistedTackles,
    this.tacklesForLoss,
    this.sacks,
    this.passesDefended,
    this.fumblesRecovered,
    this.fumbleReturnTouchdowns,
    this.quarterbackHurries,
    this.fumbles,
    this.fumblesLost,
  });

  factory NcaafTeamStats.fromJson(String str) =>
      NcaafTeamStats.fromMap(json.decode(str) as Map<String, dynamic>);

  factory NcaafTeamStats.fromMap(Map<String, dynamic> json) => NcaafTeamStats(
        statId: json['StatID']?.toInt() as int,
        teamId: json['TeamID']?.toInt() as int,
        seasonType: json['SeasonType']?.toInt() as int,
        season: json['Season']?.toInt() as int,
        name: json['Name'] as String,
        team: json['Team'] as String,
        wins: json['Wins']?.toInt() as int,
        losses: json['Losses']?.toInt() as int,
        pointsFor: json['PointsFor']?.toInt() as int,
        pointsAgainst: json['PointsAgainst']?.toInt() as int,
        conferenceWins: json['ConferenceWins']?.toInt() as int,
        conferenceLosses: json['ConferenceLosses']?.toInt() as int,
        conferencePointsFor: json['ConferencePointsFor']?.toInt() as int,
        conferencePointsAgainst:
            json['ConferencePointsAgainst']?.toInt() as int,
        homeWins: json['HomeWins']?.toInt() as int,
        homeLosses: json['HomeLosses']?.toInt() as int,
        roadWins: json['RoadWins']?.toInt() as int,
        roadLosses: json['RoadLosses']?.toInt() as int,
        streak: json['Streak']?.toInt() as int,
        score: json['Score']?.toInt() as int,
        opponentScore: json['OpponentScore']?.toInt() as int,
        firstDowns: json['FirstDowns']?.toInt() as int,
        thirdDownConversions: json['ThirdDownConversions']?.toInt() as int,
        thirdDownAttempts: json['ThirdDownAttempts']?.toInt() as int,
        fourthDownConversions: json['FourthDownConversions']?.toInt() as int,
        fourthDownAttempts: json['FourthDownAttempts']?.toInt() as int,
        penalties: json['Penalties']?.toInt() as int,
        penaltyYards: json['PenaltyYards']?.toInt() as int,
        timeOfPossessionMinutes:
            json['TimeOfPossessionMinutes']?.toInt() as int,
        timeOfPossessionSeconds:
            json['TimeOfPossessionSeconds']?.toInt() as int,
        globalTeamId: json['GlobalTeamID']?.toInt() as int,
        conferenceRank: json['ConferenceRank'],
        divisionRank: json['DivisionRank'],
        updated: DateTime.parse(json['Updated'] as String),
        created: DateTime.parse(json['Created'] as String),
        games: json['Games']?.toInt() as int,
        fantasyPoints: json['FantasyPoints']?.toInt() as int,
        passingAttempts: json['PassingAttempts']?.toInt() as int,
        passingCompletions: json['PassingCompletions']?.toInt() as int,
        passingYards: json['PassingYards']?.toInt() as int,
        passingCompletionPercentage:
            json['PassingCompletionPercentage']?.toInt() as int,
        passingYardsPerAttempt: json['PassingYardsPerAttempt']?.toInt() as int,
        passingYardsPerCompletion:
            json['PassingYardsPerCompletion']?.toInt() as int,
        passingTouchdowns: json['PassingTouchdowns']?.toInt() as int,
        passingInterceptions: json['PassingInterceptions']?.toInt() as int,
        passingRating: json['PassingRating']?.toInt() as int,
        rushingAttempts: json['RushingAttempts']?.toInt() as int,
        rushingYards: json['RushingYards']?.toInt() as int,
        rushingYardsPerAttempt: json['RushingYardsPerAttempt']?.toInt() as int,
        rushingTouchdowns: json['RushingTouchdowns']?.toInt() as int,
        rushingLong: json['RushingLong']?.toInt() as int,
        receptions: json['Receptions']?.toInt() as int,
        receivingYards: json['ReceivingYards']?.toInt() as int,
        receivingYardsPerReception:
            json['ReceivingYardsPerReception']?.toInt() as int,
        receivingTouchdowns: json['ReceivingTouchdowns']?.toInt() as int,
        receivingLong: json['ReceivingLong']?.toInt() as int,
        puntReturns: json['PuntReturns']?.toInt() as int,
        puntReturnYards: json['PuntReturnYards']?.toInt() as int,
        puntReturnYardsPerAttempt:
            json['PuntReturnYardsPerAttempt']?.toInt() as int,
        puntReturnTouchdowns: json['PuntReturnTouchdowns']?.toInt() as int,
        puntReturnLong: json['PuntReturnLong']?.toInt() as int,
        kickReturns: json['KickReturns']?.toInt() as int,
        kickReturnYards: json['KickReturnYards']?.toInt() as int,
        kickReturnYardsPerAttempt:
            json['KickReturnYardsPerAttempt']?.toInt() as int,
        kickReturnTouchdowns: json['KickReturnTouchdowns']?.toInt() as int,
        kickReturnLong: json['KickReturnLong']?.toInt() as int,
        punts: json['Punts']?.toInt() as int,
        puntYards: json['PuntYards']?.toInt() as int,
        puntAverage: json['PuntAverage']?.toInt() as int,
        puntLong: json['PuntLong']?.toInt() as int,
        fieldGoalsAttempted: json['FieldGoalsAttempted']?.toInt() as int,
        fieldGoalsMade: json['FieldGoalsMade']?.toInt() as int,
        fieldGoalPercentage: json['FieldGoalPercentage']?.toInt() as int,
        fieldGoalsLongestMade: json['FieldGoalsLongestMade']?.toInt() as int,
        extraPointsAttempted: json['ExtraPointsAttempted']?.toInt() as int,
        extraPointsMade: json['ExtraPointsMade']?.toInt() as int,
        interceptions: json['Interceptions']?.toInt() as int,
        interceptionReturnYards:
            json['InterceptionReturnYards']?.toInt() as int,
        interceptionReturnTouchdowns:
            json['InterceptionReturnTouchdowns']?.toInt() as int,
        soloTackles: json['SoloTackles']?.toInt() as int,
        assistedTackles: json['AssistedTackles']?.toInt() as int,
        tacklesForLoss: json['TacklesForLoss']?.toInt() as int,
        sacks: json['Sacks']?.toInt() as int,
        passesDefended: json['PassesDefended']?.toInt() as int,
        fumblesRecovered: json['FumblesRecovered']?.toInt() as int,
        fumbleReturnTouchdowns: json['FumbleReturnTouchdowns']?.toInt() as int,
        quarterbackHurries: json['QuarterbackHurries']?.toInt() as int,
        fumbles: json['Fumbles']?.toInt() as int,
        fumblesLost: json['FumblesLost']?.toInt() as int,
      );

  final int statId;
  final int teamId;
  final int seasonType;
  final int season;
  final String name;
  final String team;
  final int wins;
  final int losses;
  final int pointsFor;
  final int pointsAgainst;
  final int conferenceWins;
  final int conferenceLosses;
  final int conferencePointsFor;
  final int conferencePointsAgainst;
  final int homeWins;
  final int homeLosses;
  final int roadWins;
  final int roadLosses;
  final int streak;
  final int score;
  final int opponentScore;
  final int firstDowns;
  final int thirdDownConversions;
  final int thirdDownAttempts;
  final int fourthDownConversions;
  final int fourthDownAttempts;
  final int penalties;
  final int penaltyYards;
  final int timeOfPossessionMinutes;
  final int timeOfPossessionSeconds;
  final int globalTeamId;
  final dynamic conferenceRank;
  final dynamic divisionRank;
  final DateTime updated;
  final DateTime created;
  final dynamic games;
  final int fantasyPoints;
  final int passingAttempts;
  final int passingCompletions;
  final int passingYards;
  final int passingCompletionPercentage;
  final int passingYardsPerAttempt;
  final int passingYardsPerCompletion;
  final int passingTouchdowns;
  final int passingInterceptions;
  final int passingRating;
  final int rushingAttempts;
  final int rushingYards;
  final int rushingYardsPerAttempt;
  final int rushingTouchdowns;
  final int rushingLong;
  final int receptions;
  final int receivingYards;
  final int receivingYardsPerReception;
  final int receivingTouchdowns;
  final int receivingLong;
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
  final int punts;
  final int puntYards;
  final int puntAverage;
  final int puntLong;
  final int fieldGoalsAttempted;
  final int fieldGoalsMade;
  final int fieldGoalPercentage;
  final int fieldGoalsLongestMade;
  final int extraPointsAttempted;
  final int extraPointsMade;
  final int interceptions;
  final int interceptionReturnYards;
  final int interceptionReturnTouchdowns;
  final int soloTackles;
  final int assistedTackles;
  final int tacklesForLoss;
  final int sacks;
  final int passesDefended;
  final int fumblesRecovered;
  final int fumbleReturnTouchdowns;
  final int quarterbackHurries;
  final int fumbles;
  final int fumblesLost;

  NcaafTeamStats copyWith({
    int statId,
    int teamId,
    int seasonType,
    int season,
    String name,
    String team,
    int wins,
    int losses,
    int pointsFor,
    int pointsAgainst,
    int conferenceWins,
    int conferenceLosses,
    int conferencePointsFor,
    int conferencePointsAgainst,
    int homeWins,
    int homeLosses,
    int roadWins,
    int roadLosses,
    int streak,
    int score,
    int opponentScore,
    int firstDowns,
    int thirdDownConversions,
    int thirdDownAttempts,
    int fourthDownConversions,
    int fourthDownAttempts,
    int penalties,
    int penaltyYards,
    int timeOfPossessionMinutes,
    int timeOfPossessionSeconds,
    int globalTeamId,
    dynamic conferenceRank,
    dynamic divisionRank,
    DateTime updated,
    DateTime created,
    dynamic games,
    int fantasyPoints,
    int passingAttempts,
    int passingCompletions,
    int passingYards,
    int passingCompletionPercentage,
    int passingYardsPerAttempt,
    int passingYardsPerCompletion,
    int passingTouchdowns,
    int passingInterceptions,
    int passingRating,
    int rushingAttempts,
    int rushingYards,
    int rushingYardsPerAttempt,
    int rushingTouchdowns,
    int rushingLong,
    int receptions,
    int receivingYards,
    int receivingYardsPerReception,
    int receivingTouchdowns,
    int receivingLong,
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
    int punts,
    int puntYards,
    int puntAverage,
    int puntLong,
    int fieldGoalsAttempted,
    int fieldGoalsMade,
    int fieldGoalPercentage,
    int fieldGoalsLongestMade,
    int extraPointsAttempted,
    int extraPointsMade,
    int interceptions,
    int interceptionReturnYards,
    int interceptionReturnTouchdowns,
    int soloTackles,
    int assistedTackles,
    int tacklesForLoss,
    int sacks,
    int passesDefended,
    int fumblesRecovered,
    int fumbleReturnTouchdowns,
    int quarterbackHurries,
    int fumbles,
    int fumblesLost,
  }) =>
      NcaafTeamStats(
        statId: statId ?? this.statId,
        teamId: teamId ?? this.teamId,
        seasonType: seasonType ?? this.seasonType,
        season: season ?? this.season,
        name: name ?? this.name,
        team: team ?? this.team,
        wins: wins ?? this.wins,
        losses: losses ?? this.losses,
        pointsFor: pointsFor ?? this.pointsFor,
        pointsAgainst: pointsAgainst ?? this.pointsAgainst,
        conferenceWins: conferenceWins ?? this.conferenceWins,
        conferenceLosses: conferenceLosses ?? this.conferenceLosses,
        conferencePointsFor: conferencePointsFor ?? this.conferencePointsFor,
        conferencePointsAgainst:
            conferencePointsAgainst ?? this.conferencePointsAgainst,
        homeWins: homeWins ?? this.homeWins,
        homeLosses: homeLosses ?? this.homeLosses,
        roadWins: roadWins ?? this.roadWins,
        roadLosses: roadLosses ?? this.roadLosses,
        streak: streak ?? this.streak,
        score: score ?? this.score,
        opponentScore: opponentScore ?? this.opponentScore,
        firstDowns: firstDowns ?? this.firstDowns,
        thirdDownConversions: thirdDownConversions ?? this.thirdDownConversions,
        thirdDownAttempts: thirdDownAttempts ?? this.thirdDownAttempts,
        fourthDownConversions:
            fourthDownConversions ?? this.fourthDownConversions,
        fourthDownAttempts: fourthDownAttempts ?? this.fourthDownAttempts,
        penalties: penalties ?? this.penalties,
        penaltyYards: penaltyYards ?? this.penaltyYards,
        timeOfPossessionMinutes:
            timeOfPossessionMinutes ?? this.timeOfPossessionMinutes,
        timeOfPossessionSeconds:
            timeOfPossessionSeconds ?? this.timeOfPossessionSeconds,
        globalTeamId: globalTeamId ?? this.globalTeamId,
        conferenceRank: conferenceRank ?? this.conferenceRank,
        divisionRank: divisionRank ?? this.divisionRank,
        updated: updated ?? this.updated,
        created: created ?? this.created,
        games: games ?? this.games,
        fantasyPoints: fantasyPoints ?? this.fantasyPoints,
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
        rushingAttempts: rushingAttempts ?? this.rushingAttempts,
        rushingYards: rushingYards ?? this.rushingYards,
        rushingYardsPerAttempt:
            rushingYardsPerAttempt ?? this.rushingYardsPerAttempt,
        rushingTouchdowns: rushingTouchdowns ?? this.rushingTouchdowns,
        rushingLong: rushingLong ?? this.rushingLong,
        receptions: receptions ?? this.receptions,
        receivingYards: receivingYards ?? this.receivingYards,
        receivingYardsPerReception:
            receivingYardsPerReception ?? this.receivingYardsPerReception,
        receivingTouchdowns: receivingTouchdowns ?? this.receivingTouchdowns,
        receivingLong: receivingLong ?? this.receivingLong,
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
        punts: punts ?? this.punts,
        puntYards: puntYards ?? this.puntYards,
        puntAverage: puntAverage ?? this.puntAverage,
        puntLong: puntLong ?? this.puntLong,
        fieldGoalsAttempted: fieldGoalsAttempted ?? this.fieldGoalsAttempted,
        fieldGoalsMade: fieldGoalsMade ?? this.fieldGoalsMade,
        fieldGoalPercentage: fieldGoalPercentage ?? this.fieldGoalPercentage,
        fieldGoalsLongestMade:
            fieldGoalsLongestMade ?? this.fieldGoalsLongestMade,
        extraPointsAttempted: extraPointsAttempted ?? this.extraPointsAttempted,
        extraPointsMade: extraPointsMade ?? this.extraPointsMade,
        interceptions: interceptions ?? this.interceptions,
        interceptionReturnYards:
            interceptionReturnYards ?? this.interceptionReturnYards,
        interceptionReturnTouchdowns:
            interceptionReturnTouchdowns ?? this.interceptionReturnTouchdowns,
        soloTackles: soloTackles ?? this.soloTackles,
        assistedTackles: assistedTackles ?? this.assistedTackles,
        tacklesForLoss: tacklesForLoss ?? this.tacklesForLoss,
        sacks: sacks ?? this.sacks,
        passesDefended: passesDefended ?? this.passesDefended,
        fumblesRecovered: fumblesRecovered ?? this.fumblesRecovered,
        fumbleReturnTouchdowns:
            fumbleReturnTouchdowns ?? this.fumbleReturnTouchdowns,
        quarterbackHurries: quarterbackHurries ?? this.quarterbackHurries,
        fumbles: fumbles ?? this.fumbles,
        fumblesLost: fumblesLost ?? this.fumblesLost,
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
        'PointsFor': pointsFor,
        'PointsAgainst': pointsAgainst,
        'ConferenceWins': conferenceWins,
        'ConferenceLosses': conferenceLosses,
        'ConferencePointsFor': conferencePointsFor,
        'ConferencePointsAgainst': conferencePointsAgainst,
        'HomeWins': homeWins,
        'HomeLosses': homeLosses,
        'RoadWins': roadWins,
        'RoadLosses': roadLosses,
        'Streak': streak,
        'Score': score,
        'OpponentScore': opponentScore,
        'FirstDowns': firstDowns,
        'ThirdDownConversions': thirdDownConversions,
        'ThirdDownAttempts': thirdDownAttempts,
        'FourthDownConversions': fourthDownConversions,
        'FourthDownAttempts': fourthDownAttempts,
        'Penalties': penalties,
        'PenaltyYards': penaltyYards,
        'TimeOfPossessionMinutes': timeOfPossessionMinutes,
        'TimeOfPossessionSeconds': timeOfPossessionSeconds,
        'GlobalTeamID': globalTeamId,
        'ConferenceRank': conferenceRank,
        'DivisionRank': divisionRank,
        'Updated': updated.toIso8601String(),
        'Created': created.toIso8601String(),
        'Games': games,
        'FantasyPoints': fantasyPoints,
        'PassingAttempts': passingAttempts,
        'PassingCompletions': passingCompletions,
        'PassingYards': passingYards,
        'PassingCompletionPercentage': passingCompletionPercentage,
        'PassingYardsPerAttempt': passingYardsPerAttempt,
        'PassingYardsPerCompletion': passingYardsPerCompletion,
        'PassingTouchdowns': passingTouchdowns,
        'PassingInterceptions': passingInterceptions,
        'PassingRating': passingRating,
        'RushingAttempts': rushingAttempts,
        'RushingYards': rushingYards,
        'RushingYardsPerAttempt': rushingYardsPerAttempt,
        'RushingTouchdowns': rushingTouchdowns,
        'RushingLong': rushingLong,
        'Receptions': receptions,
        'ReceivingYards': receivingYards,
        'ReceivingYardsPerReception': receivingYardsPerReception,
        'ReceivingTouchdowns': receivingTouchdowns,
        'ReceivingLong': receivingLong,
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
        'Punts': punts,
        'PuntYards': puntYards,
        'PuntAverage': puntAverage,
        'PuntLong': puntLong,
        'FieldGoalsAttempted': fieldGoalsAttempted,
        'FieldGoalsMade': fieldGoalsMade,
        'FieldGoalPercentage': fieldGoalPercentage,
        'FieldGoalsLongestMade': fieldGoalsLongestMade,
        'ExtraPointsAttempted': extraPointsAttempted,
        'ExtraPointsMade': extraPointsMade,
        'Interceptions': interceptions,
        'InterceptionReturnYards': interceptionReturnYards,
        'InterceptionReturnTouchdowns': interceptionReturnTouchdowns,
        'SoloTackles': soloTackles,
        'AssistedTackles': assistedTackles,
        'TacklesForLoss': tacklesForLoss,
        'Sacks': sacks,
        'PassesDefended': passesDefended,
        'FumblesRecovered': fumblesRecovered,
        'FumbleReturnTouchdowns': fumbleReturnTouchdowns,
        'QuarterbackHurries': quarterbackHurries,
        'Fumbles': fumbles,
        'FumblesLost': fumblesLost,
      };

  Map<String, dynamic> toStatOnlyMap() => <String, dynamic>{
        'Points For': pointsFor,
        'Points Against': pointsAgainst,
        'Conference Wins': conferenceWins,
        'Conference Losses': conferenceLosses,
        'Conference Points For': conferencePointsFor,
        'Conference Points Against': conferencePointsAgainst,
        'Home Wins': homeWins,
        'Home Losses': homeLosses,
        'Road Wins': roadWins,
        'Road Losses': roadLosses,
        'Streak': streak,
        'First Downs': firstDowns,
        'Third Down Conversions': thirdDownConversions,
        'Third Down Attempts': thirdDownAttempts,
        'Fourth Down Conversions': fourthDownConversions,
        'Fourth Down Attempts': fourthDownAttempts,
        'Penalties': penalties,
        'Penalty Yards': penaltyYards,
        'Time Of Possession Minutes': timeOfPossessionMinutes,
        'Time Of Possession Seconds': timeOfPossessionSeconds,
        'Conference Rank': conferenceRank,
        'Division Rank': divisionRank,
        'Passing Attempts': passingAttempts,
        'Passing Completions': passingCompletions,
        'Passing Yards': passingYards,
        'Passing Completion Percentage': passingCompletionPercentage,
        'Passing Yards Per Attempt': passingYardsPerAttempt,
        'Passing Yards Per Completion': passingYardsPerCompletion,
        'Passing Touchdowns': passingTouchdowns,
        'Passing Interceptions': passingInterceptions,
        'Passing Rating': passingRating,
        'Rushing Attempts': rushingAttempts,
        'Rushing Yards': rushingYards,
        'Rushing Yards Per Attempt': rushingYardsPerAttempt,
        'Rushing Touchdowns': rushingTouchdowns,
        'Rushing Long': rushingLong,
        'Receptions': receptions,
        'Receiving Yards': receivingYards,
        'Receiving Yards Per Reception': receivingYardsPerReception,
        'Receiving Touchdowns': receivingTouchdowns,
        'Receiving Long': receivingLong,
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
        'Punts': punts,
        'Punt Yards': puntYards,
        'Punt Average': puntAverage,
        'Punt Long': puntLong,
        'Field Goals Attempted': fieldGoalsAttempted,
        'Field Goals Made': fieldGoalsMade,
        'Field Goal Percentage': fieldGoalPercentage,
        'Field Goals Longest Made': fieldGoalsLongestMade,
        'Extra Points Attempted': extraPointsAttempted,
        'Extra Points Made': extraPointsMade,
        'Interceptions': interceptions,
        'Interception Return Yards': interceptionReturnYards,
        'Interception Return Touchdowns': interceptionReturnTouchdowns,
        'Solo Tackles': soloTackles,
        'Assisted Tackles': assistedTackles,
        'Tackles For Loss': tacklesForLoss,
        'Sacks': sacks,
        'Passes Defended': passesDefended,
        'Fumbles Recovered': fumblesRecovered,
        'Fumble Return Touchdowns': fumbleReturnTouchdowns,
        'Quarterback Hurries': quarterbackHurries,
        'Fumbles': fumbles,
        'Fumbles Lost': fumblesLost,
      };
}
