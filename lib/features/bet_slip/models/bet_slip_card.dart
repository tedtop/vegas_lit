import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:vegas_lit/config/enum.dart';

class BetSlipCardData extends Equatable {
  BetSlipCardData({
    @required this.id,
    @required this.betType,
    @required this.betButtonCubit,
    @required this.league,
    @required this.odds,
  });

  final String id;
  final Bet betType;
  final String odds;
  final Cubit betButtonCubit;
  final String league;

  BetSlipCardData copyWith({
    String id,
    Bet betType,
    String odds,
    Cubit betButtonCubit,
    String league,
  }) {
    return BetSlipCardData(
      betButtonCubit: betButtonCubit ?? this.betButtonCubit,
      id: id ?? this.id,
      odds: odds ?? this.odds,
      betType: betType ?? this.betType,
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
    ];
  }
}
