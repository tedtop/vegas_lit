import 'package:meta/meta.dart';
import 'package:vegas_lit/data/dataproviders/cloud_firestore.dart';
import 'package:vegas_lit/data/models/bet.dart';

class BetsRepository {
  final _databaseProvider = CloudFirestore();

  Stream<List<BetData>> fetchOpenBets({@required String uid}) =>
      _databaseProvider.fetchOpenBets(uid: uid);

  Stream<List<BetData>> fetchBetHistory({
    @required String uid,
  }) =>
      _databaseProvider.fetchBetHistory(
        uid: uid,
      );

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

  Future<bool> isBetExist({@required String betId, @required String uid}) =>
      _databaseProvider.isBetExist(betId: betId, uid: uid);
}
