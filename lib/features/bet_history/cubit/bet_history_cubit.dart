import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/models/bet.dart';
import 'package:vegas_lit/data/repositories/bets_repository.dart';

part 'bet_history_state.dart';

class BetHistoryCubit extends Cubit<BetHistoryState> {
  BetHistoryCubit({
    @required BetsRepository betsRepository,
  })  : assert(betsRepository != null),
        _betsRepository = betsRepository,
        super(
          const BetHistoryState.initial(),
        );

  final BetsRepository _betsRepository;
  StreamSubscription _betHistorySubscription;

  Future<void> betHistoryOpen({@required String currentUserId}) async {
    final openBetsListData =
        _betsRepository.fetchBetHistory(uid: currentUserId);
    await _betHistorySubscription?.cancel();
    _betHistorySubscription = openBetsListData.listen(
      (event) {
        emit(
          BetHistoryState.opened(betHistoryListData: event),
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
