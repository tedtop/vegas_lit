

part of 'group_details_cubit.dart';

enum GroupDetailsStatus { initial, loading, complete, error }

class GroupDetailsState extends Equatable {
  GroupDetailsState({
    this.status = GroupDetailsStatus.initial,
    this.players = const [],
    this.isMember = false,
    this.group,
  });

  final GroupDetailsStatus status;
  final Group? group;
  final bool isMember;
  final List<Wallet> players;

  @override
  List<Object?> get props => [status, players, group, isMember];
}
