import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/bet_slip/models/bet_slip_card.dart';

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
        betPlacedCount: state.betPlacedCount,
      ),
    );
  }

  void addBetSlip(
      {@required BetSlipCardData betSlipCardData,
      @required String odds}) async {
    final toWinAmountValue =
        toWinAmount(odds: odds, betAmount: betSlipCardData.betAmount);

    final newBetSlip = betSlipCardData.copyWith(toWinAmount: toWinAmountValue);
    final newBetSlipList = List.of(state.betSlipCardData)..add(newBetSlip);
    emit(
      BetSlipState.opened(
        betSlipCardData: newBetSlipList,
        betPlacedCount: state.betPlacedCount,
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

    emit(BetSlipState.opened(
      betSlipCardData: newBetSlipList,
      betPlacedCount: state.betPlacedCount,
    ));
  }

  void betPlaced({
    @required String uniqueId,
    @required int betPlacedCount,
  }) async {
    final newBetSlipList = List.of(state.betSlipCardData)
      ..removeWhere(
        (element) => element.id == uniqueId,
      );
    emit(BetSlipState.opened(
      betSlipCardData: newBetSlipList,
      betPlacedCount: betPlacedCount,
    ));
  }

  void removeBetSlip({@required String uniqueId}) async {
    final newBetSlipList = List.of(state.betSlipCardData)
      ..removeWhere(
        (element) => element.id == uniqueId,
      );
    emit(BetSlipState.opened(
      betSlipCardData: newBetSlipList,
      betPlacedCount: state.betPlacedCount,
    ));
  }

  int toWinAmount({@required String odds, @required int betAmount}) {
    if (int.parse(odds).isNegative) {
      final toWinAmount = (100 / int.parse(odds) * betAmount).round().abs();

      return toWinAmount;
    } else {
      final toWinAmount = (int.parse(odds) / 100 * betAmount).round().abs();

      return toWinAmount;
    }
  }
}
