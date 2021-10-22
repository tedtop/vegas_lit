

import 'dart:convert';

class GolfLeaderboard {
  GolfLeaderboard({
    this.tournament,
    this.players,
  });

  factory GolfLeaderboard.fromJson(String str) =>
      GolfLeaderboard.fromMap(json.decode(str) as Map<String, dynamic>);

  factory GolfLeaderboard.fromMap(Map<String, dynamic> json) => GolfLeaderboard(
        tournament:
            GolfTournament.fromMap(json['Tournament'] as Map<String, dynamic>),
        players: List<GolfPlayer>.from(
          json['Players'].map((Map<String, dynamic> x) => GolfPlayer.fromMap(x))
              as List,
        ),
      );

  final GolfTournament? tournament;
  final List<GolfPlayer>? players;

  GolfLeaderboard copyWith({
    GolfTournament? tournament,
    List<GolfPlayer>? players,
  }) =>
      GolfLeaderboard(
        tournament: tournament ?? this.tournament,
        players: players ?? this.players,
      );

  String toJson() => json.encode(toMap());

  Map<String, Object> toMap() => {
        'Tournament': tournament!.toMap(),
        'Players': List<dynamic>.from(players!.map<dynamic>((x) => x.toMap())),
      };
}

class GolfPlayer {
  GolfPlayer({
    this.playerTournamentId,
    this.playerId,
    this.tournamentId,
    this.name,
    this.rank,
    this.country,
    this.totalScore,
    this.totalStrokes,
    this.totalThrough,
    this.earnings,
    this.fedExPoints,
    this.fantasyPoints,
    this.fantasyPointsDraftKings,
    this.draftKingsSalary,
    this.doubleEagles,
    this.eagles,
    this.birdies,
    this.pars,
    this.bogeys,
    this.doubleBogeys,
    this.worseThanDoubleBogey,
    this.holeInOnes,
    this.streaksOfThreeBirdiesOrBetter,
    this.bogeyFreeRounds,
    this.roundsUnderSeventy,
    this.tripleBogeys,
    this.worseThanTripleBogey,
    this.teeTime,
    this.madeCut,
    this.win,
    this.tournamentStatus,
    this.isAlternate,
    this.fanDuelSalary,
    this.fantasyDraftSalary,
    this.madeCutDidNotFinish,
    this.oddsToWin,
    this.oddsToWinDescription,
    this.fantasyPointsFanDuel,
    this.fantasyPointsFantasyDraft,
    this.streaksOfFourBirdiesOrBetter,
    this.streaksOfFiveBirdiesOrBetter,
    this.consecutiveBirdieOrBetterCount,
    this.bounceBackCount,
    this.roundsWithFiveOrMoreBirdiesOrBetter,
    this.isWithdrawn,
    this.fantasyPointsYahoo,
    this.streaksOfSixBirdiesOrBetter,
    this.rounds,
  });

  factory GolfPlayer.fromJson(String str) =>
      GolfPlayer.fromMap(json.decode(str) as Map<String, dynamic>);

