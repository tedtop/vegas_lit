part of 'groups_cubit.dart';

enum GroupsStatus {
  initial,
  loading,
  loaded,
  error,
}

class GroupsState extends Equatable {
  const GroupsState({
    this.publicGroups = const [],
    this.status = GroupsStatus.initial,
  });

  final GroupsStatus status;
  final List<Group> publicGroups;

  @override
  List<Object> get props => [publicGroups, status];
}
