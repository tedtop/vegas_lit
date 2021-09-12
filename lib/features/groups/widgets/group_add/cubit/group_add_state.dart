part of 'group_add_cubit.dart';

enum GroupAddStatus {
  initial,
  loading,
  success,
  failure,
}

class GroupAddState extends Equatable {
  GroupAddState({this.status = GroupAddStatus.initial, this.avatarUrl});

  final GroupAddStatus status;
  final String avatarUrl;

  @override
  List<Object> get props => [status];
}
