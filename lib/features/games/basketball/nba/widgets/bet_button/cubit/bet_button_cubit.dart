import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/config/enum.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:vegas_lit/data/models/game.dart';
import 'package:vegas_lit/data/repositories/bets_repository.dart';
import 'package:vegas_lit/features/games/basketball/nba/models/nba_team.dart';
import 'package:intl/intl.dart';

part 'bet_button_state.dart';

class NbaBetButtonCubit extends Cubit<NbaBetButtonState> {
  NbaBetButtonCubit({@required BetsRepository betsRepository})
      : assert(betsRepository != null),
        _betsRepository = betsRepository,
        super(
          const NbaBetButtonState.loading(),
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
    @required NbaTeam awayTeamData,
    @required String league,
    @required NbaTeam homeTeamData,
  }) {
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

    final toWinAmount =
        toWinAmountCalculation(odds: mainOdds, betAmount: state.betAmount);

    emit(
      NbaBetButtonState.unclicked(
        text: text,
        gameId: gameId,
        isClosed: isClosed,
        game: game,
        awayTeamData: awayTeamData,
        toWinAmount: toWinAmount,
        betAmount: state.betAmount,
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
        NbaBetButtonState.placed(
          text: state.text,
          isClosed: state.isClosed,
          gameId: state.gameId,
          game: state.game,
          uid: state.uid,
          toWinAmount: state.toWinAmount,
          betAmount: state.betAmount,
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
        NbaBetButtonState.clicked(
          text: state.text,
          isClosed: state.isClosed,
          toWinAmount: state.toWinAmount,
          betAmount: state.betAmount,
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
      NbaBetButtonState.unclicked(
        text: state.text,
        mainOdds: state.mainOdds,
        game: state.game,
        league: state.league,
        toWinAmount: state.toWinAmount,
        betAmount: state.betAmount,
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
      NbaBetButtonState.done(
        text: state.text,
        game: state.game,
        mainOdds: state.mainOdds,
        toWinAmount: state.toWinAmount,
        betAmount: state.betAmount,
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

  void updateBetAmount({@required int toWinAmount, @required int betAmount}) {
    emit(
      state.copyWith(betAmount: betAmount, toWinAmount: toWinAmount),
    );
  }

  int toWinAmountCalculation({@required String odds, @required int betAmount}) {
    if (int.parse(odds).isNegative) {
      final toWinAmount = (100 / int.parse(odds) * betAmount).round().abs();
      return toWinAmount;
    } else {
      final toWinAmount = (int.parse(odds) / 100 * betAmount).round().abs();
      return toWinAmount;
    }
  }
}
