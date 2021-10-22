

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../data/models/olympics/olympics.dart';
import '../../../../data/repositories/sports_repository.dart';

part 'olympics_add_state.dart';

class OlympicsAddCubit extends Cubit<OlympicsAddState> {
  OlympicsAddCubit({required SportsRepository sportsRepository})
      : assert(sportsRepository != null),
        _sportsRepository = sportsRepository,
        super(
          const OlympicsAddState(),
        );

  final SportsRepository _sportsRepository;

  void addOlympicsGame({required OlympicsGame game}) async {
    emit(
      const OlympicsAddState(status: OlympicsAddStatus.loading),
    );
    await _sportsRepository.addOlympicsGame(game: game);
    emit(
      const OlympicsAddState(status: OlympicsAddStatus.complete),
    );
  }
}
