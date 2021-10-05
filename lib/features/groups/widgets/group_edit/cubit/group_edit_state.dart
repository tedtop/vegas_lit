part of 'group_edit_cubit.dart';

enum GroupEditStatus {
  initial,
  loading,
  success,
  failure,
}

class GroupEditState extends Equatable {
  GroupEditState({
    this.status = GroupEditStatus.initial,
    this.avatarFile,
  });

  final GroupEditStatus status;
  final File avatarFile;

  @override
  List<Object> get props => [status, avatarFile];

  GroupEditState copyWith({
    GroupEditStatus status,
    File avatarFile,
  }) {
    return GroupEditState(
      status: status ?? this.status,
      avatarFile: avatarFile ?? this.avatarFile,
    );
  }
}
