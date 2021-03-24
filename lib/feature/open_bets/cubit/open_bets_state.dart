part of 'open_bets_cubit.dart';

abstract class OpenBetsState extends Equatable {
  const OpenBetsState();

  @override
  List<Object> get props => [];
}

class OpenBetsInitial extends OpenBetsState {}

class OpenBetsOpened extends OpenBetsState {
  OpenBetsOpened({this.openBets});

  final List<OpenBets> openBets;

  @override
  List<Object> get props => [openBets];
}
