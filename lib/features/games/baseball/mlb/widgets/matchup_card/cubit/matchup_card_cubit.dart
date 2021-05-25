import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/features/games/baseball/mlb/models/mlb_team.dart';

part 'matchup_card_state.dart';

class MatchupCardCubit extends Cubit<MatchupCardState> {
  MatchupCardCubit() : super(MatchupCardInitial());

  void openMatchupCard({
    @required Game game,
    @required dynamic parsedTeamData,
    @required String gameName,
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

  List<MlbTeam> getData({@required dynamic parsedTeamData}) {
    final teamData = parsedTeamData
        .map<MlbTeam>(
          (json) => MlbTeam.fromMap(json),
        )
        .toList();

    return teamData;
  }
}
