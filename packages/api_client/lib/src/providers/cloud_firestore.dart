import 'package:api_client/src/models/bet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../base_provider.dart';
import '../models/user.dart';

class CloudFirestore extends DatabaseProvider {
  CloudFirestore({FirebaseFirestore firebaseFirestore})
      : _firestoreData = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestoreData;

  // Sign Up Page
  @override
  Future<void> saveUserDetails(
      {@required Map userDataMap, @required String uid}) async {
    final currentUserReference = _firestoreData.collection('users').doc(uid);
    await currentUserReference.set(userDataMap, SetOptions(merge: true));
  }

  // Open Bets Page
  @override
  Stream<List<BetData>> fetchOpenBets({@required String uid}) {
    final openBetsData = _firestoreData
        .collection('bets')
        .where('user', isEqualTo: uid)
        .where('isClosed', isEqualTo: false)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => BetData.fromFirestore(e)).toList());
    return openBetsData;
  }

  // Bet History Page
  @override
  Stream<List<BetData>> fetchBetHistory({@required String uid}) {
    final betHistoryData = _firestoreData
        .collection('bets')
        .where('user', isEqualTo: uid)
        .where('isClosed', isEqualTo: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => BetData.fromFirestore(e)).toList());
    return betHistoryData;
  }

  // Bet Slip Page
  @override
  Future<void> saveBet({
    @required String uid,
    @required Map betDataMap,
    @required int cutBalance,
  }) async {
    await _firestoreData.collection('bets').add(betDataMap).then(
      (value) async {
        await value.set({'id': value.id, 'user': uid}, SetOptions(merge: true));
      },
    );
    await _firestoreData.collection('users').doc(uid).update({
      'numberBets': FieldValue.increment(1),
      'openBets': FieldValue.increment(1),
      'accountBalance': FieldValue.increment(-cutBalance),
    });
  }

  // Profile Page
  @override
  Stream<UserData> fetchUserData({@required String uid}) {
    final documentSnapshot = _firestoreData
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((event) => UserData.fromFirestore(event));
    return documentSnapshot;
  }

  // Leaderboard Page
  @override
  Stream<List<UserData>> fetchRankedUsers() {
    final documentSnapshot = _firestoreData
        .collection('users')
        .where('profit', isGreaterThan: 0)
        .orderBy('profit', descending: true)
        .limit(50)
        .snapshots();
    final userBetsList = documentSnapshot.map(
        (event) => event.docs.map((e) => UserData.fromFirestore(e)).toList());

    return userBetsList;
  }
}
