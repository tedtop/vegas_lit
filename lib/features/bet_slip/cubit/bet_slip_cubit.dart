import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
        betSlipCard: betSlipGames,
      ),
    );
  }

  void addBetSlip({@required Widget betSlipCard}) async {
    final newBetSlipList = List.of(state.betSlipCard)..add(betSlipCard);
    emit(
      BetSlipState.opened(
        betSlipCard: newBetSlipList,
      ),
    );
  }

  void removeBetSlip({@required String uniqueId}) async {
    final newBetSlipList = List.of(state.betSlipCard)
      ..removeWhere((element) => element.key == Key(uniqueId));
    emit(
      BetSlipState.opened(
        betSlipCard: newBetSlipList,
      ),
    );
  }
}
