import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
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
    final weeks = await _userRepository.fetchLeaderboardDays();
    weeks.sort((a, b) => b.compareTo(a));
    final totalWeek = currentWeek + weeks;

    await userDataValue(totalWeek: totalWeek);
  }

  Future<void> changeWeek({@required String week}) async {
    if (week == 'Current Week') {
      await userDataValue(totalWeek: state.days);
    } else {
      emit(
        LeaderboardState.loading(days: state.days, day: week),
      );
      final userDataList =
          await _userRepository.fetchLeaderboardDaysUserData(week: week)
            ..sort(
              (b, a) {
                final profitCompare = (a.accountBalance + a.riskedAmount)
                    .compareTo((b.accountBalance + b.riskedAmount));
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
          day: week,
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
            final profitCompare = (a.accountBalance + a.riskedAmount)
                .compareTo((b.accountBalance + b.riskedAmount));
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
