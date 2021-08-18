part of 'public_groups_cubit.dart';

enum PublicGroupsStatus {
  initial,
  loading,
  success,
  failure,
}

class PublicGroupsState extends Equatable {
  const PublicGroupsState({
    this.publicGroups = const [],
    this.status = PublicGroupsStatus.initial,
  });

  final PublicGroupsStatus status;
  final List<Group> publicGroups;

  @override
  List<Object> get props => [publicGroups, status];
}
