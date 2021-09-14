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
    this.avatarFile,
  });

  final GroupAddStatus status;
  final File avatarFile;

  @override
  List<Object> get props => [status, avatarFile];

  GroupAddState copyWith({
    GroupAddStatus status,
    File avatarFile,
  }) {
    return GroupAddState(
      status: status ?? this.status,
      avatarFile: avatarFile ?? this.avatarFile,
    );
  }
}
