import 'dart:convert';

import 'package:api_client/api_client.dart';
import 'package:api_client/src/config/api.dart';
import 'package:api_client/src/models/game.dart';
import 'package:api_client/src/models/player.dart';
import 'package:api_client/src/models/player_details.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class SportsAPI {
  SportsAPI({Dio dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<List<Game>> fetchMLB({@required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.mlb;
    final formattedDate = DateFormat('yyyy-MMM-dd').format(dateTime);

    final response = await _dio.get(
      'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));

      return parsed
          .map<Game>(
            (json) => Game.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailureMLB();
    }
  }

  Future<List<Game>> fetchNBA({@required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.nba;
    final formattedDate = DateFormat('yyyy-MMM-dd').format(dateTime);

    final response = await _dio.get(
      'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));

      return parsed
          .map<Game>(
            (json) => Game.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailureNBA();
    }
  }

  Future<List<Game>> fetchNCAAB({@required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.ncaab;
    final formattedDate = DateFormat('yyyy-MMM-dd').format(dateTime);

    final response = await _dio.get(
      'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(
        json.encode(response.data),
      );

      return parsed
          .map<Game>(
            (json) => Game.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailureNCAAB();
    }
  }

  Future<List<Game>> fetchNCAAF({@required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.ncaaf;
    final formattedDate = DateFormat('yyyy-MMM-dd').format(dateTime);

    final response = await _dio.get(
      'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(
        json.encode(response.data),
      );

      return parsed
          .map<Game>(
            (json) => Game.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailureNCAAB();
    }
  }

  Future<List<Game>> fetchNFL({@required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.nfl;
    final formattedDate = DateFormat('yyyy-MMM-dd').format(dateTime);

    final response = await _dio.get(
      'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));

      return parsed
          .map<Game>(
            (json) => Game.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailureNFL();
    }
  }

  Future<List<Game>> fetchNHL({@required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.nhl;
    final formattedDate = DateFormat('yyyy-MMM-dd').format(dateTime);

    final response = await _dio.get(
      'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));

      return parsed
          .map<Game>(
            (json) => Game.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailureNHL();
    }
  }

  Future<List<GolfTournament>> fetchGolfTournaments({
    DateTime dateTimeEastern,
  }) async {
    const leagueData = ConstantSportsDataAPI.golf;
    final formattedYear = DateFormat('yyyy').format(dateTimeEastern);

    final response = await _dio.get(
      'https://fly.sportsdata.io/golf/v2/json/Tournaments/$formattedYear?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      final filteredTournaments = <GolfTournament>[];
      parsed
          .map<GolfTournament>((json) {
            return GolfTournament.fromMap(json);
          })
          .toList()
          .forEach((tournament) {
            if (tournament.endDate
                    .isBefore(dateTimeEastern.add(const Duration(days: 20))) &&
                tournament.endDate.isAfter(
                    dateTimeEastern.subtract(const Duration(days: 1)))) {
              filteredTournaments.add(tournament);
            }
          });
      return filteredTournaments.reversed.toList();
      //return allTournaments;
    } else {
      throw FetchGolfFailure();
    }
  }

  Future<GolfLeaderboard> fetchGolfLeaderboard(
      {@required int tournamentID}) async {
    const leagueData = ConstantSportsDataAPI.golf;

    final response = await _dio.get(
      'https://fly.sportsdata.io/golf/v2/json/Leaderboard/$tournamentID?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      final leaderboard = GolfLeaderboard.fromMap(parsed);
      return leaderboard;
    } else {
      throw FetchGolfFailure();
    }
  }

  Future<List<Player>> fetchPlayers({String teamKey, String gameName}) async {
    final jsonUrl = _getTeamPlayerUrl(gameName, teamKey);
    final response = await _dio.get(jsonUrl);
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      return parsed.map<Player>((json) => Player.fromJson(json)).toList();
    } else {
      throw FetchFailurePlayer();
    }
  }

  String _getTeamPlayerUrl(String gameName, String teamKey) {
    //  'NFL',
    // 'NBA',
    // 'MLB',
    // 'NHL',
    // 'NCAAF',
    // 'NCAAB',
    // 'GOLF'
    switch (gameName.toLowerCase()) {
      case 'mlb':
        return 'https://fly.sportsdata.io/v3/mlb/scores/json/Players/$teamKey?key=${ConstantSportsDataAPI.mlb['key']}';
      case 'nba':
        return 'https://fly.sportsdata.io/v3/nba/stats/json/Players/$teamKey?key=${ConstantSportsDataAPI.nba['key']}';
      case 'nhl':
        return 'https://fly.sportsdata.io/v3/nhl/scores/json/Players/$teamKey?key=${ConstantSportsDataAPI.nhl['key']}';
      case 'cbb':
      case 'ncaab':
        return 'https://fly.sportsdata.io/v3/cbb/scores/json/Players/$teamKey?key=${ConstantSportsDataAPI.ncaab['key']}';
      default:
        return 'Key';
    }
  }

  String _getPlayerDetailsUrl(String gameName, String playerId) {
    //  'NFL',
    // 'NBA',
    // 'MLB',
    // 'NHL',
    // 'NCAAF',
    // 'NCAAB',
    // 'GOLF'
    switch (gameName.toLowerCase()) {
      case 'mlb':
        return 'https://fly.sportsdata.io/v3/$gameName/scores/json/Player/$playerId?key=${ConstantSportsDataAPI.mlb['key']}';
      case 'nba':
        return 'https://fly.sportsdata.io/v3/$gameName/scores/json/Player/$playerId?key=${ConstantSportsDataAPI.nba['key']}';
      case 'nhl':
        return 'https://fly.sportsdata.io/v3/$gameName/scores/json/Player/$playerId?key=${ConstantSportsDataAPI.nhl['key']}';
      case 'cbb':
      case 'ncaab':
        return 'https://fly.sportsdata.io/v3/$gameName/scores/json/Player/$playerId?key=${ConstantSportsDataAPI.ncaab['key']}';
      default:
        return 'Key';
    }
  }

  Future<PlayerDetails> fetchPlayerDetails({
    String playerId,
    String gameName,
  }) async {
    final jsonUrl = _getPlayerDetailsUrl(gameName, playerId);
    final response = await _dio.get(jsonUrl);
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      return PlayerDetails.fromJson(parsed);
    } else {
      throw FetchFailurePlayerDetails();
    }
  }
}

class FetchFailurePlayer implements Exception {}

class FetchFailurePlayerDetails implements Exception {}

class FetchFailureNFL implements Exception {}

class FetchFailureNBA implements Exception {}

class FetchFailureMLB implements Exception {}

class FetchFailureNHL implements Exception {}

class FetchFailureNCAAF implements Exception {}

class FetchFailureNCAAB implements Exception {}

class FetchGolfFailure implements Exception {}
