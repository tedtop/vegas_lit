part of 'leaderboard_cubit.dart';

enum LeaderboardStatus { initial, opened, loading, weekChanged }

class LeaderboardState extends Equatable {
  const LeaderboardState._({
    this.rankedUserList = const [],
    this.status = LeaderboardStatus.initial,
    this.days,
    this.day = 'Today',
  });

  const LeaderboardState.initial() : this._();

  const LeaderboardState.opened({
    @required List<Wallet> rankedUserList,
    @required List<String> days,
  }) : this._(
          rankedUserList: rankedUserList,
          status: LeaderboardStatus.opened,
          days: days,
        );

  const LeaderboardState.weekChanged({
    @required List<Wallet> rankedUserList,
    @required List<String> days,
    @required String day,
  }) : this._(
          rankedUserList: rankedUserList,
          status: LeaderboardStatus.weekChanged,
          days: days,
          day: day,
        );

  const LeaderboardState.loading({
    @required List<String> days,
    @required String day,
  }) : this._(
          status: LeaderboardStatus.loading,
          days: days,
          day: day,
        );

  final List<Wallet> rankedUserList;
  final List<String> days;
  final String day;
  final LeaderboardStatus status;

  @override
  List<Object> get props => [status, rankedUserList, day, days];
}
