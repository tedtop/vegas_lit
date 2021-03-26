import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:vegas_lit/config/enum.dart';
import 'package:vegas_lit/feature/sportsbook/subfeature/bet_button/bet_button.dart';

class BetSlipCardData extends Equatable {
  final String id;
  final bool isRemove;
  final Bet betType;
  final int betAmount;
  final BetButtonCubit betButtonCubit;
  final int toWinAmount;

  BetSlipCardData({
    @required this.id,
    this.isRemove = false,
    @required this.betType,
    @required this.betAmount,
    @required this.betButtonCubit,
    @required this.toWinAmount,
  });

  BetSlipCardData copyWith({
    String id,
    bool isRemove,
    Bet betType,
    int betAmount,
    BetButtonCubit betButtonCubit,
    int toWinAmount,
  }) {
    return BetSlipCardData(
      betButtonCubit: betButtonCubit ?? this.betButtonCubit,
      id: id ?? this.id,
      isRemove: isRemove ?? this.isRemove,
      betType: betType ?? this.betType,
      betAmount: betAmount ?? this.betAmount,
      toWinAmount: toWinAmount ?? this.toWinAmount,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      betButtonCubit,
      isRemove,
      betType,
      betAmount,
      toWinAmount,
    ];
  }
}
