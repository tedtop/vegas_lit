part of 'bet_button_cubit.dart';

enum BetButtonStatus { done, error, loading, clicked, unclicked, placed }

enum BetButtonWin { away, home }

class NbaBetButtonState extends Equatable {
  const NbaBetButtonState._({
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
    this.uid,
    this.league,
    this.homeTeamData,
    this.winTeam,
  });

  const NbaBetButtonState.loading() : this._();

  const NbaBetButtonState.clicked(
      {@required String text,
      @required Game game,
      @required String uniqueId,
      @required String league,
      @required double spread,
      @required NbaTeam awayTeamData,
      @required NbaTeam homeTeamData,
      @required bool isClosed,
      @required int gameId,
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
          spread: spread,
          awayTeamData: awayTeamData,
          mainOdds: mainOdds,
          league: league,
          betType: betType,
        );

  const NbaBetButtonState.unclicked(
      {@required String text,
      @required Game game,
      @required String uniqueId,
      @required String mainOdds,
      @required bool isClosed,
      @required int gameId,
      @required double spread,
      @required BetButtonWin winTeam,
      @required String uid,
      @required NbaTeam awayTeamData,
      @required String league,
      @required NbaTeam homeTeamData,
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
            league: league,
            gameId: gameId,
            winTeam: winTeam,
            isClosed: isClosed,
            awayTeamData: awayTeamData,
            betType: betType);

  const NbaBetButtonState.done({
    @required String text,
    @required Game game,
    @required String mainOdds,
    @required NbaTeam awayTeamData,
    @required bool isClosed,
    @required int gameId,
    @required NbaTeam homeTeamData,
    @required double spread,
    @required String league,
    @required String uid,
    @required BetButtonWin winTeam,
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
          spread: spread,
          isClosed: isClosed,
          uid: uid,
          homeTeamData: homeTeamData,
          awayTeamData: awayTeamData,
          mainOdds: mainOdds,
          betType: betType,
        );

  const NbaBetButtonState.placed({
    @required String text,
    @required Game game,
    @required String mainOdds,
    @required NbaTeam awayTeamData,
    @required bool isClosed,
    @required int gameId,
    @required NbaTeam homeTeamData,
    @required String uid,
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
          isClosed: isClosed,
          uid: uid,
          homeTeamData: homeTeamData,
          awayTeamData: awayTeamData,
          mainOdds: mainOdds,
          betType: betType,
        );

  final BetButtonStatus status;
  final String text;
  final Game game;
  final String uniqueId;
  final Bet betType;
  final String mainOdds;
  final double spread;
  final NbaTeam awayTeamData;
  final String league;
  final int gameId;
  final String uid;
  final bool isClosed;
  final NbaTeam homeTeamData;
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
        uid,
        mainOdds,
        awayTeamData,
        homeTeamData
      ];
}
