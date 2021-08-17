import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../../../data/models/ncaaf/ncaaf_game.dart';
import '../../../models/ncaaf_team.dart';

part 'matchup_card_state.dart';

class NcaafMatchupCardCubit extends Cubit<NcaafMatchupCardState> {
  NcaafMatchupCardCubit() : super(MatchupCardInitial());

  void openMatchupCard({
    @required NcaafGame game,
    @required List<NcaafTeam> parsedTeamData,
    @required String gameName,
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
