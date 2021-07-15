import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vegas_lit/data/models/olympics/olympics.dart';

part 'olympics_bet_button_state.dart';

class OlympicsBetButtonCubit extends Cubit<OlympicsBetButtonState> {
  OlympicsBetButtonCubit() : super(const OlympicsBetButtonState());
}
