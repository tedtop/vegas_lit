import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../../../../data/models/cricket/cricket.dart';
import '../../../models/cricket_team.dart';

part 'cricket_matchup_card_state.dart';

class CricketMatchupCardCubit extends Cubit<CricketMatchupCardState> {
  CricketMatchupCardCubit() : super(CricketMatchupCardInitial());

  void openCricketMatchupCard({
    required CricketDatum gamec,
    required String gameName,
  }) async {
    final teamData = await getData();
    final homeTeamData =
        teamData.singleWhere((element) => element.title == gamec.homeTeam);
    final awayTeamData = teamData.singleWhere((element) {
      if (homeTeamData.title == gamec.teams![0]) {
        return element.title == gamec.teams![1];
      } else {
        return element.title == gamec.teams![0];
      }
    });

    emit(
      CricketMatchupCardOpened(
        game: gamec,
        awayTeamData: awayTeamData,
        homeTeamData: homeTeamData,
        league: gameName,
      ),
    );
  }

  Future<List<CricketTeam>> getData() async {
    final jsonData = await rootBundle.loadString('assets/json/icc.json');
    final parsedTeamData = await json.decode(jsonData) as List;
    final teamData = parsedTeamData
        .map<CricketTeam>(
          (dynamic json) => CricketTeam.fromMap(
            json as Map<String, dynamic>,
          ),
        )
        .toList();

    return teamData;
  }

// // ignore: missing_return
//   String BetsDataHelper.whichGame({String gameName}) {
//     switch (gameName) {
//       case 'IPL':
//         return 'ipl';
//
//       case 'Test Matches':
//         return 'icc_men';
//
//       default:
//
//     }
//   }
}
