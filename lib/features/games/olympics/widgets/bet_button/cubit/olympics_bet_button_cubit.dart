import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vegas_lit/config/extensions.dart';
import 'package:vegas_lit/data/models/bet.dart';
import 'package:vegas_lit/data/models/olympics/olympics.dart';
import 'package:vegas_lit/data/repositories/bets_repository.dart';

part 'olympics_bet_button_state.dart';

class OlympicsBetButtonCubit extends Cubit<OlympicsBetButtonState> {
  OlympicsBetButtonCubit({@required BetsRepository betsRepository})
      : assert(betsRepository != null),
        _betsRepository = betsRepository,
        super(
          const OlympicsBetButtonState(),
        );

  final BetsRepository _betsRepository;

  void openBetButton({
    @required OlympicsGame game,
    @required String uid,
    @required BetButtonWin winTeam,
    @required String league,
  }) {
    final winTeamString = winTeam == BetButtonWin.player ? 'player' : 'rival';
    final gameStartTimeFormat =
        DateFormat('yyyy-MM-dd-hh-mm').format(game.startTime);

    final uniqueId =
        '${league.toUpperCase()}-${winTeamString.toUpperCase()}-${game.documentID}-${gameStartTimeFormat.toUpperCase()}-$uid';

    final toWinAmount = toWinAmountCalculation(
        odds: state.mainOdds, betAmount: state.betAmount);

    emit(
      OlympicsBetButtonState(
        status: OlympicsBetButtonStatus.unclicked,
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
        state.copyWith(status: OlympicsBetButtonStatus.alreadyPlaced),
      );
      return true;
    } else {
      emit(
        state.copyWith(status: OlympicsBetButtonStatus.clicked),
      );
      return false;
    }
  }

  void unclickBetButton() {
    emit(
      state.copyWith(status: OlympicsBetButtonStatus.unclicked),
    );
  }

  Future<void> placeBet({
    @required bool isMinimumVersion,
    @required OlympicsBetButtonState betButtonState,
    @required BuildContext context,
    @required int balanceAmount,
    @required String username,
    @required String currentUserId,
  }) async {
    if (isMinimumVersion) {
      if (betButtonState.game.startTime.isBefore(ESTDateTime.fetchTimeEST())) {
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
            emit(state.copyWith(status: OlympicsBetButtonStatus.placing));
            // await context.read<OlympicsBetButtonCubit>().updateOpenBets(
            //       betAmount: betButtonState.betAmount,
            //       // betsData: OlympicsBetData(
            //       //   stillOpen: false,
            //       //   username: username,
            //       //   betAmount: betButtonState.betAmount,
            //       //   isClosed: betButtonState.game.isClosed,
            //       //   winningTeam: null,
            //       //   winningTeamName: null,
            //       //   status: betButtonState.game.status,
            //       //   league: betButtonState.league,
            //       //   betOverUnder: betButtonState.game.overUnder,
            //       //   betPointSpread: betButtonState.game.pointSpread,
            //       //   awayTeamName: betButtonState.awayTeamData.name,
            //       //   homeTeamName: betButtonState.homeTeamData.name,
            //       //   totalGameScore: null,
            //       //   id: betButtonState.uniqueId,
            //       //   betType:
            //       //       whichBetSystemToSave(betType: betButtonState.betType),
            //       //   odds: int.parse(betButtonState.),
            //       //   betProfit: betButtonState.toWinAmount,
            //       //   gameStartDateTime: betButtonState.game.date.toString(),
            //       //   uid: currentUserId,
            //       //   dateTime: ESTDateTime.fetchTimeEST().toString(),
            //       //   week: ESTDateTime.weekStringVL,
            //       //   clientVersion: await _getAppVersion(),
            //       //   dataProvider: 'sportsdata.io',
            //       // ),
            //       currentUserId: currentUserId,
            //     );

            emit(state.copyWith(status: OlympicsBetButtonStatus.placed));
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

  int toWinAmountCalculation({@required int odds, @required int betAmount}) {
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
