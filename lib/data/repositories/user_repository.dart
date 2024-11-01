import 'package:firebase_auth/firebase_auth.dart';

import '../models/bet.dart';

import '../models/user.dart';
import '../models/vault_data.dart';
import '../models/wallet.dart';
import '../providers/cloud_firestore.dart';
import '../providers/firebase_auth.dart';

class UserRepository {
  UserRepository(
      {FirebaseAuthentication? authenticationProvider,
      CloudFirestoreClient? databaseProvider})
      : _authenticationProvider =
            authenticationProvider ?? FirebaseAuthentication(),
        _databaseProvider = databaseProvider ?? CloudFirestoreClient();

  final FirebaseAuthentication _authenticationProvider;
  final CloudFirestoreClient _databaseProvider;

  Future<void> signUp({
    required String email,
    required String password,
  }) =>
      _authenticationProvider.signUp(
        email: email,
        password: password,
      );

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      _authenticationProvider.logInWithEmailAndPassword(
        email: email,
        password: password,
      );

  Future<void> signOutUser() => _authenticationProvider.signOutUser();

  Future<User?> getCurrentUser() => _authenticationProvider.getCurrentUser;

  Stream<User?> get getUser => _authenticationProvider.getUser;

  Future<void> resetPasswordEmail({required String email}) =>
      _authenticationProvider.resetPasswordEmail(email: email);

  Future<void> saveUserDetails({
    required UserData userData,
    required String uid,
  }) =>
      _databaseProvider.saveUserDetails(
        user: userData,
        uid: uid,
      );

  Future<void> updateUserAvatar(
          {required String avatarUrl, required String? uid}) =>
      _databaseProvider.updateUserAvatar(avatarUrl: avatarUrl, uid: uid);

  Future<bool> isProfileComplete({required String uid}) =>
      _databaseProvider.isProfileComplete(uid: uid);

  Future<void> sendEmailVerification({required User user}) =>
      _authenticationProvider.sendEmailVerification(user: user);

  Stream<UserData> fetchUserData({required String? uid}) =>
      _databaseProvider.fetchUserData(uid: uid);

  Stream<Wallet> fetchWalletData({required String? uid}) =>
      _databaseProvider.fetchUserWallet(uid: uid);

  Future<Wallet> fetchUserWalletByWeek(
          {required String? uid, required String? week}) =>
      _databaseProvider.fetchUserWalletByWeek(uid: uid, week: week);

  Future<bool> isUserWalletExistByWeek(
          {required String? uid, required String? week}) =>
      _databaseProvider.isUserWalletExistByWeek(uid: uid, week: week);

  Future<bool> isUsernameExist({required String username}) =>
      _databaseProvider.isUsernameExist(username: username);

  Stream<List<Wallet>> fetchRankedUsers() =>
      _databaseProvider.fetchRankedUsers();

  Stream<List<String>> fetchLeaderboardWeeks() =>
      _databaseProvider.fetchLeaderboardWeeks();

  Future<List<Wallet>> fetchLeaderboardDaysUserData({required String week}) =>
      _databaseProvider.fetchLeaderboardDaysUserData(week: week);

  Stream<List<BetData>> fetchBetHistoryByWeek(
          {required String? week, required String? uid}) =>
      _databaseProvider.fetchBetHistoryByWeek(week: week, uid: uid);

  Stream<String?> fetchMinimumVersion() =>
      _databaseProvider.fetchMinimumVersion();

  Stream<List<VaultItem>> fetchAdminVaultDaily() =>
      _databaseProvider.fetchAdminVaultDaily();

  Future<VaultItem> fetchAdminVaultCumulative() =>
      _databaseProvider.fetchAdminVaultCumulative();

  Future<void> rewardForVideoAd(
          {required String uid, required int rewardValue}) =>
      _databaseProvider.rewardBalance(uid: uid, rewardValue: rewardValue);

  Future<List<UserData>> searchUserResults({required String query}) =>
      _databaseProvider.searchUserResults(query: query);

  Future<List<UserData>> searchUserSuggestions({required String query}) =>
      _databaseProvider.searchUserSuggestions(query: query);
}
