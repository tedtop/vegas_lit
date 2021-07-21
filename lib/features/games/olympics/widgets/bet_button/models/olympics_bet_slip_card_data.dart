import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class OlympicsBetSlipCardData extends Equatable {
  OlympicsBetSlipCardData({
    @required this.id,
    @required this.betButtonCubit,
    @required this.league,
    @required this.odds,
  });

  final String id;
  final int odds;
  final Cubit betButtonCubit;
  final String league;

  OlympicsBetSlipCardData copyWith({
    String id,
    int odds,
    Cubit betButtonCubit,
    String league,
  }) {
    return OlympicsBetSlipCardData(
      betButtonCubit: betButtonCubit ?? this.betButtonCubit,
      id: id ?? this.id,
      odds: odds ?? this.odds,
      league: league ?? this.league,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      betButtonCubit,
      odds,
      league,
    ];
  }
}
