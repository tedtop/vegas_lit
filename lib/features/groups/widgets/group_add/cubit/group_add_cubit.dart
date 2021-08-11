import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegas_lit/data/models/group.dart';
import 'package:vegas_lit/data/repositories/groups_repository.dart';

part 'group_add_state.dart';

class GroupAddCubit extends Cubit<GroupAddState> {
  GroupAddCubit({@required GroupsRepository groupsRepository})
      : assert(groupsRepository != null),
        _groupsRepository = groupsRepository,
        super(
          GroupAddState(status: GroupAddStatus.initial),
        );

  final GroupsRepository _groupsRepository;

  void addGroup({@required Group group}) async {
    emit(GroupAddState(status: GroupAddStatus.loading));
    await _groupsRepository.addNewGroup(group: group);
    emit(GroupAddState(status: GroupAddStatus.success));
  }
}
