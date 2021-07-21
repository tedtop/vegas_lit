import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vegas_lit/config/extensions.dart';
import 'package:vegas_lit/data/models/mlb/mlb_bet.dart';

import '../../../../../../../config/enum.dart';
import '../../../../../../../data/models/bet.dart';
import '../../../../../../../data/models/mlb/mlb_game.dart';
import '../../../../../../../data/repositories/bets_repository.dart';
import '../../../models/mlb_team.dart';

part 'bet_button_state.dart';

class MlbBetButtonCubit extends Cubit<MlbBetButtonState> {
  MlbBetButtonCubit({@required BetsRepository betsRepository})
      : assert(betsRepository != null),
        _betsRepository = betsRepository,
        super(
          const MlbBetButtonState(),
        );

  final BetsRepository _betsRepository;

  void openBetButton({
    @required String text,
    @required MlbGame game,
    @required Bet betType,
    @required String uid,
    @required String mainOdds,
    @required BetButtonWin winTeam,
    @required double spread,
    @required MlbTeam awayTeamData,
    @required String league,
    @required MlbTeam homeTeamData,
  }) {
    final winTeamString = winTeam == BetButtonWin.away ? 'away' : 'home';
    final gameStartTimeFormat =
        DateFormat('yyyy-MM-dd-hh-mm').format(game.dateTime);
    final betTypeString = betType == Bet.ml
        ? 'ml'
        : betType == Bet.pts
            ? 'pts'
            : 'tot';
    final uniqueId =
        '${league.toUpperCase()}-${game.awayTeam.toUpperCase()}-${game.homeTeam.toUpperCase()}-${betTypeString.toUpperCase()}-${winTeamString.toUpperCase()}-${game.gameId}-${gameStartTimeFormat.toUpperCase()}-$uid';

    final toWinAmount =
        toWinAmountCalculation(odds: mainOdds, betAmount: state.betAmount);

    emit(
      MlbBetButtonState(
        text: text,
        status: MlbBetButtonStatus.unclicked,
        game: game,
        toWinAmount: toWinAmount,
        betAmount: state.betAmount,
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
      uid: state.uid,
    );
    if (isBetExists) {
      emit(
        state.copyWith(status: MlbBetButtonStatus.alreadyPlaced),
      );
      return true;
    } else {
      emit(
        state.copyWith(status: MlbBetButtonStatus.clicked),
      );
      return false;
    }
  }

  void unclickBetButton() {
    emit(
      state.copyWith(status: MlbBetButtonStatus.unclicked),
    );
  }

  Future<void> placeBet({
    @required bool isMinimumVersion,
    @required MlbBetButtonState betButtonState,
    @required BuildContext context,
    @required int balanceAmount,
    @required String username,
    @required String currentUserId,
  }) async {
    if (isMinimumVersion) {
      if (betButtonState.game.dateTime.isBefore(ESTDateTime.fetchTimeEST())) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              duration: Duration(milliseconds: 2000),
              content: Text(
                'This game has already started.',
              ),
            ),
          );
      } else {
        if (betButtonState.betAmount != null &&
            betButtonState.betAmount != 0 &&
            betButtonState.toWinAmount != 0) {
          if (balanceAmount - betButtonState.betAmount < 0) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  duration: Duration(milliseconds: 2000),
                  content: Text(
                    // ignore: lines_longer_than_80_chars
                    "You're out of funds. Try watching the video in your bet slip.",
                  ),
                ),
              );
          } else {
            emit(state.copyWith(status: MlbBetButtonStatus.placing));
            await context.read<MlbBetButtonCubit>().updateOpenBets(
                  betAmount: betButtonState.betAmount,
                  betsData: MlbBetData(
                    stillOpen: false,
                    username: username,
                    homeTeamCity: betButtonState.homeTeamData.city,
                    awayTeamCity: betButtonState.awayTeamData.city,
                    betAmount: betButtonState.betAmount,
                    gameId: betButtonState.game.gameId,
                    isClosed: betButtonState.game.isClosed,
                    homeTeam: betButtonState.game.homeTeam,
                    awayTeam: betButtonState.game.awayTeam,
                    winningTeam: null,
                    winningTeamName: null,
                    status: betButtonState.game.status,
                    league: betButtonState.league,
                    betOverUnder: betButtonState.game.overUnder,
                    betPointSpread: betButtonState.game.pointSpread,
                    awayTeamName: betButtonState.awayTeamData.name,
                    homeTeamName: betButtonState.homeTeamData.name,
                    totalGameScore: null,
                    id: betButtonState.uniqueId,
                    betType:
                        whichBetSystemToSave(betType: betButtonState.betType),
                    odds: int.parse(betButtonState.mainOdds),
                    betProfit: betButtonState.toWinAmount,
                    gameStartDateTime: betButtonState.game.dateTime.toString(),
                    awayTeamScore: betButtonState.game.awayTeamScore,
                    homeTeamScore: betButtonState.game.homeTeamScore,
                    uid: currentUserId,
                    betTeam: betButtonState.winTeam == BetButtonWin.home
                        ? 'home'
                        : 'away',
                    dateTime: ESTDateTime.fetchTimeEST().toString(),
                    week: ESTDateTime.weekStringVL,
                    clientVersion: await _getAppVersion(),
                    dataProvider: 'sportsdata.io',
                  ),
                  currentUserId: currentUserId,
                );

            emit(state.copyWith(status: MlbBetButtonStatus.placed));
          }
        }
      }
    } else {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 2000),
            content: Text(
              'Please update your app to place bets.',
            ),
          ),
        );
    }
  }

  Future<void> updateOpenBets({
    @required String currentUserId,
    @required BetData betsData,
    @required int betAmount,
  }) async {
    await _betsRepository.saveBet(
      uid: currentUserId,
      betsData: betsData,
      cutBalance: betAmount,
    );
  }

  void updateBetAmount({@required int toWinAmount, @required int betAmount}) {
    emit(
      state.copyWith(betAmount: betAmount, toWinAmount: toWinAmount),
    );
  }

  int toWinAmountCalculation({@required String odds, @required int betAmount}) {
    if (int.parse(odds).isNegative) {
      final toWinAmount = (100 / int.parse(odds) * betAmount).round().abs();
      return toWinAmount;
    } else {
      final toWinAmount = (int.parse(odds) / 100 * betAmount).round().abs();
      return toWinAmount;
    }
  }

  String whichBetSystemToSave({@required Bet betType}) {
    if (betType == Bet.ml) {
      return 'moneyline';
    }
    if (betType == Bet.pts) {
      return 'pointspread';
    }
    if (betType == Bet.tot) {
      return 'total';
    } else {
      return 'error';
    }
  }

  Future<String> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
