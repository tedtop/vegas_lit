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
  });

  const BetButtonState.loading() : this._();

  const BetButtonState.clicked(
      {@required String text,
      @required Game game,
      @required String uniqueId,
      @required String mainOdds,
      @required Bet betType})
      : this._(
            status: BetButtonStatus.clicked,
            text: text,
            game: game,
            uniqueId: uniqueId,
            mainOdds: mainOdds,
            betType: betType);

  const BetButtonState.unclicked(
      {@required String text,
      @required Game game,
      @required String uniqueId,
      @required String mainOdds,
      @required Bet betType})
      : this._(
            status: BetButtonStatus.unclicked,
            text: text,
            game: game,
            uniqueId: uniqueId,
            mainOdds: mainOdds,
            betType: betType);

  const BetButtonState.done(
      {@required String text,
      @required Game game,
      @required String mainOdds,
      @required String uniqueId,
      @required Bet betType})
      : this._(
          status: BetButtonStatus.done,
          text: text,
          game: game,
          uniqueId: uniqueId,
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

  @override
  List<Object> get props => [status, text, game, uniqueId, betType, mainOdds];
}
