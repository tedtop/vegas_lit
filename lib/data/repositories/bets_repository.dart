import 'package:meta/meta.dart';
import 'package:vegas_lit/data/dataproviders/cloud_firestore.dart';
import 'package:vegas_lit/data/models/bet.dart';

class BetsRepository {
  final _databaseProvider = CloudFirestoreClient();

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
    @required BetData betsData,
    @required int cutBalance,
  }) =>
      _databaseProvider.saveBets(
        uid: uid,
        betsData: betsData,
        cutBalance: cutBalance,
      );

  Future<bool> isBetExist({@required String betId, @required String uid}) =>
      _databaseProvider.isBetExist(betId: betId, uid: uid);
}
