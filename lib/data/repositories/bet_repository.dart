import '../models/bet.dart';
import '../providers/cloud_firestore.dart';

class BetRepository {
  BetRepository({
    CloudFirestoreClient? databaseProvider,
  }) : _databaseProvider = databaseProvider ?? CloudFirestoreClient();

  final CloudFirestoreClient _databaseProvider;

  Stream<List<BetData>> fetchOpenBets({required String uid}) =>
      _databaseProvider.fetchOpenBets(uid: uid);

  Future<void> saveBet({
    required String? uid,
    required BetData betsData,
    required int cutBalance,
  }) =>
      _databaseProvider.saveBets(
        uid: uid,
        betsData: betsData,
        cutBalance: cutBalance,
      );

  Future<bool> isBetExist({required String? betId, required String? uid}) =>
      _databaseProvider.isBetExist(betId: betId, uid: uid);
}
