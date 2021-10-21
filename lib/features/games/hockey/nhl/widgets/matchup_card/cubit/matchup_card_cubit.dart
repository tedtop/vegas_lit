import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../../../data/models/nhl/nhl_game.dart';
import '../../../models/nhl_team.dart';

part 'matchup_card_state.dart';

class NhlMatchupCardCubit extends Cubit<NhlMatchupCardState> {
  NhlMatchupCardCubit() : super(MatchupCardInitial());

  void openMatchupCard({
    @required NhlGame game,
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

  List<NhlTeam> getData({@required dynamic parsedTeamData}) {
    final List<NhlTeam> teamData = parsedTeamData
        .map<NhlTeam>(
          (json) => NhlTeam.fromMap(json),
        )
        .toList();

    return teamData;
  }
}
