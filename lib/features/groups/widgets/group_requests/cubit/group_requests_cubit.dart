import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../data/models/group.dart';
import '../../../../../data/repositories/group_repository.dart';

part 'group_requests_state.dart';

class GroupRequestsCubit extends Cubit<GroupRequestsState> {
  GroupRequestsCubit({required GroupRepository groupsRepository})
      : assert(groupsRepository != null),
        _groupsRepository = groupsRepository,
        super(
          const GroupRequestsState(),
        );
  final GroupRepository _groupsRepository;
  StreamSubscription? _groupRequestsSubscription;

  Future<void> openGroupRequests({required String? uid}) async {
    emit(
      const GroupRequestsState(status: GroupRequestsStatus.loading),
    );
    try {
      final groupsSnapshot = _groupsRepository.fetchGroupRequests(uid: uid);
      await _groupRequestsSubscription?.cancel();
      _groupRequestsSubscription = groupsSnapshot.listen(
        (event) {
          emit(
            GroupRequestsState(
              status: GroupRequestsStatus.success,
              groups: event,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        const GroupRequestsState(
          status: GroupRequestsStatus.failure,
        ),
      );
    }
  }

  Future<void> acceptGroup(
      {required String? groupId, required String uid}) async {
    await _groupsRepository.acceptGroupRequest(groupId: groupId, uid: uid);
  }

  Future<void> rejectGroup(
      {required String? groupId, required String uid}) async {
    await _groupsRepository.rejectGroupRequest(groupId: groupId, uid: uid);
  }

  @override
  Future<void> close() async {
    await _groupRequestsSubscription?.cancel();
    return super.close();
  }
}
