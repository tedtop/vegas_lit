import 'package:api_client/api_client.dart';
import 'package:api_client/src/base_provider.dart';
import 'package:api_client/src/providers/database.dart';

class UserRepository {
  final BaseDatabaseProvider _baseDatabaseProvider = DatabaseProvider();

  Stream<UserData> fetchUserData({String currentUserId}) =>
      _baseDatabaseProvider.fetchUserData(currentUserId: currentUserId);
}
