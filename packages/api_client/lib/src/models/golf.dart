import 'dart:convert';

class GolfLeaderboard {
  GolfLeaderboard({
    this.tournament,
    this.players,
  });

  final GolfTournament tournament;
  final List<GolfPlayer> players;

  GolfLeaderboard copyWith({
    GolfTournament tournament,
    List<GolfPlayer> players,
  }) =>
      GolfLeaderboard(
        tournament: tournament ?? this.tournament,
        players: players ?? this.players,
      );

  factory GolfLeaderboard.fromJson(String str) =>
      GolfLeaderboard.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GolfLeaderboard.fromMap(Map<String, dynamic> json) => GolfLeaderboard(
        tournament: GolfTournament.fromMap(json["Tournament"]),
        players: List<GolfPlayer>.from(
            json["Players"].map((x) => GolfPlayer.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Tournament": tournament.toMap(),
        "Players": List<dynamic>.from(players.map((x) => x.toMap())),
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

  final int playerTournamentId;
  final int playerId;
  final int tournamentId;
  final String name;
  final int rank;
  final String country;
  final int totalScore;
  final int totalStrokes;
  final dynamic totalThrough;
  final int earnings;
  final int fedExPoints;
  final double fantasyPoints;
  final double fantasyPointsDraftKings;
  final int draftKingsSalary;
  final int doubleEagles;
  final int eagles;
  final int birdies;
  final int pars;
  final int bogeys;
  final int doubleBogeys;
  final int worseThanDoubleBogey;
  final int holeInOnes;
  final int streaksOfThreeBirdiesOrBetter;
  final int bogeyFreeRounds;
  final int roundsUnderSeventy;
  final int tripleBogeys;
  final int worseThanTripleBogey;
  final DateTime teeTime;
  final int madeCut;
  final int win;
  final String tournamentStatus;
  final bool isAlternate;
  final int fanDuelSalary;
  final dynamic fantasyDraftSalary;
  final bool madeCutDidNotFinish;
  final double oddsToWin;
  final String oddsToWinDescription;
  final double fantasyPointsFanDuel;
  final int fantasyPointsFantasyDraft;
  final int streaksOfFourBirdiesOrBetter;
  final int streaksOfFiveBirdiesOrBetter;
  final int consecutiveBirdieOrBetterCount;
  final int bounceBackCount;
  final int roundsWithFiveOrMoreBirdiesOrBetter;
  final bool isWithdrawn;
  final double fantasyPointsYahoo;
  final int streaksOfSixBirdiesOrBetter;
  final List<PlayerRound> rounds;

  GolfPlayer copyWith({
    int playerTournamentId,
    int playerId,
    int tournamentId,
    String name,
    int rank,
    String country,
    int totalScore,
    int totalStrokes,
    dynamic totalThrough,
    int earnings,
    int fedExPoints,
    double fantasyPoints,
    double fantasyPointsDraftKings,
    int draftKingsSalary,
    int doubleEagles,
    int eagles,
    int birdies,
    int pars,
    int bogeys,
    int doubleBogeys,
    int worseThanDoubleBogey,
    int holeInOnes,
    int streaksOfThreeBirdiesOrBetter,
    int bogeyFreeRounds,
    int roundsUnderSeventy,
    int tripleBogeys,
    int worseThanTripleBogey,
    DateTime teeTime,
    int madeCut,
    int win,
    String tournamentStatus,
    bool isAlternate,
    int fanDuelSalary,
    dynamic fantasyDraftSalary,
    bool madeCutDidNotFinish,
    double oddsToWin,
    String oddsToWinDescription,
    double fantasyPointsFanDuel,
    int fantasyPointsFantasyDraft,
    int streaksOfFourBirdiesOrBetter,
    int streaksOfFiveBirdiesOrBetter,
    int consecutiveBirdieOrBetterCount,
    int bounceBackCount,
    int roundsWithFiveOrMoreBirdiesOrBetter,
    bool isWithdrawn,
    double fantasyPointsYahoo,
    int streaksOfSixBirdiesOrBetter,
    List<PlayerRound> rounds,
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

  factory GolfPlayer.fromJson(String str) =>
      GolfPlayer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GolfPlayer.fromMap(Map<String, dynamic> json) => GolfPlayer(
        playerTournamentId: json["PlayerTournamentID"]?.toInt(),
        playerId: json["PlayerID"]?.toInt(),
        tournamentId: json["TournamentID"]?.toInt(),
        name: json["Name"],
        rank: json["Rank"] == null ? null : json["Rank"]?.toInt(),
        country: json["Country"],
        totalScore:
            json["TotalScore"] == null ? null : json["TotalScore"]?.toInt(),
        totalStrokes:
            json["TotalStrokes"] == null ? null : json["TotalStrokes"]?.toInt(),
        totalThrough: json["TotalThrough"],
        earnings: json["Earnings"] == null ? null : json["Earnings"]?.toInt(),
        fedExPoints:
            json["FedExPoints"] == null ? null : json["FedExPoints"]?.toInt(),
        fantasyPoints: json["FantasyPoints"].toDouble(),
        fantasyPointsDraftKings: json["FantasyPointsDraftKings"].toDouble(),
        draftKingsSalary: json["DraftKingsSalary"] == null
            ? null
            : json["DraftKingsSalary"]?.toInt(),
        doubleEagles: json["DoubleEagles"]?.toInt(),
        eagles: json["Eagles"]?.toInt(),
        birdies: json["Birdies"]?.toInt(),
        pars: json["Pars"]?.toInt(),
        bogeys: json["Bogeys"]?.toInt(),
        doubleBogeys: json["DoubleBogeys"]?.toInt(),
        worseThanDoubleBogey: json["WorseThanDoubleBogey"]?.toInt(),
        holeInOnes: json["HoleInOnes"]?.toInt(),
        streaksOfThreeBirdiesOrBetter:
            json["StreaksOfThreeBirdiesOrBetter"]?.toInt(),
        bogeyFreeRounds: json["BogeyFreeRounds"]?.toInt(),
        roundsUnderSeventy: json["RoundsUnderSeventy"]?.toInt(),
        tripleBogeys: json["TripleBogeys"]?.toInt(),
        worseThanTripleBogey: json["WorseThanTripleBogey"]?.toInt(),
        teeTime:
            json["TeeTime"] == null ? null : DateTime.parse(json["TeeTime"]),
        madeCut: json["MadeCut"]?.toInt(),
        win: json["Win"]?.toInt(),
        tournamentStatus:
            json["TournamentStatus"] == null ? null : json["TournamentStatus"],
        isAlternate: json["IsAlternate"],
        fanDuelSalary: json["FanDuelSalary"] == null
            ? null
            : json["FanDuelSalary"]?.toInt(),
        fantasyDraftSalary: json["FantasyDraftSalary"],
        madeCutDidNotFinish: json["MadeCutDidNotFinish"],
        oddsToWin:
            json["OddsToWin"] == null ? null : json["OddsToWin"].toDouble(),
        oddsToWinDescription: json["OddsToWinDescription"] == null
            ? null
            : json["OddsToWinDescription"],
        fantasyPointsFanDuel: json["FantasyPointsFanDuel"].toDouble(),
        fantasyPointsFantasyDraft: json["FantasyPointsFantasyDraft"]?.toInt(),
        streaksOfFourBirdiesOrBetter:
            json["StreaksOfFourBirdiesOrBetter"]?.toInt(),
        streaksOfFiveBirdiesOrBetter:
            json["StreaksOfFiveBirdiesOrBetter"]?.toInt(),
        consecutiveBirdieOrBetterCount:
            json["ConsecutiveBirdieOrBetterCount"]?.toInt(),
        bounceBackCount: json["BounceBackCount"]?.toInt(),
        roundsWithFiveOrMoreBirdiesOrBetter:
            json["RoundsWithFiveOrMoreBirdiesOrBetter"]?.toInt(),
        isWithdrawn: json["IsWithdrawn"],
        fantasyPointsYahoo: json["FantasyPointsYahoo"].toDouble(),
        streaksOfSixBirdiesOrBetter:
            json["StreaksOfSixBirdiesOrBetter"]?.toInt(),
        rounds: List<PlayerRound>.from(
            json["Rounds"].map((x) => PlayerRound.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "PlayerTournamentID": playerTournamentId,
        "PlayerID": playerId,
        "TournamentID": tournamentId,
        "Name": name,
        "Rank": rank == null ? null : rank,
        "Country": country,
        "TotalScore": totalScore == null ? null : totalScore,
        "TotalStrokes": totalStrokes == null ? null : totalStrokes,
        "TotalThrough": totalThrough,
        "Earnings": earnings == null ? null : earnings,
        "FedExPoints": fedExPoints == null ? null : fedExPoints,
        "FantasyPoints": fantasyPoints,
        "FantasyPointsDraftKings": fantasyPointsDraftKings,
        "DraftKingsSalary": draftKingsSalary == null ? null : draftKingsSalary,
        "DoubleEagles": doubleEagles,
        "Eagles": eagles,
        "Birdies": birdies,
        "Pars": pars,
        "Bogeys": bogeys,
        "DoubleBogeys": doubleBogeys,
        "WorseThanDoubleBogey": worseThanDoubleBogey,
        "HoleInOnes": holeInOnes,
        "StreaksOfThreeBirdiesOrBetter": streaksOfThreeBirdiesOrBetter,
        "BogeyFreeRounds": bogeyFreeRounds,
        "RoundsUnderSeventy": roundsUnderSeventy,
        "TripleBogeys": tripleBogeys,
        "WorseThanTripleBogey": worseThanTripleBogey,
        "TeeTime": teeTime == null ? null : teeTime.toIso8601String(),
        "MadeCut": madeCut,
        "Win": win,
        "TournamentStatus": tournamentStatus == null ? null : tournamentStatus,
        "IsAlternate": isAlternate,
        "FanDuelSalary": fanDuelSalary == null ? null : fanDuelSalary,
        "FantasyDraftSalary": fantasyDraftSalary,
        "MadeCutDidNotFinish": madeCutDidNotFinish,
        "OddsToWin": oddsToWin == null ? null : oddsToWin,
        "OddsToWinDescription":
            oddsToWinDescription == null ? null : oddsToWinDescription,
        "FantasyPointsFanDuel": fantasyPointsFanDuel,
        "FantasyPointsFantasyDraft": fantasyPointsFantasyDraft,
        "StreaksOfFourBirdiesOrBetter": streaksOfFourBirdiesOrBetter,
        "StreaksOfFiveBirdiesOrBetter": streaksOfFiveBirdiesOrBetter,
        "ConsecutiveBirdieOrBetterCount": consecutiveBirdieOrBetterCount,
        "BounceBackCount": bounceBackCount,
        "RoundsWithFiveOrMoreBirdiesOrBetter":
            roundsWithFiveOrMoreBirdiesOrBetter,
        "IsWithdrawn": isWithdrawn,
        "FantasyPointsYahoo": fantasyPointsYahoo,
        "StreaksOfSixBirdiesOrBetter": streaksOfSixBirdiesOrBetter,
        "Rounds": List<dynamic>.from(rounds.map((x) => x.toMap())),
      };
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

  final int playerRoundId;
  final int playerTournamentId;
  final int number;
  final DateTime day;
  final int par;
  final int score;
  final bool bogeyFree;
  final bool includesStreakOfThreeBirdiesOrBetter;
  final int doubleEagles;
  final int eagles;
  final int birdies;
  final int pars;
  final int bogeys;
  final int doubleBogeys;
  final int worseThanDoubleBogey;
  final int holeInOnes;
  final int tripleBogeys;
  final int worseThanTripleBogey;
  final int longestBirdieOrBetterStreak;
  final int consecutiveBirdieOrBetterCount;
  final int bounceBackCount;
  final bool includesStreakOfFourBirdiesOrBetter;
  final bool includesStreakOfFiveBirdiesOrBetter;
  final bool includesFiveOrMoreBirdiesOrBetter;
  final bool includesStreakOfSixBirdiesOrBetter;
  final DateTime teeTime;
  final List<Hole> holes;

  PlayerRound copyWith({
    int playerRoundId,
    int playerTournamentId,
    int number,
    DateTime day,
    int par,
    int score,
    bool bogeyFree,
    bool includesStreakOfThreeBirdiesOrBetter,
    int doubleEagles,
    int eagles,
    int birdies,
    int pars,
    int bogeys,
    int doubleBogeys,
    int worseThanDoubleBogey,
    int holeInOnes,
    int tripleBogeys,
    int worseThanTripleBogey,
    int longestBirdieOrBetterStreak,
    int consecutiveBirdieOrBetterCount,
    int bounceBackCount,
    bool includesStreakOfFourBirdiesOrBetter,
    bool includesStreakOfFiveBirdiesOrBetter,
    bool includesFiveOrMoreBirdiesOrBetter,
    bool includesStreakOfSixBirdiesOrBetter,
    DateTime teeTime,
    List<Hole> holes,
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

  factory PlayerRound.fromJson(String str) =>
      PlayerRound.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlayerRound.fromMap(Map<String, dynamic> json) => PlayerRound(
        playerRoundId: json["PlayerRoundID"]?.toInt(),
        playerTournamentId: json["PlayerTournamentID"]?.toInt(),
        number: json["Number"]?.toInt(),
        day: DateTime.parse(json["Day"]),
        par: json["Par"]?.toInt(),
        score: json["Score"]?.toInt(),
        bogeyFree: json["BogeyFree"],
        includesStreakOfThreeBirdiesOrBetter:
            json["IncludesStreakOfThreeBirdiesOrBetter"],
        doubleEagles: json["DoubleEagles"]?.toInt(),
        eagles: json["Eagles"]?.toInt(),
        birdies: json["Birdies"]?.toInt(),
        pars: json["Pars"]?.toInt(),
        bogeys: json["Bogeys"]?.toInt(),
        doubleBogeys: json["DoubleBogeys"]?.toInt(),
        worseThanDoubleBogey: json["WorseThanDoubleBogey"]?.toInt(),
        holeInOnes: json["HoleInOnes"]?.toInt(),
        tripleBogeys: json["TripleBogeys"]?.toInt(),
        worseThanTripleBogey: json["WorseThanTripleBogey"]?.toInt(),
        longestBirdieOrBetterStreak:
            json["LongestBirdieOrBetterStreak"]?.toInt(),
        consecutiveBirdieOrBetterCount:
            json["ConsecutiveBirdieOrBetterCount"]?.toInt(),
        bounceBackCount: json["BounceBackCount"]?.toInt(),
        includesStreakOfFourBirdiesOrBetter:
            json["IncludesStreakOfFourBirdiesOrBetter"],
        includesStreakOfFiveBirdiesOrBetter:
            json["IncludesStreakOfFiveBirdiesOrBetter"],
        includesFiveOrMoreBirdiesOrBetter:
            json["IncludesFiveOrMoreBirdiesOrBetter"],
        includesStreakOfSixBirdiesOrBetter:
            json["IncludesStreakOfSixBirdiesOrBetter"],
        teeTime:
            json["TeeTime"] == null ? null : DateTime.parse(json["TeeTime"]),
        holes: List<Hole>.from(json["Holes"].map((x) => Hole.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "PlayerRoundID": playerRoundId,
        "PlayerTournamentID": playerTournamentId,
        "Number": number,
        "Day": day.toIso8601String(),
        "Par": par,
        "Score": score,
        "BogeyFree": bogeyFree,
        "IncludesStreakOfThreeBirdiesOrBetter":
            includesStreakOfThreeBirdiesOrBetter,
        "DoubleEagles": doubleEagles,
        "Eagles": eagles,
        "Birdies": birdies,
        "Pars": pars,
        "Bogeys": bogeys,
        "DoubleBogeys": doubleBogeys,
        "WorseThanDoubleBogey": worseThanDoubleBogey,
        "HoleInOnes": holeInOnes,
        "TripleBogeys": tripleBogeys,
        "WorseThanTripleBogey": worseThanTripleBogey,
        "LongestBirdieOrBetterStreak": longestBirdieOrBetterStreak,
        "ConsecutiveBirdieOrBetterCount": consecutiveBirdieOrBetterCount,
        "BounceBackCount": bounceBackCount,
        "IncludesStreakOfFourBirdiesOrBetter":
            includesStreakOfFourBirdiesOrBetter,
        "IncludesStreakOfFiveBirdiesOrBetter":
            includesStreakOfFiveBirdiesOrBetter,
        "IncludesFiveOrMoreBirdiesOrBetter": includesFiveOrMoreBirdiesOrBetter,
        "IncludesStreakOfSixBirdiesOrBetter":
            includesStreakOfSixBirdiesOrBetter,
        "TeeTime": teeTime == null ? null : teeTime.toIso8601String(),
        "Holes": List<dynamic>.from(holes.map((x) => x.toMap())),
      };
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

  final int playerRoundId;
  final int number;
  final int par;
  final int score;
  final int toPar;
  final bool holeInOne;
  final bool doubleEagle;
  final bool eagle;
  final bool birdie;
  final bool isPar;
  final bool bogey;
  final bool doubleBogey;
  final bool worseThanDoubleBogey;

  Hole copyWith({
    int playerRoundId,
    int number,
    int par,
    int score,
    int toPar,
    bool holeInOne,
    bool doubleEagle,
    bool eagle,
    bool birdie,
    bool isPar,
    bool bogey,
    bool doubleBogey,
    bool worseThanDoubleBogey,
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

  factory Hole.fromJson(String str) => Hole.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Hole.fromMap(Map<String, dynamic> json) => Hole(
        playerRoundId: json["PlayerRoundID"]?.toInt(),
        number: json["Number"]?.toInt(),
        par: json["Par"]?.toInt(),
        score: json["Score"] == null ? null : json["Score"]?.toInt(),
        toPar: json["ToPar"] == null ? null : json["ToPar"]?.toInt(),
        holeInOne: json["HoleInOne"],
        doubleEagle: json["DoubleEagle"],
        eagle: json["Eagle"],
        birdie: json["Birdie"],
        isPar: json["IsPar"],
        bogey: json["Bogey"],
        doubleBogey: json["DoubleBogey"],
        worseThanDoubleBogey: json["WorseThanDoubleBogey"],
      );

  Map<String, dynamic> toMap() => {
        "PlayerRoundID": playerRoundId,
        "Number": number,
        "Par": par,
        "Score": score == null ? null : score,
        "ToPar": toPar == null ? null : toPar,
        "HoleInOne": holeInOne,
        "DoubleEagle": doubleEagle,
        "Eagle": eagle,
        "Birdie": birdie,
        "IsPar": isPar,
        "Bogey": bogey,
        "DoubleBogey": doubleBogey,
        "WorseThanDoubleBogey": worseThanDoubleBogey,
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

  final int tournamentId;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final bool isOver;
  final bool isInProgress;
  final String venue;
  final String location;
  final int par;
  final int yards;
  final int purse;
  final DateTime startDateTime;
  final bool canceled;
  final bool covered;
  final String city;
  final String state;
  final dynamic zipCode;
  final String country;
  final String timeZone;
  final Format format;
  final String sportRadarTournamentId;
  final List<Round> rounds;

  GolfTournament copyWith({
    int tournamentId,
    String name,
    DateTime startDate,
    DateTime endDate,
    bool isOver,
    bool isInProgress,
    String venue,
    String location,
    int par,
    int yards,
    int purse,
    DateTime startDateTime,
    bool canceled,
    bool covered,
    String city,
    String state,
    dynamic zipCode,
    String country,
    String timeZone,
    Format format,
    String sportRadarTournamentId,
    List<Round> rounds,
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

  factory GolfTournament.fromJson(String str) =>
      GolfTournament.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GolfTournament.fromMap(Map<String, dynamic> json) => GolfTournament(
        tournamentId: json["TournamentID"].toInt(),
        name: json["Name"],
        startDate: DateTime.parse(json["StartDate"]),
        endDate: DateTime.parse(json["EndDate"]),
        isOver: json["IsOver"],
        isInProgress: json["IsInProgress"],
        venue: json["Venue"] == null ? null : json["Venue"],
        location: json["Location"] == null ? null : json["Location"],
        par: json["Par"] == null ? null : json["Par"].toInt(),
        yards: json["Yards"] == null ? null : json["Yards"].toInt(),
        purse: json["Purse"] == null ? null : json["Purse"].toInt(),
        startDateTime: json["StartDateTime"] == null
            ? null
            : DateTime.parse(json["StartDateTime"]),
        canceled: json["Canceled"] == null ? null : json["Canceled"],
        covered: json["Covered"] == null ? null : json["Covered"],
        city: json["City"] == null ? null : json["City"],
        state: json["State"] == null ? null : json["State"],
        zipCode: json["ZipCode"],
        country: json["Country"] == null ? null : json["Country"],
        timeZone: json["TimeZone"] == null ? null : json["TimeZone"],
        format:
            json["Format"] == null ? null : formatValues.map[json["Format"]],
        sportRadarTournamentId: json["SportRadarTournamentID"],
        rounds: List<Round>.from(json["Rounds"].map((x) => Round.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "TournamentID": tournamentId,
        "Name": name,
        "StartDate": startDate.toIso8601String(),
        "EndDate": endDate.toIso8601String(),
        "IsOver": isOver,
        "IsInProgress": isInProgress,
        "Venue": venue == null ? null : venue,
        "Location": location == null ? null : location,
        "Par": par == null ? null : par,
        "Yards": yards == null ? null : yards,
        "Purse": purse == null ? null : purse,
        "StartDateTime":
            startDateTime == null ? null : startDateTime.toIso8601String(),
        "Canceled": canceled == null ? null : canceled,
        "Covered": covered == null ? null : covered,
        "City": city == null ? null : city,
        "State": state == null ? null : state,
        "ZipCode": zipCode,
        "Country": country == null ? null : country,
        "TimeZone": timeZone == null ? null : timeZone,
        "Format": format == null ? null : formatValues.reverse[format],
        "SportRadarTournamentID": sportRadarTournamentId,
        "Rounds": List<dynamic>.from(rounds.map((x) => x.toMap())),
      };
}

enum Format { STROKE, STABLEFORD, TEAM, MATCH }

final formatValues = EnumValues({
  "Match": Format.MATCH,
  "Stableford": Format.STABLEFORD,
  "Stroke": Format.STROKE,
  "Team": Format.TEAM
});

class Round {
  Round({
    this.tournamentId,
    this.roundId,
    this.number,
    this.day,
  });

  final int tournamentId;
  final int roundId;
  final int number;
  final DateTime day;

  Round copyWith({
    int tournamentId,
    int roundId,
    int number,
    DateTime day,
  }) =>
      Round(
        tournamentId: tournamentId ?? this.tournamentId,
        roundId: roundId ?? this.roundId,
        number: number ?? this.number,
        day: day ?? this.day,
      );

  factory Round.fromJson(String str) => Round.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Round.fromMap(Map<String, dynamic> json) => Round(
        tournamentId: json["TournamentID"]?.toInt(),
        roundId: json["RoundID"]?.toInt(),
        number: json["Number"]?.toInt(),
        day: DateTime.parse(json["Day"]),
      );

  Map<String, dynamic> toMap() => {
        "TournamentID": tournamentId,
        "RoundID": roundId,
        "Number": number,
        "Day": day.toIso8601String(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