  factory GolfPlayer.fromMap(Map<String, dynamic> json) => GolfPlayer(
        playerTournamentId: json['PlayerTournamentID']?.toInt() as int?,
        playerId: json['PlayerID']?.toInt() as int?,
        tournamentId: json['TournamentID']?.toInt() as int?,
        name: json['Name'] as String?,
        rank: json['Rank'] == null ? null : json['Rank']?.toInt() as int?,
        country: json['Country'] as String?,
        totalScore: json['TotalScore'] == null
            ? null
            : json['TotalScore']?.toInt() as int?,
        totalStrokes: json['TotalStrokes'] == null
            ? null
            : json['TotalStrokes']?.toInt() as int?,
        totalThrough: json['TotalThrough'],
        earnings:
            json['Earnings'] == null ? null : json['Earnings']?.toInt() as int?,
        fedExPoints: json['FedExPoints'] == null
            ? null
            : json['FedExPoints']?.toInt() as int?,
        fantasyPoints: json['FantasyPoints'].toDouble() as double?,
        fantasyPointsDraftKings:
            json['FantasyPointsDraftKings'].toDouble() as double?,
        draftKingsSalary: json['DraftKingsSalary'] == null
            ? null
            : json['DraftKingsSalary']?.toInt() as int?,
        doubleEagles: json['DoubleEagles']?.toInt() as int?,
        eagles: json['Eagles']?.toInt() as int?,
        birdies: json['Birdies']?.toInt() as int?,
        pars: json['Pars']?.toInt() as int?,
        bogeys: json['Bogeys']?.toInt() as int?,
        doubleBogeys: json['DoubleBogeys']?.toInt() as int?,
        worseThanDoubleBogey: json['WorseThanDoubleBogey']?.toInt() as int?,
        holeInOnes: json['HoleInOnes']?.toInt() as int?,
        streaksOfThreeBirdiesOrBetter:
            json['StreaksOfThreeBirdiesOrBetter']?.toInt() as int?,
        bogeyFreeRounds: json['BogeyFreeRounds']?.toInt() as int?,
        roundsUnderSeventy: json['RoundsUnderSeventy']?.toInt() as int?,
        tripleBogeys: json['TripleBogeys']?.toInt() as int?,
        worseThanTripleBogey: json['WorseThanTripleBogey']?.toInt() as int?,
        teeTime: json['TeeTime'] == null
            ? null
            : DateTime.parse(json['TeeTime'] as String),
        madeCut: json['MadeCut']?.toInt() as int?,
        win: json['Win']?.toInt() as int?,
        tournamentStatus: json['TournamentStatus'] as String?,
        isAlternate: json['IsAlternate'] as bool?,
        fanDuelSalary: json['FanDuelSalary'] == null
            ? null
            : json['FanDuelSalary']?.toInt() as int?,
        fantasyDraftSalary: json['FantasyDraftSalary'],
        madeCutDidNotFinish: json['MadeCutDidNotFinish'] as bool?,
        oddsToWin: json['OddsToWin'] == null
            ? null
            : json['OddsToWin'].toDouble() as double?,
        oddsToWinDescription: json['OddsToWinDescription'] as String?,
        fantasyPointsFanDuel: json['FantasyPointsFanDuel'].toDouble() as double?,
        fantasyPointsFantasyDraft:
            json['FantasyPointsFantasyDraft']?.toInt() as int?,
        streaksOfFourBirdiesOrBetter:
            json['StreaksOfFourBirdiesOrBetter']?.toInt() as int?,
        streaksOfFiveBirdiesOrBetter:
            json['StreaksOfFiveBirdiesOrBetter']?.toInt() as int?,
        consecutiveBirdieOrBetterCount:
            json['ConsecutiveBirdieOrBetterCount']?.toInt() as int?,
        bounceBackCount: json['BounceBackCount']?.toInt() as int?,
        roundsWithFiveOrMoreBirdiesOrBetter:
            json['RoundsWithFiveOrMoreBirdiesOrBetter']?.toInt() as int?,
        isWithdrawn: json['IsWithdrawn'] as bool?,
        fantasyPointsYahoo: json['FantasyPointsYahoo'].toDouble() as double?,
        streaksOfSixBirdiesOrBetter:
            json['StreaksOfSixBirdiesOrBetter']?.toInt() as int?,
        rounds: List<PlayerRound>.from(
          json['Rounds'].map((Map<String, dynamic> x) => PlayerRound.fromMap(x))
              as List,
        ),
      );

  String toJson() => json.encode(toMap());

  Map<String, Object?> toMap() => {
        'PlayerTournamentID': playerTournamentId,
        'PlayerID': playerId,
        'TournamentID': tournamentId,
        'Name': name,
        'Rank': rank,
        'Country': country,
        'TotalScore': totalScore,
        'TotalStrokes': totalStrokes,
        'TotalThrough': totalThrough,
        'Earnings': earnings,
        'FedExPoints': fedExPoints,
        'FantasyPoints': fantasyPoints,
        'FantasyPointsDraftKings': fantasyPointsDraftKings,
        'DraftKingsSalary': draftKingsSalary,
        'DoubleEagles': doubleEagles,
        'Eagles': eagles,
        'Birdies': birdies,
        'Pars': pars,
        'Bogeys': bogeys,
        'DoubleBogeys': doubleBogeys,
        'WorseThanDoubleBogey': worseThanDoubleBogey,
        'HoleInOnes': holeInOnes,
        'StreaksOfThreeBirdiesOrBetter': streaksOfThreeBirdiesOrBetter,
        'BogeyFreeRounds': bogeyFreeRounds,
        'RoundsUnderSeventy': roundsUnderSeventy,
        'TripleBogeys': tripleBogeys,
        'WorseThanTripleBogey': worseThanTripleBogey,
        'TeeTime': teeTime?.toIso8601String(),
        'MadeCut': madeCut,
        'Win': win,
        'TournamentStatus': tournamentStatus,
        'IsAlternate': isAlternate,
        'FanDuelSalary': fanDuelSalary,
        'FantasyDraftSalary': fantasyDraftSalary,
        'MadeCutDidNotFinish': madeCutDidNotFinish,
        'OddsToWin': oddsToWin,
        'OddsToWinDescription': oddsToWinDescription,
        'FantasyPointsFanDuel': fantasyPointsFanDuel,
        'FantasyPointsFantasyDraft': fantasyPointsFantasyDraft,
        'StreaksOfFourBirdiesOrBetter': streaksOfFourBirdiesOrBetter,
        'StreaksOfFiveBirdiesOrBetter': streaksOfFiveBirdiesOrBetter,
        'ConsecutiveBirdieOrBetterCount': consecutiveBirdieOrBetterCount,
        'BounceBackCount': bounceBackCount,
        'RoundsWithFiveOrMoreBirdiesOrBetter':
            roundsWithFiveOrMoreBirdiesOrBetter,
        'IsWithdrawn': isWithdrawn,
        'FantasyPointsYahoo': fantasyPointsYahoo,
        'StreaksOfSixBirdiesOrBetter': streaksOfSixBirdiesOrBetter,
        'Rounds': List<dynamic>.from(rounds!.map<dynamic>((x) => x.toMap())),
      };

