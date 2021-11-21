import 'package:bloc/bloc.dart';

import '../../../../../../../data/models/mlb/mlb_game.dart';
import '../../../models/mlb_team.dart';

part 'matchup_card_state.dart';

class MlbMatchupCardCubit extends Cubit<MlbMatchupCardState> {
  MlbMatchupCardCubit() : super(MatchupCardInitial());

  Future<void> openMatchupCard({
    required MlbGame game,
    required List<MlbTeam> teamData,
    required String? gameName,
  }) async {
    final awayTeamData =
        teamData.singleWhere((element) => element.key == game.awayTeam);
    final homeTeamData =
        teamData.singleWhere((element) => element.key == game.homeTeam);

    // MlbTeam awayTeamData;
    // MlbTeam homeTeamData;
    // await Future.wait(
    //   teamData.map(
    //     (e) async {
    //       if (e.key == game.homeTeam) {
    //         homeTeamData = e;
    //       } else if (e.key == game.awayTeam) {
    //         awayTeamData = e;
    //       }
    //     },
    //   ),
    // );

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
