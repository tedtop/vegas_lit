import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vegas_lit/data/models/group.dart';

part 'groups_state.dart';

class GroupsCubit extends Cubit<GroupsState> {
  GroupsCubit() : super(const GroupsState());
}
