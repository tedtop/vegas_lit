import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:vegas_lit/config/enum.dart';

class BetSlipCardData extends Equatable {
  BetSlipCardData({
    @required this.id,
    @required this.betType,
    @required this.betAmount,
    @required this.betButtonCubit,
    @required this.toWinAmount,
    @required this.league,
    @required this.odds,
  });

  final String id;
  final Bet betType;
  final String odds;
  final int betAmount;
  final Cubit betButtonCubit;
  final int toWinAmount;
  final String league;

  BetSlipCardData copyWith({
    String id,
    bool isRemove,
    Bet betType,
    int betAmount,
    String odds,
    Cubit betButtonCubit,
    int toWinAmount,
    String league,
  }) {
    return BetSlipCardData(
      betButtonCubit: betButtonCubit ?? this.betButtonCubit,
      id: id ?? this.id,
      odds: odds ?? this.odds,
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
      odds,
      betType,
      league,
      betAmount,
      toWinAmount,
    ];
  }
}
