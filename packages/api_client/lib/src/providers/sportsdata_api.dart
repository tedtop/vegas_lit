import 'dart:convert';

import 'package:api_client/src/base_provider.dart';
import 'package:api_client/src/config/api.dart';
import 'package:api_client/src/models/game.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class SportsAPI extends SportsProvider {
  SportsAPI({Dio dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  @override
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

  @override
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

  @override
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

  @override
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

  @override
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

  @override
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
}

class FetchFailureNFL implements Exception {}

class FetchFailureNBA implements Exception {}

class FetchFailureMLB implements Exception {}

class FetchFailureNHL implements Exception {}

class FetchFailureNCAAF implements Exception {}

class FetchFailureNCAAB implements Exception {}