  GolfPlayer copyWith({
    int? playerTournamentId,
    int? playerId,
    int? tournamentId,
    String? name,
    int? rank,
    String? country,
    int? totalScore,
    int? totalStrokes,
    dynamic totalThrough,
    int? earnings,
    int? fedExPoints,
    double? fantasyPoints,
    double? fantasyPointsDraftKings,
    int? draftKingsSalary,
    int? doubleEagles,
    int? eagles,
    int? birdies,
    int? pars,
    int? bogeys,
    int? doubleBogeys,
    int? worseThanDoubleBogey,
    int? holeInOnes,
    int? streaksOfThreeBirdiesOrBetter,
    int? bogeyFreeRounds,
    int? roundsUnderSeventy,
    int? tripleBogeys,
    int? worseThanTripleBogey,
    DateTime? teeTime,
    int? madeCut,
    int? win,
    String? tournamentStatus,
    bool? isAlternate,
    int? fanDuelSalary,
    dynamic fantasyDraftSalary,
    bool? madeCutDidNotFinish,
    double? oddsToWin,
    String? oddsToWinDescription,
    double? fantasyPointsFanDuel,
    int? fantasyPointsFantasyDraft,
    int? streaksOfFourBirdiesOrBetter,
    int? streaksOfFiveBirdiesOrBetter,
    int? consecutiveBirdieOrBetterCount,
    int? bounceBackCount,
    int? roundsWithFiveOrMoreBirdiesOrBetter,
    bool? isWithdrawn,
    double? fantasyPointsYahoo,
    int? streaksOfSixBirdiesOrBetter,
    List<PlayerRound>? rounds,
  }) =>
      GolfPlayer(
        playerTournamentId: playerTournamentId ?? this.playerTournamentId,
        playerId: playerId ?? this.playerId,
        tournamentId: tournamentId ?? this.tournamentId,
        name: name ?? this.name,
        rank: rank ?? this.rank,
        country: country ?? this.country,
        totalScore: totalScore ?? this.totalScore,
        totalStrokes: totalStrokes ?? this.totalStrokes,
        totalThrough: totalThrough ?? this.totalThrough,
        earnings: earnings ?? this.earnings,
        fedExPoints: fedExPoints ?? this.fedExPoints,
        fantasyPoints: fantasyPoints ?? this.fantasyPoints,
        fantasyPointsDraftKings:
            fantasyPointsDraftKings ?? this.fantasyPointsDraftKings,
        draftKingsSalary: draftKingsSalary ?? this.draftKingsSalary,
        doubleEagles: doubleEagles ?? this.doubleEagles,
        eagles: eagles ?? this.eagles,
        birdies: birdies ?? this.birdies,
        pars: pars ?? this.pars,
        bogeys: bogeys ?? this.bogeys,
        doubleBogeys: doubleBogeys ?? this.doubleBogeys,
        worseThanDoubleBogey: worseThanDoubleBogey ?? this.worseThanDoubleBogey,
        holeInOnes: holeInOnes ?? this.holeInOnes,
        streaksOfThreeBirdiesOrBetter:
            streaksOfThreeBirdiesOrBetter ?? this.streaksOfThreeBirdiesOrBetter,
        bogeyFreeRounds: bogeyFreeRounds ?? this.bogeyFreeRounds,
        roundsUnderSeventy: roundsUnderSeventy ?? this.roundsUnderSeventy,
        tripleBogeys: tripleBogeys ?? this.tripleBogeys,
        worseThanTripleBogey: worseThanTripleBogey ?? this.worseThanTripleBogey,
        teeTime: teeTime ?? this.teeTime,
        madeCut: madeCut ?? this.madeCut,
        win: win ?? this.win,
        tournamentStatus: tournamentStatus ?? this.tournamentStatus,
        isAlternate: isAlternate ?? this.isAlternate,
        fanDuelSalary: fanDuelSalary ?? this.fanDuelSalary,
        fantasyDraftSalary: fantasyDraftSalary ?? this.fantasyDraftSalary,
        madeCutDidNotFinish: madeCutDidNotFinish ?? this.madeCutDidNotFinish,
        oddsToWin: oddsToWin ?? this.oddsToWin,
        oddsToWinDescription: oddsToWinDescription ?? this.oddsToWinDescription,
        fantasyPointsFanDuel: fantasyPointsFanDuel ?? this.fantasyPointsFanDuel,
        fantasyPointsFantasyDraft:
            fantasyPointsFantasyDraft ?? this.fantasyPointsFantasyDraft,
        streaksOfFourBirdiesOrBetter:
            streaksOfFourBirdiesOrBetter ?? this.streaksOfFourBirdiesOrBetter,
        streaksOfFiveBirdiesOrBetter:
            streaksOfFiveBirdiesOrBetter ?? this.streaksOfFiveBirdiesOrBetter,
        consecutiveBirdieOrBetterCount: consecutiveBirdieOrBetterCount ??
            this.consecutiveBirdieOrBetterCount,
        bounceBackCount: bounceBackCount ?? this.bounceBackCount,
        roundsWithFiveOrMoreBirdiesOrBetter:
            roundsWithFiveOrMoreBirdiesOrBetter ??
                this.roundsWithFiveOrMoreBirdiesOrBetter,
        isWithdrawn: isWithdrawn ?? this.isWithdrawn,
        fantasyPointsYahoo: fantasyPointsYahoo ?? this.fantasyPointsYahoo,
        streaksOfSixBirdiesOrBetter:
            streaksOfSixBirdiesOrBetter ?? this.streaksOfSixBirdiesOrBetter,
        rounds: rounds ?? this.rounds,
      );

