import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vegas_lit/data/models/wallet.dart';
import 'package:vegas_lit/data/repositories/user_repository.dart';
import '../../../data/models/bet.dart';
import '../../../data/repositories/bets_repository.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit({
    @required BetsRepository betsRepository,
    @required UserRepository userRepository,
  })  : assert(betsRepository != null),
        assert(userRepository != null),
        _betsRepository = betsRepository,
        _userRepository = userRepository,
        super(const HistoryState());

  final BetsRepository _betsRepository;
  final UserRepository _userRepository;
  StreamSubscription _betHistorySubscription;

  Future<void> fetchAllBets({@required String uid}) async {
    emit(HistoryState(
      status: HistoryStatus.loading,
      bets: state.bets,
    ));
    try {
      final walletStream = _userRepository.fetchWalletData(uid: uid);
      final betsStream = _betsRepository.fetchBetHistory(uid: uid);
      await _betHistorySubscription?.cancel();
      _betHistorySubscription = Rx.combineLatest2(
        betsStream,
        walletStream,
        (
          List<BetData> bets,
          Wallet wallet,
        ) {
          emit(HistoryState(
            status: HistoryStatus.success,
            bets: bets,
            userWallet: wallet,
          ));
        },
      ).listen(
        // ignore: avoid_print
        print,
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
    await _betHistorySubscription?.cancel();
    return super.close();
  }
}
