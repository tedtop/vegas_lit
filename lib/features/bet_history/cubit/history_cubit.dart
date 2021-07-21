import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vegas_lit/config/extensions.dart';

import '../../../data/models/bet.dart';
import '../../../data/models/wallet.dart';
import '../../../data/repositories/user_repository.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository,
        super(const HistoryState());

  final UserRepository _userRepository;
  StreamSubscription _betHistorySubscription;

  Future<void> fetchAllBets({@required String uid}) async {
    final currentWeek = <String>['Current Week'];
    emit(
      HistoryState(
        status: HistoryStatus.loading,
        bets: state.bets,
        uid: uid,
      ),
    );
    try {
      final walletStream = _userRepository.fetchWalletData(uid: uid);
      final betListStream = _userRepository.fetchBetHistoryByWeek(
          week: ESTDateTime.weekStringVL, uid: state.uid);
      final weeksStream = _userRepository.fetchLeaderboardWeeks();
      await _betHistorySubscription?.cancel();
      _betHistorySubscription = Rx.combineLatest3(
        walletStream,
        weeksStream,
        betListStream,
        (
          Wallet wallet,
          List<String> weeks,
          List<BetData> betList,
        ) {
          weeks.sort((a, b) => b.compareTo(a));
          final totalWeeks = currentWeek + weeks;
          emit(
            HistoryState(
              status: HistoryStatus.success,
              bets: betList,
              userWallet: wallet,
              weeks: totalWeeks,
              uid: uid,
            ),
          );
        },
      ).listen(
        // ignore: avoid_print
        print,
      );
    } on Exception {
      emit(
        HistoryState(
          uid: state.uid,
          status: HistoryStatus.failure,
          bets: state.bets,
          weeks: state.weeks,
          week: state.week,
        ),
      );
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
      final isUserWalletExist = await _userRepository.isUserWalletExistByWeek(
          uid: state.uid, week: week);
      if (isUserWalletExist) {
        final walletData = await _userRepository.fetchUserWalletByWeek(
            uid: state.uid, week: state.week);
        final betDataList = await _userRepository
            .fetchBetHistoryByWeek(week: week, uid: state.uid)
            .first;
        await _betHistorySubscription?.cancel();
        emit(HistoryState(
          status: HistoryStatus.success,
          bets: betDataList,
          week: week,
          userWallet: walletData,
          weeks: state.weeks,
          uid: state.uid,
        ));
      } else {
        emit(HistoryState(
          uid: state.uid,
          status: HistoryStatus.empty,
          bets: state.bets,
          weeks: state.weeks,
          week: week,
        ));
      }
    }
  }

  @override
  Future<void> close() async {
    await _betHistorySubscription?.cancel();
    return super.close();
  }
}