  final int? playerTournamentId;
  final int? playerId;
  final int? tournamentId;
  final String? name;
  final int? rank;
  final String? country;
  final int? totalScore;
  final int? totalStrokes;
  final dynamic totalThrough;
  final int? earnings;
  final int? fedExPoints;
  final double? fantasyPoints;
  final double? fantasyPointsDraftKings;
  final int? draftKingsSalary;
  final int? doubleEagles;
  final int? eagles;
  final int? birdies;
  final int? pars;
  final int? bogeys;
  final int? doubleBogeys;
  final int? worseThanDoubleBogey;
  final int? holeInOnes;
  final int? streaksOfThreeBirdiesOrBetter;
  final int? bogeyFreeRounds;
  final int? roundsUnderSeventy;
  final int? tripleBogeys;
  final int? worseThanTripleBogey;
  final DateTime? teeTime;
  final int? madeCut;
  final int? win;
  final String? tournamentStatus;
  final bool? isAlternate;
  final int? fanDuelSalary;
  final dynamic fantasyDraftSalary;
  final bool? madeCutDidNotFinish;
  final double? oddsToWin;
  final String? oddsToWinDescription;
  final double? fantasyPointsFanDuel;
  final int? fantasyPointsFantasyDraft;
  final int? streaksOfFourBirdiesOrBetter;
  final int? streaksOfFiveBirdiesOrBetter;
  final int? consecutiveBirdieOrBetterCount;
  final int? bounceBackCount;
  final int? roundsWithFiveOrMoreBirdiesOrBetter;
  final bool? isWithdrawn;
  final double? fantasyPointsYahoo;
  final int? streaksOfSixBirdiesOrBetter;
  final List<PlayerRound>? rounds;
}

class PlayerRound {
  PlayerRound({
    this.playerRoundId,
    this.playerTournamentId,
    this.number,
    this.day,
    this.par,
    this.score,
    this.bogeyFree,
    this.includesStreakOfThreeBirdiesOrBetter,
    this.doubleEagles,
    this.eagles,
    this.birdies,
    this.pars,
    this.bogeys,
    this.doubleBogeys,
    this.worseThanDoubleBogey,
    this.holeInOnes,
    this.tripleBogeys,
    this.worseThanTripleBogey,
    this.longestBirdieOrBetterStreak,
    this.consecutiveBirdieOrBetterCount,
    this.bounceBackCount,
    this.includesStreakOfFourBirdiesOrBetter,
    this.includesStreakOfFiveBirdiesOrBetter,
    this.includesFiveOrMoreBirdiesOrBetter,
    this.includesStreakOfSixBirdiesOrBetter,
    this.teeTime,
    this.holes,
  });

