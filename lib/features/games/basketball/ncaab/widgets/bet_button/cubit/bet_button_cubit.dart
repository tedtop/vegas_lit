import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/config/enum.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/data/repositories/bets_repository.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/features/games/basketball/ncaab/models/ncaab_team.dart';

part 'bet_button_state.dart';

class NcaabBetButtonCubit extends Cubit<NccabBetButtonState> {
  NcaabBetButtonCubit({@required BetsRepository betsRepository})
      : assert(betsRepository != null),
        _betsRepository = betsRepository,
        super(
          const NccabBetButtonState.loading(),
        );

  final BetsRepository _betsRepository;

  DateTime fetchTimeEST() {
    tz.initializeTimeZones();
    final locationNY = tz.getLocation('America/New_York');
    final nowNY = tz.TZDateTime.now(locationNY);
    return nowNY;
  }

  void openBetButton({
    @required String text,
    @required Game game,
    @required Bet betType,
    @required String uid,
    @required String mainOdds,
    @required int gameId,
    @required bool isClosed,
    @required BetButtonWin winTeam,
    @required double spread,
    @required NcaabTeam awayTeamData,
    @required String league,
    @required NcaabTeam homeTeamData,
  }) {
    // final todayDateTime = fetchTimeEST();
    // final todayFormatDate = todayDateTime.millisecondsSinceEpoch;
    // final todayFormatDate = DateFormat('yyyy-MM-dd').format(todayDateTime);
    final winTeamString = winTeam == BetButtonWin.away ? 'away' : 'home';
    final gameStartTimeFormat =
        DateFormat('yyyy-MM-dd-hh-mm').format(game.dateTime);
    final betTypeString = betType == Bet.ml
        ? 'ml'
        : betType == Bet.pts
            ? 'pts'
            : 'tot';
    final uniqueId =
        '${league.toUpperCase()}-${game.awayTeam.toUpperCase()}-${game.homeTeam.toUpperCase()}-${betTypeString.toUpperCase()}-${winTeamString.toUpperCase()}-$gameId-${gameStartTimeFormat.toUpperCase()}-$uid';

    emit(
      NccabBetButtonState.unclicked(
        text: text,
        gameId: gameId,
        isClosed: isClosed,
        game: game,
        awayTeamData: awayTeamData,
        winTeam: winTeam,
        homeTeamData: homeTeamData,
        uniqueId: uniqueId,
        spread: spread,
        league: league,
        betType: betType,
        mainOdds: mainOdds,
        uid: uid,
      ),
    );
  }

  Future<bool> clickBetButton() async {
    final isBetExists = await _betsRepository.isBetExist(
      betId: state.uniqueId,
      uid: state.uid,
    );
    if (isBetExists) {
      emit(
        NccabBetButtonState.placed(
          text: state.text,
          isClosed: state.isClosed,
          gameId: state.gameId,
          game: state.game,
          uid: state.uid,
          winTeam: state.winTeam,
          uniqueId: state.uniqueId,
          spread: state.spread,
          awayTeamData: state.awayTeamData,
          league: state.league,
          homeTeamData: state.homeTeamData,
          mainOdds: state.mainOdds,
          betType: state.betType,
        ),
      );
      return true;
    } else {
      emit(
        NccabBetButtonState.clicked(
          text: state.text,
          isClosed: state.isClosed,
          uid: state.uid,
          gameId: state.gameId,
          game: state.game,
          winTeam: state.winTeam,
          uniqueId: state.uniqueId,
          spread: state.spread,
          awayTeamData: state.awayTeamData,
          league: state.league,
          homeTeamData: state.homeTeamData,
          mainOdds: state.mainOdds,
          betType: state.betType,
        ),
      );
      return false;
    }
  }

  void unclickBetButton() {
    emit(
      NccabBetButtonState.unclicked(
        text: state.text,
        mainOdds: state.mainOdds,
        game: state.game,
        league: state.league,
        isClosed: state.isClosed,
        gameId: state.gameId,
        uid: state.uid,
        winTeam: state.winTeam,
        awayTeamData: state.awayTeamData,
        homeTeamData: state.homeTeamData,
        spread: state.spread,
        uniqueId: state.uniqueId,
        betType: state.betType,
      ),
    );
  }

  void confirmBetButton() {
    emit(
      NccabBetButtonState.done(
        text: state.text,
        game: state.game,
        mainOdds: state.mainOdds,
        winTeam: state.winTeam,
        uid: state.uid,
        isClosed: state.isClosed,
        gameId: state.gameId,
        league: state.league,
        awayTeamData: state.awayTeamData,
        homeTeamData: state.homeTeamData,
        spread: state.spread,
        uniqueId: state.uniqueId,
        betType: state.betType,
      ),
    );
  }
}
