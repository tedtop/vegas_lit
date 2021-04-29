import 'package:api_client/src/base_provider.dart';
import 'package:api_client/src/models/bet.dart';
import 'package:api_client/src/providers/cloud_firestore.dart';
import 'package:meta/meta.dart';

class BetsRepository {
  final DatabaseProvider _databaseProvider = CloudFirestore();

  Stream<List<BetData>> fetchOpenBets({
    @required String uid,
  }) =>
      _databaseProvider.fetchOpenBets(uid: uid);

  Stream<List<BetData>> fetchBetHistory({
    @required String uid,
  }) =>
      _databaseProvider.fetchBetHistory(uid: uid);

  Future<void> saveBets({
    @required String uid,
    @required Map openBetsDataMap,
  }) =>
      _databaseProvider.saveBets(
        uid: uid,
        openBetsDataMap: openBetsDataMap,
      );

  Future<void> updateUserBets({
    @required String uid,
    @required int cutBalance,
  }) =>
      _databaseProvider.updateUserBets(
        uid: uid,
        cutBalance: cutBalance,
      );
}
