import 'package:api_client/src/models/game.dart';
import 'package:api_client/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import 'models/bet.dart';
import 'models/game.dart';
import 'models/golf.dart';

abstract class AuthenticationProvider {
  Future<void> signUp({@required String email, @required String password});
  Future<void> logInWithEmailAndPassword(
      {@required String email, @required String password});
  Future<void> signOutUser();
  Future<User> getCurrentUser;
  Future<void> resetPasswordEmail({@required String email});
  Stream<User> getUser;
}

abstract class DatabaseProvider {
  Future<void> saveUserDetails({
    @required String uid,
    @required Map userDataMap,
  });

  Stream<List<BetData>> fetchOpenBets({@required String uid});
  Stream<List<BetData>> fetchBetHistory({@required String uid});
  Stream<UserData> fetchUserData({@required String uid});

  Future<void> saveBet({
    @required String uid,
    @required Map betDataMap,
    @required int cutBalance,
  });

  Stream<List<UserData>> fetchRankedUsers();

  Future<bool> isBetExist({
    @required String betId,
  });
}

abstract class SportsProvider {
  Future<List<Game>> fetchNFL({@required DateTime dateTime});
  Future<List<Game>> fetchNBA({@required DateTime dateTime});
  Future<List<Game>> fetchMLB({@required DateTime dateTime});
  Future<List<Game>> fetchNHL({@required DateTime dateTime});
  Future<List<Game>> fetchNCAAF({@required DateTime dateTime});
  Future<List<Game>> fetchNCAAB({@required DateTime dateTime});
  Future<List<GolfTournament>> fetchGolfTournaments(
      {@required DateTime dateTimeEastern});
  Future<GolfLeaderboard> fetchGolfLeaderboard({@required int tournamentID});
}
