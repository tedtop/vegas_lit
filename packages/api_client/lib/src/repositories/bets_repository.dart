import 'package:api_client/src/models/bet.dart';
import 'package:api_client/src/providers/cloud_firestore.dart';
import 'package:meta/meta.dart';

class BetsRepository {
  final _databaseProvider = CloudFirestore();

  Stream<List<BetData>> fetchOpenBets({@required String uid}) =>
      _databaseProvider.fetchOpenBets(uid: uid);

  Stream<List<BetData>> fetchBetHistory({@required String uid}) =>
      _databaseProvider.fetchBetHistory(uid: uid);

  Future<void> saveBet({
    @required String uid,
    @required Map openBetsDataMap,
    @required int cutBalance,
  }) =>
      _databaseProvider.saveBet(
        uid: uid,
        betDataMap: openBetsDataMap,
        cutBalance: cutBalance,
      );

  Future<bool> isBetExist({@required String betId}) =>
      _databaseProvider.isBetExist(betId: betId);
}