  factory PlayerRound.fromJson(String str) =>
      PlayerRound.fromMap(json.decode(str) as Map<String, dynamic>);

  factory PlayerRound.fromMap(Map<String, dynamic> json) => PlayerRound(
        playerRoundId: json['PlayerRoundID']?.toInt() as int?,
        playerTournamentId: json['PlayerTournamentID']?.toInt() as int?,
        number: json['Number']?.toInt() as int?,
        day: DateTime.parse(json['Day'] as String),
        par: json['Par']?.toInt() as int?,
        score: json['Score']?.toInt() as int?,
        bogeyFree: json['BogeyFree'] as bool?,
        includesStreakOfThreeBirdiesOrBetter:
            json['IncludesStreakOfThreeBirdiesOrBetter'] as bool?,
        doubleEagles: json['DoubleEagles']?.toInt() as int?,
        eagles: json['Eagles']?.toInt() as int?,
        birdies: json['Birdies']?.toInt() as int?,
        pars: json['Pars']?.toInt() as int?,
        bogeys: json['Bogeys']?.toInt() as int?,
        doubleBogeys: json['DoubleBogeys']?.toInt() as int?,
        worseThanDoubleBogey: json['WorseThanDoubleBogey']?.toInt() as int?,
        holeInOnes: json['HoleInOnes']?.toInt() as int?,
        tripleBogeys: json['TripleBogeys']?.toInt() as int?,
        worseThanTripleBogey: json['WorseThanTripleBogey']?.toInt() as int?,
        longestBirdieOrBetterStreak:
            json['LongestBirdieOrBetterStreak']?.toInt() as int?,
        consecutiveBirdieOrBetterCount:
            json['ConsecutiveBirdieOrBetterCount']?.toInt() as int?,
        bounceBackCount: json['BounceBackCount']?.toInt() as int?,
        includesStreakOfFourBirdiesOrBetter:
            json['IncludesStreakOfFourBirdiesOrBetter'] as bool?,
        includesStreakOfFiveBirdiesOrBetter:
            json['IncludesStreakOfFiveBirdiesOrBetter'] as bool?,
        includesFiveOrMoreBirdiesOrBetter:
            json['IncludesFiveOrMoreBirdiesOrBetter'] as bool?,
        includesStreakOfSixBirdiesOrBetter:
            json['IncludesStreakOfSixBirdiesOrBetter'] as bool?,
        teeTime: json['TeeTime'] == null
            ? null
            : DateTime.parse(json['TeeTime'] as String),
        holes: List<Hole>.from(json['Holes']
            .map((Map<String, dynamic> x) => Hole.fromMap(x)) as List),
      );

  final int? playerRoundId;
  final int? playerTournamentId;
  final int? number;
  final DateTime? day;
  final int? par;
  final int? score;
  final bool? bogeyFree;
  final bool? includesStreakOfThreeBirdiesOrBetter;
  final int? doubleEagles;
  final int? eagles;
  final int? birdies;
  final int? pars;
  final int? bogeys;
  final int? doubleBogeys;
  final int? worseThanDoubleBogey;
  final int? holeInOnes;
  final int? tripleBogeys;
  final int? worseThanTripleBogey;
  final int? longestBirdieOrBetterStreak;
  final int? consecutiveBirdieOrBetterCount;
  final int? bounceBackCount;
  final bool? includesStreakOfFourBirdiesOrBetter;
  final bool? includesStreakOfFiveBirdiesOrBetter;
  final bool? includesFiveOrMoreBirdiesOrBetter;
  final bool? includesStreakOfSixBirdiesOrBetter;
  final DateTime? teeTime;
  final List<Hole>? holes;

