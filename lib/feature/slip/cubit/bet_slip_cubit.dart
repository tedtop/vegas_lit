import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/feature/slip/models/bet_slip_card.dart';

part 'bet_slip_state.dart';

class BetSlipCubit extends Cubit<BetSlipState> {
  BetSlipCubit()
      : super(
          const BetSlipState.loading(),
        );

  void openBetSlip({
    @required List<BetSlipCardData> betSlipGames,
  }) async {
    emit(
      BetSlipState.opened(
        betSlipCardData: betSlipGames,
      ),
    );
  }

  void addBetSlip({@required BetSlipCardData betSlipCardData}) async {
    final newBetSlipList = List.of(state.betSlipCardData)..add(betSlipCardData);
    emit(
      BetSlipState.opened(
        betSlipCardData: newBetSlipList,
      ),
    );
  }

  void updateBetAmount({
    @required int betAmount,
    @required String uniqueId,
    @required int toWinAmount,
  }) {
    final newBetSlipList = List.of(state.betSlipCardData).map(
      (item) {
        return item.id == uniqueId
            ? item.copyWith(
                betAmount: betAmount,
                toWinAmount: toWinAmount,
              )
            : item;
      },
    ).toList();

    emit(BetSlipState.opened(betSlipCardData: newBetSlipList));
  }

  void removeBetSlip({@required String uniqueId}) async {
    final newBetSlipList = List.of(state.betSlipCardData)
      ..removeWhere(
        (element) => element.id == uniqueId,
      );
    emit(BetSlipState.opened(betSlipCardData: newBetSlipList));
  }
}
