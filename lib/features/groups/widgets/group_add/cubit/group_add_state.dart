part of 'group_add_cubit.dart';

enum GroupAddStatus {
  initial,
  loading,
  success,
  failure,
}

class GroupAddState extends Equatable {
  GroupAddState({
    this.status = GroupAddStatus.initial,
  });

  final GroupAddStatus status;

  @override
  List<Object> get props => [status];
}
