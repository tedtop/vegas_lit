

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../../../data/models/ncaab/ncaab_game.dart';
import '../../../models/ncaab_team.dart';

part 'matchup_card_state.dart';

class NcaabMatchupCardCubit extends Cubit<NcaabMatchupCardState> {
  NcaabMatchupCardCubit() : super(MatchupCardInitial());

  void openMatchupCard({
    required NcaabGame game,
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

  List<NcaabTeam> getData({required List parsedTeamData}) {
    final teamData = parsedTeamData
        .map<NcaabTeam>(
          ((Object json) => NcaabTeam.fromMap(json as Map<String, Object>)) as NcaabTeam Function(dynamic),
        )
        .toList();

    return teamData;
  }
}
