import 'package:bloc/bloc.dart';

import '../../../../../../../data/models/nhl/nhl_game.dart';
import '../../../models/nhl_team.dart';

part 'matchup_card_state.dart';

class NhlMatchupCardCubit extends Cubit<NhlMatchupCardState> {
  NhlMatchupCardCubit() : super(MatchupCardInitial());

  void openMatchupCard({
    required NhlGame game,
    required List<NhlTeam> teamData,
    required String? gameName,
  }) async {
    final awayTeamData =
        teamData.singleWhere((element) => element.key == game.awayTeam);
    final homeTeamData =
        teamData.singleWhere((element) => element.key == game.homeTeam);

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
