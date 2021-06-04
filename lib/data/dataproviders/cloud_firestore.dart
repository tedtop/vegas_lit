import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../models/bet.dart';
import '../models/user.dart';
import '../models/vault_data.dart';
import '../models/wallet.dart';

class CloudFirestoreClient {
  CloudFirestoreClient({FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firebaseFirestore;

  // Sign Up Page

  Future<void> saveUserDetails({
    @required UserData user,
    @required String uid,
  }) async {
    final userDetailsWriteBatch = _firebaseFirestore.batch();
    final userReference = _firebaseFirestore.collection('users').doc(uid);
    final walletReference = _firebaseFirestore.collection('wallets').doc(uid);
    final wallet = Wallet(
      accountBalance: 1000,
      totalBets: 0,
      totalBetsLost: 0,
      totalLoss: 0,
      totalOpenBets: 0,
      totalRiskedAmount: 0,
      totalProfit: 0,
      rank: 0,
      totalBetsWon: 0,
      uid: uid,
      potentialWinAmount: 0,
      biggestWinAmount: 0,
      username: user.username,
      totalRewards: 0,
      pendingRiskedAmount: 0,
    );
    userDetailsWriteBatch
      ..set(userReference, user.toMap(), SetOptions(merge: true))
      ..set(walletReference, wallet.toMap(), SetOptions(merge: true));
    await userDetailsWriteBatch.commit();
  }

  Future<bool> isProfileComplete({@required String uid}) async {
    final snapshot =
        await _firebaseFirestore.collection('users').doc(uid).get();

    final isProfileComplete = snapshot != null &&
        snapshot.exists &&
        snapshot.data().containsKey('uid');
    return isProfileComplete;
  }

  // Open Bets Page

  Stream<List<BetData>> fetchOpenBets({@required String uid}) {
    final openBetsData = _firebaseFirestore
        .collection('bets')
        .where('uid', isEqualTo: uid)
        .where('isClosed', isEqualTo: false)
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => BetData.fromFirestore(e),
              )
              .toList(),
        );
    return openBetsData;
  }

  // Bet History Page

  Stream<List<BetData>> fetchBetHistory({
    @required String uid,
  }) {
    final betHistoryData = _firebaseFirestore
        .collection('bets')
        .where('uid', isEqualTo: uid)
        .where('isClosed', isEqualTo: true)
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => BetData.fromFirestore(e),
              )
              .toList(),
        );
    return betHistoryData;
  }

  // Bet Slip Page

  Future<void> saveBets({
    @required String uid,
    @required BetData betsData,
    @required int cutBalance,
  }) async {
    final saveBetsWrite = _firebaseFirestore.batch();

    final betsReference =
        _firebaseFirestore.collection('bets').doc(betsData.id);
    final walletReference = _firebaseFirestore.collection('wallets').doc(uid);

    saveBetsWrite
      ..set(betsReference, betsData.toMap(), SetOptions(merge: true))
      ..update(
        walletReference,
        {
          'totalBets': FieldValue.increment(1),
          'totalOpenBets': FieldValue.increment(1),
          'accountBalance': FieldValue.increment(-cutBalance),
          'potentialWinAmount': FieldValue.increment(betsData.betProfit),
          'totalRiskedAmount': FieldValue.increment(betsData.betAmount),
          'pendingRiskedAmount': FieldValue.increment(betsData.betAmount),
        },
      );
    await saveBetsWrite.commit();
    await _saveToAdminVault(betsData: betsData);
  }

  Future<void> _saveToAdminVault({@required BetData betsData}) async {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final saveAdminVaultWrite = _firebaseFirestore.batch();
    final dailyReference = _firebaseFirestore
        .collection('vault')
        .doc('regular')
        .collection('daily')
        .doc(dateFormat.format(DateTime.now()));
    final cumulativeReference =
        _firebaseFirestore.collection('vault').doc('cumulative');
    saveAdminVaultWrite
      ..set(
        dailyReference,
        {
          'moneyIn': FieldValue.increment(betsData.betAmount),
          'moneyOut': FieldValue.increment(betsData.betProfit),
          'numberOfBets': FieldValue.increment(1),
          'date': dateFormat.format(DateTime.now()),
        },
        SetOptions(merge: true),
      )
      ..set(
        cumulativeReference,
        {
          'moneyIn': FieldValue.increment(betsData.betAmount),
          'moneyOut': FieldValue.increment(betsData.betProfit),
          'numberOfBets': FieldValue.increment(1),
        },
        SetOptions(merge: true),
      );
    await saveAdminVaultWrite.commit();
  }

  // Vault Page
  Stream<List<VaultItem>> fetchAllDataDateWise() {
    final vaultSnapshot = _firebaseFirestore
        .collection('vault')
        .doc('regular')
        .collection('daily')
        .limit(10)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (element) => VaultItem.fromFirestore(element),
              )
              .toList(),
        );
    return vaultSnapshot;
  }

  Future<VaultItem> fetchCumulativeAdminVaultData() {
    final cumulativeData =
        _firebaseFirestore.collection('vault').doc('cumulative').get().then(
              (value) => VaultItem.fromFirestore(
                value,
              ),
            );

    return cumulativeData;
  }

  // Profile Page

  Stream<UserData> fetchUserData({@required String uid}) {
    final snapshot = _firebaseFirestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((event) => UserData.fromFirestore(event));
    return snapshot;
  }

  Stream<Wallet> fetchUserWallet({@required String uid}) {
    final snapshot = _firebaseFirestore
        .collection('wallets')
        .doc(uid)
        .snapshots()
        .map((event) => Wallet.fromFirestore(event));
    return snapshot;
  }

  // Leaderboard Page

  Stream<List<Wallet>> fetchRankedUsers() {
    final snapshot = _firebaseFirestore
        .collection('wallets')
        .where('totalBets', isGreaterThan: 5)
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
    final isBetExist = await _firebaseFirestore
        .collection('bets')
        .where('id', isEqualTo: betId)
        .where('uid', isEqualTo: uid)
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
    final documentSnapshot = await _firebaseFirestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
    final isUsernameExist = documentSnapshot.docs.isNotEmpty;
    return isUsernameExist;
  }

  Future<List<String>> fetchLeaderboardDays() async {
    final days = await _firebaseFirestore
        .collection('leaderboard')
        .doc('global')
        .collection('weeks')
        .get()
        .then(
          (value) => value.docs.map((e) => e.id).toList(),
        );
    return days;
  }

  Future<List<Wallet>> fetchLeaderboardDaysUserData(
      {@required String week}) async {
    final userWalletList = await _firebaseFirestore
        .collection('leaderboard')
        .doc('global')
        .collection('weeks')
        .doc(week)
        .collection('wallets')
        .where('totalBets', isGreaterThan: 3)
        .limit(50)
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
    final minimumVersion = await _firebaseFirestore
        .collection('constants')
        .doc('version')
        .get()
        .then(
          (value) => value.data()['minimumVersion'] as String,
        );

    return minimumVersion;
  }

  Future<void> rewardBalance({
    @required String uid,
    @required int rewardValue,
  }) async {
    await _firebaseFirestore.collection('wallets').doc(uid).update({
      'totalRewards': FieldValue.increment(rewardValue),
      'accountBalance': FieldValue.increment(rewardValue),
    });
  }
}
