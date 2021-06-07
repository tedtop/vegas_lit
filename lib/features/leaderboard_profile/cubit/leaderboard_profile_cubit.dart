import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vegas_lit/data/models/wallet.dart';
import 'package:vegas_lit/data/repositories/user_repository.dart';

import '../../../data/models/bet.dart';
import '../../../data/repositories/bets_repository.dart';

part 'leaderboard_profile_state.dart';

class LeaderboardProfileCubit extends Cubit<LeaderboardProfileState> {
  LeaderboardProfileCubit({
    @required BetsRepository betsRepository,
    @required UserRepository userRepository,
  })  : assert(betsRepository != null),
        assert(userRepository != null),
        _betsRepository = betsRepository,
        _userRepository = userRepository,
        super(const LeaderboardProfileState());

  final BetsRepository _betsRepository;
  final UserRepository _userRepository;
  StreamSubscription _betHistorySubscription;

  Future<void> fetchAllBets({@required String uid}) async {
    emit(LeaderboardProfileState(
      status: LeaderboardProfileStatus.loading,
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
