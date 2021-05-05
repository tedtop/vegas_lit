import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
    final weeks = await _userRepository.fetchLeaderboardWeeks();
    final totalWeek = currentWeek + weeks;

    await userDataValue(totalWeek: totalWeek);
  }

  Future<void> changeWeek({@required String week}) async {
    if (week == 'Current Week') {
      await userDataValue(totalWeek: state.weeks);
    } else {
      emit(
        LeaderboardState.loading(weeks: state.weeks, week: week),
      );
      final userDataList =
          await _userRepository.fetchLeaderboardWeeksUserData(week: week);
      emit(
        LeaderboardState.weekChanged(
          rankedUserList: userDataList,
          weeks: state.weeks,
          week: week,
        ),
      );
    }
  }

  Future<void> userDataValue({List<String> totalWeek}) async {
    final usersStream = _userRepository.fetchRankedUsers();

    await _leaderboardSubscription?.cancel();
    _leaderboardSubscription = usersStream.listen(
      (event) {
        emit(
          LeaderboardState.opened(
            rankedUserList: event,
            weeks: totalWeek,
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
