import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vegas_lit/data/models/nascar/nascar_race.dart';
import 'package:vegas_lit/data/models/nascar/nascar_race_results.dart';
import 'package:vegas_lit/data/repositories/nascar_repository.dart';

part 'race_play_state.dart';

class RacePlayCubit extends Cubit<RacePlayState> {
  RacePlayCubit({required NascarRepository nascarRepository})
      : _nascarRepository = nascarRepository,
        super(const RacePlayState());

  final NascarRepository _nascarRepository;

  Future<void> openRacePlayPage({required Race race}) async {
    emit(const RacePlayState(status: RacePlayStatus.loading));
    final raceDetails = await _nascarRepository.fetchRaceResults(
        raceId: race.raceId.toString());
    emit(
      RacePlayState(
        status: RacePlayStatus.success,
        raceDetails: raceDetails,
      ),
    );
  }
}
