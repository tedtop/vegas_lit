import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/data/models/nascar/nascar_driver.dart';
import 'package:vegas_lit/data/models/nascar/nascar_race.dart';
import 'package:vegas_lit/data/models/nascar/nascar_race_results.dart';
import 'package:vegas_lit/features/games/baseball/mlb/models/mlb_team.dart';
import 'package:vegas_lit/features/games/basketball/nba/models/nba_team.dart';
import 'package:vegas_lit/features/games/basketball/ncaab/models/ncaab_team.dart';
import 'package:vegas_lit/features/games/football/ncaaf/models/ncaaf_team.dart';
import 'package:vegas_lit/features/games/football/nfl/models/nfl_team.dart';
import 'package:vegas_lit/features/games/hockey/nhl/models/nhl_team.dart';

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
                (dynamic json) => MlbGame.fromMap(json as Map<String, dynamic>),
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
            (dynamic json) =>
                MlbTeamStats.fromMap(json as Map<String, dynamic>),
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
            (dynamic json) => MlbPlayer.fromMap(json as Map<String, dynamic>),
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

  Future<List<MlbTeam>> fetchMLBTeams() async {
    const leagueData = ConstantSportsDataAPI.mlb;

    final response = await _dio.get<Object>(
      'https://api.sportsdata.io/v3/${leagueData['league']}/scores/json/teams?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return parsed
          .map<MlbTeam>(
            (dynamic json) => MlbTeam.fromMap(json as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw FetchFailureTeams();
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
              (dynamic json) => NbaGame.fromMap(json as Map<String, dynamic>),
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
            (dynamic json) =>
                NbaTeamStats.fromMap(json as Map<String, dynamic>),
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
            (dynamic json) => NbaPlayer.fromMap(json as Map<String, dynamic>),
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

  Future<List<NbaTeam>> fetchNBATeams() async {
    const leagueData = ConstantSportsDataAPI.nba;

    final response = await _dio.get<Object>(
      'https://api.sportsdata.io/v3/${leagueData['league']}/scores/json/teams?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return parsed
          .map<NbaTeam>(
            (dynamic json) => NbaTeam.fromMap(json as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw FetchFailureTeams();
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
              (dynamic json) => NcaabGame.fromMap(json as Map<String, dynamic>),
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
            (dynamic json) =>
                NcaabTeamStats.fromMap(json as Map<String, dynamic>),
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
            (dynamic json) => NcaabPlayer.fromMap(json as Map<String, dynamic>),
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

  Future<List<NcaabTeam>> fetchNCAABTeams() async {
    const leagueData = ConstantSportsDataAPI.ncaab;

    final response = await _dio.get<Object>(
      'https://api.sportsdata.io/v3/${leagueData['league']}/scores/json/teams?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return parsed
          .map<NcaabTeam>(
            (dynamic json) => NcaabTeam.fromMap(json as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw FetchFailureTeams();
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
      formattedDates.map(
        (formattedDate) => _dio.get<Object>(
          'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate?key=${leagueData['key']}',
        ),
      ),
    );
    final games = <NcaafGame>[];
    for (final response in responses) {
      if (response.statusCode == 200) {
        final parsed = json.decode(json.encode(response.data)) as List;

        games.addAll(
          parsed
              .map<NcaafGame>(
                (dynamic json) =>
                    NcaafGame.fromMap(json as Map<String, dynamic>),
              )
              .toList(),
        );
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
            (dynamic json) =>
                NcaafTeamStats.fromMap(json as Map<String, dynamic>),
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
            (dynamic json) => NcaafPlayer.fromMap(json as Map<String, dynamic>),
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

  Future<List<NcaafTeam>> fetchNCAAFTeams() async {
    const leagueData = ConstantSportsDataAPI.ncaaf;

    final response = await _dio.get<Object>(
      'https://api.sportsdata.io/v3/${leagueData['league']}/scores/json/teams?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return parsed
          .map<NcaafTeam>(
            (dynamic json) => NcaafTeam.fromMap(json as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw FetchFailureTeams();
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
              (dynamic json) => NflGame.fromMap(json as Map<String, dynamic>),
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
            (dynamic json) =>
                NflTeamStats.fromMap(json as Map<String, dynamic>),
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
            (dynamic json) => NflPlayer.fromMap(json as Map<String, dynamic>),
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

  Future<List<NflTeam>> fetchNFLTeams() async {
    const leagueData = ConstantSportsDataAPI.nfl;

    final response = await _dio.get<Object>(
      'https://api.sportsdata.io/v3/${leagueData['league']}/scores/json/teams?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return parsed
          .map<NflTeam>(
            (dynamic json) => NflTeam.fromMap(json as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw FetchFailureTeams();
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
              (dynamic json) => NhlGame.fromMap(json as Map<String, dynamic>),
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
            (dynamic json) =>
                NhlTeamStats.fromMap(json as Map<String, dynamic>),
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
            (dynamic json) => NhlPlayer.fromMap(json as Map<String, dynamic>),
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

  Future<List<NhlTeam>> fetchNHLTeams() async {
    const leagueData = ConstantSportsDataAPI.nhl;

    final response = await _dio.get<Object>(
      'https://api.sportsdata.io/v3/${leagueData['league']}/scores/json/teams?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return parsed
          .map<NhlTeam>(
            (dynamic json) => NhlTeam.fromMap(json as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw FetchFailureTeams();
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
          .map<GolfTournament>((dynamic json) {
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
    } else {
      throw FetchFailureGolf();
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
      throw FetchFailureGolf();
    }
  }

  /// NASCAR
  ///
  /// All functions related to NASCAR.
  Future<Driver> fetchDriverDetails({required String driverId}) async {
    final response = await _dio.get<Object>(
      'https://api.sportsdata.io/nascar/v2/json/driver/$driverId?key=2567df976b82403592b9c12b3832a950',
    );
    if (response.statusCode == 200) {
      final parsed =
          json.decode(json.encode(response.data)) as Map<String, dynamic>;
      return Driver.fromMap(parsed);
    } else {
      throw FetchFailureNascarDriverDetails();
    }
  }

  Future<List<Driver>> fetchAllDrivers() async {
    final response = await _dio.get<Object>(
      'https://api.sportsdata.io/nascar/v2/json/drivers?key=2567df976b82403592b9c12b3832a950',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return parsed
          .map<Driver>(
            (dynamic json) => Driver.fromMap(json as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw FetchFailureNascarAllDriverDetails();
    }
  }

  Future<List<Race>> fetchAllRaces() async {
    final response = await _dio.get<Object>(
      'https://api.sportsdata.io/nascar/v2/json/drivers?key=2567df976b82403592b9c12b3832a950',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data)) as List;
      return parsed
          .map<Race>(
            (dynamic json) => Race.fromMap(json as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw FetchFailureNascarAllRaces();
    }
  }

  Future<RaceResults> fetchRaceResults({required String raceId}) async {
    final response = await _dio.get<Object>(
      'https://api.sportsdata.io/nascar/v2/json/driver/$raceId?key=2567df976b82403592b9c12b3832a950',
    );
    if (response.statusCode == 200) {
      final parsed =
          json.decode(json.encode(response.data)) as Map<String, dynamic>;
      return RaceResults.fromMap(parsed);
    } else {
      throw FetchFailureNascarRaceResults();
    }
  }
}

class FetchFailureTeamStats implements Exception {}

class FetchFailurePlayer implements Exception {}

class FetchFailureTeams implements Exception {}

class FetchFailurePlayerStats implements Exception {}

class FetchFailureNFL implements Exception {}

class FetchFailureNBA implements Exception {}

class FetchFailureMLB implements Exception {}

class FetchFailureNHL implements Exception {}

class FetchFailureNCAAF implements Exception {}

class FetchFailureNCAAB implements Exception {}

class FetchFailureCricket implements Exception {}

class FetchFailureGolf implements Exception {}

/// NASCAR
class FetchFailureNascarDriverDetails implements Exception {}

class FetchFailureNascarAllDriverDetails implements Exception {}

class FetchFailureNascarAllRaces implements Exception {}

class FetchFailureNascarRaceResults implements Exception {}
