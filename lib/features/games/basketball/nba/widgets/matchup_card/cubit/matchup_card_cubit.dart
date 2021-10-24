import 'package:bloc/bloc.dart';

import '../../../../../../../data/models/nba/nba_game.dart';
import '../../../models/nba_team.dart';

part 'matchup_card_state.dart';

class NbaMatchupCardCubit extends Cubit<NbaMatchupCardState> {
  NbaMatchupCardCubit() : super(MatchupCardInitial());

  void openMatchupCard({
    required NbaGame game,
    required List parsedTeamData,
    required String? gameName,
  }) async {
    final teamData = getData(parsedTeamData: parsedTeamData);
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

  List<NbaTeam> getData({required List parsedTeamData}) {
    final teamData = parsedTeamData
        .map<NbaTeam>(
          (dynamic json) => NbaTeam.fromMap(json as Map<String, dynamic>),
        )
        .toList();

    return teamData;
  }
}
