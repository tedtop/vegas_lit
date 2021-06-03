part of 'bet_button_cubit.dart';

enum BetButtonStatus { done, error, loading, clicked, unclicked, placed }

enum BetButtonWin { away, home }

class NcaabBetButtonState extends Equatable {
  const NcaabBetButtonState._({
    this.text,
    this.game,
    this.uniqueId,
    this.mainOdds,
    this.status = BetButtonStatus.loading,
    this.betType,
    this.isClosed,
    this.gameId,
    this.betAmount = 100,
    this.toWinAmount,
    this.awayTeamData,
    this.spread,
    this.uid,
    this.league,
    this.homeTeamData,
    this.winTeam,
  });

  const NcaabBetButtonState.loading() : this._();

  const NcaabBetButtonState.clicked(
      {@required String text,
      @required NcaabGame game,
      @required String uniqueId,
      @required String league,
      @required double spread,
      @required NcaabTeam awayTeamData,
      @required NcaabTeam homeTeamData,
      @required bool isClosed,
      @required int gameId,
      @required int betAmount,
      @required int toWinAmount,
      @required String uid,
      @required BetButtonWin winTeam,
      @required String mainOdds,
      @required Bet betType})
      : this._(
          status: BetButtonStatus.clicked,
          text: text,
          game: game,
          uniqueId: uniqueId,
          winTeam: winTeam,
          homeTeamData: homeTeamData,
          gameId: gameId,
          isClosed: isClosed,
          uid: uid,
          betAmount: betAmount,
          toWinAmount: toWinAmount,
          spread: spread,
          awayTeamData: awayTeamData,
          mainOdds: mainOdds,
          league: league,
          betType: betType,
        );

  const NcaabBetButtonState.unclicked(
      {@required String text,
      @required NcaabGame game,
      @required String uniqueId,
      @required String mainOdds,
      @required bool isClosed,
      @required int gameId,
      @required double spread,
      @required BetButtonWin winTeam,
      @required int betAmount,
      @required int toWinAmount,
      @required String uid,
      @required NcaabTeam awayTeamData,
      @required String league,
      @required NcaabTeam homeTeamData,
      @required Bet betType})
      : this._(
            status: BetButtonStatus.unclicked,
            text: text,
            game: game,
            uniqueId: uniqueId,
            mainOdds: mainOdds,
            homeTeamData: homeTeamData,
            uid: uid,
            spread: spread,
            betAmount: betAmount,
            toWinAmount: toWinAmount,
            league: league,
            gameId: gameId,
            winTeam: winTeam,
            isClosed: isClosed,
            awayTeamData: awayTeamData,
            betType: betType);

  const NcaabBetButtonState.done({
    @required String text,
    @required NcaabGame game,
    @required String mainOdds,
    @required NcaabTeam awayTeamData,
    @required bool isClosed,
    @required int gameId,
    @required NcaabTeam homeTeamData,
    @required double spread,
    @required String league,
    @required String uid,
    @required BetButtonWin winTeam,
    @required int betAmount,
    @required int toWinAmount,
    @required String uniqueId,
    @required Bet betType,
  }) : this._(
          status: BetButtonStatus.done,
          text: text,
          game: game,
          league: league,
          uniqueId: uniqueId,
          winTeam: winTeam,
          gameId: gameId,
          betAmount: betAmount,
          toWinAmount: toWinAmount,
          spread: spread,
          isClosed: isClosed,
          uid: uid,
          homeTeamData: homeTeamData,
          awayTeamData: awayTeamData,
          mainOdds: mainOdds,
          betType: betType,
        );

  const NcaabBetButtonState.placed({
    @required String text,
    @required NcaabGame game,
    @required String mainOdds,
    @required NcaabTeam awayTeamData,
    @required bool isClosed,
    @required int gameId,
    @required NcaabTeam homeTeamData,
    @required String uid,
    @required int betAmount,
    @required int toWinAmount,
    @required double spread,
    @required String league,
    @required BetButtonWin winTeam,
    @required String uniqueId,
    @required Bet betType,
  }) : this._(
          status: BetButtonStatus.placed,
          text: text,
          game: game,
          league: league,
          uniqueId: uniqueId,
          winTeam: winTeam,
          gameId: gameId,
          spread: spread,
          betAmount: betAmount,
          toWinAmount: toWinAmount,
          isClosed: isClosed,
          uid: uid,
          homeTeamData: homeTeamData,
          awayTeamData: awayTeamData,
          mainOdds: mainOdds,
          betType: betType,
        );

  final BetButtonStatus status;
  final String text;
  final NcaabGame game;
  final String uniqueId;
  final Bet betType;
  final String mainOdds;
  final double spread;
  final NcaabTeam awayTeamData;
  final String league;
  final int gameId;
  final String uid;
  final bool isClosed;
  final int betAmount;
  final int toWinAmount;
  final NcaabTeam homeTeamData;
  final BetButtonWin winTeam;

  @override
  List<Object> get props => [
        status,
        text,
        league,
        gameId,
        isClosed,
        winTeam,
        betAmount,
        toWinAmount,
        spread,
        game,
        uniqueId,
        betType,
        uid,
        mainOdds,
        awayTeamData,
        homeTeamData
      ];

  NcaabBetButtonState copyWith({
    BetButtonStatus status,
    String text,
    NcaabGame game,
    String uniqueId,
    Bet betType,
    String mainOdds,
    double spread,
    NcaabTeam awayTeamData,
    String league,
    int gameId,
    String uid,
    bool isClosed,
    int betAmount,
    int toWinAmount,
    NcaabTeam homeTeamData,
    BetButtonWin winTeam,
  }) {
    return NcaabBetButtonState._(
      status: status ?? this.status,
      text: text ?? this.text,
      game: game ?? this.game,
      uniqueId: uniqueId ?? this.uniqueId,
      betType: betType ?? this.betType,
      mainOdds: mainOdds ?? this.mainOdds,
      spread: spread ?? this.spread,
      awayTeamData: awayTeamData ?? this.awayTeamData,
      league: league ?? this.league,
      gameId: gameId ?? this.gameId,
      uid: uid ?? this.uid,
      isClosed: isClosed ?? this.isClosed,
      betAmount: betAmount ?? this.betAmount,
      toWinAmount: toWinAmount ?? this.toWinAmount,
      homeTeamData: homeTeamData ?? this.homeTeamData,
      winTeam: winTeam ?? this.winTeam,
    );
  }
}
