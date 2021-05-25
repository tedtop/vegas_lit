import 'package:meta/meta.dart';
import 'package:vegas_lit/data/dataproviders/sportsdata_api.dart';
import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/data/models/golf.dart';
import 'package:vegas_lit/data/models/player.dart';
import 'package:vegas_lit/data/models/player_details.dart';

class SportsRepository {
  final _sportsProvider = SportsAPI();

  Future<List<Game>> fetchMLB({@required DateTime dateTime}) =>
      _sportsProvider.fetchMLB(dateTime: dateTime);

  Future<List<Game>> fetchNBA({@required DateTime dateTime}) =>
      _sportsProvider.fetchNBA(dateTime: dateTime);

  Future<List<Game>> fetchNCAAB({@required DateTime dateTime}) =>
      _sportsProvider.fetchNCAAB(dateTime: dateTime);

  Future<List<Game>> fetchNCAAF({@required DateTime dateTime}) =>
      _sportsProvider.fetchNCAAF(dateTime: dateTime);

  Future<List<Game>> fetchNFL({@required DateTime dateTime}) =>
      _sportsProvider.fetchNFL(dateTime: dateTime);

  Future<List<Game>> fetchNHL({@required DateTime dateTime}) =>
      _sportsProvider.fetchNHL(dateTime: dateTime);

  // Future<List<CricketDatum>> fetchCricketGames(
  //         {String gameName, DateTime dateTime}) =>
  //     _sportsProvider.fetchCricketGame(dateTimeEastern: dateTime);

  Future<List<GolfTournament>> fetchGolfTournaments({
    @required DateTime dateTimeEastern,
  }) =>
      _sportsProvider.fetchGolfTournaments(dateTimeEastern: dateTimeEastern);

  Future<GolfLeaderboard> fetchGolfLeaderboard({@required int tournamentID}) =>
      _sportsProvider.fetchGolfLeaderboard(tournamentID: tournamentID);

  Future<List<Player>> fetchPlayers({
    @required String teamKey,
    @required String gameName,
  }) =>
      _sportsProvider.fetchPlayers(teamKey: teamKey, gameName: gameName);

  Future<PlayerDetails> fetchPlayerDetails({
    @required String playerId,
    @required String gameName,
  }) =>
      _sportsProvider.fetchPlayerDetails(
          playerId: playerId, gameName: gameName);
}
