import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:vegas_lit/data/models/paralympics/paralympics.dart';
import 'package:vegas_lit/data/repositories/sports_repository.dart';

part 'paralympics_add_state.dart';

class ParalympicsAddCubit extends Cubit<ParalympicsAddState> {
  ParalympicsAddCubit({@required SportsRepository sportsRepository})
      : assert(sportsRepository != null),
        _sportsRepository = sportsRepository,
        super(
          const ParalympicsAddState(),
        );

  final SportsRepository _sportsRepository;

  void addParalympicsGame({@required ParalympicsGame game}) async {
    emit(
      const ParalympicsAddState(status: ParalympicsAddStatus.loading),
    );
    await _sportsRepository.addParalympicsGame(game: game);
    emit(
      const ParalympicsAddState(status: ParalympicsAddStatus.complete),
    );
  }
}
