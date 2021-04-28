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
    final usersStream = _userRepository.fetchRankedUsers();
    await _leaderboardSubscription?.cancel();
    _leaderboardSubscription = usersStream.listen(
      (event) {
        emit(
          LeaderboardState.opened(
            rankedUserList: event,
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
