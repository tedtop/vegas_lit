

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cricket_state.dart';

class CricketCubit extends Cubit<CricketState> {
  CricketCubit() : super(CricketInitial());
}
