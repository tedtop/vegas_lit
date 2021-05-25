import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/models/bet.dart';
import 'package:vegas_lit/data/repositories/bets_repository.dart';

part 'bet_history_state.dart';

class BetHistoryCubit extends Cubit<BetHistoryState> {
  BetHistoryCubit({@required BetsRepository betsRepository})
      : assert(betsRepository != null),
        _betsRepository = betsRepository,
        super(
          const BetHistoryState.initial(),
        );

  final BetsRepository _betsRepository;
  StreamSubscription _betHistorySubscription;
  DateTime todayDate = DateTime.now();

  Future<void> betHistoryOpen({
    @required String currentUserId,
    DateTime betDateHistory,
  }) async {
    betDateHistory = betDateHistory ?? todayDate;
    final openBetsData = _betsRepository.fetchBetHistory(
        uid: currentUserId, betDateTime: betDateHistory);
    await _betHistorySubscription?.cancel();
    _betHistorySubscription = openBetsData.listen(
      (event) {
        emit(
          BetHistoryState.opened(betHistoryDataList: event),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    await _betHistorySubscription?.cancel();
    return super.close();
  }
}
