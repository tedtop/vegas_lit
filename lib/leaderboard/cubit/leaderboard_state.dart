part of 'leaderboard_cubit.dart';

enum LeaderboardStatus { initial, opened }

class LeaderboardState extends Equatable {
  const LeaderboardState._({
    this.rankedUserList = const [],
    this.status = LeaderboardStatus.initial,
  });

  const LeaderboardState.initial() : this._();

  const LeaderboardState.opened({
    @required List<UserData> rankedUserList,
  }) : this._(
          rankedUserList: rankedUserList,
          status: LeaderboardStatus.opened,
        );

  final List<UserData> rankedUserList;
  final LeaderboardStatus status;

  @override
  List<Object> get props => [status, rankedUserList];
}
