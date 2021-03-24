import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'bet_slip_state.dart';

class BetSlipCubit extends Cubit<BetSlipState> {
  BetSlipCubit()
      : super(
          const BetSlipState.loading(),
        );

  void openBetSlip({
    @required List<Widget> betSlipGames,
  }) async {
    emit(
      BetSlipState.opened(
        games: betSlipGames,
      ),
    );
  }

  void addBetSlip({@required Widget game}) async {
    emit(
      BetSlipState.opened(
        games: state.games..add(game),
      ),
    );
  }

  void removeBetSlip({@required String uniqueId}) async {
    emit(
      BetSlipState.opened(
        games: state.games
          ..removeWhere(
            (element) => element.key == Key('$uniqueId'),
          ),
      ),
    );
  }
}
