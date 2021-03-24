import 'package:api_client/src/models/game.dart';
import 'package:api_client/src/providers/sportspage.dart';

class SportsfeedRepository {
  final _baseSportsfeedProvider = SportsfeedProvider();

  Future<List<Game>> fetchGameList() => _baseSportsfeedProvider.fetchGameList();
  Future<List<Game>> fetchGameListByGame({String gameName}) =>
      _baseSportsfeedProvider.fetchGameListByGame(gameName: gameName);
}
