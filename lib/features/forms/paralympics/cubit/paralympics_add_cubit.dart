import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/paralympics/paralympics.dart';
import '../../../../data/repositories/sport_repository.dart';

part 'paralympics_add_state.dart';

class ParalympicsAddCubit extends Cubit<ParalympicsAddState> {
  ParalympicsAddCubit({required SportRepository sportsRepository})
      : _sportsRepository = sportsRepository,
        super(
          const ParalympicsAddState(),
        );

  final SportRepository _sportsRepository;

  void addParalympicsGame({required ParalympicsGame game}) async {
    emit(
      const ParalympicsAddState(status: ParalympicsAddStatus.loading),
    );
    await _sportsRepository.addParalympicsGame(game: game);
    emit(
      const ParalympicsAddState(status: ParalympicsAddStatus.complete),
    );
  }
}
