part of 'bet_button_cubit.dart';

enum BetButtonStatus { done, error, loading, clicked, unclicked }

enum BetButtonWin { away, home }

class BetButtonState extends Equatable {
  const BetButtonState._({
    this.text,
    this.game,
    this.uniqueId,
    this.mainOdds,
    this.status = BetButtonStatus.loading,
    this.betType,
    this.isClosed,
    this.gameId,
    this.awayTeamData,
    this.spread,
    this.league,
    this.homeTeamData,
    this.winTeam,
  });

  const BetButtonState.loading() : this._();

  const BetButtonState.clicked(
      {@required String text,
      @required Game game,
      @required String uniqueId,
      @required String league,
      @required int spread,
      @required Team awayTeamData,
      @required Team homeTeamData,
      @required bool isClosed,
      @required int gameId,
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
          spread: spread,
          awayTeamData: awayTeamData,
          mainOdds: mainOdds,
          league: league,
          betType: betType,
        );

  const BetButtonState.unclicked(
      {@required String text,
      @required Game game,
      @required String uniqueId,
      @required String mainOdds,
      @required bool isClosed,
      @required int gameId,
      @required int spread,
      @required BetButtonWin winTeam,
      @required Team awayTeamData,
      @required String league,
      @required Team homeTeamData,
      @required Bet betType})
      : this._(
            status: BetButtonStatus.unclicked,
            text: text,
            game: game,
            uniqueId: uniqueId,
            mainOdds: mainOdds,
            homeTeamData: homeTeamData,
            spread: spread,
            league: league,
            gameId: gameId,
            winTeam: winTeam,
            isClosed: isClosed,
            awayTeamData: awayTeamData,
            betType: betType);

  const BetButtonState.done(
      {@required String text,
      @required Game game,
      @required String mainOdds,
      @required Team awayTeamData,
      @required bool isClosed,
      @required int gameId,
      @required Team homeTeamData,
      @required int spread,
      @required String league,
      @required BetButtonWin winTeam,
      @required String uniqueId,
      @required Bet betType})
      : this._(
          status: BetButtonStatus.done,
          text: text,
          game: game,
          league: league,
          uniqueId: uniqueId,
          winTeam: winTeam,
          gameId: gameId,
          spread: spread,
          isClosed: isClosed,
          homeTeamData: homeTeamData,
          awayTeamData: awayTeamData,
          mainOdds: mainOdds,
          betType: betType,
        );

  // const BetButtonState.error() : this._(status: BetButtonStatus.error);

  final BetButtonStatus status;
  final String text;
  final Game game;
  final String uniqueId;
  final Bet betType;
  final String mainOdds;
  final int spread;
  final Team awayTeamData;
  final String league;
  final int gameId;
  final bool isClosed;
  final Team homeTeamData;
  final BetButtonWin winTeam;

  @override
  List<Object> get props => [
        status,
        text,
        league,
        gameId,
        isClosed,
        winTeam,
        spread,
        game,
        uniqueId,
        betType,
        mainOdds,
        awayTeamData,
        homeTeamData
      ];
}
