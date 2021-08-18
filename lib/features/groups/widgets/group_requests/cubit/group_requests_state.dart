part of 'group_requests_cubit.dart';

enum GroupRequestsStatus {
  initial,
  loading,
  success,
  failure,
}

class GroupRequestsState extends Equatable {
  const GroupRequestsState({
    this.groups = const [],
    this.status = GroupRequestsStatus.initial,
  });

  final GroupRequestsStatus status;
  final List<Group> groups;

  @override
  List<Object> get props => [groups, status];
}
