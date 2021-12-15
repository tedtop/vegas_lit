import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../../../config/extensions.dart';
import '../../../../../../data/models/bet.dart';
import '../../../../../../data/models/paralympics/paralympics.dart';
import '../../../../../../data/models/paralympics/paralympics_bet.dart';
import '../../../../../../data/repositories/bet_repository.dart';

part 'paralympics_bet_button_state.dart';

class ParalympicsBetButtonCubit extends Cubit<ParalympicsBetButtonState> {
  ParalympicsBetButtonCubit({required BetRepository betsRepository})
      : assert(betsRepository != null),
        _betsRepository = betsRepository,
        super(
          const ParalympicsBetButtonState(),
        );

  final BetRepository _betsRepository;

  void openBetButton({
    required ParalympicsGame game,
    required String? uid,
    required BetButtonWin winTeam,
    required String league,
  }) {
    final winTeamString = winTeam == BetButtonWin.player ? 'player' : 'rival';
    final gameStartTimeFormat =
        DateFormat('yyyy-MM-dd-hh-mm').format(game.startTime!);

    final uniqueId =
        '${league.toUpperCase()}-${winTeamString.toUpperCase()}-${game.gameId}-${gameStartTimeFormat.toUpperCase()}-$uid';

    final toWinAmount = toWinAmountCalculation(
        odds: state.mainOdds, betAmount: state.betAmount);

    emit(
      ParalympicsBetButtonState(
        status: ParalympicsBetButtonStatus.unclicked,
        game: game,
        toWinAmount: toWinAmount,
        betAmount: state.betAmount,
        winTeam: winTeam,
        uniqueId: uniqueId,
        league: league,
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
        state.copyWith(status: ParalympicsBetButtonStatus.alreadyPlaced),
      );
      return true;
    } else {
      emit(
        state.copyWith(status: ParalympicsBetButtonStatus.clicked),
      );
      return false;
    }
  }

  void unclickBetButton() {
    emit(
      state.copyWith(status: ParalympicsBetButtonStatus.unclicked),
    );
  }

  Future<void> placeBet({
    required bool isMinimumVersion,
    required ParalympicsBetButtonState betButtonState,
    required BuildContext context,
    required int? balanceAmount,
    required String? username,
    required String? currentUserId,
  }) async {
    if (isMinimumVersion) {
      if (betButtonState.game!.startTime!
          .isBefore(ESTDateTime.fetchTimeEST())) {
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
          if (balanceAmount! - betButtonState.betAmount < 0) {
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
            emit(
              state.copyWith(status: ParalympicsBetButtonStatus.placing),
            );
            await context.read<ParalympicsBetButtonCubit>().updateOpenBets(
                  betAmount: betButtonState.betAmount,
                  betsData: ParalympicsBetData(
                    username: username,
                    betAmount: betButtonState.betAmount,
                    isClosed: betButtonState.game!.isClosed,
                    league: betButtonState.league!.toLowerCase(),
                    id: betButtonState.uniqueId,
                    betProfit: betButtonState.toWinAmount,
                    uid: currentUserId,
                    dateTime: ESTDateTime.fetchTimeEST().toString(),
                    week: ESTDateTime.fetchTimeEST().weekStringVL,
                    clientVersion: await _getAppVersion(),
                    dataProvider: 'paralympics.com',
                    gameName: state.game!.gameName,
                    playerName: state.game!.player,
                    rivalCountry: state.game!.rivalCountry,
                    rivalName: state.game!.rival,
                    eventType: state.game!.eventType,
                    betTeam: state.winTeam == BetButtonWin.player
                        ? 'player'
                        : 'rival',
                    event: state.game!.event,
                    gameId: state.game!.gameId,
                    playerCountry: state.game!.playerCountry,
                    gameStartDateTime: state.game!.startTime.toString(),
                    winner: null,
                  ),
                  currentUserId: currentUserId,
                );

            emit(
              state.copyWith(status: ParalympicsBetButtonStatus.placed),
            );
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
    required String? currentUserId,
    required BetData betsData,
    required int betAmount,
  }) async {
    await _betsRepository.saveBet(
      uid: currentUserId,
      betsData: betsData,
      cutBalance: betAmount,
    );
  }

  void updateBetAmount({required int toWinAmount, required int? betAmount}) {
    emit(
      state.copyWith(betAmount: betAmount, toWinAmount: toWinAmount),
    );
  }

  int toWinAmountCalculation({required int odds, required int betAmount}) {
    if (odds.isNegative) {
      final toWinAmount = (100 / odds * betAmount).round().abs();
      return toWinAmount;
    } else {
      final toWinAmount = (odds / 100 * betAmount).round().abs();
      return toWinAmount;
    }
  }

  Future<String> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
