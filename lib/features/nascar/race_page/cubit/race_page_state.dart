part of 'race_page_cubit.dart';

enum RacePageStatus { initial, loading, success, failure }

class RacePageState extends Equatable {
  const RacePageState({
    this.raceList = const [],
    this.status = RacePageStatus.initial,
  });

  final List<Race> raceList;
  final RacePageStatus status;

  RacePageState copyWith({
    List<Race>? raceList,
    RacePageStatus? status,
  }) {
    return RacePageState(
      raceList: raceList ?? this.raceList,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [raceList, status];
}