  PlayerRound copyWith({
    int? playerRoundId,
    int? playerTournamentId,
    int? number,
    DateTime? day,
    int? par,
    int? score,
    bool? bogeyFree,
    bool? includesStreakOfThreeBirdiesOrBetter,
    int? doubleEagles,
    int? eagles,
    int? birdies,
    int? pars,
    int? bogeys,
    int? doubleBogeys,
    int? worseThanDoubleBogey,
    int? holeInOnes,
    int? tripleBogeys,
    int? worseThanTripleBogey,
    int? longestBirdieOrBetterStreak,
    int? consecutiveBirdieOrBetterCount,
    int? bounceBackCount,
    bool? includesStreakOfFourBirdiesOrBetter,
    bool? includesStreakOfFiveBirdiesOrBetter,
    bool? includesFiveOrMoreBirdiesOrBetter,
    bool? includesStreakOfSixBirdiesOrBetter,
    DateTime? teeTime,
    List<Hole>? holes,
  }) =>
      PlayerRound(
        playerRoundId: playerRoundId ?? this.playerRoundId,
        playerTournamentId: playerTournamentId ?? this.playerTournamentId,
        number: number ?? this.number,
        day: day ?? this.day,
        par: par ?? this.par,
        score: score ?? this.score,
        bogeyFree: bogeyFree ?? this.bogeyFree,
        includesStreakOfThreeBirdiesOrBetter:
            includesStreakOfThreeBirdiesOrBetter ??
                this.includesStreakOfThreeBirdiesOrBetter,
        doubleEagles: doubleEagles ?? this.doubleEagles,
        eagles: eagles ?? this.eagles,
        birdies: birdies ?? this.birdies,
        pars: pars ?? this.pars,
        bogeys: bogeys ?? this.bogeys,
        doubleBogeys: doubleBogeys ?? this.doubleBogeys,
        worseThanDoubleBogey: worseThanDoubleBogey ?? this.worseThanDoubleBogey,
        holeInOnes: holeInOnes ?? this.holeInOnes,
        tripleBogeys: tripleBogeys ?? this.tripleBogeys,
        worseThanTripleBogey: worseThanTripleBogey ?? this.worseThanTripleBogey,
        longestBirdieOrBetterStreak:
            longestBirdieOrBetterStreak ?? this.longestBirdieOrBetterStreak,
        consecutiveBirdieOrBetterCount: consecutiveBirdieOrBetterCount ??
            this.consecutiveBirdieOrBetterCount,
        bounceBackCount: bounceBackCount ?? this.bounceBackCount,
        includesStreakOfFourBirdiesOrBetter:
            includesStreakOfFourBirdiesOrBetter ??
                this.includesStreakOfFourBirdiesOrBetter,
        includesStreakOfFiveBirdiesOrBetter:
            includesStreakOfFiveBirdiesOrBetter ??
                this.includesStreakOfFiveBirdiesOrBetter,
        includesFiveOrMoreBirdiesOrBetter: includesFiveOrMoreBirdiesOrBetter ??
            this.includesFiveOrMoreBirdiesOrBetter,
        includesStreakOfSixBirdiesOrBetter:
            includesStreakOfSixBirdiesOrBetter ??
                this.includesStreakOfSixBirdiesOrBetter,
        teeTime: teeTime ?? this.teeTime,
        holes: holes ?? this.holes,
      );

  Map<String, Object?> toMap() => {
        'PlayerRoundID': playerRoundId,
        'PlayerTournamentID': playerTournamentId,
        'Number': number,
        'Day': day!.toIso8601String(),
        'Par': par,
        'Score': score,
        'BogeyFree': bogeyFree,
        'IncludesStreakOfThreeBirdiesOrBetter':
            includesStreakOfThreeBirdiesOrBetter,
        'DoubleEagles': doubleEagles,
        'Eagles': eagles,
        'Birdies': birdies,
        'Pars': pars,
        'Bogeys': bogeys,
        'DoubleBogeys': doubleBogeys,
        'WorseThanDoubleBogey': worseThanDoubleBogey,
        'HoleInOnes': holeInOnes,
        'TripleBogeys': tripleBogeys,
        'WorseThanTripleBogey': worseThanTripleBogey,
        'LongestBirdieOrBetterStreak': longestBirdieOrBetterStreak,
        'ConsecutiveBirdieOrBetterCount': consecutiveBirdieOrBetterCount,
        'BounceBackCount': bounceBackCount,
        'IncludesStreakOfFourBirdiesOrBetter':
            includesStreakOfFourBirdiesOrBetter,
        'IncludesStreakOfFiveBirdiesOrBetter':
            includesStreakOfFiveBirdiesOrBetter,
        'IncludesFiveOrMoreBirdiesOrBetter': includesFiveOrMoreBirdiesOrBetter,
        'IncludesStreakOfSixBirdiesOrBetter':
            includesStreakOfSixBirdiesOrBetter,
        'TeeTime': teeTime?.toIso8601String(),
        'Holes': List<dynamic>.from(holes!.map<dynamic>((x) => x.toMap())),
      };

  String toJson() => json.encode(toMap());
}

class Hole {
  Hole({
    this.playerRoundId,
    this.number,
    this.par,
    this.score,
    this.toPar,
    this.holeInOne,
    this.doubleEagle,
    this.eagle,
    this.birdie,
    this.isPar,
    this.bogey,
    this.doubleBogey,
    this.worseThanDoubleBogey,
  });

