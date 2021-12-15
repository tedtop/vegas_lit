part of 'game_entry_cubit.dart';

enum GameEntryStatus { initial, loading, success, failure }

class GameEntryState {
  const GameEntryState({
    this.status = GameEntryStatus.initial,
    this.previousWeekWallet,
  });

  final Wallet? previousWeekWallet;
  final GameEntryStatus status;
}
