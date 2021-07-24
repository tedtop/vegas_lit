import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegas_lit/data/models/group.dart';
import 'package:vegas_lit/data/repositories/user_repository.dart';

part 'group_add_state.dart';

class GroupAddCubit extends Cubit<GroupAddState> {
  GroupAddCubit({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(GroupAddState(status: GroupAddStatus.initial));

  final UserRepository _userRepository;

  void addGroup({@required Group group}) async {
    emit(GroupAddState(status: GroupAddStatus.loading));
    //logic to send to firestore
    emit(GroupAddState(status: GroupAddStatus.complete));
  }
}
