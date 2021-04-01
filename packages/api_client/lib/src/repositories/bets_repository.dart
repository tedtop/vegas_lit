import 'package:api_client/src/base_provider.dart';
import 'package:api_client/src/models/open_bets.dart';
import 'package:api_client/src/providers/database.dart';

class BetsRepository {
  final BaseDatabaseProvider _databaseProvider = DatabaseProvider();

  Stream<List<OpenBetsData>> fetchOpenBetsByUserId(String currentUserId) =>
      _databaseProvider.fetchOpenBetsById(currentUserId);

  Future<void> saveOpenBetsById({String currentUserId, Map openBetsData}) =>
      _databaseProvider.saveOpenBetsById(
        currentUserId: currentUserId,
        openBetsData: openBetsData,
      );
}
