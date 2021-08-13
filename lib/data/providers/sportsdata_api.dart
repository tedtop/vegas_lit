import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/models/mlb/mlb_player_stats.dart';
import 'package:vegas_lit/data/models/mlb/mlb_team_stats.dart';
import 'package:vegas_lit/data/models/nba/nba_player_stats.dart';
import 'package:vegas_lit/data/models/nba/nba_team_stats.dart';
import 'package:vegas_lit/data/models/ncaab/ncaab_player_stats.dart';
import 'package:vegas_lit/data/models/ncaab/ncaab_team_stats.dart';
import 'package:vegas_lit/data/models/ncaaf/ncaaf_player_stats.dart';
import 'package:vegas_lit/data/models/ncaaf/ncaaf_team_stats.dart';
import 'package:vegas_lit/data/models/nfl/nfl_player_stats.dart';
import 'package:vegas_lit/data/models/nfl/nfl_team_stats.dart';
import 'package:vegas_lit/data/models/nhl/nfl_player_stats.dart';
import 'package:vegas_lit/data/models/nhl/nhl_team_stats.dart';

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
  Future<List<MlbGame>> fetchMLB(
      {@required DateTime dateTime, @required int days}) async {
    const leagueData = ConstantSportsDataAPI.mlb;
    final formattedDates = <String>[];
    for (var day = 0; day < days; day++) {
      formattedDates.add(
          DateFormat('yyyy-MMM-dd').format(dateTime.add(Duration(days: day))));
    }
    final responses =
        await Future.wait((formattedDates).map((formattedDate) => _dio.get(
              'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate?key=${leagueData['key']}',
            )));
    final games = <MlbGame>[];
    for (final response in responses) {
      if (response.statusCode == 200) {
        final parsed = json.decode(json.encode(response.data));

        games.addAll(parsed
            .map<MlbGame>(
              (json) => MlbGame.fromMap(json),
            )
            .toList());
      } else {
        throw FetchFailureMLB();
      }
    }
    return games;
  }

  Future<List<MlbTeamStats>> fetchMLBTeamStats(
      {@required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.mlb;
    final response = await _dio.get(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/TeamSeasonStats/${dateTime.year}?key=${leagueData['key']}');
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
      'https://fly.sportsdata.io/v3/${leagueData['league']}/stats/json/PlayerSeasonStatsByPlayer/${dateTime.year}/$playerId?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      return MlbPlayerStats.fromMap(parsed);
    } else {
      throw FetchFailurePlayerStats();
    }
  }

  // NBA
  Future<List<NbaGame>> fetchNBA(
      {@required DateTime dateTime, @required int days}) async {
    const leagueData = ConstantSportsDataAPI.nba;
    final formattedDates = <String>[];
    for (var day = 0; day < days; day++) {
      formattedDates.add(
          DateFormat('yyyy-MMM-dd').format(dateTime.add(Duration(days: day))));
    }
    final responses =
        await Future.wait((formattedDates).map((formattedDate) => _dio.get(
              'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate?key=${leagueData['key']}',
            )));
    final games = <NbaGame>[];
    for (final response in responses) {
      if (response.statusCode == 200) {
        final parsed = json.decode(json.encode(response.data));

        games.addAll(parsed
            .map<NbaGame>(
              (json) => NbaGame.fromMap(json),
            )
            .toList());
      } else {
        throw FetchFailureNBA();
      }
    }
    return games;
  }

  Future<List<NbaTeamStats>> fetchNBATeamStats(
      {@required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.nba;
    final response = await _dio.get(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/TeamSeasonStats/${dateTime.year}?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      return parsed
          .map<NbaTeamStats>(
            (json) => NbaTeamStats.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailureTeamStats();
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

  Future<NbaPlayerStats> fetchNBAPlayerStats(
      {@required String playerId, @required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.nba;
    final response = await _dio.get(
      'https://fly.sportsdata.io/v3/${leagueData['league']}/stats/json/PlayerSeasonStatsByPlayer/${dateTime.year}/$playerId?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      return NbaPlayerStats.fromMap(parsed);
    } else {
      throw FetchFailurePlayerStats();
    }
  }

  // NCAAB
  Future<List<NcaabGame>> fetchNCAAB(
      {@required DateTime dateTime, @required int days}) async {
    const leagueData = ConstantSportsDataAPI.ncaab;
    final formattedDates = <String>[];
    for (var day = 0; day < days; day++) {
      formattedDates.add(
          DateFormat('yyyy-MMM-dd').format(dateTime.add(Duration(days: day))));
    }
    final responses =
        await Future.wait((formattedDates).map((formattedDate) => _dio.get(
              'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate?key=${leagueData['key']}',
            )));
    final games = <NcaabGame>[];
    for (final response in responses) {
      if (response.statusCode == 200) {
        final parsed = json.decode(json.encode(response.data));

        games.addAll(parsed
            .map<NcaabGame>(
              (json) => NcaabGame.fromMap(json),
            )
            .toList());
      } else {
        throw FetchFailureNCAAB();
      }
    }
    return games;
  }

  Future<List<NcaabTeamStats>> fetchNCAABTeamStats(
      {@required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.ncaab;
    final response = await _dio.get(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/TeamSeasonStats/${dateTime.year}?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      return parsed
          .map<NcaabTeamStats>(
            (json) => NcaabTeamStats.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailureTeamStats();
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

  Future<NcaabPlayerStats> fetchNCAABPlayerStats(
      {@required String playerId, @required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.ncaab;
    final response = await _dio.get(
      'https://fly.sportsdata.io/v3/${leagueData['league']}/stats/json/PlayerSeasonStatsByPlayer/${dateTime.year}/$playerId?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      return NcaabPlayerStats.fromMap(parsed);
    } else {
      throw FetchFailurePlayerStats();
    }
  }

  // NCAAF
  Future<List<NcaafGame>> fetchNCAAF(
      {@required DateTime dateTime, @required int days}) async {
    const leagueData = ConstantSportsDataAPI.ncaaf;
    final formattedDates = <String>[];
    for (var day = 0; day < days; day++) {
      formattedDates.add(
          DateFormat('yyyy-MMM-dd').format(dateTime.add(Duration(days: day))));
    }
    final responses =
        await Future.wait((formattedDates).map((formattedDate) => _dio.get(
              'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate?key=${leagueData['key']}',
            )));
    final games = <NcaafGame>[];
    for (final response in responses) {
      if (response.statusCode == 200) {
        final parsed = json.decode(json.encode(response.data));

        games.addAll(parsed
            .map<NcaafGame>(
              (json) => NcaafGame.fromMap(json),
            )
            .toList());
      } else {
        throw FetchFailureNCAAB();
      }
    }
    return games;
  }

  Future<List<NcaafTeamStats>> fetchNCAAFTeamStats(
      {@required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.ncaaf;
    final response = await _dio.get(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/TeamSeasonStats/${dateTime.year}?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      return parsed
          .map<NcaafTeamStats>(
            (json) => NcaafTeamStats.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailureTeamStats();
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

  Future<NcaafPlayerStats> fetchNCAAFPlayerStats(
      {@required String playerId, @required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.ncaaf;
    final response = await _dio.get(
      'https://fly.sportsdata.io/v3/${leagueData['league']}/stats/json/PlayerSeasonStatsByPlayer/${dateTime.year}/$playerId?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      return NcaafPlayerStats.fromMap(parsed);
    } else {
      throw FetchFailurePlayerStats();
    }
  }

  // NFL
  Future<List<NflGame>> fetchNFL(
      {@required DateTime dateTime, @required int days}) async {
    const leagueData = ConstantSportsDataAPI.nfl;
    final formattedDates = <String>[];
    for (var day = 0; day < days; day++) {
      formattedDates.add(
          DateFormat('yyyy-MMM-dd').format(dateTime.add(Duration(days: day))));
    }
    final responses =
        await Future.wait((formattedDates).map((formattedDate) => _dio.get(
              'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/ScoresByDate/$formattedDate?key=${leagueData['key']}',
            )));
    final games = <NflGame>[];
    for (final response in responses) {
      if (response.statusCode == 200) {
        final parsed = json.decode(json.encode(response.data));

        games.addAll(parsed
            .map<NflGame>(
              (json) => NflGame.fromMap(json),
            )
            .toList());
      } else {
        throw FetchFailureNFL();
      }
    }
    return games;
  }

  Future<List<NflTeamStats>> fetchNFLTeamStats(
      {@required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.nfl;
    final response = await _dio.get(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/TeamSeasonStats/${dateTime.year}?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      return parsed
          .map<NflTeamStats>(
            (json) => NflTeamStats.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailureTeamStats();
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

  Future<NflPlayerStats> fetchNFLPlayerStats(
      {@required String playerId, @required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.nfl;
    final response = await _dio.get(
      'https://fly.sportsdata.io/v3/${leagueData['league']}/stats/json/PlayerSeasonStatsByPlayerID/${dateTime.year}/$playerId?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      return NflPlayerStats.fromMap(parsed);
    } else {
      throw FetchFailurePlayerStats();
    }
  }

  // NHL
  Future<List<NhlGame>> fetchNHL(
      {@required DateTime dateTime, @required int days}) async {
    const leagueData = ConstantSportsDataAPI.nhl;
    final formattedDates = <String>[];
    for (var day = 0; day < days; day++) {
      formattedDates.add(
          DateFormat('yyyy-MMM-dd').format(dateTime.add(Duration(days: day))));
    }
    final responses =
        await Future.wait((formattedDates).map((formattedDate) => _dio.get(
              'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate?key=${leagueData['key']}',
            )));
    final games = <NhlGame>[];
    for (final response in responses) {
      if (response.statusCode == 200) {
        final parsed = json.decode(json.encode(response.data));

        games.addAll(parsed
            .map<NhlGame>(
              (json) => NhlGame.fromMap(json),
            )
            .toList());
      } else {
        throw FetchFailureNHL();
      }
    }
    return games;
  }

  Future<List<NhlTeamStats>> fetchNHLTeamStats(
      {@required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.nhl;
    final response = await _dio.get(
        'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/TeamSeasonStats/${dateTime.year}?key=${leagueData['key']}');
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      return parsed
          .map<NhlTeamStats>(
            (json) => NhlTeamStats.fromMap(json),
          )
          .toList();
    } else {
      throw FetchFailureTeamStats();
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

  Future<NhlPlayerStats> fetchNHLPlayerStats(
      {@required String playerId, @required DateTime dateTime}) async {
    const leagueData = ConstantSportsDataAPI.nhl;
    final response = await _dio.get(
      'https://fly.sportsdata.io/v3/${leagueData['league']}/stats/json/PlayerSeasonStatsByPlayer/${dateTime.year}/$playerId?key=${leagueData['key']}',
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      return NhlPlayerStats.fromMap(parsed);
    } else {
      throw FetchFailurePlayerStats();
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
