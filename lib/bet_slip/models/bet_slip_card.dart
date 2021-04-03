import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:vegas_lit/config/enum.dart';
import 'package:vegas_lit/sportsbook/widgets/bet_button/bet_button.dart';

class BetSlipCardData extends Equatable {
  final String id;

  final Bet betType;
  final int betAmount;
  final BetButtonCubit betButtonCubit;
  final int toWinAmount;
  final String league;

  BetSlipCardData({
    @required this.id,
    @required this.betType,
    @required this.betAmount,
    @required this.betButtonCubit,
    @required this.toWinAmount,
    @required this.league,
  });

  BetSlipCardData copyWith({
    String id,
    bool isRemove,
    Bet betType,
    int betAmount,
    BetButtonCubit betButtonCubit,
    int toWinAmount,
    String league,
  }) {
    return BetSlipCardData(
      betButtonCubit: betButtonCubit ?? this.betButtonCubit,
      id: id ?? this.id,
      betType: betType ?? this.betType,
      betAmount: betAmount ?? this.betAmount,
      toWinAmount: toWinAmount ?? this.toWinAmount,
      league: league ?? this.league,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      betButtonCubit,
      betType,
      league,
      betAmount,
      toWinAmount,
    ];
  }
}
