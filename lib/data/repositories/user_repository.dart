import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/dataproviders/cloud_firestore.dart';
import 'package:vegas_lit/data/dataproviders/firebase_auth.dart';
import 'package:vegas_lit/data/models/user.dart';
import 'package:vegas_lit/data/models/vault_data.dart';
import 'package:vegas_lit/data/models/wallet.dart';

class UserRepository {
  final _authenticationProvider = FirebaseAuthentication();
  final _databaseProvider = CloudFirestore();

  Future<void> signUp({
    @required String email,
    @required String password,
  }) =>
      _authenticationProvider.signUp(
        email: email,
        password: password,
      );

  Future<void> logInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) =>
      _authenticationProvider.logInWithEmailAndPassword(
        email: email,
        password: password,
      );

  Future<void> signOutUser() => _authenticationProvider.signOutUser();

  Future<User> getCurrentUser() => _authenticationProvider.getCurrentUser;

  Stream<User> get getUser => _authenticationProvider.getUser;

  Future<void> resetPasswordEmail({@required String email}) =>
      _authenticationProvider.resetPasswordEmail(email: email);

  Future<void> saveUserDetails({
    @required Map userDataMap,
    @required String uid,
  }) =>
      _databaseProvider.saveUserDetails(
        userDataMap: userDataMap,
        uid: uid,
      );

  Future<bool> isProfileComplete({@required String uid}) =>
      _databaseProvider.isProfileComplete(uid: uid);

  Future<void> sendEmailVerification({@required User user}) =>
      _authenticationProvider.sendEmailVerification(user: user);

  Stream<UserData> fetchUserData({@required String uid}) =>
      _databaseProvider.fetchUserData(uid: uid);

  Stream<Wallet> fetchWalletData({@required String uid}) =>
      _databaseProvider.fetchUserWallet(uid: uid);

  Future<bool> isUsernameExist({@required String username}) =>
      _databaseProvider.isUsernameExist(username: username);

  Stream<List<Wallet>> fetchRankedUsers() =>
      _databaseProvider.fetchRankedUsers();

  Future<List<String>> fetchLeaderboardDays() =>
      _databaseProvider.fetchLeaderboardDays();

  Future<List<Wallet>> fetchLeaderboardDaysUserData({@required String week}) =>
      _databaseProvider.fetchLeaderboardDaysUserData(week: week);

  Future<String> fetchMinimumVersion() =>
      _databaseProvider.fetchMinimumVersion();

  Stream<List<VaultItem>> fetchAllDataDateWise() =>
      _databaseProvider.fetchAllDataDateWise();

  Future<VaultItem> fetchCumulativeAdminVaultData() =>
      _databaseProvider.fetchCumulativeAdminVaultData();

  Future<void> rewardForVideoAd(
          {@required String uid, @required int rewardValue}) =>
      _databaseProvider.rewardBalance(uid: uid, rewardValue: rewardValue);
}
