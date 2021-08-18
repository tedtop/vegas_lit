import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vegas_lit/data/models/group.dart';
import 'package:vegas_lit/data/repositories/groups_repository.dart';
import 'package:meta/meta.dart';
part 'private_groups_state.dart';

class PrivateGroupsCubit extends Cubit<PrivateGroupsState> {
  PrivateGroupsCubit({@required GroupsRepository groupsRepository})
      : assert(groupsRepository != null),
        _groupsRepository = groupsRepository,
        super(
          const PrivateGroupsState(),
        );
  final GroupsRepository _groupsRepository;
  StreamSubscription _privateGroupsSubscription;

  Future<void> openPrivateGroups({@required String uid}) async {
    emit(
      const PrivateGroupsState(status: PrivateGroupsStatus.loading),
    );
    try {
      final groupsSnapshot = _groupsRepository.fetchPrivateGroups(uid: uid);
      await _privateGroupsSubscription?.cancel();
      _privateGroupsSubscription = groupsSnapshot.listen(
        (event) {
          emit(
            PrivateGroupsState(
              status: PrivateGroupsStatus.success,
              privateGroups: event,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        const PrivateGroupsState(
          status: PrivateGroupsStatus.failure,
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    await _privateGroupsSubscription?.cancel();
    return super.close();
  }
}