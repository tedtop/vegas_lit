import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/models/olympics/olympics.dart';
import 'package:vegas_lit/data/repositories/sports_repository.dart';

part 'olympics_add_state.dart';

class OlympicsAddCubit extends Cubit<OlympicsAddState> {
  OlympicsAddCubit({@required SportsRepository sportsRepository})
      : assert(sportsRepository != null),
        _sportsRepository = sportsRepository,
        super(OlympicsAddInitial());

  final SportsRepository _sportsRepository;

  void addOlympicsGame({@required OlympicsGame game}) async {
    emit(OlympicsAddLoading());
    await _sportsRepository.addOlympicsGame(game: game);
    emit(OlympicsAddComplete());
  }
}
