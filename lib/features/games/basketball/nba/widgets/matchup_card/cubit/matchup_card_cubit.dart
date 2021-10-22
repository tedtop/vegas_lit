

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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
          ((Object json) => NbaTeam.fromMap(json as Map<String, dynamic>)) as NbaTeam Function(dynamic),
        )
        .toList();

    return teamData;
  }
}
