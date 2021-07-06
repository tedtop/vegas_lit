import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../../../../../config/enum.dart';
import '../../../../../../../data/models/bet.dart';
import '../../../../../../../data/models/nfl/nfl_game.dart';
import '../../../../../../../data/repositories/bets_repository.dart';
import '../../../models/nfl_team.dart';

part 'bet_button_state.dart';

class NflBetButtonCubit extends Cubit<NflBetButtonState> {
  NflBetButtonCubit({@required BetsRepository betsRepository})
      : assert(betsRepository != null),
        _betsRepository = betsRepository,
        super(
          const NflBetButtonState(),
        );

  final BetsRepository _betsRepository;

  void openBetButton({
    @required String text,
    @required NflGame game,
    @required Bet betType,
    @required String uid,
    @required String mainOdds,
    @required BetButtonWin winTeam,
    @required double spread,
    @required NflTeam awayTeamData,
    @required String league,
    @required NflTeam homeTeamData,
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
        '${league.toUpperCase()}-${game.awayTeam.toUpperCase()}-${game.homeTeam.toUpperCase()}-${betTypeString.toUpperCase()}-${winTeamString.toUpperCase()}-${game.gameId}-${gameStartTimeFormat.toUpperCase()}-$uid';

    final toWinAmount =
        toWinAmountCalculation(odds: mainOdds, betAmount: state.betAmount);

    emit(
      NflBetButtonState(
        text: text,
        status: NflBetButtonStatus.unclicked,
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
        state.copyWith(status: NflBetButtonStatus.alreadyPlaced),
      );
      return true;
    } else {
      emit(
        state.copyWith(status: NflBetButtonStatus.clicked),
      );
      return false;
    }
  }

  void unclickBetButton() {
    emit(
      state.copyWith(status: NflBetButtonStatus.unclicked),
    );
  }

  void confirmBetButton() {
    emit(
      state.copyWith(status: NflBetButtonStatus.placed),
    );
  }

  void placingBet() {
    emit(
      state.copyWith(status: NflBetButtonStatus.placing),
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
