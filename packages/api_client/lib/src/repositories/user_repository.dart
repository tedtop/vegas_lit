import 'package:api_client/src/models/wallet.dart';
import 'package:api_client/src/models/user.dart';
import 'package:api_client/src/providers/cloud_firestore.dart';
import 'package:api_client/src/providers/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

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

  Stream<UserData> fetchUserData({@required String uid}) =>
      _databaseProvider.fetchUserData(uid: uid);

  Stream<Wallet> fetchWalletData({@required String uid}) =>
      _databaseProvider.fetchUserWallet(uid: uid);

  Stream<List<Wallet>> fetchRankedUsers() =>
      _databaseProvider.fetchRankedUsers();

  Future<List<String>> fetchLeaderboardWeeks() =>
      _databaseProvider.fetchLeaderboardWeeks();

  Future<List<Wallet>> fetchLeaderboardWeeksUserData({@required String week}) =>
      _databaseProvider.fetchLeaderboardWeeksUserData(week: week);
}
