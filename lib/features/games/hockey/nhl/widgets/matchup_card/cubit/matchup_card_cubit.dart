

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../../../data/models/nhl/nhl_game.dart';
import '../../../models/nhl_team.dart';

part 'matchup_card_state.dart';

class NhlMatchupCardCubit extends Cubit<NhlMatchupCardState> {
  NhlMatchupCardCubit() : super(MatchupCardInitial());

  void openMatchupCard({
    required NhlGame game,
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

  List<NhlTeam> getData({required List parsedTeamData}) {
    final teamData = parsedTeamData
        .map<NhlTeam>(
          ((Object json) => NhlTeam.fromMap(json as Map<String, dynamic>)) as NhlTeam Function(dynamic),
        )
        .toList();

    return teamData;
  }
}
