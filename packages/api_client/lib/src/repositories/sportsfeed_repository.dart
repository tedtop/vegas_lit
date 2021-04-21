import 'package:api_client/src/models/game.dart';
import 'package:api_client/src/providers/sportsdata_api.dart';
import 'package:meta/meta.dart';

import '../base_provider.dart';

class SportsfeedRepository {
  final SportsDataProvider _baseSportsDataProvider = SportsDataAPI();

  Future<List<Game>> fetchGameListByLeague({
    @required String league,
    @required DateTime dateTimeEastern,
  }) =>
      _baseSportsDataProvider.fetchGameListByLeague(
        league: league,
        dateTimeEastern: dateTimeEastern,
      );
}
