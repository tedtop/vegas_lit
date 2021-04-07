import 'package:api_client/src/models/game.dart';
import 'package:api_client/src/models/game_new.dart';
import 'package:api_client/src/providers/sportsfeed.dart';
import 'package:api_client/src/providers/sportsdata.dart';
import 'package:meta/meta.dart';

class SportsfeedRepository {
  final _baseSportsFeedProvider = SportsFeedProvider();
  final _baseSportsDataProvider = SportsDataProvider();

  Future<List<Game>> fetchGameListByGame({String gameName}) =>
      _baseSportsFeedProvider.fetchGameListByGame(gameName: gameName);

  Future<List<Game>> fetchGameListByNewGame(
          {@required String gameName, @required DateTime dateTime}) =>
      _baseSportsDataProvider.fetchGameListByNewGame(
          gameName: gameName, dateTimeEastern: dateTime);
}
