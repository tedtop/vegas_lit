import 'dart:convert';

import 'package:api_client/api_client.dart';
import 'package:api_client/src/models/game.dart';
import 'package:dio/dio.dart';

import '../base_provider.dart';

class SportsFeedProvider extends BaseSportsfeedProvider {
  SportsFeedProvider({Dio dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  @override
  Future<List<Game>> fetchGameListByGame({String gameName}) async {
    final response = await _dio.get(
      'https://sportspage-feeds.p.rapidapi.com/games',
      queryParameters: {"league": "$gameName"},
      options: Options(
        headers: {
          // 'x-rapidapi-key': '$rapidApiKey',
          // 'x-rapidapi-host': '$rapidApiUrl',
          'useQueryString': true
        },
      ),
    );
    if (response.statusCode == 200) {
      final List<dynamic> parsed =
          json.decode(json.encode(response.data))["results"];
      return parsed
          .map<Game>(
            (json) => Game.fromJson(json),
          )
          .toList();
    } else {
      throw FetchGameListByGameFailure();
    }
  }
}

class FetchGameListByGameFailure implements Exception {}
