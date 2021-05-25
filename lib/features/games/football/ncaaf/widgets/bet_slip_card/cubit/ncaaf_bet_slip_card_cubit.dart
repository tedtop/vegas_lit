import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/features/bet_slip/models/bet_slip_card.dart';

part 'ncaaf_bet_slip_card_state.dart';

class NcaafBetSlipCardCubit extends Cubit<NcaafBetSlipCardState> {
  NcaafBetSlipCardCubit() : super(const NcaafBetSlipCardState.initial());

  void openBetSlipCard({@required BetSlipCardData betSlipCardData}) {
    final toWinAmountValue = toWinAmount(
      odds: betSlipCardData.odds,
      betAmount: betSlipCardData.betAmount,
    );
    final updatedBetSlipCard = betSlipCardData.copyWith(
      toWinAmount: toWinAmountValue,
      betAmount: betSlipCardData.betAmount,
    );
    emit(
      NcaafBetSlipCardState.opened(
        toWinAmount: toWinAmountValue,
        betSlipCardData: updatedBetSlipCard,
      ),
    );
  }

  void updateBetAmount({@required int toWinAmount, @required int betAmount}) {
    final updatedBetSlipCard = state.betSlipCardData.copyWith(
      toWinAmount: toWinAmount,
      betAmount: betAmount,
    );
    emit(
      NcaafBetSlipCardState.opened(
        toWinAmount: toWinAmount,
        betSlipCardData: updatedBetSlipCard,
      ),
    );
  }

  int toWinAmount({@required String odds, @required int betAmount}) {
    if (int.parse(odds).isNegative) {
      final toWinAmount = (100 / int.parse(odds) * betAmount).round().abs();
      return toWinAmount;
    } else {
      final toWinAmount = (int.parse(odds) / 100 * betAmount).round().abs();
      return toWinAmount;
    }
  }
}
