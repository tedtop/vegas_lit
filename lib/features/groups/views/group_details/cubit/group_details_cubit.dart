import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'group_details_state.dart';

class GroupDetailsCubit extends Cubit<GroupDetailsState> {
  GroupDetailsCubit() : super(GroupDetailsInitial());
}
