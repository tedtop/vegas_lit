part of 'leaderboard_cubit.dart';

enum LeaderboardStatus { initial, opened, loading, weekChanged }

class LeaderboardState extends Equatable {
  const LeaderboardState._({
    this.rankedUserList = const [],
    this.status = LeaderboardStatus.initial,
    this.weeks,
    this.week = 'Current Week',
  });

  const LeaderboardState.initial() : this._();

  const LeaderboardState.opened({
    @required List<Purse> rankedUserList,
    @required List<String> weeks,
  }) : this._(
          rankedUserList: rankedUserList,
          status: LeaderboardStatus.opened,
          weeks: weeks,
        );

  const LeaderboardState.weekChanged({
    @required List<Purse> rankedUserList,
    @required List<String> weeks,
    @required String week,
  }) : this._(
          rankedUserList: rankedUserList,
          status: LeaderboardStatus.weekChanged,
          weeks: weeks,
          week: week,
        );

  const LeaderboardState.loading({
    @required List<String> weeks,
    @required String week,
  }) : this._(
          status: LeaderboardStatus.loading,
          weeks: weeks,
          week: week,
        );

  final List<Purse> rankedUserList;
  final List<String> weeks;
  final String week;
  final LeaderboardStatus status;

  @override
  List<Object> get props => [status, rankedUserList, week, weeks];
}
