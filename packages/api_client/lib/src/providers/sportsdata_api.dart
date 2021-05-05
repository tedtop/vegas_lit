import 'dart:convert';

import 'package:api_client/src/config/api.dart';
import 'package:api_client/src/models/game.dart';
import 'package:api_client/src/models/golf.dart';
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
      'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate',
      options: Options(
        headers: {
          'Ocp-Apim-Subscription-Key': leagueData['key'],
        },
      ),
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
      'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate',
      options: Options(
        headers: {
          'Ocp-Apim-Subscription-Key': leagueData['key'],
        },
      ),
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
      'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate',
      options: Options(
        headers: {
          'Ocp-Apim-Subscription-Key': leagueData['key'],
        },
      ),
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
      'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate',
      options: Options(
        headers: {
          'Ocp-Apim-Subscription-Key': leagueData['key'],
        },
      ),
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
      'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate',
      options: Options(
        headers: {
          'Ocp-Apim-Subscription-Key': leagueData['key'],
        },
      ),
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
      'https://fly.sportsdata.io/v3/${leagueData['league']}/scores/json/GamesByDate/$formattedDate',
      options: Options(
        headers: {
          'Ocp-Apim-Subscription-Key': leagueData['key'],
        },
      ),
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

  @override
  Future<List<GolfTournament>> fetchGolfTournaments({
    DateTime dateTimeEastern,
  }) async {
    const leagueData = ConstantSportsDataAPI.golf;
    final formattedYear = DateFormat('yyyy').format(dateTimeEastern);

    final response = await _dio.get(
      'https://fly.sportsdata.io/golf/v2/json/Tournaments/$formattedYear',
      options: Options(
        headers: {
          'Ocp-Apim-Subscription-Key': leagueData['key'],
        },
      ),
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      //final filteredTournaments = <GolfTournament>[];
      final List<GolfTournament> allTournaments =
          parsed.map<GolfTournament>((json) {
        return GolfTournament.fromMap(json);
      }).toList();
      // allTournaments.forEach((tournament) {
      //   if (tournament != null &&
      //       tournament.endDate
      //           .isBefore(dateTimeEastern.add(const Duration(days: 5))) &&
      //       tournament.endDate
      //           .isAfter(dateTimeEastern.subtract(const Duration(days: 1)))) {
      //     filteredTournaments.add(tournament);
      //   }
      // });
      // return filteredTournaments;
      return allTournaments;
    } else {
      throw FetchGolfFailure();
    }
  }

  @override
  Future<GolfLeaderboard> fetchGolfLeaderboard(
      {@required int tournamentID}) async {
    const leagueData = ConstantSportsDataAPI.golf;

    final response = await _dio.get(
        'https://fly.sportsdata.io/golf/v2/json/Leaderboard/$tournamentID',
        options: Options(
          headers: {
            'Ocp-Apim-Subscription-Key': leagueData['key'],
          },
        ));
    if (response.statusCode == 200) {
      final parsed = json.decode(json.encode(response.data));
      final leaderboard = GolfLeaderboard.fromMap(parsed);
      return leaderboard;
    } else {
      throw FetchGolfFailure();
    }
  }
}

class FetchFailureNFL implements Exception {}

class FetchFailureNBA implements Exception {}

class FetchFailureMLB implements Exception {}

class FetchFailureNHL implements Exception {}

class FetchFailureNCAAF implements Exception {}

class FetchFailureNCAAB implements Exception {}

class FetchGolfFailure implements Exception {}
