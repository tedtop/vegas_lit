import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegas_lit/data/models/wallet.dart';
import 'package:vegas_lit/data/repositories/user_repository.dart';

part 'group_details_state.dart';

class GroupDetailsCubit extends Cubit<GroupDetailsState> {
  GroupDetailsCubit({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(GroupDetailsState());

  final UserRepository _userRepository;

  void fetchLeaderboardForGroup({@required String groupId}) async {
    emit(GroupDetailsState(status: GroupDetailsStatus.loading));

    //Logic for getting leaderboard

    emit(GroupDetailsState(status: GroupDetailsStatus.complete, players: [
      Wallet(
          uid: 'thisisuid',
          username: 'username1',
          totalProfit: 8500,
          totalLoss: 2599,
          accountBalance: 2356,
          totalBets: 10,
          totalBetsWon: 186,
          totalRewards: 850,
          totalBetsLost: 5,
          totalOpenBets: 14,
          potentialWinAmount: 5900,
          pendingRiskedAmount: 9000,
          rank: 2,
          biggestWinAmount: 2000,
          totalRiskedAmount: 6800,
          avatarUrl: null,
          todayRewards: 500)
    ]));
  }
}
