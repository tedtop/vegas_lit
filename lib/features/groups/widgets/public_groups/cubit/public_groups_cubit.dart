import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../data/models/group.dart';
import '../../../../../data/repositories/groups_repository.dart';

part 'public_groups_state.dart';

class PublicGroupsCubit extends Cubit<PublicGroupsState> {
  PublicGroupsCubit({required GroupsRepository groupsRepository})
      : assert(groupsRepository != null),
        _groupsRepository = groupsRepository,
        super(
          const PublicGroupsState(),
        );
  final GroupsRepository _groupsRepository;
  StreamSubscription? _publicGroupsSubscription;

  Future<void> openPublicGroups() async {
    emit(
      const PublicGroupsState(status: PublicGroupsStatus.loading),
    );
    try {
      final groupsSnapshot = _groupsRepository.fetchPublicGroups();
      await _publicGroupsSubscription?.cancel();
      _publicGroupsSubscription = groupsSnapshot.listen(
        (event) {
          emit(
            PublicGroupsState(
              status: PublicGroupsStatus.success,
              publicGroups: event,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        const PublicGroupsState(
          status: PublicGroupsStatus.failure,
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
