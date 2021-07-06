import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../../../../../config/enum.dart';
import '../../../../../../../data/models/bet.dart';
import '../../../../../../../data/models/ncaaf/ncaaf_game.dart';
import '../../../../../../../data/repositories/bets_repository.dart';
import '../../../models/ncaaf_team.dart';

part 'bet_button_state.dart';

class NcaafBetButtonCubit extends Cubit<NcaafBetButtonState> {
  NcaafBetButtonCubit({@required BetsRepository betsRepository})
      : assert(betsRepository != null),
        _betsRepository = betsRepository,
        super(
          const NcaafBetButtonState(),
        );

  final BetsRepository _betsRepository;

  void openBetButton({
    @required String text,
    @required NcaafGame game,
    @required Bet betType,
    @required String uid,
    @required String mainOdds,
    @required BetButtonWin winTeam,
    @required double spread,
    @required NcaafTeam awayTeamData,
    @required String league,
    @required NcaafTeam homeTeamData,
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
      NcaafBetButtonState(
        text: text,
        status: NcaafBetButtonStatus.unclicked,
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
        state.copyWith(status: NcaafBetButtonStatus.alreadyPlaced),
      );
      return true;
    } else {
      emit(
        state.copyWith(status: NcaafBetButtonStatus.clicked),
      );
      return false;
    }
  }

  void unclickBetButton() {
    emit(
      state.copyWith(status: NcaafBetButtonStatus.unclicked),
    );
  }

  void confirmBetButton() {
    emit(
      state.copyWith(status: NcaafBetButtonStatus.placed),
    );
  }

  void placingBet() {
    emit(
      state.copyWith(status: NcaafBetButtonStatus.placing),
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
