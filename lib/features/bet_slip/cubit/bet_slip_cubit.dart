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
    @required List<Widget> singleBetSlipGames,
    @required List<Widget> parlayBetSlipGames,
  }) async {
    emit(
      BetSlipState.opened(
        singleBetSlipCard: singleBetSlipGames,
        parlayBetSlipCard: parlayBetSlipGames,
      ),
    );
  }

  void addBetSlip({
    @required Widget singleBetSlipCard,
    @required Widget parlayBetSlipCard,
  }) async {
    final newSingleBetSlipList = List.of(state.singleBetSlipCard)
      ..add(singleBetSlipCard);
    final newParlayBetSlipList = List.of(state.parlayBetSlipCard)
      ..add(parlayBetSlipCard);
    emit(
      BetSlipState.opened(
        singleBetSlipCard: newSingleBetSlipList,
        parlayBetSlipCard: newParlayBetSlipList,
      ),
    );
  }

  void removeBetSlip({
    @required String singleBetSlipId,
    @required String parlayBetSlipId,
  }) async {
    final newSingleBetSlipList = List.of(state.singleBetSlipCard)
      ..removeWhere((element) => element.key == Key(singleBetSlipId));
    final newParlayBetSlipList = List.of(state.parlayBetSlipCard)
      ..removeWhere((element) => element.key == Key(parlayBetSlipId));
    emit(
      BetSlipState.opened(
        singleBetSlipCard: newSingleBetSlipList,
        parlayBetSlipCard: newParlayBetSlipList,
      ),
    );
  }
}
