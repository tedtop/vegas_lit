import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../../../../../config/enum.dart';
import '../../../../../../../data/models/bet.dart';
import '../../../../../../../data/models/mlb/mlb_game.dart';
import '../../../../../../../data/repositories/bets_repository.dart';
import '../../../models/mlb_team.dart';

part 'bet_button_state.dart';

class MlbBetButtonCubit extends Cubit<MlbBetButtonState> {
  MlbBetButtonCubit({@required BetsRepository betsRepository})
      : assert(betsRepository != null),
        _betsRepository = betsRepository,
        super(
          const MlbBetButtonState(),
        );

  final BetsRepository _betsRepository;

  void openBetButton({
    @required String text,
    @required MlbGame game,
    @required Bet betType,
    @required String uid,
    @required String mainOdds,
    @required BetButtonWin winTeam,
    @required double spread,
    @required MlbTeam awayTeamData,
    @required String league,
    @required MlbTeam homeTeamData,
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
      MlbBetButtonState(
        text: text,
        status: MlbBetButtonStatus.unclicked,
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
        state.copyWith(status: MlbBetButtonStatus.alreadyPlaced),
      );
      return true;
    } else {
      emit(
        state.copyWith(status: MlbBetButtonStatus.clicked),
      );
      return false;
    }
  }

  void unclickBetButton() {
    emit(
      state.copyWith(status: MlbBetButtonStatus.unclicked),
    );
  }

  void confirmBetButton() {
    emit(
      state.copyWith(status: MlbBetButtonStatus.placed),
    );
  }

  void placingBet() {
    emit(
      state.copyWith(status: MlbBetButtonStatus.placing),
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
