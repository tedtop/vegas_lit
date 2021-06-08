import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../models/user.dart';
import '../models/vault_data.dart';
import '../models/wallet.dart';
import '../providers/cloud_firestore.dart';
import '../providers/firebase_auth.dart';

class UserRepository {
  final _authenticationProvider = FirebaseAuthentication();
  final _databaseProvider = CloudFirestoreClient();

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
    @required UserData userData,
    @required String uid,
  }) =>
      _databaseProvider.saveUserDetails(
        user: userData,
        uid: uid,
      );

  Future<void> updateUserAvatar(
          {@required String avatarUrl, @required String uid}) =>
      _databaseProvider.updateUserAvatar(avatarUrl: avatarUrl, uid: uid);

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

  Stream<String> fetchMinimumVersion() =>
      _databaseProvider.fetchMinimumVersion();

  Stream<List<VaultItem>> fetchAllDataDateWise() =>
      _databaseProvider.fetchAllDataDateWise();

  Future<VaultItem> fetchCumulativeAdminVaultData() =>
      _databaseProvider.fetchCumulativeAdminVaultData();

  Future<void> rewardForVideoAd(
          {@required String uid, @required int rewardValue}) =>
      _databaseProvider.rewardBalance(uid: uid, rewardValue: rewardValue);
}
