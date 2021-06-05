import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../data/models/bet.dart';
import '../../../data/repositories/bets_repository.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit({
    @required BetsRepository betsRepository,
  })  : assert(betsRepository != null),
        _betsRepository = betsRepository,
        super(const HistoryState());

  final BetsRepository _betsRepository;
  StreamSubscription _betsSubscription;

  Future<void> fetchAllBets({@required String uid}) async {
    emit(HistoryState(
      status: HistoryStatus.loading,
      bets: state.bets,
    ));
    try {
      final betsStream = _betsRepository.fetchBetHistory(uid: uid);
      await _betsSubscription?.cancel();
      _betsSubscription = betsStream.listen(
        (bets) {
          emit(HistoryState(
            status: HistoryStatus.success,
            bets: bets,
          ));
        },
      );
    } on Exception {
      emit(HistoryState(
        status: HistoryStatus.failure,
        bets: state.bets,
      ));
    }
  }

  @override
  Future<void> close() async {
    await _betsSubscription?.cancel();
    return super.close();
  }
}
