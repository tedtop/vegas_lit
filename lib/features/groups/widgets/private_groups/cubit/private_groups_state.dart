

part of 'private_groups_cubit.dart';

enum PrivateGroupsStatus {
  initial,
  loading,
  success,
  failure,
}

class PrivateGroupsState extends Equatable {
  const PrivateGroupsState({
    this.privateGroups = const [],
    this.status = PrivateGroupsStatus.initial,
  });

  final PrivateGroupsStatus status;
  final List<Group> privateGroups;

  @override
  List<Object> get props => [privateGroups, status];
}
