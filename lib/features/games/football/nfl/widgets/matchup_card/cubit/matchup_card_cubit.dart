

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../../../data/models/nfl/nfl_game.dart';
import '../../../models/nfl_team.dart';

part 'matchup_card_state.dart';

class NflMatchupCardCubit extends Cubit<NflMatchupCardState> {
  NflMatchupCardCubit() : super(MatchupCardInitial());

  void openMatchupCard({
    required NflGame game,
    required List<NflTeam> parsedTeamData,
    required String? gameName,
  }) async {
    final awayTeamData =
        parsedTeamData.singleWhere((element) => element.key == game.awayTeam);
    final homeTeamData =
        parsedTeamData.singleWhere((element) => element.key == game.homeTeam);

    emit(
      MatchupCardOpened(
        game: game,
        awayTeamData: awayTeamData,
        homeTeamData: homeTeamData,
        league: gameName,
      ),
    );
  }
}
