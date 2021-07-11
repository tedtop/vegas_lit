import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'olympics_state.dart';

class OlympicsCubit extends Cubit<OlympicsState> {
  OlympicsCubit() : super(OlympicsInitial());
}
