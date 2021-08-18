import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/config/extensions.dart';
import 'package:vegas_lit/data/models/mlb/mlb_bet.dart';
import 'package:vegas_lit/data/models/nba/nba_bet.dart';
import 'package:vegas_lit/data/models/ncaab/ncaab_bet.dart';
import 'package:vegas_lit/data/models/ncaaf/ncaaf_bet.dart';
import 'package:vegas_lit/data/models/nfl/nfl_bet.dart';
import 'package:vegas_lit/data/models/nhl/nhl_bet.dart';
import 'package:vegas_lit/data/models/olympics/olympic_bet.dart';
import 'package:vegas_lit/data/models/olympics/olympics.dart';
import 'package:vegas_lit/data/models/group.dart';
import '../models/bet.dart';
import '../models/user.dart';
import '../models/vault_data.dart';
import '../models/wallet.dart';

class CloudFirestoreClient {
  CloudFirestoreClient({FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firebaseFirestore;

  Future<void> saveUserDetails({
    @required UserData user,
    @required String uid,
  }) async {
    final userDetailsWriteBatch = _firebaseFirestore.batch();
    final userReference = _firebaseFirestore.collection('users').doc(uid);
    final walletReference = _firebaseFirestore.collection('wallets').doc(uid);
    final wallet = Wallet(
        accountBalance: 1000,
        todayRewards: 0,
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
        avatarUrl: user.avatarUrl);
    userDetailsWriteBatch
      ..set(userReference, user.toMap(), SetOptions(merge: true))
      ..set(walletReference, wallet.toMap(), SetOptions(merge: true));
    await userDetailsWriteBatch.commit();
  }

  Future<void> updateUserDetails(
      {@required UserData user, @required String uid}) async {
    final userDetailsUpdateBatch = _firebaseFirestore.batch();
    final userReference = _firebaseFirestore.collection('users').doc(uid);
    final walletReference = _firebaseFirestore.collection('wallets').doc(uid);
    final walletData = {'username': user.username};
    userDetailsUpdateBatch
      ..set(userReference, user.toMap(), SetOptions(merge: true))
      ..set(walletReference, walletData, SetOptions(merge: true));
    await userDetailsUpdateBatch.commit();
  }

  Future<bool> isProfileComplete({@required String uid}) async {
    final snapshot =
        await _firebaseFirestore.collection('users').doc(uid).get();

    final isProfileComplete = snapshot != null &&
        snapshot.exists &&
        snapshot.data().containsKey('uid');
    return isProfileComplete;
  }

  Future<void> updateUserAvatar(
      {@required String avatarUrl, @required String uid}) async {
    final userAvatarUpdateBatch = _firebaseFirestore.batch();
    final userReference = _firebaseFirestore.collection('users').doc(uid);
    final walletReference = _firebaseFirestore.collection('wallets').doc(uid);
    final avatarData = {
      'avatarUrl': avatarUrl,
    };
    userAvatarUpdateBatch
      ..set(userReference, avatarData, SetOptions(merge: true))
      ..set(walletReference, avatarData, SetOptions(merge: true));
    await userAvatarUpdateBatch.commit();
  }

  Stream<List<BetData>> fetchOpenBets({@required String uid}) {
    final openBetsData = _firebaseFirestore
        .collection('bets')
        .where('uid', isEqualTo: uid)
        .where('isClosed', isEqualTo: false)
        .orderBy('gameStartDateTime', descending: true)
        .snapshots()
        .map(
          (event) => event.docs.map(
            (snapshot) {
              switch (snapshot.data()['league'] as String) {
                case 'mlb':
                  return MlbBetData.fromFirestore(snapshot);
                  break;
                case 'nba':
                  return NbaBetData.fromFirestore(snapshot);
                  break;
                case 'cbb':
                  return NcaabBetData.fromFirestore(snapshot);
                  break;
                case 'cfb':
                  return NcaafBetData.fromFirestore(snapshot);
                  break;
                case 'nfl':
                  return NflBetData.fromFirestore(snapshot);
                  break;
                case 'nhl':
                  return NhlBetData.fromFirestore(snapshot);
                  break;
                case 'olympics':
                  return OlympicsBetData.fromFirestore(snapshot);
                  break;
                default:
                  return BetData.fromFirestore(snapshot);
              }
            },
          ).toList(),
        );
    return openBetsData;
  }

  Stream<List<BetData>> fetchBetHistoryByWeek({
    @required String uid,
    @required String week,
  }) {
    final betHistoryData = _firebaseFirestore
        .collection('bets')
        .where('uid', isEqualTo: uid)
        .where('isClosed', isEqualTo: true)
        .where('week', isEqualTo: week)
        .orderBy('gameStartDateTime', descending: true)
        .snapshots()
        .map(
          (event) => event.docs.map(
            (snapshot) {
              switch (snapshot.data()['league'] as String) {
                case 'mlb':
                  return MlbBetData.fromFirestore(snapshot);
                  break;
                case 'nba':
                  return NbaBetData.fromFirestore(snapshot);
                  break;
                case 'cbb':
                  return NcaabBetData.fromFirestore(snapshot);
                  break;
                case 'cfb':
                  return NcaafBetData.fromFirestore(snapshot);
                  break;
                case 'nfl':
                  return NflBetData.fromFirestore(snapshot);
                  break;
                case 'nhl':
                  return NhlBetData.fromFirestore(snapshot);
                  break;
                case 'olympics':
                  return OlympicsBetData.fromFirestore(snapshot);
                  break;
                default:
                  return BetData.fromFirestore(snapshot);
              }
            },
          ).toList(),
        );
    return betHistoryData;
  }

  Future<bool> isUserWalletExistByWeek({
    @required String uid,
    @required String week,
  }) async {
    final snapshot = await _firebaseFirestore
        .collection('leaderboard')
        .doc('global')
        .collection('weeks')
        .doc(week)
        .collection('wallets')
        .doc(uid)
        .get();

    final isWalletExist = snapshot != null && snapshot.exists;

    return isWalletExist;
  }

  Future<Wallet> fetchUserWalletByWeek({
    @required String uid,
    @required String week,
  }) async {
    final snapshot = await _firebaseFirestore
        .collection('leaderboard')
        .doc('global')
        .collection('weeks')
        .doc(week)
        .collection('wallets')
        .doc(uid)
        .get()
        .then(
          (event) => Wallet.fromFirestore(event),
        );
    return snapshot;
  }

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
        .doc(dateFormat.format(ESTDateTime.fetchTimeEST()));
    final cumulativeReference =
        _firebaseFirestore.collection('vault').doc('cumulative');
    saveAdminVaultWrite
      ..set(
        dailyReference,
        {
          'moneyIn': FieldValue.increment(betsData.betAmount),
          'moneyOut': FieldValue.increment(0),
          'totalBets': FieldValue.increment(1),
          'date': dateFormat.format(ESTDateTime.fetchTimeEST()),
        },
        SetOptions(merge: true),
      )
      ..set(
        cumulativeReference,
        {
          'moneyIn': FieldValue.increment(betsData.betAmount),
          'moneyOut': FieldValue.increment(0),
          'totalBets': FieldValue.increment(1),
        },
        SetOptions(merge: true),
      );
    await saveAdminVaultWrite.commit();
  }

  Stream<List<VaultItem>> fetchAdminVaultDaily() {
    final dailyData = _firebaseFirestore
        .collection('vault')
        .doc('regular')
        .collection('daily')
        .snapshots()
        .map(
          (event) => event.docs
              .map((element) => VaultItem.fromFirestore(element))
              .toList(),
        );
    return dailyData;
  }

  Future<VaultItem> fetchAdminVaultCumulative() {
    final cumulativeData =
        _firebaseFirestore.collection('vault').doc('cumulative').get().then(
              (value) => VaultItem.fromFirestore(value),
            );

    return cumulativeData;
  }

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

  Stream<List<Wallet>> fetchRankedUsers() {
    final snapshot = _firebaseFirestore
        .collection('wallets')
        .where('rank', isNotEqualTo: 0)
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

  Stream<List<String>> fetchLeaderboardWeeks() {
    final days = _firebaseFirestore
        .collection('leaderboard')
        .doc('global')
        .collection('weeks')
        .snapshots()
        .map(
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
        .where('rank', isNotEqualTo: 0)
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

  Stream<String> fetchMinimumVersion() {
    final minimumVersion = _firebaseFirestore
        .collection('constants')
        .doc('version')
        .snapshots()
        .map(
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
      'todayRewards': FieldValue.increment(rewardValue),
      'accountBalance': FieldValue.increment(rewardValue),
    });
  }

  Stream<List<OlympicsGame>> fetchOlympicsGames() {
    final snapshots = _firebaseFirestore
        .collection('custom_matches')
        .doc('olympics_2021_tokyo')
        .collection('matches')
        .where('isClosed', isEqualTo: false)
        .orderBy('startTime')
        .snapshots();

    final gameList = snapshots.map(
      (event) => event.docs
          .map(
            (e) => OlympicsGame.fromFirestore(e),
          )
          .toList(),
    );
    return gameList;
  }

  Future<void> addOlympicsGame({@required OlympicsGame game}) async {
    final olympicsCollectionRef = _firebaseFirestore
        .collection('custom_matches')
        .doc('olympics_2021_tokyo')
        .collection('matches')
        .doc(game.gameId);

    await olympicsCollectionRef.set(game.toMap(), SetOptions(merge: true));
  }

  Future<void> updateOlympicGame({@required OlympicsGame game}) async {
    final olympicsCollectionRef = _firebaseFirestore
        .collection('custom_matches')
        .doc('olympics_2021_tokyo')
        .collection('matches')
        .doc(game.gameId);

    await olympicsCollectionRef.update(game.toMap());
  }

  Stream<List<Group>> fetchPublicGroups() {
    final snapshotRef = _firebaseFirestore
        .collection('groups')
        .where('isPublic', isEqualTo: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Group.fromFirestore(e),
              )
              .toList(),
        );
    return snapshotRef;
  }

  Stream<List<Group>> fetchPrivateGroups({@required String uid}) {
    final snapshotRef = _firebaseFirestore
        .collection('groups')
        .where('isPublic', isEqualTo: false)
        .where('users.$uid', isEqualTo: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Group.fromFirestore(e),
              )
              .toList(),
        );
    return snapshotRef;
  }

  Stream<List<Group>> fetchGroupRequests({@required String uid}) {
    final snapshotRef = _firebaseFirestore
        .collection('groups')
        .where('isPublic', isEqualTo: false)
        .where('users.$uid', isEqualTo: false)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Group.fromFirestore(e),
              )
              .toList(),
        );
    return snapshotRef;
  }

  Stream<Group> fetchGroupDetails({@required String groupId}) {
    final snapshotRef =
        _firebaseFirestore.collection('groups').doc(groupId).snapshots().map(
              (e) => Group.fromFirestore(e),
            );
    return snapshotRef;
  }

  Future<List<Wallet>> fetchGroupLeaderboard(
      {@required List<String> userList}) async {
    final walletList = await Future.wait(
      userList.map(
        (e) async =>
            await _firebaseFirestore.collection('wallets').doc(e).get().then(
                  (value) => Wallet.fromFirestore(value),
                ),
      ),
    );

    return walletList;
  }

  Future<void> addNewGroup({@required Group group}) async {
    await _firebaseFirestore
        .collection('groups')
        .add(
          group.toMap(),
        )
        .then(
      (value) async {
        await value.update(
          {'id': value.id},
        );
      },
    );
  }

  Future<void> addNewUserToGroup({
    @required String groupId,
    @required Map<String, bool> users,
  }) async {
    final addNewUserBatch = _firebaseFirestore.batch();
    final groupRef = _firebaseFirestore.collection('groups').doc(groupId);

    addNewUserBatch.update(groupRef, {'users': users});

    await addNewUserBatch.commit();
  }

  Future<void> acceptGroupRequest({
    @required String groupId,
    @required String uid,
  }) async {
    await _firebaseFirestore
        .collection('groups')
        .doc(groupId)
        .update({'users.$uid': true});
  }

  Future<void> rejectGroupRequest({
    @required String groupId,
    @required String uid,
  }) async {
    await _firebaseFirestore.collection('groups').doc(groupId).update(
      {'users.$uid': FieldValue.delete()},
    );
  }

  Future<List<UserData>> searchUserResults({@required String query}) async {
    final results = await _firebaseFirestore
        .collection('users')
        .where('username', isEqualTo: query)
        .limit(5)
        .get()
        .then(
          (value) => value.docs
              .map(
                (e) => UserData.fromFirestore(e),
              )
              .toList(),
        );
    return results;
  }

  Future<List<UserData>> searchUserSuggestions({@required String query}) async {
    final results = await _firebaseFirestore
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: query)
        .limit(5)
        .get()
        .then(
          (value) => value.docs
              .map(
                (e) => UserData.fromFirestore(e),
              )
              .toList(),
        );
    return results;
  }
}
