import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../base_provider.dart';
import '../models/open_bets.dart';
import '../models/user.dart';

class DatabaseProvider extends BaseDatabaseProvider {
  DatabaseProvider({FirebaseFirestore firebaseFirestore})
      : _firestoreData = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestoreData;

  @override
  Future<void> saveDetailsFromAuthentication(
    User currentAuthenticatedUser,
  ) async {
    final userData = {
      'uid': currentAuthenticatedUser.uid,
      'name': currentAuthenticatedUser.displayName,
      'email': currentAuthenticatedUser.email,
      'googlePhoto': currentAuthenticatedUser.photoURL,
    };
    final currentUserReference = _firestoreData.collection('users').doc(
          currentAuthenticatedUser.uid,
        );
    final userEmpty = await currentUserReference.snapshots().isEmpty;
    if (!userEmpty) {
      await currentUserReference.set(
        userData,
        SetOptions(
          merge: true,
        ),
      );
    }
  }

  @override
  Future<void> saveUserDetails({
    // String currentUserId,
    // String profileImageURL,
    // int age,
    // String username,
    Map userDataMap,
    String currentUserId,
  }) async {
    // final userData = {
    //   'uploadPhoto': profileImageURL,
    //   'age': age,
    //   'username': username,
    //   'bio': '',
    // };
    final currentUserReference = _firestoreData.collection('users').doc(
          currentUserId,
        );
    await currentUserReference.set(
      userDataMap,
      SetOptions(
        merge: true,
      ),
    );
  }

  @override
  Future<UserData> isProfileComplete(String currentUserId) async {
    final currentUserReference = _firestoreData.collection('users').doc(
          currentUserId,
        );
    final currentUserDocument = await currentUserReference.get();
    final isProfileComplete = currentUserDocument != null &&
        currentUserDocument.exists &&
        currentUserDocument.data().containsKey('uid') &&
        // currentUserDocument.data().containsKey('name') &&
        currentUserDocument.data().containsKey('email') &&
        // currentUserDocument.data().containsKey('uploadPhoto') &&
        currentUserDocument.data().containsKey('username');
    if (isProfileComplete) {
      return UserData.fromFirestore(currentUserDocument);
    } else {
      return null;
    }
  }

  @override
  Stream<List<OpenBetsData>> fetchOpenBetsById(String currentUserId) {
    final openBetsData = _firestoreData
        .collection('users')
        .doc(currentUserId)
        .collection('open_bets')
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => OpenBetsData.fromFirestore(e),
              )
              .toList(),
        );

    return openBetsData;
  }

  @override
  Future<void> saveOpenBetsById({
    @required String currentUserId,
    @required Map openBetsData,
  }) async {
    await _firestoreData
        .collection('users')
        .doc(currentUserId)
        .collection('open_bets')
        .add(openBetsData)
        .then(
      (value) async {
        await value.set(
          {'id': value.id},
          SetOptions(merge: true),
        );
        return value.id;
      },
    );
  }

  @override
  Stream<UserData> fetchUserData({String currentUserId}) {
    final documentSnapshot =
        _firestoreData.collection('users').doc(currentUserId).snapshots().map(
              (event) => UserData.fromFirestore(
                event,
              ),
            );
    return documentSnapshot;
  }
}
