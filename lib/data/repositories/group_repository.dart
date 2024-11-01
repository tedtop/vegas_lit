import '../models/group.dart';
import '../models/wallet.dart';
import '../providers/cloud_firestore.dart';

class GroupRepository {
  GroupRepository({
    CloudFirestoreClient? databaseProvider,
  }) : _databaseProvider = databaseProvider ?? CloudFirestoreClient();

  final CloudFirestoreClient _databaseProvider;

  Stream<List<Group>> fetchPublicGroups() =>
      _databaseProvider.fetchPublicGroups();

  Stream<List<Group>> fetchPrivateGroups({required String? uid}) =>
      _databaseProvider.fetchPrivateGroups(uid: uid);

  Stream<List<Group>> fetchGroupRequests({required String? uid}) =>
      _databaseProvider.fetchGroupRequests(uid: uid);

  Future<String> addNewGroup({required Group group}) =>
      _databaseProvider.addNewGroup(group: group);

  Future<void> updateGroup({
    required Group group,
    required String? groupId,
  }) =>
      _databaseProvider.updateGroup(
        group: group,
        groupId: groupId,
      );

  Future<bool> isGroupExists({required String groupId}) =>
      _databaseProvider.isGroupExists(groupId: groupId);

  Future<void> updateGroupAvatar(
          {required String avatarUrl, required String groupId}) =>
      _databaseProvider.updateGroupAvatar(
          avatarUrl: avatarUrl, groupId: groupId);

  Stream<Group> fetchGroupDetails({required String? groupId}) =>
      _databaseProvider.fetchGroupDetails(groupId: groupId);

  Future<List<Wallet>> fetchGroupLeaderboard(
          {required List<String> userList}) =>
      _databaseProvider.fetchGroupLeaderboard(userList: userList);

  Future<void> addNewUserToGroup({
    required String? groupId,
    required Map<String?, bool> users,
  }) =>
      _databaseProvider.addNewUserToGroup(groupId: groupId, users: users);

  Future<void> rejectGroupRequest({
    required String? groupId,
    required String uid,
  }) =>
      _databaseProvider.rejectGroupRequest(groupId: groupId, uid: uid);

  Future<void> acceptGroupRequest({
    required String? groupId,
    required String uid,
  }) =>
      _databaseProvider.acceptGroupRequest(groupId: groupId, uid: uid);
}
