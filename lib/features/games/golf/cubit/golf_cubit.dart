import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:vegas_lit/data/models/golf.dart';
import 'package:vegas_lit/data/repositories/sports_repository.dart';

part 'golf_state.dart';

class GolfCubit extends Cubit<GolfState> {
  GolfCubit({@required SportsRepository sportsfeedRepository})
      : assert(sportsfeedRepository != null),
        _sportsfeedRepository = sportsfeedRepository,
        super(
          GolfInitial(),
        );
  final SportsRepository _sportsfeedRepository;

  Future<void> fetchTournaments() async {
    emit(GolfInitial());
    final estTimeZone = fetchTimeEST();
    List<GolfTournament> tournaments;
    tournaments = await _sportsfeedRepository.fetchGolfTournaments(
        dateTimeEastern: estTimeZone);
    emit(GolfTournamentsOpened(tournaments: tournaments));
  }

  Future<void> fetchTournamentDetails({int tournamentID}) async {
    emit(GolfInitial());
    GolfLeaderboard leaderboard;
    leaderboard = await _sportsfeedRepository.fetchGolfLeaderboard(
        tournamentID: tournamentID);
    emit(GolfDetailOpened(
        tournament: leaderboard.tournament, players: leaderboard.players));
  }

  Future<void> fetchPlayerDetails(
      {GolfTournament tournament, GolfPlayer player}) async {
    emit(GolfInitial());
    emit(GolfPlayerOpened(
        player: player,
        tournamentID: tournament.tournamentId,
        name: tournament.name,
        venue: tournament.venue,
        location: tournament.location));
  }
}

DateTime fetchTimeEST() {
  tz.initializeTimeZones();
  final locationNY = tz.getLocation('America/New_York');
  final nowNY = tz.TZDateTime.now(locationNY);
  return nowNY;
}
