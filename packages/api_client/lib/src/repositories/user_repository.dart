import 'package:api_client/api_client.dart';
import 'package:api_client/src/base_provider.dart';
import 'package:api_client/src/providers/cloud_firestore.dart';
import 'package:meta/meta.dart';

class UserRepository {
  final DatabaseProvider _baseDatabaseProvider = CloudFirestore();

  Stream<UserData> fetchUserData({
    @required String uid,
  }) =>
      _baseDatabaseProvider.fetchUserData(uid: uid);
}
