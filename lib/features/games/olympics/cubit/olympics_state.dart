

part of 'olympics_cubit.dart';

enum OlympicsStatus {
  initial,
  opened,
}

class OlympicsState extends Equatable {
  const OlympicsState._({
    this.games,
    this.league = 'OLYMPICS',
    this.estTimeZone,
    this.status = OlympicsStatus.initial,
  });

  const OlympicsState.initial() : this._();

  const OlympicsState.opened({
    required List<OlympicsGame> games,
    required String league,
    required DateTime estTimeZone,
  }) : this._(
          games: games,
          league: league,
          estTimeZone: estTimeZone,
          status: OlympicsStatus.opened,
        );

  final List<OlympicsGame>? games;
  final String league;
  final DateTime? estTimeZone;
  final OlympicsStatus status;

  @override
  List<Object?> get props => [
        games,
        league,
        estTimeZone,
        status,
      ];
}
