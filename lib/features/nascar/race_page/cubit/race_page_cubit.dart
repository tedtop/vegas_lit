import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vegas_lit/data/models/nascar/nascar_race.dart';
import 'package:vegas_lit/data/repositories/nascar_repository.dart';

part 'race_page_state.dart';

class RacePageCubit extends Cubit<RacePageState> {
  RacePageCubit({required NascarRepository nascarRepository})
      : _nascarRepository = nascarRepository,
        super(const RacePageState());

  final NascarRepository _nascarRepository;

  Future<void> openRacePage() async {
    emit(const RacePageState(status: RacePageStatus.loading));
    final allRace = await _nascarRepository.fetchAllRaces();
    emit(
      RacePageState(status: RacePageStatus.success, raceList: allRace),
    );
  }
}
