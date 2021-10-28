import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/bet.dart';
import '../../../data/repositories/bets_repository.dart';

part 'open_bets_state.dart';

class OpenBetsCubit extends Cubit<OpenBetsState> {
  OpenBetsCubit({
    required BetsRepository betsRepository,
  })  : assert(betsRepository != null),
        _betsRepository = betsRepository,
        super(const OpenBetsState());

  final BetsRepository _betsRepository;
  StreamSubscription? _betsSubscription;

  Future<void> fetchAllBets({required String uid}) async {
    emit(OpenBetsState(
      status: OpenBetsStatus.loading,
      bets: state.bets,
    ));
    try {
      final openBetsData = _betsRepository.fetchOpenBets(uid: uid);
      await _betsSubscription?.cancel();
      _betsSubscription = openBetsData.listen(
        (bets) {
          emit(OpenBetsState(
            status: OpenBetsStatus.success,
            bets: bets,
          ));
        },
      );
    } on Exception {
      emit(OpenBetsState(
        status: OpenBetsStatus.failure,
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
