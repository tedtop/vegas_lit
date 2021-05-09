import 'package:api_client/src/models/bet.dart';
import 'package:api_client/src/models/purse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../models/user.dart';

class CloudFirestore {
  CloudFirestore({FirebaseFirestore firebaseFirestore})
      : _firestoreData = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestoreData;

  // Sign Up Page

  Future<void> saveUserDetails(
      {@required Map userDataMap, @required String uid}) async {
    final userReference = _firestoreData.collection('users').doc(uid);
    final purseReference = _firestoreData.collection('purse').doc(uid);
    final purseMap = Purse(
      accountBalance: 1000,
      totalBets: 0,
      totalLoseBets: 0,
      totalOpenBets: 0,
      totalRiskedAmount: 0,
      totalProfit: 0,
      totalWinBets: 0,
      uid: uid,
      potentialWinAmount: 0,
      biggestWinAmount: 0,
      username: userDataMap['username'],
    ).toMap();
    await userReference.set(userDataMap, SetOptions(merge: true));
    await purseReference.set(purseMap, SetOptions(merge: true));
  }

  // Open Bets Page

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

  Future<void> saveBet({
    @required String uid,
    @required Map betDataMap,
    @required int cutBalance,
  }) async {
    final betProfit = betDataMap['betProfit'] as int;
    final betAmount = betDataMap['betAmount'] as int;
    final docRef = _firestoreData.collection('bets').doc(betDataMap['id']);
    await docRef.set(betDataMap, SetOptions(merge: true)).then(
      (value) async {
        await docRef.set({'user': uid}, SetOptions(merge: true));
      },
    );
    await _firestoreData.collection('purse').doc(uid).update({
      'totalBets': FieldValue.increment(1),
      'totalOpenBets': FieldValue.increment(1),
      'accountBalance': FieldValue.increment(-cutBalance),
      'potentialWinAmount': FieldValue.increment(betProfit),
      'totalRiskedAmount': FieldValue.increment(betAmount),
    });
  }

  // Profile Page

  Stream<UserData> fetchUserData({@required String uid}) {
    final snapshot = _firestoreData
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((event) => UserData.fromFirestore(event));
    return snapshot;
  }

  Stream<Purse> fetchUserPurse({@required String uid}) {
    final snapshot = _firestoreData
        .collection('purse')
        .doc(uid)
        .snapshots()
        .map((event) => Purse.fromFirestore(event));
    return snapshot;
  }

  // Leaderboard Page

  Stream<List<Purse>> fetchRankedUsers() {
    final snapshot = _firestoreData
        .collection('purse')
        .where('totalProfit', isGreaterThan: 0)
        .orderBy('totalProfit', descending: true)
        .limit(50)
        .snapshots();
    final userPurseList = snapshot
        .map((event) => event.docs.map((e) => Purse.fromFirestore(e)).toList());

    return userPurseList;
  }

  Future<bool> isBetExist({String betId}) async {
    final isBetExist =
        await _firestoreData.collection('bets').doc(betId).get().then(
              (value) => value.exists,
            );
    return isBetExist;
  }

  Future<List<String>> fetchLeaderboardWeeks() async {
    final weeks = await _firestoreData.collection('leaderboard').get().then(
          (value) => value.docs.map((e) => e.id).toList(),
        );
    return weeks;
  }

  Future<List<Purse>> fetchLeaderboardWeeksUserData(
      {@required String week}) async {
    final userPurseList = await _firestoreData
        .collection('leaderboard')
        .doc(week)
        .collection('purse')
        .where('totalProfit', isGreaterThan: 0)
        .orderBy('totalProfit', descending: true)
        .limit(50)
        .get()
        .then(
          (value) => value.docs
              .map(
                (e) => Purse.fromFirestore(e),
              )
              .toList(),
        );
    return userPurseList;
  }
}
