import 'package:vegas_lit/features/games/baseball/mlb/models/mlb_team.dart';
import 'package:vegas_lit/features/games/basketball/nba/models/nba_team.dart';
import 'package:vegas_lit/features/games/basketball/ncaab/models/ncaab_team.dart';
import 'package:vegas_lit/features/games/football/ncaaf/models/ncaaf_team.dart';
import 'package:vegas_lit/features/games/football/nfl/models/nfl_team.dart';
import 'package:vegas_lit/features/games/hockey/nhl/models/nhl_team.dart';

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
import '../models/paralympics/paralympics.dart';
import '../providers/cloud_firestore.dart';
import '../providers/sportsdata_api.dart';

class SportRepository {
  SportRepository({
    SportsdataApiClient? sportsProvider,
    CloudFirestoreClient? databaseProvider,
  })  : _sportsProvider = sportsProvider ?? SportsdataApiClient(),
        _databaseProvider = databaseProvider ?? CloudFirestoreClient();

  final SportsdataApiClient _sportsProvider;
  final CloudFirestoreClient _databaseProvider;

  /// MLB
  Future<List<MlbGame>> fetchMLB({required DateTime dateTime, int days = 1}) =>
      _sportsProvider.fetchMLB(dateTime: dateTime, days: days);

  Future<List<MlbTeamStats>> fetchMLBTeamStats({required DateTime dateTime}) =>
      _sportsProvider.fetchMLBTeamStats(dateTime: dateTime);

  Future<List<MlbPlayer>> fetchMLBPlayers({required String? teamKey}) =>
      _sportsProvider.fetchMLBPlayers(teamKey: teamKey);

  Future<MlbPlayerStats> fetchMLBPlayerStats(
          {required String? playerId, required DateTime dateTime}) =>
      _sportsProvider.fetchMLBPlayerStats(
          playerId: playerId, dateTime: dateTime);

  Future<List<MlbTeam>> fetchMLBTeams() => _sportsProvider.fetchMLBTeams();

  /// NBA
  Future<List<NbaGame>> fetchNBA({required DateTime dateTime, int days = 1}) =>
      _sportsProvider.fetchNBA(dateTime: dateTime, days: days);

  Future<List<NbaTeamStats>> fetchNBATeamStats({required DateTime dateTime}) =>
      _sportsProvider.fetchNBATeamStats(dateTime: dateTime);

  Future<List<NbaPlayer>> fetchNBAPlayers({required String? teamKey}) =>
      _sportsProvider.fetchNBAPlayers(teamKey: teamKey);

  Future<NbaPlayerStats> fetchNBAPlayerStats(
          {required String? playerId, required DateTime dateTime}) =>
      _sportsProvider.fetchNBAPlayerStats(
          playerId: playerId, dateTime: dateTime);

  Future<List<NbaTeam>> fetchNBATeams() => _sportsProvider.fetchNBATeams();

  /// NCAAB
  Future<List<NcaabGame>> fetchNCAAB(
          {required DateTime dateTime, int days = 1}) =>
      _sportsProvider.fetchNCAAB(dateTime: dateTime, days: days);

  Future<List<NcaabTeamStats>> fetchNCAABTeamStats(
          {required DateTime dateTime}) =>
      _sportsProvider.fetchNCAABTeamStats(dateTime: dateTime);

  Future<List<NcaabPlayer>> fetchNCAABPlayers({required String? teamKey}) =>
      _sportsProvider.fetchNCAABPlayers(teamKey: teamKey);

  Future<NcaabPlayerStats> fetchNCAABPlayerStats(
          {required String? playerId, required DateTime dateTime}) =>
      _sportsProvider.fetchNCAABPlayerStats(
          playerId: playerId, dateTime: dateTime);

  Future<List<NcaabTeam>> fetchNCAABTeams() =>
      _sportsProvider.fetchNCAABTeams();

  /// NCAAF
  Future<List<NcaafGame>> fetchNCAAF(
          {required DateTime dateTime, int days = 1}) =>
      _sportsProvider.fetchNCAAF(dateTime: dateTime, days: days);

