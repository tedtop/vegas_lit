import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import '../../../config/extensions.dart';

import '../../../data/models/bet.dart';
import '../../../data/models/wallet.dart';
import '../../../data/repositories/user_repository.dart';

part 'leaderboard_profile_state.dart';

class LeaderboardProfileCubit extends Cubit<LeaderboardProfileState> {
  LeaderboardProfileCubit({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository,
        super(const LeaderboardProfileState());

  final UserRepository _userRepository;
  StreamSubscription _betHistorySubscription;

  Future<void> fetchAllBets(
      {@required String uid, @required String week}) async {
    emit(LeaderboardProfileState(
      status: LeaderboardProfileStatus.loading,
      bets: state.bets,
    ));

    try {
      if (week == 'Current Week') {
        final walletStream = _userRepository.fetchWalletData(uid: uid);
        final betsStream = _userRepository.fetchBetHistoryByWeek(
          uid: uid,
          week: ESTDateTime.fetchTimeEST().weekStringVL,
        );
        await _betHistorySubscription?.cancel();
        _betHistorySubscription = Rx.combineLatest2(
          betsStream,
          walletStream,
          (
            List<BetData> bets,
            Wallet wallet,
          ) {
            emit(LeaderboardProfileState(
              status: LeaderboardProfileStatus.success,
              bets: bets,
              userWallet: wallet,
            ));
          },
        ).listen(
          // ignore: avoid_print
          print,
        );
      } else {
        final wallet =
            await _userRepository.fetchUserWalletByWeek(uid: uid, week: week);
        final bets = await _userRepository
            .fetchBetHistoryByWeek(uid: uid, week: week)
            .first;
        emit(LeaderboardProfileState(
          status: LeaderboardProfileStatus.success,
          bets: bets,
          userWallet: wallet,
        ));
      }
    } on Exception {
      emit(LeaderboardProfileState(
        status: LeaderboardProfileStatus.failure,
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
