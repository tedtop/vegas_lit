import 'dart:io';

import 'package:api_client/src/models/open_bets.dart';
import 'package:api_client/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/game.dart';

abstract class BaseAuthenticationProvider {
  Future<void> signInWithGoogle();
  Future<void> signUp({String email, String password});
  Future<void> logInWithEmailAndPassword({String email, String password});
  Future<void> signOutUser();
  Future<User> getCurrentUser();
  Stream<User> getUser;
}

abstract class BaseDatabaseProvider {
  Future<void> saveDetailsFromAuthentication(User currentAuthenticatedUser);
  Future<void> saveUserDetails(
      {String currentUserId, String profileImageURL, String username, int age});
  Future<UserData> isProfileComplete(String currentUserId);
  Stream<List<OpenBetsData>> fetchOpenBetsById(String currentUserId);
}

abstract class BaseStorageProvider {
  Future<String> uploadFile(File file, String path);
}

abstract class BaseSportsfeedProvider {
  Future<List<Game>> fetchGameList();
  Future<List<Game>> fetchGameListByGame({String gameName});
}
