import 'package:api_client/src/base_provider.dart';
import 'package:api_client/src/models/open_bet.dart';
import 'package:api_client/src/providers/cloud_firestore.dart';
import 'package:meta/meta.dart';

class BetsRepository {
  final DatabaseProvider _databaseProvider = CloudFirestore();

  Stream<List<OpenBetsData>> fetchOpenBets({
    @required String uid,
  }) =>
      _databaseProvider.fetchOpenBets(uid: uid);

  Future<void> saveBets({
    @required String uid,
    @required Map openBetsDataMap,
  }) =>
      _databaseProvider.saveBets(
        uid: uid,
        openBetsDataMap: openBetsDataMap,
      );
}
