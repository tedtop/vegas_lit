

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../config/api.dart';
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

class SportsdataApiClient {
  SportsdataApiClient({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  /// MLB
  ///
  /// All functions related to MLB.
  Future<List<MlbGame>> fetchMLB(
      {required DateTime dateTime, required int days}) async {
    const leagueData = ConstantSportsDataAPI.mlb;
    final formattedDates = <String>[];
    for (var day = 0; day < days; day++) {
      formattedDates.add(
          DateFormat('yyyy-MMM-dd').format(dateTime.add(Duration(days: day))));
    }
    final responses = await Future.wait(
      formattedDates.map(
        (formattedDate) => _dio.get<Object>(
          'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate?key=${leagueData['key']}',
        ),
      ),
    );
    final games = <MlbGame>[];
    for (final response in responses) {
      if (response.statusCode == 200) {
        final parsed = json.decode(json.encode(response.data)) as List;

        games.addAll(
          parsed
              .map<MlbGame>(
                ((Object json) => MlbGame.fromMap(json as Map<String, dynamic>)) as MlbGame Function(dynamic),
              )
              .toList(),
        );
      } else {
        throw FetchFailureMLB();
      }
    }
    return games;
  }

  Future<List<MlbTeamStats>> fetchMLBTeamStats({
    required DateTime dateTime,
  }) async {
    const leagueData = ConstantSportsDataAPI.mlb;
    final response = await _dio.get<Object>(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/TeamSeasonStats/${dateTime.year}?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return parsed
          .map<MlbTeamStats>(
            ((Object json) => MlbTeamStats.fromMap(json as Map<String, dynamic>)) as MlbTeamStats Function(dynamic),
          )
          .toList();
    } else {
      throw FetchFailureTeamStats();
    }
  }

  Future<List<MlbPlayer>> fetchMLBPlayers({required String? teamKey}) async {
    const leagueData = ConstantSportsDataAPI.mlb;

    final response = await _dio.get<Object>(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/Players/$teamKey?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return parsed
          .map<MlbPlayer>(
            ((Object json) => MlbPlayer.fromMap(json as Map<String, dynamic>)) as MlbPlayer Function(dynamic),
          )
          .toList();
    } else {
      throw FetchFailurePlayer();
    }
  }

  Future<MlbPlayerStats> fetchMLBPlayerStats(
      {required String? playerId, required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.mlb;
    final response = await _dio.get<Object>(
      'https://fly.sportsdata.io/v3/${leagueData['league']}/stats/json/PlayerSeasonStatsByPlayer/${dateTime.year}/$playerId?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return MlbPlayerStats.fromMap(parsed as Map<String, dynamic>);
    } else {
      throw FetchFailurePlayerStats();
    }
  }

  /// NBA
  ///
  /// All functions related to NBA.
  Future<List<NbaGame>> fetchNBA(
      {required DateTime dateTime, required int days}) async {
    const leagueData = ConstantSportsDataAPI.nba;
    final formattedDates = <String>[];
    for (var day = 0; day < days; day++) {
      formattedDates.add(
          DateFormat('yyyy-MMM-dd').format(dateTime.add(Duration(days: day))));
    }
    final responses = await Future.wait(
        formattedDates.map((formattedDate) => _dio.get<Object>(
              'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate?key=${leagueData['key']}',
            )));
    final games = <NbaGame>[];
    for (final response in responses) {
      if (response.statusCode == 200) {
        final parsed = json.decode(json.encode(response.data)) as List;

        games.addAll(parsed
            .map<NbaGame>(
              ((Object json) => NbaGame.fromMap(json as Map<String, dynamic>)) as NbaGame Function(dynamic),
            )
            .toList());
      } else {
        throw FetchFailureNBA();
      }
    }
    return games;
  }

  Future<List<NbaTeamStats>> fetchNBATeamStats(
      {required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.nba;
    final response = await _dio.get<Object>(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/TeamSeasonStats/${dateTime.year}?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return parsed
          .map<NbaTeamStats>(
            ((Object json) => NbaTeamStats.fromMap(json as Map<String, dynamic>)) as NbaTeamStats Function(dynamic),
          )
          .toList();
    } else {
      throw FetchFailureTeamStats();
    }
  }

  Future<List<NbaPlayer>> fetchNBAPlayers({required String? teamKey}) async {
    const leagueData = ConstantSportsDataAPI.nba;

    final response = await _dio.get<Object>(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/stats/json/Players/$teamKey?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return parsed
          .map<NbaPlayer>(
            ((Object json) => NbaPlayer.fromMap(json as Map<String, dynamic>)) as NbaPlayer Function(dynamic),
          )
          .toList();
    } else {
      throw FetchFailurePlayer();
    }
  }

  Future<NbaPlayerStats> fetchNBAPlayerStats(
      {required String? playerId, required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.nba;
    final response = await _dio.get<Object>(
      'https://fly.sportsdata.io/v3/${leagueData['league']}/stats/json/PlayerSeasonStatsByPlayer/${dateTime.year}/$playerId?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return NbaPlayerStats.fromMap(parsed as Map<String, dynamic>);
    } else {
      throw FetchFailurePlayerStats();
    }
  }

  /// NCAAB
  ///
  /// All functions related to NCAAB.
  Future<List<NcaabGame>> fetchNCAAB(
      {required DateTime dateTime, required int days}) async {
    const leagueData = ConstantSportsDataAPI.ncaab;
    final formattedDates = <String>[];
    for (var day = 0; day < days; day++) {
      formattedDates.add(
          DateFormat('yyyy-MMM-dd').format(dateTime.add(Duration(days: day))));
    }
    final responses = await Future.wait(
        formattedDates.map((formattedDate) => _dio.get<Object>(
              'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate?key=${leagueData['key']}',
            )));
    final games = <NcaabGame>[];
    for (final response in responses) {
      if (response.statusCode == 200) {
        final parsed = json.decode(json.encode(response.data)) as List;

        games.addAll(parsed
            .map<NcaabGame>(
              ((Object json) => NcaabGame.fromMap(json as Map<String, dynamic>)) as NcaabGame Function(dynamic),
            )
            .toList());
      } else {
        throw FetchFailureNCAAB();
      }
    }
    return games;
  }

  Future<List<NcaabTeamStats>> fetchNCAABTeamStats(
      {required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.ncaab;
    final response = await _dio.get<Object>(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/TeamSeasonStats/${dateTime.year}?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return parsed
          .map<NcaabTeamStats>(
            ((Object json) =>
                NcaabTeamStats.fromMap(json as Map<String, dynamic>)) as NcaabTeamStats Function(dynamic),
          )
          .toList();
    } else {
      throw FetchFailureTeamStats();
    }
  }

  Future<List<NcaabPlayer>> fetchNCAABPlayers(
      {required String? teamKey}) async {
    const leagueData = ConstantSportsDataAPI.ncaab;

    final response = await _dio.get<Object>(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/Players/$teamKey?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return parsed
          .map<NcaabPlayer>(
            ((Object json) => NcaabPlayer.fromMap(json as Map<String, dynamic>)) as NcaabPlayer Function(dynamic),
          )
          .toList();
    } else {
      throw FetchFailurePlayer();
    }
  }

  Future<NcaabPlayerStats> fetchNCAABPlayerStats(
      {required String? playerId, required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.ncaab;
    final response = await _dio.get<Object>(
      'https://fly.sportsdata.io/v3/${leagueData['league']}/stats/json/PlayerSeasonStatsByPlayer/${dateTime.year}/$playerId?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return NcaabPlayerStats.fromMap(parsed as Map<String, dynamic>);
    } else {
      throw FetchFailurePlayerStats();
    }
  }

  /// NCAAF
  ///
  /// All functions related to NCAAF.
  Future<List<NcaafGame>> fetchNCAAF(
      {required DateTime dateTime, required int days}) async {
    const leagueData = ConstantSportsDataAPI.ncaaf;
    final formattedDates = <String>[];
    for (var day = 0; day < days; day++) {
      formattedDates.add(
          DateFormat('yyyy-MMM-dd').format(dateTime.add(Duration(days: day))));
    }
    final responses = await Future.wait(
        formattedDates.map((formattedDate) => _dio.get<Object>(
              'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate?key=${leagueData['key']}',
            )));
    final games = <NcaafGame>[];
    for (final response in responses) {
      if (response.statusCode == 200) {
        final parsed = json.decode(json.encode(response.data)) as List;

        games.addAll(parsed
            .map<NcaafGame>(
              ((Object json) => NcaafGame.fromMap(json as Map<String, dynamic>)) as NcaafGame Function(dynamic),
            )
            .toList());
      } else {
        throw FetchFailureNCAAB();
      }
    }
    return games;
  }

  Future<List<NcaafTeamStats>> fetchNCAAFTeamStats(
      {required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.ncaaf;
    final response = await _dio.get<Object>(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/TeamSeasonStats/${dateTime.year}?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return parsed
          .map<NcaafTeamStats>(
            ((Object json) =>
                NcaafTeamStats.fromMap(json as Map<String, dynamic>)) as NcaafTeamStats Function(dynamic),
          )
          .toList();
    } else {
      throw FetchFailureTeamStats();
    }
  }

  Future<List<NcaafPlayer>> fetchNCAAFPlayers(
      {required String? teamKey}) async {
    const leagueData = ConstantSportsDataAPI.ncaaf;

    final response = await _dio.get<Object>(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/Players/$teamKey?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return parsed
          .map<NcaafPlayer>(
            ((Object json) => NcaafPlayer.fromMap(json as Map<String, dynamic>)) as NcaafPlayer Function(dynamic),
          )
          .toList();
    } else {
      throw FetchFailurePlayer();
    }
  }

  Future<NcaafPlayerStats> fetchNCAAFPlayerStats(
      {required String? playerId, required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.ncaaf;
    final response = await _dio.get<Object>(
      'https://fly.sportsdata.io/v3/${leagueData['league']}/stats/json/PlayerSeasonStatsByPlayer/${dateTime.year}/$playerId?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return NcaafPlayerStats.fromMap(parsed as Map<String, dynamic>);
    } else {
      throw FetchFailurePlayerStats();
    }
  }

  /// NFL
  ///
  /// All functions related to NFL.
  Future<List<NflGame>> fetchNFL(
      {required DateTime dateTime, required int days}) async {
    const leagueData = ConstantSportsDataAPI.nfl;
    final formattedDates = <String>[];
    for (var day = 0; day < days; day++) {
      formattedDates.add(
          DateFormat('yyyy-MMM-dd').format(dateTime.add(Duration(days: day))));
    }
    final responses = await Future.wait(
        formattedDates.map((formattedDate) => _dio.get<Object>(
              'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/ScoresByDate/$formattedDate?key=${leagueData['key']}',
            )));
    final games = <NflGame>[];
    for (final response in responses) {
      if (response.statusCode == 200) {
        final parsed = json.decode(json.encode(response.data)) as List;

        games.addAll(parsed
            .map<NflGame>(
              ((Object json) => NflGame.fromMap(json as Map<String, dynamic>)) as NflGame Function(dynamic),
            )
            .toList());
      } else {
        return [];
        // throw FetchFailureNFL();
      }
    }
    return games;
  }

  Future<List<NflTeamStats>> fetchNFLTeamStats(
      {required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.nfl;
    final response = await _dio.get<Object>(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/TeamSeasonStats/${dateTime.year}PRE?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return parsed
          .map<NflTeamStats>(
            ((Object json) => NflTeamStats.fromMap(json as Map<String, dynamic>)) as NflTeamStats Function(dynamic),
          )
          .toList();
    } else {
      throw FetchFailureTeamStats();
    }
  }

  Future<List<NflPlayer>> fetchNFLPlayers({required String? teamKey}) async {
    const leagueData = ConstantSportsDataAPI.nfl;

    final response = await _dio.get<Object>(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/Players/$teamKey?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return parsed
          .map<NflPlayer>(
            ((Object json) => NflPlayer.fromMap(json as Map<String, dynamic>)) as NflPlayer Function(dynamic),
          )
          .toList();
    } else {
      throw FetchFailurePlayer();
    }
  }

  Future<NflPlayerStats> fetchNFLPlayerStats(
      {required String? playerId, required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.nfl;
    final response = await _dio.get<Object>(
      'https://fly.sportsdata.io/v3/${leagueData['league']}/stats/json/PlayerSeasonStatsByPlayerID/${dateTime.year}PRE/$playerId?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return NflPlayerStats.fromMap(parsed as Map<String, dynamic>);
    } else {
      throw FetchFailurePlayerStats();
    }
  }

  /// NHL
  ///
  /// All functions related to NHL.
  Future<List<NhlGame>> fetchNHL(
      {required DateTime dateTime, required int days}) async {
    const leagueData = ConstantSportsDataAPI.nhl;
    final formattedDates = <String>[];
    for (var day = 0; day < days; day++) {
      formattedDates.add(
          DateFormat('yyyy-MMM-dd').format(dateTime.add(Duration(days: day))));
    }
    final responses = await Future.wait(
        formattedDates.map((formattedDate) => _dio.get<Object>(
              'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate?key=${leagueData['key']}',
            )));
    final games = <NhlGame>[];
    for (final response in responses) {
      if (response.statusCode == 200) {
        final parsed = json.decode(json.encode(response.data)) as List;

        games.addAll(parsed
            .map<NhlGame>(
              ((Object json) => NhlGame.fromMap(json as Map<String, dynamic>)) as NhlGame Function(dynamic),
            )
            .toList());
      } else {
        throw FetchFailureNHL();
      }
    }
    return games;
  }

  Future<List<NhlTeamStats>> fetchNHLTeamStats(
      {required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.nhl;
    final response = await _dio.get<Object>(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/TeamSeasonStats/${dateTime.year}?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return parsed
          .map<NhlTeamStats>(
            ((Object json) => NhlTeamStats.fromMap(json as Map<String, dynamic>)) as NhlTeamStats Function(dynamic),
          )
          .toList();
    } else {
      throw FetchFailureTeamStats();
    }
  }

  Future<List<NhlPlayer>> fetchNHLPlayers({required String? teamKey}) async {
    const leagueData = ConstantSportsDataAPI.nhl;

    final response = await _dio.get<Object>(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/Players/$teamKey?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return parsed
          .map<NhlPlayer>(
            ((Object json) => NhlPlayer.fromMap(json as Map<String, dynamic>)) as NhlPlayer Function(dynamic),
          )
          .toList();
    } else {
      throw FetchFailurePlayer();
    }
  }

  Future<NhlPlayerStats> fetchNHLPlayerStats(
      {required String? playerId, required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.nhl;
    final response = await _dio.get<Object>(
      'https://fly.sportsdata.io/v3/${leagueData['league']}/stats/json/PlayerSeasonStatsByPlayer/${dateTime.year}/$playerId?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return NhlPlayerStats.fromMap(parsed as Map<String, dynamic>);
    } else {
      throw FetchFailurePlayerStats();
    }
  }

  /// Cricket
  ///
  /// All functions related to Cricket.
  // Future<List<CricketDatum>> fetchCricketGame(
  //     {@required DateTime dateTimeEastern}) async {
  //   const leagueData = ConstantSportsDataAPI.cricket;
  //   Response response;

  //   response = await _dio.get<Object>(
  //     'https://api.the-odds-api.com/v3/odds/?sport=${leagueData['league']}&region=us&mkt=h2h&dateFormat=iso&apiKey=${leagueData['key']}',
  //   );
  //   // print(response);
  //   if (response.statusCode == 200) {
  //     final parsed = json.decode(json.encode(response.data)) as List;
  //     return CricketModel.fromMap(parsed as Map<String, dynamic>).data;
  //   } else {
  //     //print(response.statusCode.toString());
  //     throw FetchCricketFailure();
  //   }
  // }

  /// Golf
  ///
  /// All functions related to Golf.
  Future<List<GolfTournament>> fetchGolfTournaments({
    required DateTime dateTimeEastern,
  }) async {
    const leagueData = ConstantSportsDataAPI.golf;
    final formattedYear = DateFormat('yyyy').format(dateTimeEastern);

    final response = await _dio.get<Object>(
      'https://fly.sportsdata.io/golf/v2/json/Tournaments/$formattedYear?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final dynamic parsed = json.decode(json.encode(response.data)) as List;
      final filteredTournaments = <GolfTournament>[];
      parsed
          .map<GolfTournament>((Object json) {
            return GolfTournament.fromMap(json as Map<String, dynamic>);
          })
          .toList()
          .forEach((GolfTournament tournament) {
            if (tournament.endDate!
                    .isBefore(dateTimeEastern.add(const Duration(days: 20))) &&
                tournament.endDate!.isAfter(
                  dateTimeEastern.subtract(const Duration(days: 1)),
                )) {
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
      {required int? tournamentID}) async {
    const leagueData = ConstantSportsDataAPI.golf;

    final response = await _dio.get<Object>(
      'https://fly.sportsdata.io/golf/v2/json/Leaderboard/$tournamentID?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      final leaderboard =
          GolfLeaderboard.fromMap(parsed as Map<String, dynamic>);
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
