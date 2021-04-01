import 'dart:io';

import 'package:api_client/src/models/user.dart';
import 'package:api_client/src/providers/authentication.dart';
import 'package:api_client/src/providers/database.dart';
import 'package:api_client/src/providers/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../base_provider.dart';

class AuthenticationRepository {
  BaseAuthenticationProvider authenticationProvider = AuthenticationProvider();
  BaseDatabaseProvider databaseProvider = DatabaseProvider();
  BaseStorageProvider storageProvider = StorageProvider();

  Future<void> signInWithGoogle() => authenticationProvider.signInWithGoogle();

  Future<void> signUp({String email, String password}) =>
      authenticationProvider.signUp(email: email, password: password);

  Future<void> logInWithEmailAndPassword({String email, String password}) =>
      authenticationProvider.logInWithEmailAndPassword(
          email: email, password: password);

  Future<void> signOutUser() => authenticationProvider.signOutUser();

  Future<User> getCurrentUser() => authenticationProvider.getCurrentUser();

  Stream<User> get getUser => authenticationProvider.getUser;

  Future<void> saveDetailsFromAuthentication(User currentAuthenticatedUser) =>
      databaseProvider.saveDetailsFromAuthentication(currentAuthenticatedUser);

  Future<void> saveUserDetails({
    String currentUserId,
    String profileImageURL,
    String username,
    int age,
  }) =>
      databaseProvider.saveUserDetails(
        currentUserId: currentUserId,
        profileImageURL: profileImageURL,
        username: username,
        age: age,
      );

  Future<UserData> isProfileComplete(String currentUserId) =>
      databaseProvider.isProfileComplete(currentUserId);

  Future<String> uploadFile(File file, String path) =>
      storageProvider.uploadFile(file, path);
}
