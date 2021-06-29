import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/models/mlb/mlb_player_stats.dart';
import 'package:vegas_lit/data/models/mlb/mlb_team_stats.dart';

import '../../config/api.dart';
import '../models/golf/golf.dart';
import '../models/mlb/mlb_game.dart';
import '../models/mlb/mlb_player.dart';
import '../models/nba/nba_game.dart';
import '../models/nba/nba_player.dart';
import '../models/ncaab/ncaab_game.dart';
import '../models/ncaab/ncaab_player.dart';
import '../models/ncaaf/ncaaf_game.dart';
import '../models/ncaaf/ncaaf_player.dart';
import '../models/nfl/nfl_game.dart';
import '../models/nfl/nfl_player.dart';
import '../models/nhl/nhl_game.dart';
import '../models/nhl/nhl_player.dart';

class SportsAPI {
  SportsAPI({Dio dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  // MLB
  Future<List<MlbGame>> fetchMLB({@required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.mlb;
    final formattedDate = DateFormat('yyyy-MMM-dd').format(dateTime);

    final response = await _dio.get(
      'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));

      return parsed
          .map<MlbGame>(
            (json) => MlbGame.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailureMLB();
    }
  }

  Future<List<MlbTeamStats>> fetchMLBTeamStats(
      {@required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.mlb;
    final response = await _dio.get(
        'https://fly.sportsdata.io/v3/mlb/scores/json/TeamSeasonStats/${dateTime.year}?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      return parsed
          .map<MlbTeamStats>(
            (json) => MlbTeamStats.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailureTeamStats();
    }
  }

  Future<List<MlbPlayer>> fetchMLBPlayers({@required String teamKey}) async {
    const leagueData = ConstantSportsDataAPI.mlb;

    final response = await _dio.get(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/Players/$teamKey?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      return parsed
          .map<MlbPlayer>(
            (json) => MlbPlayer.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailurePlayer();
    }
  }

  Future<MlbPlayerStats> fetchMLBPlayerStats(
      {@required String playerId, @required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.mlb;
    final response = await _dio.get(
      'https://fly.sportsdata.io/v3/mlb/stats/json/PlayerSeasonStatsByPlayer/${dateTime.year}/$playerId?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      return MlbPlayerStats.fromMap(parsed);
    } else {
      throw FetchFailurePlayerStats();
    }
  }

  // NBA
  Future<List<NbaGame>> fetchNBA({@required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.nba;
    final formattedDate = DateFormat('yyyy-MMM-dd').format(dateTime);

    final response = await _dio.get(
      'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));

      return parsed
          .map<NbaGame>(
            (json) => NbaGame.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailureNBA();
    }
  }

  Future<List<NbaPlayer>> fetchNBAPlayers({@required String teamKey}) async {
    const leagueData = ConstantSportsDataAPI.nba;

    final response = await _dio.get(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/stats/json/Players/$teamKey?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      return parsed
          .map<NbaPlayer>(
            (json) => NbaPlayer.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailurePlayer();
    }
  }

  // NCAAB
  Future<List<NcaabGame>> fetchNCAAB({@required DateTime dateTime}) async {
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
          .map<NcaabGame>(
            (json) => NcaabGame.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailureNCAAB();
    }
  }

  Future<List<NcaabPlayer>> fetchNCAABPlayers(
      {@required String teamKey}) async {
    const leagueData = ConstantSportsDataAPI.ncaab;

    final response = await _dio.get(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/Players/$teamKey?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      return parsed
          .map<NcaabPlayer>(
            (json) => NcaabPlayer.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailurePlayer();
    }
  }

  // NCAAF
  Future<List<NcaafGame>> fetchNCAAF({@required DateTime dateTime}) async {
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
          .map<NcaafGame>(
            (json) => NcaafGame.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailureNCAAB();
    }
  }

  Future<List<NcaafPlayer>> fetchNCAAFPlayers(
      {@required String teamKey}) async {
    const leagueData = ConstantSportsDataAPI.ncaaf;

    final response = await _dio.get(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/Players/$teamKey?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      return parsed
          .map<NcaafPlayer>(
            (json) => NcaafPlayer.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailurePlayer();
    }
  }

  // NFL
  Future<List<NflGame>> fetchNFL({@required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.nfl;
    final formattedDate = DateFormat('yyyy-MMM-dd').format(dateTime);

    final response = await _dio.get(
      'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));

      return parsed
          .map<NflGame>(
            (json) => NflGame.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailureNFL();
    }
  }

  Future<List<NflPlayer>> fetchNFLPlayers({@required String teamKey}) async {
    const leagueData = ConstantSportsDataAPI.nfl;

    final response = await _dio.get(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/Players/$teamKey?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      return parsed
          .map<NflPlayer>(
            (json) => NflPlayer.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailurePlayer();
    }
  }

  // NHL
  Future<List<NhlGame>> fetchNHL({@required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.nhl;
    final formattedDate = DateFormat('yyyy-MMM-dd').format(dateTime);

    final response = await _dio.get(
      'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));

      return parsed
          .map<NhlGame>(
            (json) => NhlGame.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailureNHL();
    }
  }

  Future<List<NhlPlayer>> fetchNHLPlayers({@required String teamKey}) async {
    const leagueData = ConstantSportsDataAPI.nhl;

    final response = await _dio.get(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/Players/$teamKey?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      return parsed
          .map<NhlPlayer>(
            (json) => NhlPlayer.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailurePlayer();
    }
  }

  // Future<List<CricketDatum>> fetchCricketGame(
  //     {@required DateTime dateTimeEastern}) async {
  //   const leagueData = ConstantSportsDataAPI.cricket;
  //   Response response;

  //   response = await _dio.get(
  //     'https://api.the-odds-api.com/v3/odds/?sport=${leagueData['league']}&region=us&mkt=h2h&dateFormat=iso&apiKey=${leagueData['key']}',
  //   );
  //   // print(response);
  //   if (response.statusCode == 200) {
  //     final parsed = json.decode(json.encode(response.data));
  //     return CricketModel.fromMap(parsed).data;
  //   } else {
  //     //print(response.statusCode.toString());
  //     throw FetchCricketFailure();
  //   }
  // }

  // GOLF
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
}

class FetchFailureTeamStats implements Exception {}

class FetchFailurePlayer implements Exception {}

class FetchFailurePlayerStats implements Exception {}

class FetchFailureNFL implements Exception {}

class FetchFailureNBA implements Exception {}

class FetchFailureMLB implements Exception {}

class FetchFailureNHL implements Exception {}

class FetchFailureNCAAF implements Exception {}

class FetchFailureNCAAB implements Exception {}

class FetchCricketFailure implements Exception {}

class FetchGolfFailure implements Exception {}
