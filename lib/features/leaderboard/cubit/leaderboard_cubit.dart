import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/models/wallet.dart';
import 'package:vegas_lit/data/repositories/user_repository.dart';

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
    final currentWeek = <String>['Today'];
    final weeks = await _userRepository.fetchLeaderboardDays();
    weeks.sort((a, b) => b.compareTo(a));
    final totalWeek = currentWeek + weeks;

    await userDataValue(totalWeek: totalWeek);
  }

  Future<void> changeWeek({@required String day}) async {
    if (day == 'Today') {
      await userDataValue(totalWeek: state.days);
    } else {
      emit(
        LeaderboardState.loading(days: state.days, day: day),
      );
      final userDataList = await _userRepository.fetchLeaderboardDaysUserData(
          day: day)
        ..sort(
          (b, a) {
            final profitCompare = (a.totalProfit).compareTo((b.totalProfit));
            if (profitCompare == 0) {
              return (a.totalBets).compareTo((b.totalBets));
            }
            return profitCompare;
          },
        );
      emit(
        LeaderboardState.weekChanged(
          rankedUserList: userDataList,
          days: state.days,
          day: day,
        ),
      );
    }
  }

  Future<void> userDataValue({List<String> totalWeek}) async {
    final usersStream = _userRepository.fetchRankedUsers();

    await _leaderboardSubscription?.cancel();
    _leaderboardSubscription = usersStream.listen(
      (event) {
        event.sort(
          (b, a) {
            final profitCompare = (a.totalProfit).compareTo((b.totalProfit));
            if (profitCompare == 0) {
              return (a.totalBets).compareTo((b.totalBets));
            }
            return profitCompare;
          },
        );

        emit(
          LeaderboardState.opened(
            rankedUserList: event,
            days: totalWeek,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    await _leaderboardSubscription?.cancel();
    return super.close();
  }
}