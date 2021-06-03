import 'package:meta/meta.dart';
import 'package:vegas_lit/data/dataproviders/sportsdata_api.dart';
import 'package:vegas_lit/data/models/golf.dart';
import 'package:vegas_lit/data/models/mlb/mlb_game.dart';
import 'package:vegas_lit/data/models/mlb/mlb_player.dart';
import 'package:vegas_lit/data/models/nba/nba_game.dart';
import 'package:vegas_lit/data/models/nba/nba_player.dart';
import 'package:vegas_lit/data/models/ncaab/ncaab_game.dart';
import 'package:vegas_lit/data/models/ncaab/ncaab_player.dart';
import 'package:vegas_lit/data/models/ncaaf/ncaaf_game.dart';
import 'package:vegas_lit/data/models/ncaaf/ncaaf_player.dart';
import 'package:vegas_lit/data/models/nfl/nfl_game.dart';
import 'package:vegas_lit/data/models/nfl/nfl_player.dart';
import 'package:vegas_lit/data/models/nhl/nhl_game.dart';
import 'package:vegas_lit/data/models/nhl/nhl_player.dart';

class SportsRepository {
  final _sportsProvider = SportsAPI();

  // MLB
  Future<List<MlbGame>> fetchMLB({@required DateTime dateTime}) =>
      _sportsProvider.fetchMLB(dateTime: dateTime);

  Future<List<MlbPlayer>> fetchMLBPlayers({@required String teamKey}) =>
      _sportsProvider.fetchMLBPlayers(teamKey: teamKey);

  // NBA
  Future<List<NbaGame>> fetchNBA({@required DateTime dateTime}) =>
      _sportsProvider.fetchNBA(dateTime: dateTime);

  Future<List<NbaPlayer>> fetchNBAPlayers({@required String teamKey}) =>
      _sportsProvider.fetchNBAPlayers(teamKey: teamKey);

  // NCAAB
  Future<List<NcaabGame>> fetchNCAAB({@required DateTime dateTime}) =>
      _sportsProvider.fetchNCAAB(dateTime: dateTime);

  Future<List<NcaabPlayer>> fetchNCAABPlayers({@required String teamKey}) =>
      _sportsProvider.fetchNCAABPlayers(teamKey: teamKey);

  // NCAAF
  Future<List<NcaafGame>> fetchNCAAF({@required DateTime dateTime}) =>
      _sportsProvider.fetchNCAAF(dateTime: dateTime);

  Future<List<NcaafPlayer>> fetchNCAAFPlayers({@required String teamKey}) =>
      _sportsProvider.fetchNCAAFPlayers(teamKey: teamKey);

  // NFL
  Future<List<NflGame>> fetchNFL({@required DateTime dateTime}) =>
      _sportsProvider.fetchNFL(dateTime: dateTime);

  Future<List<NflPlayer>> fetchNFLPlayers({@required String teamKey}) =>
      _sportsProvider.fetchNFLPlayers(teamKey: teamKey);

  // NHL
  Future<List<NhlGame>> fetchNHL({@required DateTime dateTime}) =>
      _sportsProvider.fetchNHL(dateTime: dateTime);

  Future<List<NhlPlayer>> fetchNHLPlayers({@required String teamKey}) =>
      _sportsProvider.fetchNHLPlayers(teamKey: teamKey);

  // Future<List<CricketDatum>> fetchCricketGames(
  //         {String gameName, DateTime dateTime}) =>
  //     _sportsProvider.fetchCricketGame(dateTimeEastern: dateTime);

  // GOLF
  Future<List<GolfTournament>> fetchGolfTournaments({
    @required DateTime dateTimeEastern,
  }) =>
      _sportsProvider.fetchGolfTournaments(dateTimeEastern: dateTimeEastern);

  Future<GolfLeaderboard> fetchGolfLeaderboard({@required int tournamentID}) =>
      _sportsProvider.fetchGolfLeaderboard(tournamentID: tournamentID);
}
