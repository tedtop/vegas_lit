import 'package:api_client/src/models/bet.dart';
import 'package:api_client/src/models/wallet.dart';
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
    final walletReference = _firestoreData.collection('wallets').doc(uid);
    final walletMap = Wallet(
      accountBalance: 1000,
      totalBets: 0,
      totalBetsLost: 0,
      totalLoss: 0,
      totalOpenBets: 0,
      totalRiskedAmount: 0,
      totalProfit: 0,
      totalBetsWon: 0,
      uid: uid,
      potentialWinAmount: 0,
      biggestWinAmount: 0,
      username: userDataMap['username'],
    ).toMap();
    await userReference.set(userDataMap, SetOptions(merge: true));
    await walletReference.set(walletMap, SetOptions(merge: true));
  }

  Future<bool> isProfileComplete({@required String uid}) async {
    final snapshot = await _firestoreData.collection('users').doc(uid).get();

    final isProfileComplete = snapshot != null &&
        snapshot.exists &&
        snapshot.data().containsKey('uid');
    return isProfileComplete;
  }

  // Open Bets Page

  Stream<List<BetData>> fetchOpenBets({@required String uid}) {
    final openBetsData = _firestoreData
        .collection('bets')
        .where('user', isEqualTo: uid)
        .where('isClosed', isEqualTo: false)
        .orderBy('dateTime', descending: true)
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
        .orderBy('dateTime', descending: true)
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
    await _firestoreData.collection('wallets').doc(uid).update({
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

  Stream<Wallet> fetchUserWallet({@required String uid}) {
    final snapshot = _firestoreData
        .collection('wallets')
        .doc(uid)
        .snapshots()
        .map((event) => Wallet.fromFirestore(event));
    return snapshot;
  }

  // Leaderboard Page

  Stream<List<Wallet>> fetchRankedUsers() {
    final snapshot = _firestoreData
        .collection('wallets')
        .where('totalBets', isGreaterThan: 5)
        // .orderBy('totalProfit', descending: true)
        .limit(100)
        .snapshots();
    final userWalletList = snapshot.map(
      (event) => event.docs
          .map(
            (e) => Wallet.fromFirestore(e),
          )
          .toList(),
    );

    return userWalletList;
  }

  Future<bool> isBetExist(
      {@required String betId, @required String uid}) async {
    final isBetExist = await _firestoreData
        .collection('bets')
        .where('id', isEqualTo: betId)
        .where('user', isEqualTo: uid)
        .get()
        .then(
          (value) => value.docs
              .map(
                (e) => e.exists,
              )
              .toList()
              .isNotEmpty,
        );
    return isBetExist;
  }

  Future<bool> isUsernameExist({@required String username}) async {
    final documentSnapshot = await _firestoreData
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
    final isUsernameExist = documentSnapshot.docs.isNotEmpty;
    return isUsernameExist;
  }

  Future<List<String>> fetchLeaderboardDays() async {
    final days = await _firestoreData.collection('leaderboard').get().then(
          (value) => value.docs.map((e) => e.id).toList(),
        );
    return days;
  }

  Future<List<Wallet>> fetchLeaderboardDaysUserData(
      {@required String day}) async {
    final userWalletList = await _firestoreData
        .collection('leaderboard')
        .doc(day)
        .collection('wallets')
        .where('totalBets', isGreaterThan: 5)
        // .orderBy('totalProfit', descending: true)
        .limit(100)
        .get()
        .then(
          (value) => value.docs
              .map(
                (e) => Wallet.fromFirestore(e),
              )
              .toList(),
        );
    return userWalletList;
  }

  Future<String> fetchMinimumVersion() async {
    final minimumVersion =
        await _firestoreData.collection('constants').doc('version').get().then(
              (value) => value.data()['minimumVersion'] as String,
            );

    return minimumVersion;
  }

  Future<void> rewardBalance({
    @required String uid,
    @required int rewardValue,
  }) async {
    await _firestoreData.collection('wallets').doc(uid).update({
      // 'totalRewards': FieldValue.increment(1),
      'accountBalance': FieldValue.increment(rewardValue),
    });
  }
}
