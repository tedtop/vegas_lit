import 'dart:io';

import 'package:api_client/src/models/user.dart';
import 'package:api_client/src/providers/authentication.dart';
import 'package:api_client/src/providers/database.dart';
import 'package:api_client/src/providers/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../base_provider.dart';

class AuthenticationRepository {
  final BaseAuthenticationProvider _authenticationProvider =
      AuthenticationProvider();
  final BaseDatabaseProvider _databaseProvider = DatabaseProvider();
  final BaseStorageProvider _storageProvider = StorageProvider();

  Future<void> signInWithGoogle() => _authenticationProvider.signInWithGoogle();

  Future<void> signUp({String email, String password}) =>
      _authenticationProvider.signUp(email: email, password: password);

  Future<void> logInWithEmailAndPassword({String email, String password}) =>
      _authenticationProvider.logInWithEmailAndPassword(
          email: email, password: password);

  Future<void> signOutUser() => _authenticationProvider.signOutUser();

  Future<User> getCurrentUser() => _authenticationProvider.getCurrentUser();

  Stream<User> get getUser => _authenticationProvider.getUser;

  Future<void> saveDetailsFromAuthentication(User currentAuthenticatedUser) =>
      _databaseProvider.saveDetailsFromAuthentication(currentAuthenticatedUser);

  Future<void> saveUserDetails({
    Map userDataMap,
    String currentUserId,
  }) =>
      _databaseProvider.saveUserDetails(
          userDataMap: userDataMap, currentUserId: currentUserId);

  Future<bool> isProfileComplete(String currentUserId) =>
      _databaseProvider.isProfileComplete(currentUserId);

  Future<String> uploadFile(File file, String path) =>
      _storageProvider.uploadFile(file, path);
}
