import 'package:meta/meta.dart';

import '../models/golf/golf.dart';
import '../models/mlb/mlb_game.dart';
import '../models/mlb/mlb_player.dart';
import '../models/mlb/mlb_player_stats.dart';
import '../models/mlb/mlb_team_stats.dart';
import '../models/nba/nba_game.dart';
import '../models/nba/nba_player.dart';
import '../models/nba/nba_player_stats.dart';
import '../models/nba/nba_team_stats.dart';
import '../models/ncaab/ncaab_game.dart';
import '../models/ncaab/ncaab_player.dart';
import '../models/ncaab/ncaab_player_stats.dart';
import '../models/ncaab/ncaab_team_stats.dart';
import '../models/ncaaf/ncaaf_game.dart';
import '../models/ncaaf/ncaaf_player.dart';
import '../models/ncaaf/ncaaf_player_stats.dart';
import '../models/ncaaf/ncaaf_team_stats.dart';
import '../models/nfl/nfl_game.dart';
import '../models/nfl/nfl_player.dart';
import '../models/nfl/nfl_player_stats.dart';
import '../models/nfl/nfl_team_stats.dart';
import '../models/nhl/nfl_player_stats.dart';
import '../models/nhl/nhl_game.dart';
import '../models/nhl/nhl_player.dart';
import '../models/nhl/nhl_team_stats.dart';
import '../models/olympics/olympics.dart';
import '../providers/cloud_firestore.dart';
import '../providers/sportsdata_api.dart';

class SportsRepository {
  final _sportsProvider = SportsdataApiClient();
  final _databaseProvider = CloudFirestoreClient();

  // MLB
  Future<List<MlbGame>> fetchMLB({@required DateTime dateTime, int days = 1}) =>
      _sportsProvider.fetchMLB(dateTime: dateTime, days: days);

  Future<List<MlbTeamStats>> fetchMLBTeamStats({@required DateTime dateTime}) =>
      _sportsProvider.fetchMLBTeamStats(dateTime: dateTime);

  Future<List<MlbPlayer>> fetchMLBPlayers({@required String teamKey}) =>
      _sportsProvider.fetchMLBPlayers(teamKey: teamKey);

  Future<MlbPlayerStats> fetchMLBPlayerStats(
          {@required String playerId, @required DateTime dateTime}) =>
      _sportsProvider.fetchMLBPlayerStats(
          playerId: playerId, dateTime: dateTime);

  // NBA
  Future<List<NbaGame>> fetchNBA({@required DateTime dateTime, int days = 1}) =>
      _sportsProvider.fetchNBA(dateTime: dateTime, days: days);

  Future<List<NbaTeamStats>> fetchNBATeamStats({@required DateTime dateTime}) =>
      _sportsProvider.fetchNBATeamStats(dateTime: dateTime);

  Future<List<NbaPlayer>> fetchNBAPlayers({@required String teamKey}) =>
      _sportsProvider.fetchNBAPlayers(teamKey: teamKey);

  Future<NbaPlayerStats> fetchNBAPlayerStats(
          {@required String playerId, @required DateTime dateTime}) =>
      _sportsProvider.fetchNBAPlayerStats(
          playerId: playerId, dateTime: dateTime);

  // NCAAB
  Future<List<NcaabGame>> fetchNCAAB(
          {@required DateTime dateTime, int days = 1}) =>
      _sportsProvider.fetchNCAAB(dateTime: dateTime, days: days);

  Future<List<NcaabTeamStats>> fetchNCAABTeamStats(
          {@required DateTime dateTime}) =>
      _sportsProvider.fetchNCAABTeamStats(dateTime: dateTime);

  Future<List<NcaabPlayer>> fetchNCAABPlayers({@required String teamKey}) =>
      _sportsProvider.fetchNCAABPlayers(teamKey: teamKey);

  Future<NcaabPlayerStats> fetchNCAABPlayerStats(
          {@required String playerId, @required DateTime dateTime}) =>
      _sportsProvider.fetchNCAABPlayerStats(
          playerId: playerId, dateTime: dateTime);

  // NCAAF
  Future<List<NcaafGame>> fetchNCAAF(
          {@required DateTime dateTime, int days = 1}) =>
      _sportsProvider.fetchNCAAF(dateTime: dateTime, days: days);

  Future<List<NcaafTeamStats>> fetchNCAAFTeamStats(
          {@required DateTime dateTime}) =>
      _sportsProvider.fetchNCAAFTeamStats(dateTime: dateTime);

  Future<List<NcaafPlayer>> fetchNCAAFPlayers({@required String teamKey}) =>
      _sportsProvider.fetchNCAAFPlayers(teamKey: teamKey);

  Future<NcaafPlayerStats> fetchNCAAFPlayerStats(
          {@required String playerId, @required DateTime dateTime}) =>
      _sportsProvider.fetchNCAAFPlayerStats(
          playerId: playerId, dateTime: dateTime);

  // NFL
  Future<List<NflGame>> fetchNFL({@required DateTime dateTime, int days = 1}) =>
      _sportsProvider.fetchNFL(dateTime: dateTime, days: days);

  Future<List<NflTeamStats>> fetchNFLTeamStats({@required DateTime dateTime}) =>
      _sportsProvider.fetchNFLTeamStats(dateTime: dateTime);

  Future<List<NflPlayer>> fetchNFLPlayers({@required String teamKey}) =>
      _sportsProvider.fetchNFLPlayers(teamKey: teamKey);

  Future<NflPlayerStats> fetchNFLPlayerStats(
          {@required String playerId, @required DateTime dateTime}) =>
      _sportsProvider.fetchNFLPlayerStats(
          playerId: playerId, dateTime: dateTime);

  // NHL
  Future<List<NhlGame>> fetchNHL({@required DateTime dateTime, int days = 1}) =>
      _sportsProvider.fetchNHL(dateTime: dateTime, days: days);

  Future<List<NhlTeamStats>> fetchNHLTeamStats({@required DateTime dateTime}) =>
      _sportsProvider.fetchNHLTeamStats(dateTime: dateTime);

  Future<List<NhlPlayer>> fetchNHLPlayers({@required String teamKey}) =>
      _sportsProvider.fetchNHLPlayers(teamKey: teamKey);

  Future<NhlPlayerStats> fetchNHLPlayerStats(
          {@required String playerId, @required DateTime dateTime}) =>
      _sportsProvider.fetchNHLPlayerStats(
          playerId: playerId, dateTime: dateTime);

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

  Stream<List<OlympicsGame>> fetchOlympicsGame() =>
      _databaseProvider.fetchOlympicsGames();

  Future<void> addOlympicsGame({OlympicsGame game}) =>
      _databaseProvider.addOlympicsGame(game: game);

  Future<void> updateOlympicGame({OlympicsGame game}) =>
      _databaseProvider.updateOlympicGame(game: game);
}
