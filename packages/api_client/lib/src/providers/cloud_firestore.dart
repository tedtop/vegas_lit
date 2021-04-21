import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../base_provider.dart';
import '../models/bet_history.dart';
import '../models/open_bet.dart';
import '../models/user.dart';

class CloudFirestore extends DatabaseProvider {
  CloudFirestore({FirebaseFirestore firebaseFirestore})
      : _firestoreData = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestoreData;

  @override
  Future<void> saveUserDetails({
    Map userDataMap,
    String uid,
  }) async {
    final currentUserReference = _firestoreData.collection('users').doc(uid);
    await currentUserReference.set(
      userDataMap,
      SetOptions(
        merge: true,
      ),
    );
  }

  @override
  Stream<List<OpenBetsData>> fetchOpenBets({@required String uid}) {
    final openBetsData = _firestoreData
        .collection('open_bets')
        .where('user', isEqualTo: uid)
        .where('isClosed', isEqualTo: false)
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
  Stream<List<BetHistoryData>> fetchBetHistory({@required String uid}) {
    final betHistoryData = _firestoreData
        .collection('open_bets')
        .where('user', isEqualTo: uid)
        .where('isClosed', isEqualTo: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => BetHistoryData.fromFirestore(e),
              )
              .toList(),
        );
    return betHistoryData;
  }

  @override
  Future<void> saveBets({
    @required String uid,
    @required Map openBetsDataMap,
  }) async {
    await _firestoreData.collection('open_bets').add(openBetsDataMap).then(
      (value) async {
        await value.set(
          {
            'id': value.id,
            'user': uid,
          },
          SetOptions(merge: true),
        );
        return value.id;
      },
    );
  }

  @override
  Stream<UserData> fetchUserData({@required String uid}) {
    final documentSnapshot =
        _firestoreData.collection('users').doc(uid).snapshots().map(
              (event) => UserData.fromFirestore(
                event,
              ),
            );
    return documentSnapshot;
  }
}
