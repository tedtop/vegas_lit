import 'package:vegas_lit/data/models/group.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/providers/cloud_firestore.dart';

class GroupsRepository {
  final _databaseProvider = CloudFirestoreClient();

  Stream<List<Group>> fetchPublicGroups() =>
      _databaseProvider.fetchPublicGroups();

  Future<void> addNewGroup({@required Group group}) =>
      _databaseProvider.addNewGroup(group: group);
}
