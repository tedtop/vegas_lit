import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bet_history_state.dart';

class BetHistoryCubit extends Cubit<BetHistoryState> {
  BetHistoryCubit() : super(BetHistoryInitial());
}
