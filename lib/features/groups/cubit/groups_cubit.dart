import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/models/group.dart';
import 'package:vegas_lit/data/repositories/groups_repository.dart';

part 'groups_state.dart';

class GroupsCubit extends Cubit<GroupsState> {
  GroupsCubit({@required GroupsRepository groupsRepository})
      : assert(groupsRepository != null),
        _groupsRepository = groupsRepository,
        super(
          const GroupsState(),
        );
  final GroupsRepository _groupsRepository;
  StreamSubscription _publicGroupsSubscription;

  Future<void> openPublicGroups() async {
    emit(
      const GroupsState(status: GroupsStatus.loading),
    );
    try {
      final groupsSnapshot = _groupsRepository.fetchPublicGroups();
      await _publicGroupsSubscription?.cancel();
      _publicGroupsSubscription = groupsSnapshot.listen(
        (event) {
          emit(
            GroupsState(
              status: GroupsStatus.success,
              publicGroups: event,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        const GroupsState(
          status: GroupsStatus.failure,
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    await _publicGroupsSubscription?.cancel();
    return super.close();
  }
}
