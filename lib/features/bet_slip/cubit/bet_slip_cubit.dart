

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/models/bet.dart';

part 'bet_slip_state.dart';

class BetSlipCubit extends Cubit<BetSlipState> {
  BetSlipCubit()
      : super(
          const BetSlipState.loading(),
        );

  void openBetSlip({
    required List<Widget> singleBetSlipGames,
    required List<Widget> parlayBetSlipGames,
    required List<BetData> betDataList,
  }) async {
    emit(
      BetSlipState.opened(
        singleBetSlipCard: singleBetSlipGames,
        parlayBetSlipCard: parlayBetSlipGames,
        betDataList: betDataList,
      ),
    );
  }

  void addBetSlip({
    required Widget singleBetSlipCard,
    required Widget parlayBetSlipCard,
    required BetData betData,
  }) async {
    final newSingleBetSlipList = List.of(state.singleBetSlipCard!)
      ..add(singleBetSlipCard);
    final newParlayBetSlipList = List.of(state.parlayBetSlipCard!)
      ..add(parlayBetSlipCard);
    final newBetDataList = List.of(state.betDataList!)..add(betData);
    emit(
      BetSlipState.opened(
        singleBetSlipCard: newSingleBetSlipList,
        parlayBetSlipCard: newParlayBetSlipList,
        betDataList: newBetDataList,
      ),
    );
  }

  void removeBetSlip({
    required String? betSlipDataId,
  }) async {
    final newSingleBetSlipList = List.of(state.singleBetSlipCard!)
      ..removeWhere((element) => element.key == Key(betSlipDataId!));
    final newParlayBetSlipList = List.of(state.parlayBetSlipCard!)
      ..removeWhere((element) => element.key == Key(betSlipDataId!));
    final newBetDataList = List.of(state.betDataList!)
      ..removeWhere((element) => element.id == betSlipDataId);
    emit(
      BetSlipState.opened(
        singleBetSlipCard: newSingleBetSlipList,
        parlayBetSlipCard: newParlayBetSlipList,
        betDataList: newBetDataList,
      ),
    );
  }
}
