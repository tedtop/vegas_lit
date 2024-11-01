import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../config/extensions.dart';

import '../../../../data/models/golf/golf.dart';
import '../../../../data/repositories/sport_repository.dart';

part 'golf_state.dart';

class GolfCubit extends Cubit<GolfState> {
  GolfCubit({required SportRepository sportsfeedRepository})
      : assert(sportsfeedRepository != null),
        _sportsfeedRepository = sportsfeedRepository,
        super(
          GolfInitial(),
        );
  final SportRepository _sportsfeedRepository;

  Future<void> fetchTournaments() async {
    emit(GolfInitial());
    final estTimeZone = ESTDateTime.fetchTimeEST();
    List<GolfTournament> tournaments;
    tournaments = await _sportsfeedRepository.fetchGolfTournaments(
        dateTimeEastern: estTimeZone);
    emit(GolfTournamentsOpened(tournaments: tournaments));
  }

  Future<void> fetchTournamentDetails({int? tournamentID}) async {
    emit(GolfInitial());
    GolfLeaderboard leaderboard;
    leaderboard = await _sportsfeedRepository.fetchGolfLeaderboard(
        tournamentID: tournamentID);
    emit(GolfDetailOpened(
        tournament: leaderboard.tournament, players: leaderboard.players));
  }

  Future<void> fetchPlayerDetails(
      {required GolfTournament tournament, GolfPlayer? player}) async {
    emit(GolfInitial());
    emit(GolfPlayerOpened(
        player: player,
        tournamentID: tournament.tournamentId,
        name: tournament.name,
        venue: tournament.venue,
        location: tournament.location));
  }
}
