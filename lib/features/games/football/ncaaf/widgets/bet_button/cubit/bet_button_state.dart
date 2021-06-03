part of 'bet_button_cubit.dart';

enum BetButtonStatus { done, error, loading, clicked, unclicked, placed }

enum BetButtonWin { away, home }

class NcaafBetButtonState extends Equatable {
  const NcaafBetButtonState._({
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

  const NcaafBetButtonState.loading() : this._();

  const NcaafBetButtonState.clicked(
      {@required String text,
      @required NcaafGame game,
      @required String uniqueId,
      @required String league,
      @required double spread,
      @required NcaafTeam awayTeamData,
      @required NcaafTeam homeTeamData,
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

  const NcaafBetButtonState.unclicked(
      {@required String text,
      @required NcaafGame game,
      @required String uniqueId,
      @required String mainOdds,
      @required bool isClosed,
      @required int gameId,
      @required double spread,
      @required BetButtonWin winTeam,
      @required int betAmount,
      @required int toWinAmount,
      @required String uid,
      @required NcaafTeam awayTeamData,
      @required String league,
      @required NcaafTeam homeTeamData,
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

  const NcaafBetButtonState.done({
    @required String text,
    @required NcaafGame game,
    @required String mainOdds,
    @required NcaafTeam awayTeamData,
    @required bool isClosed,
    @required int gameId,
    @required NcaafTeam homeTeamData,
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

  const NcaafBetButtonState.placed({
    @required String text,
    @required NcaafGame game,
    @required String mainOdds,
    @required NcaafTeam awayTeamData,
    @required bool isClosed,
    @required int gameId,
    @required NcaafTeam homeTeamData,
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
  final NcaafGame game;
  final String uniqueId;
  final Bet betType;
  final String mainOdds;
  final double spread;
  final NcaafTeam awayTeamData;
  final String league;
  final int gameId;
  final String uid;
  final bool isClosed;
  final int betAmount;
  final int toWinAmount;
  final NcaafTeam homeTeamData;
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

  NcaafBetButtonState copyWith({
    BetButtonStatus status,
    String text,
    NcaafGame game,
    String uniqueId,
    Bet betType,
    String mainOdds,
    double spread,
    NcaafTeam awayTeamData,
    String league,
    int gameId,
    String uid,
    bool isClosed,
    int betAmount,
    int toWinAmount,
    NcaafTeam homeTeamData,
    BetButtonWin winTeam,
  }) {
    return NcaafBetButtonState._(
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
