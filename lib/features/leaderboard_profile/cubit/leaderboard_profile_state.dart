part of 'leaderboard_profile_cubit.dart';

enum LeaderboardProfileStatus { initial, loading, success, failure }

class LeaderboardProfileState extends Equatable {
  const LeaderboardProfileState({
    this.status = LeaderboardProfileStatus.initial,
    this.bets = const [],
    this.userWallet,
  });

  final LeaderboardProfileStatus status;
  final List<BetData> bets;
  final Wallet userWallet;

  @override
  List<Object> get props => [status, bets, userWallet];
}
