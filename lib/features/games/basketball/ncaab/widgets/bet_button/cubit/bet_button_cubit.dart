import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../../../../../config/enum.dart';
import '../../../../../../../data/models/bet.dart';
import '../../../../../../../data/models/ncaab/ncaab_game.dart';
import '../../../../../../../data/repositories/bets_repository.dart';
import '../../../models/ncaab_team.dart';

part 'bet_button_state.dart';

class NcaabBetButtonCubit extends Cubit<NcaabBetButtonState> {
  NcaabBetButtonCubit({@required BetsRepository betsRepository})
      : assert(betsRepository != null),
        _betsRepository = betsRepository,
        super(
          const NcaabBetButtonState.loading(),
        );

  final BetsRepository _betsRepository;

  void openBetButton({
    @required String text,
    @required NcaabGame game,
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
      NcaabBetButtonState.unclicked(
        text: text,
        gameId: gameId,
        isClosed: isClosed,
        game: game,
        toWinAmount: toWinAmount,
        betAmount: state.betAmount,
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
        NcaabBetButtonState.placed(
          text: state.text,
          isClosed: state.isClosed,
          gameId: state.gameId,
          game: state.game,
          toWinAmount: state.toWinAmount,
          betAmount: state.betAmount,
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
        NcaabBetButtonState.clicked(
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
          toWinAmount: state.toWinAmount,
          betAmount: state.betAmount,
          mainOdds: state.mainOdds,
          betType: state.betType,
        ),
      );
      return false;
    }
  }

  void unclickBetButton() {
    emit(
      NcaabBetButtonState.unclicked(
        text: state.text,
        mainOdds: state.mainOdds,
        game: state.game,
        league: state.league,
        isClosed: state.isClosed,
        toWinAmount: state.toWinAmount,
        betAmount: state.betAmount,
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
      NcaabBetButtonState.done(
        text: state.text,
        game: state.game,
        toWinAmount: state.toWinAmount,
        betAmount: state.betAmount,
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

  Future<void> updateOpenBets({
    @required String currentUserId,
    @required BetData betsData,
    @required int betAmount,
  }) async {
    await _betsRepository.saveBet(
      uid: currentUserId,
      betsData: betsData,
      cutBalance: betAmount,
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
