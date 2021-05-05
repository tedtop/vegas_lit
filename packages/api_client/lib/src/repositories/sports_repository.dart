import 'package:api_client/src/models/game.dart';
import 'package:api_client/src/providers/sportsdata_api.dart';
import 'package:meta/meta.dart';

class SportsRepository {
  final _sportsProvider = SportsAPI();

  Future<List<Game>> fetchMLB({@required DateTime dateTime}) =>
      _sportsProvider.fetchMLB(dateTime: dateTime);

  Future<List<Game>> fetchNBA({@required DateTime dateTime}) =>
      _sportsProvider.fetchNBA(dateTime: dateTime);

  Future<List<Game>> fetchNCAAB({@required DateTime dateTime}) =>
      _sportsProvider.fetchNCAAB(dateTime: dateTime);

  Future<List<Game>> fetchNCAAF({@required DateTime dateTime}) =>
      _sportsProvider.fetchNCAAF(dateTime: dateTime);

  Future<List<Game>> fetchNFL({@required DateTime dateTime}) =>
      _sportsProvider.fetchNFL(dateTime: dateTime);

  Future<List<Game>> fetchNHL({@required DateTime dateTime}) =>
      _sportsProvider.fetchNHL(dateTime: dateTime);
}
