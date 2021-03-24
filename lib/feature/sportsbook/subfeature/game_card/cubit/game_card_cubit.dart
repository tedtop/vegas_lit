import 'package:api_client/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'game_card_state.dart';

class GameCardCubit extends Cubit<GameCardState> {
  GameCardCubit() : super(GameCardInitial());

  void openGameCard({
    @required Game game,
  }) async {
    emit(
      GameCardOpened(game: game),
    );
  }
}
