import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vegas_lit/config/extensions.dart';

import '../../../data/models/bet.dart';
import '../../../data/models/wallet.dart';
import '../../../data/repositories/bets_repository.dart';
import '../../../data/repositories/user_repository.dart';

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
    final currentWeek = <String>['Current Week'];
    emit(HistoryState(
      status: HistoryStatus.loading,
      bets: state.bets,
      uid: uid,
    ));
    try {
      final walletStream = _userRepository.fetchWalletData(uid: uid);
      // final betsStream = _betsRepository.fetchBetHistory(uid: uid);
      final betDataList = await _userRepository.fetchBetHistoryByWeek(
          week: ESTDateTime.weekStringVL, uid: state.uid);
      final weeksStream = _userRepository.fetchLeaderboardWeeks();
      await _betHistorySubscription?.cancel();
      _betHistorySubscription = Rx.combineLatest2(
        walletStream,
        weeksStream,
        (
          Wallet wallet,
          List<String> weeks,
        ) {
          weeks.sort((a, b) => b.compareTo(a));
          final totalWeeks = currentWeek + weeks;
          emit(HistoryState(
            status: HistoryStatus.success,
            bets: betDataList,
            userWallet: wallet,
            weeks: totalWeeks,
            uid: uid,
          ));
        },
      ).listen(
        // ignore: avoid_print
        print,
      );
    } on Exception {
      emit(HistoryState(
        uid: state.uid,
        status: HistoryStatus.failure,
        bets: state.bets,
      ));
    }
  }

  Future<void> changeWeek({@required String week}) async {
    if (week == 'Current Week') {
      await fetchAllBets(uid: state.uid);
    } else {
      emit(
        HistoryState(
          uid: state.uid,
          status: HistoryStatus.loading,
          weeks: state.weeks,
          week: week,
          userWallet: state.userWallet,
        ),
      );
      final betDataList = await _userRepository.fetchBetHistoryByWeek(
          week: week, uid: state.uid);
      emit(HistoryState(
        status: HistoryStatus.success,
        bets: betDataList,
        week: week,
        userWallet: state.userWallet,
        weeks: state.weeks,
        uid: state.uid,
      ));
    }
  }

  @override
  Future<void> close() async {
    await _betHistorySubscription?.cancel();
    return super.close();
  }
}
