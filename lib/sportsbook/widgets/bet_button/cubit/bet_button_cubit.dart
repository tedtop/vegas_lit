import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:api_client/api_client.dart';
import 'package:meta/meta.dart';
// ignore: unused_import
import 'package:uuid/uuid.dart';
import 'package:vegas_lit/config/enum.dart';
import 'package:vegas_lit/sportsbook/models/team.dart';

part 'bet_button_state.dart';

class BetButtonCubit extends Cubit<BetButtonState> {
  BetButtonCubit({@required BetsRepository betsRepository})
      : assert(betsRepository != null),
        _betsRepository = betsRepository,
        super(
          const BetButtonState.loading(),
        );

  final BetsRepository _betsRepository;

  void openBetButton({
    @required String text,
    @required Game game,
    @required Bet betType,
    @required String mainOdds,
    @required int gameId,
    @required bool isClosed,
    @required BetButtonWin winTeam,
    @required double spread,
    @required Team awayTeamData,
    @required String league,
    @required Team homeTeamData,
  }) {
    final winTeamString = winTeam == BetButtonWin.away ? 'away' : 'home';
    final betTypeString = betType == Bet.ml
        ? 'ml'
        : betType == Bet.pts
            ? 'pts'
            : 'tot';
    final uniqueId =
        '$gameId$league${game.dateTime}$winTeamString$betTypeString';
    emit(
      BetButtonState.unclicked(
        text: text,
        gameId: gameId,
        isClosed: isClosed,
        game: game,
        awayTeamData: awayTeamData,
        winTeam: winTeam,
        homeTeamData: homeTeamData,
        uniqueId: uniqueId,
        spread: spread,
        league: league,
        betType: betType,
        mainOdds: mainOdds,
      ),
    );
  }

  Future<bool> clickBetButton() async {
    final isBetExists = await _betsRepository.isBetExist(
      betId: state.uniqueId,
    );
    if (isBetExists) {
      emit(
        BetButtonState.placed(
          text: state.text,
          isClosed: state.isClosed,
          gameId: state.gameId,
          game: state.game,
          winTeam: state.winTeam,
          uniqueId: state.uniqueId,
          spread: state.spread,
          awayTeamData: state.awayTeamData,
          league: state.league,
          homeTeamData: state.homeTeamData,
          mainOdds: state.mainOdds,
          betType: state.betType,
        ),
      );
      return true;
    } else {
      emit(
        BetButtonState.clicked(
          text: state.text,
          isClosed: state.isClosed,
          gameId: state.gameId,
          game: state.game,
          winTeam: state.winTeam,
          uniqueId: state.uniqueId,
          spread: state.spread,
          awayTeamData: state.awayTeamData,
          league: state.league,
          homeTeamData: state.homeTeamData,
          mainOdds: state.mainOdds,
          betType: state.betType,
        ),
      );
      return false;
    }
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
        winTeam: state.winTeam,
        awayTeamData: state.awayTeamData,
        homeTeamData: state.homeTeamData,
        spread: state.spread,
        uniqueId: state.uniqueId,
        betType: state.betType,
      ),
    );
  }

  void confirmBetButton() {
    emit(
      BetButtonState.done(
          text: state.text,
          game: state.game,
          mainOdds: state.mainOdds,
          winTeam: state.winTeam,
          isClosed: state.isClosed,
          gameId: state.gameId,
          league: state.league,
          awayTeamData: state.awayTeamData,
          homeTeamData: state.homeTeamData,
          spread: state.spread,
          uniqueId: state.uniqueId,
          betType: state.betType),
    );
  }
}
