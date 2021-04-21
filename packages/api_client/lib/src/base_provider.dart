import 'package:api_client/src/models/game.dart';
import 'package:api_client/src/models/open_bet.dart';
import 'package:api_client/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import 'models/bet_history.dart';
import 'models/game.dart';

abstract class AuthenticationProvider {
  Future<void> signUp({
    @required String email,
    @required String password,
  });
  Future<void> logInWithEmailAndPassword({
    @required String email,
    @required String password,
  });
  Future<void> signOutUser();
  Future<User> getCurrentUser();
  Future<void> resetPasswordEmail({@required String email});
  Stream<User> getUser;
}

abstract class DatabaseProvider {
  Future<void> saveUserDetails({
    @required String uid,
    @required Map userDataMap,
  });

  Stream<List<OpenBetsData>> fetchOpenBets({@required String uid});
  Stream<List<BetHistoryData>> fetchBetHistory({@required String uid});
  Stream<UserData> fetchUserData({@required String uid});

  Future<void> saveBets({
    @required String uid,
    @required Map openBetsDataMap,
  });
}

abstract class SportsDataProvider {
  Future<List<Game>> fetchGameListByLeague({
    @required String league,
    @required DateTime dateTimeEastern,
  });
}
