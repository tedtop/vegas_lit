part of 'race_play_cubit.dart';

enum RacePlayStatus { initial, loading, success, failure }

class RacePlayState {
  const RacePlayState({
    this.status = RacePlayStatus.initial,
    this.raceDetails,
  });

  final RacePlayStatus status;
  final RaceResults? raceDetails;
}
