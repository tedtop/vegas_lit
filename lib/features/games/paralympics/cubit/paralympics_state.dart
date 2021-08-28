part of 'paralympics_cubit.dart';

enum ParalympicsStatus {
  initial,
  opened,
}

class ParalympicsState extends Equatable {
  const ParalympicsState._({
    this.games,
    this.league = 'PARALYMPICS',
    this.estTimeZone,
    this.status = ParalympicsStatus.initial,
  });

  const ParalympicsState.initial() : this._();

  const ParalympicsState.opened({
    @required List<ParalympicsGame> games,
    @required String league,
    @required DateTime estTimeZone,
  }) : this._(
          games: games,
          league: league,
          estTimeZone: estTimeZone,
          status: ParalympicsStatus.opened,
        );

  final List<ParalympicsGame> games;
  final String league;
  final DateTime estTimeZone;
  final ParalympicsStatus status;

  @override
  List<Object> get props => [
        games,
        league,
        estTimeZone,
        status,
      ];
}
