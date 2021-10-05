import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/models/wallet.dart';
import '../../../data/repositories/user_repository.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  LeaderboardCubit({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(
          const LeaderboardState.initial(),
        );

  final UserRepository _userRepository;
  StreamSubscription _leaderboardSubscription;

  Future<void> openLeaderboard() async {
    final currentWeek = <String>['Current Week'];
    final weeksStream = _userRepository.fetchLeaderboardWeeks();
    final usersStream = _userRepository.fetchRankedUsers();
    await _leaderboardSubscription?.cancel();
    _leaderboardSubscription = Rx.combineLatest2(
      weeksStream,
      usersStream,
      (List<String> weeks, List<Wallet> users) {
        weeks.sort((a, b) => b.compareTo(a));
        final totalWeek = currentWeek + weeks;
        users.sort(
          (a, b) => (a.rank).compareTo(b.rank),
        );
        emit(
          LeaderboardState.opened(
            rankedUserList: users,
            days: totalWeek,
          ),
        );
      },
    ).listen(
      print,
    );
  }

  Future<void> changeWeek({@required String week}) async {
    if (week == 'Current Week') {
      await openLeaderboard();
    } else {
      emit(
        LeaderboardState.loading(days: state.days, day: week),
      );
      final userDataList =
          await _userRepository.fetchLeaderboardDaysUserData(week: week)
            ..sort(
              (a, b) => (a.rank).compareTo(b.rank),
            );
      emit(
        LeaderboardState.weekChanged(
          rankedUserList: userDataList,
          days: state.days,
          day: week,
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    await _leaderboardSubscription?.cancel();
    return super.close();
  }
}