  factory Hole.fromJson(String str) =>
      Hole.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Hole.fromMap(Map<String, dynamic> json) => Hole(
        playerRoundId: json['PlayerRoundID']?.toInt() as int?,
        number: json['Number']?.toInt() as int?,
        par: json['Par']?.toInt() as int?,
        score: json['Score'] == null ? null : json['Score']?.toInt() as int?,
        toPar: json['ToPar'] == null ? null : json['ToPar']?.toInt() as int?,
        holeInOne: json['HoleInOne'] as bool?,
        doubleEagle: json['DoubleEagle'] as bool?,
        eagle: json['Eagle'] as bool?,
        birdie: json['Birdie'] as bool?,
        isPar: json['IsPar'] as bool?,
        bogey: json['Bogey'] as bool?,
        doubleBogey: json['DoubleBogey'] as bool?,
        worseThanDoubleBogey: json['WorseThanDoubleBogey'] as bool?,
      );

  final int? playerRoundId;
  final int? number;
  final int? par;
  final int? score;
  final int? toPar;
  final bool? holeInOne;
  final bool? doubleEagle;
  final bool? eagle;
  final bool? birdie;
  final bool? isPar;
  final bool? bogey;
  final bool? doubleBogey;
  final bool? worseThanDoubleBogey;

  Hole copyWith({
    int? playerRoundId,
    int? number,
    int? par,
    int? score,
    int? toPar,
    bool? holeInOne,
    bool? doubleEagle,
    bool? eagle,
    bool? birdie,
    bool? isPar,
    bool? bogey,
    bool? doubleBogey,
    bool? worseThanDoubleBogey,
  }) =>
      Hole(
        playerRoundId: playerRoundId ?? this.playerRoundId,
        number: number ?? this.number,
        par: par ?? this.par,
        score: score ?? this.score,
        toPar: toPar ?? this.toPar,
        holeInOne: holeInOne ?? this.holeInOne,
        doubleEagle: doubleEagle ?? this.doubleEagle,
        eagle: eagle ?? this.eagle,
        birdie: birdie ?? this.birdie,
        isPar: isPar ?? this.isPar,
        bogey: bogey ?? this.bogey,
        doubleBogey: doubleBogey ?? this.doubleBogey,
        worseThanDoubleBogey: worseThanDoubleBogey ?? this.worseThanDoubleBogey,
      );

  String toJson() => json.encode(toMap());

  Map<String, Object?> toMap() => {
        'PlayerRoundID': playerRoundId,
        'Number': number,
        'Par': par,
        'Score': score,
        'ToPar': toPar,
        'HoleInOne': holeInOne,
        'DoubleEagle': doubleEagle,
        'Eagle': eagle,
        'Birdie': birdie,
        'IsPar': isPar,
        'Bogey': bogey,
        'DoubleBogey': doubleBogey,
        'WorseThanDoubleBogey': worseThanDoubleBogey,
      };
}

class GolfTournament {
  GolfTournament({
    this.tournamentId,
    this.name,
    this.startDate,
    this.endDate,
    this.isOver,
    this.isInProgress,
    this.venue,
    this.location,
    this.par,
    this.yards,
    this.purse,
    this.startDateTime,
    this.canceled,
    this.covered,
    this.city,
    this.state,
    this.zipCode,
    this.country,
    this.timeZone,
    this.format,
    this.sportRadarTournamentId,
    this.rounds,
  });

  factory GolfTournament.fromJson(String str) =>
      GolfTournament.fromMap(json.decode(str) as Map<String, dynamic>);

  factory GolfTournament.fromMap(Map<String, dynamic> json) => GolfTournament(
        tournamentId: json['TournamentID'].toInt() as int?,
        name: json['Name'] as String?,
        startDate: DateTime.parse(json['StartDate'] as String),
        endDate: DateTime.parse(json['EndDate'] as String),
        isOver: json['IsOver'] as bool?,
        isInProgress: json['IsInProgress'] as bool?,
        venue: json['Venue'] as String?,
        location: json['Location'] as String?,
        par: json['Par'] == null ? null : json['Par'].toInt() as int?,
        yards: json['Yards'] == null ? null : json['Yards'].toInt() as int?,
        purse: json['Purse'] == null ? null : json['Purse'].toInt() as int?,
        startDateTime: json['StartDateTime'] == null
            ? null
            : DateTime.parse(json['StartDateTime'] as String),
        canceled: json['Canceled'] as bool?,
        covered: json['Covered'] as bool?,
        city: json['City'] as String?,
        state: json['State'] as String?,
        zipCode: json['ZipCode'] as String?,
        country: json['Country'] as String?,
        timeZone: json['TimeZone'] as String?,
        format:
            json['Format'] == null ? null : formatValues.map[json['Format']],
        sportRadarTournamentId: json['SportRadarTournamentID'] as String?,
        rounds: List<Round>.from(json['Rounds']
            .map((Map<String, dynamic> x) => Round.fromMap(x)) as List),
      );

