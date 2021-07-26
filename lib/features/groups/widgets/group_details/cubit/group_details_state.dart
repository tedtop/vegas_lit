part of 'group_details_cubit.dart';

enum GroupDetailsStatus { initial, loading, complete, error }

class GroupDetailsState extends Equatable {
  GroupDetailsState({
    this.status = GroupDetailsStatus.initial,
    this.players = const [],
  });

  final GroupDetailsStatus status;
  final List<Wallet> players;

  @override
  List<Object> get props => [status, players];
}
