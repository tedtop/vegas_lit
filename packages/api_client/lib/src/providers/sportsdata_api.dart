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
  Future<List<Game>> fetchGameCommon({
    @required String league,
    @required DateTime dateTime,
  }) async {
    final formattedLeague = whichGame(league: league);
    final formattedDate = DateFormat('yyyy-MMM-dd').format(dateTime);

    final response = await _dio.get(
      'https://fly.sportsdata.io/v3/$formattedLeague/scores/json/GamesByDate/$formattedDate',
      options: Options(
        headers: {
          'Ocp-Apim-Subscription-Key': whichKey(league: league),
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
    } else {}
  }

  // ignore: missing_return
  String whichGame({@required String league}) {
    switch (league) {
      case 'NBA':
        return 'nba';
        break;
      case 'MLB':
        return 'mlb';
        break;
      case 'NHL':
        return 'nhl';
        break;
      case 'NCAAB':
        return 'cbb';
        break;
      default:
        break;
    }
  }

  // ignore: missing_return
  String whichKey({@required String league}) {
    switch (league) {
      case 'NBA':
        return ConstantSportsDataAPI.nba;
        break;
      case 'MLB':
        return ConstantSportsDataAPI.mlb;
        break;
      case 'NHL':
        return ConstantSportsDataAPI.nhl;
        break;
      case 'NCAAB':
        return ConstantSportsDataAPI.ncaab;
        break;
      default:
        break;
    }
  }
}

class FetchGameListByLeagueFailure implements Exception {}
