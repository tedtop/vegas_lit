import 'dart:convert';

import 'package:api_client/src/base_provider.dart';
import 'package:api_client/src/config/sports_api.dart';
import 'package:api_client/src/models/game_new.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class SportsDataProvider extends BaseSportsdataProvider {
  SportsDataProvider({Dio dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  @override
  Future<List<Game>> fetchGameListByNewGame({String gameName}) async {
    final newGameName = whichGame(gameName: gameName);
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MMM-dd').format(now);

    final response = await _dio.get(
      'https://fly.sportsdata.io/v3/$newGameName/scores/json/GamesByDate/$formattedDate',
      options: Options(
        headers: {
          'Ocp-Apim-Subscription-Key': whichKey(gameName: gameName),
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
      throw FetchGameListByGameFailure();
    }
  }

  // ignore: missing_return
  String whichGame({String gameName}) {
    switch (gameName) {
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
  String whichKey({String gameName}) {
    switch (gameName) {
      case 'NBA':
        return SportsDataApi.nba;
        break;
      case 'MLB':
        return SportsDataApi.mlb;
        break;
      case 'NHL':
        return SportsDataApi.nhl;
        break;
      case 'NCAAB':
        return SportsDataApi.ncaab;
        break;
      default:
        break;
    }
  }
}

class FetchGameListByGameFailure implements Exception {}
