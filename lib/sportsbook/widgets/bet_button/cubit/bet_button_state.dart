part of 'bet_button_cubit.dart';

enum BetButtonStatus { done, error, loading, clicked, unclicked }

class BetButtonState extends Equatable {
  const BetButtonState._({
    this.text,
    this.game,
    this.uniqueId,
    this.mainOdds,
    this.status = BetButtonStatus.loading,
    this.betType,
    this.awayTeamData,
    this.league,
    this.homeTeamData,
  });

  const BetButtonState.loading() : this._();

  const BetButtonState.clicked(
      {@required String text,
      @required Game game,
      @required String uniqueId,
      @required String league,
      @required Team awayTeamData,
      @required Team homeTeamData,
      @required String mainOdds,
      @required Bet betType})
      : this._(
          status: BetButtonStatus.clicked,
          text: text,
          game: game,
          uniqueId: uniqueId,
          homeTeamData: homeTeamData,
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
            league: league,
            awayTeamData: awayTeamData,
            betType: betType);

  const BetButtonState.done(
      {@required String text,
      @required Game game,
      @required String mainOdds,
      @required Team awayTeamData,
      @required Team homeTeamData,
      @required String league,
      @required String uniqueId,
      @required Bet betType})
      : this._(
          status: BetButtonStatus.done,
          text: text,
          game: game,
          league: league,
          uniqueId: uniqueId,
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
  final Team awayTeamData;
  final String league;
  final Team homeTeamData;

  @override
  List<Object> get props => [
        status,
        text,
        league,
        game,
        uniqueId,
        betType,
        mainOdds,
        awayTeamData,
        homeTeamData
      ];
}
