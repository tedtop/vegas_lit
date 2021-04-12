import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:api_client/api_client.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import 'package:vegas_lit/config/enum.dart';
import 'package:vegas_lit/sportsbook/models/team.dart';

part 'bet_button_state.dart';

class BetButtonCubit extends Cubit<BetButtonState> {
  BetButtonCubit()
      : super(
          const BetButtonState.loading(),
        );

  void openBetButton({
    @required String text,
    @required Game game,
    @required Bet betType,
    @required String mainOdds,
    @required int gameId,
    @required bool isClosed,
    @required Team awayTeamData,
    @required String league,
    @required Team homeTeamData,
  }) {
    final uniqueId = const Uuid().v1();
    emit(
      BetButtonState.unclicked(
        text: text,
        gameId: gameId,
        isClosed: isClosed,
        game: game,
        awayTeamData: awayTeamData,
        homeTeamData: homeTeamData,
        uniqueId: uniqueId,
        league: league,
        betType: betType,
        mainOdds: mainOdds,
      ),
    );
  }

  void clickBetButton() {
    emit(
      BetButtonState.clicked(
          text: state.text,
          isClosed: state.isClosed,
          gameId: state.gameId,
          game: state.game,
          uniqueId: state.uniqueId,
          awayTeamData: state.awayTeamData,
          league: state.league,
          homeTeamData: state.homeTeamData,
          mainOdds: state.mainOdds,
          betType: state.betType),
    );
  }

  void unclickBetButton() {
    emit(
      BetButtonState.unclicked(
          text: state.text,
          mainOdds: state.mainOdds,
          game: state.game,
          league: state.league,
          isClosed: state.isClosed,
          gameId: state.gameId,
          awayTeamData: state.awayTeamData,
          homeTeamData: state.homeTeamData,
          uniqueId: state.uniqueId,
          betType: state.betType),
    );
  }

  void confirmBetButton() {
    emit(
      BetButtonState.done(
          text: state.text,
          game: state.game,
          mainOdds: state.mainOdds,
          isClosed: state.isClosed,
          gameId: state.gameId,
          league: state.league,
          awayTeamData: state.awayTeamData,
          homeTeamData: state.homeTeamData,
          uniqueId: state.uniqueId,
          betType: state.betType),
    );
  }
}
