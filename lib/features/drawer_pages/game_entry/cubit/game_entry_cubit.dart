import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vegas_lit/config/extensions.dart';
import 'package:vegas_lit/data/models/wallet.dart';
import 'package:vegas_lit/data/repositories/user_repository.dart';

part 'game_entry_state.dart';

class GameEntryCubit extends Cubit<GameEntryState> {
  GameEntryCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const GameEntryState());

  final UserRepository _userRepository;

  Future<void> openGameEntry({required String uid}) async {
    try {
      emit(const GameEntryState(status: GameEntryStatus.loading));
      final walletData = await _userRepository.fetchUserWalletByWeek(
          uid: uid, week: ESTDateTime.fetchTimeEST().previousWeekStringVL);

      emit(
        GameEntryState(
          status: GameEntryStatus.success,
          previousWeekWallet: walletData,
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(
        const GameEntryState(status: GameEntryStatus.failure),
      );
    }
  }
}