  Future<List<NcaafTeamStats>> fetchNCAAFTeamStats(
          {required DateTime dateTime}) =>
      _sportsProvider.fetchNCAAFTeamStats(dateTime: dateTime);

  Future<List<NcaafPlayer>> fetchNCAAFPlayers({required String? teamKey}) =>
      _sportsProvider.fetchNCAAFPlayers(teamKey: teamKey);

  Future<NcaafPlayerStats> fetchNCAAFPlayerStats(
          {required String? playerId, required DateTime dateTime}) =>
      _sportsProvider.fetchNCAAFPlayerStats(
          playerId: playerId, dateTime: dateTime);

  Future<List<NcaafTeam>> fetchNCAAFTeams() =>
      _sportsProvider.fetchNCAAFTeams();

  /// NFL
  Future<List<NflGame>> fetchNFL({required DateTime dateTime, int days = 1}) =>
      _sportsProvider.fetchNFL(dateTime: dateTime, days: days);

  Future<List<NflTeamStats>> fetchNFLTeamStats({required DateTime dateTime}) =>
      _sportsProvider.fetchNFLTeamStats(dateTime: dateTime);

  Future<List<NflPlayer>> fetchNFLPlayers({required String? teamKey}) =>
      _sportsProvider.fetchNFLPlayers(teamKey: teamKey);

  Future<NflPlayerStats> fetchNFLPlayerStats(
          {required String? playerId, required DateTime dateTime}) =>
      _sportsProvider.fetchNFLPlayerStats(
          playerId: playerId, dateTime: dateTime);

  Future<List<NflTeam>> fetchNFLTeams() => _sportsProvider.fetchNFLTeams();

  /// NHL
  Future<List<NhlGame>> fetchNHL({required DateTime dateTime, int days = 1}) =>
      _sportsProvider.fetchNHL(dateTime: dateTime, days: days);

  Future<List<NhlTeamStats>> fetchNHLTeamStats({required DateTime dateTime}) =>
      _sportsProvider.fetchNHLTeamStats(dateTime: dateTime);

  Future<List<NhlPlayer>> fetchNHLPlayers({required String? teamKey}) =>
      _sportsProvider.fetchNHLPlayers(teamKey: teamKey);

  Future<NhlPlayerStats> fetchNHLPlayerStats(
          {required String? playerId, required DateTime dateTime}) =>
      _sportsProvider.fetchNHLPlayerStats(
          playerId: playerId, dateTime: dateTime);

  Future<List<NhlTeam>> fetchNHLTeams() => _sportsProvider.fetchNHLTeams();

  // Future<List<CricketDatum>> fetchCricketGames(
  //         {String gameName, DateTime dateTime}) =>
  //     _sportsProvider.fetchCricketGame(dateTimeEastern: dateTime);

  /// GOLF
  Future<List<GolfTournament>> fetchGolfTournaments({
    required DateTime dateTimeEastern,
  }) =>
      _sportsProvider.fetchGolfTournaments(dateTimeEastern: dateTimeEastern);

  Future<GolfLeaderboard> fetchGolfLeaderboard({required int? tournamentID}) =>
      _sportsProvider.fetchGolfLeaderboard(tournamentID: tournamentID);

  Stream<List<OlympicsGame>> fetchOlympicsGame() =>
      _databaseProvider.fetchOlympicsGames();

  Future<void> addOlympicsGame({required OlympicsGame game}) =>
      _databaseProvider.addOlympicsGame(game: game);

  Future<void> updateOlympicGame({required OlympicsGame game}) =>
      _databaseProvider.updateOlympicGame(game: game);

  Future<void> addParalympicsGame({required ParalympicsGame game}) =>
      _databaseProvider.addParalympicsGame(game: game);

  Stream<List<ParalympicsGame>> fetchParalympicsGame() =>
      _databaseProvider.fetchParalympicGames();

  Future<void> updateParalympicsGame({required ParalympicsGame game}) =>
      _databaseProvider.updateParalympicsGame(game: game);
}