  final int? tournamentId;
  final String? name;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? isOver;
  final bool? isInProgress;
  final String? venue;
  final String? location;
  final int? par;
  final int? yards;
  final int? purse;
  final DateTime? startDateTime;
  final bool? canceled;
  final bool? covered;
  final String? city;
  final String? state;
  final dynamic zipCode;
  final String? country;
  final String? timeZone;
  final Format? format;
  final String? sportRadarTournamentId;
  final List<Round>? rounds;

  GolfTournament copyWith({
    int? tournamentId,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    bool? isOver,
    bool? isInProgress,
    String? venue,
    String? location,
    int? par,
    int? yards,
    int? purse,
    DateTime? startDateTime,
    bool? canceled,
    bool? covered,
    String? city,
    String? state,
    dynamic zipCode,
    String? country,
    String? timeZone,
    Format? format,
    String? sportRadarTournamentId,
    List<Round>? rounds,
  }) =>
      GolfTournament(
        tournamentId: tournamentId ?? this.tournamentId,
        name: name ?? this.name,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        isOver: isOver ?? this.isOver,
        isInProgress: isInProgress ?? this.isInProgress,
        venue: venue ?? this.venue,
        location: location ?? this.location,
        par: par ?? this.par,
        yards: yards ?? this.yards,
        purse: purse ?? this.purse,
        startDateTime: startDateTime ?? this.startDateTime,
        canceled: canceled ?? this.canceled,
        covered: covered ?? this.covered,
        city: city ?? this.city,
        state: state ?? this.state,
        zipCode: zipCode ?? this.zipCode,
        country: country ?? this.country,
        timeZone: timeZone ?? this.timeZone,
        format: format ?? this.format,
        sportRadarTournamentId:
            sportRadarTournamentId ?? this.sportRadarTournamentId,
        rounds: rounds ?? this.rounds,
      );

  String toJson() => json.encode(toMap());

  Map<String, Object?> toMap() => {
        'TournamentID': tournamentId,
        'Name': name,
        'StartDate': startDate!.toIso8601String(),
        'EndDate': endDate!.toIso8601String(),
        'IsOver': isOver,
        'IsInProgress': isInProgress,
        'Venue': venue,
        'Location': location,
        'Par': par,
        'Yards': yards,
        'Purse': purse,
        'StartDateTime': startDateTime?.toIso8601String(),
        'Canceled': canceled,
        'Covered': covered,
        'City': city,
        'State': state,
        'ZipCode': zipCode,
        'Country': country,
        'TimeZone': timeZone,
        'Format': format == null ? null : formatValues.reverse![format!],
        'SportRadarTournamentID': sportRadarTournamentId,
        'Rounds': List<dynamic>.from(rounds!.map<dynamic>((x) => x.toMap())),
      };
}

enum Format { stroke, stableford, team, match }

final formatValues = EnumValues({
  'Match': Format.match,
  'Stableford': Format.stableford,
  'Stroke': Format.stroke,
  'Team': Format.team
});

class Round {
  Round({
    this.tournamentId,
    this.roundId,
    this.number,
    this.day,
  });

  factory Round.fromJson(String str) =>
      Round.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Round.fromMap(Map<String, dynamic> json) => Round(
        tournamentId: json['TournamentID']?.toInt() as int?,
        roundId: json['RoundID']?.toInt() as int?,
        number: json['Number']?.toInt() as int?,
        day: DateTime.parse(json['Day'] as String),
      );

  String toJson() => json.encode(toMap());

  Round copyWith({
    int? tournamentId,
    int? roundId,
    int? number,
    DateTime? day,
  }) =>
      Round(
        tournamentId: tournamentId ?? this.tournamentId,
        roundId: roundId ?? this.roundId,
        number: number ?? this.number,
        day: day ?? this.day,
      );

  final int? tournamentId;
  final int? roundId;
  final int? number;
  final DateTime? day;

  Map<String, Object?> toMap() => {
        'TournamentID': tournamentId,
        'RoundID': roundId,
        'Number': number,
        'Day': day!.toIso8601String(),
      };
}

class EnumValues<T> {
  EnumValues(this.map);
  Map<String, T> map;
  Map<T, String>? reverseMap;

  Map<T, String>? get reverse {
    // ignore: join_return_with_assignment
    // ignore: join_return_with_assignment
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
