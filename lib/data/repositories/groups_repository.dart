import 'package:vegas_lit/data/models/group.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/models/wallet.dart';
import 'package:vegas_lit/data/providers/cloud_firestore.dart';

class GroupsRepository {
  final _databaseProvider = CloudFirestoreClient();

  Stream<List<Group>> fetchPublicGroups() =>
      _databaseProvider.fetchPublicGroups();

  Future<void> addNewGroup({@required Group group}) =>
      _databaseProvider.addNewGroup(group: group);

  Stream<Group> fetchPublicGroup({@required String groupId}) =>
      _databaseProvider.fetchPublicGroup(groupId: groupId);

  Future<List<Wallet>> fetchGroupLeaderboard(
          {@required List<String> userList}) =>
      _databaseProvider.fetchGroupLeaderboard(userList: userList);

  Future<void> addNewUserToGroup(
          {@required String groupId, @required String userId}) =>
      _databaseProvider.addNewUserToGroup(groupId: groupId, userId: userId);
}
