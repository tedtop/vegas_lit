import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:api_client/api_client.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/config/enum.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:vegas_lit/sportsbook/models/team.dart';
import 'package:intl/intl.dart';

part 'bet_button_state.dart';

class BetButtonCubit extends Cubit<BetButtonState> {
  BetButtonCubit({@required BetsRepository betsRepository})
      : assert(betsRepository != null),
        _betsRepository = betsRepository,
        super(
          const BetButtonState.loading(),
        );

  final BetsRepository _betsRepository;

  DateTime fetchTimeEST() {
    tz.initializeTimeZones();
    final locationNY = tz.getLocation('America/New_York');
    final nowNY = tz.TZDateTime.now(locationNY);
    return nowNY;
  }

  void openBetButton({
    @required String text,
    @required Game game,
    @required Bet betType,
    @required String uid,
    @required String mainOdds,
    @required int gameId,
    @required bool isClosed,
    @required BetButtonWin winTeam,
    @required double spread,
    @required Team awayTeamData,
    @required String league,
    @required Team homeTeamData,
  }) {
    final todayDateTime = fetchTimeEST();
    final todayFormatDate = DateFormat('yyyy-MM-dd').format(todayDateTime);
    final winTeamString = winTeam == BetButtonWin.away ? 'away' : 'home';
    final gameStartTimeFormat = DateFormat('hh:mm').format(game.dateTime);
    final betTypeString = betType == Bet.ml
        ? 'ml'
        : betType == Bet.pts
            ? 'pts'
            : 'tot';
    final uniqueId =
        '$league-${game.awayTeam}-${game.homeTeam}-$betTypeString-$winTeamString@$todayFormatDate $gameStartTimeFormat'
            .toUpperCase();
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
        uid: uid,
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
          uid: state.uid,
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
          uid: state.uid,
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
        uid: state.uid,
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
        uid: state.uid,
        isClosed: state.isClosed,
        gameId: state.gameId,
        league: state.league,
        awayTeamData: state.awayTeamData,
        homeTeamData: state.homeTeamData,
        spread: state.spread,
        uniqueId: state.uniqueId,
        betType: state.betType,
      ),
    );
  }
}
