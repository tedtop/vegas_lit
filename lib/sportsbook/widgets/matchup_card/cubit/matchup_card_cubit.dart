import 'package:api_client/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'matchup_card_state.dart';

class MatchupCardCubit extends Cubit<MatchupCardState> {
  MatchupCardCubit() : super(MatchupCardInitial());

  void openMatchupCard({
    @required Game game,
  }) async {
    emit(
      MatchupCardOpened(game: game),
    );
  }
}
