import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vegas_lit/config/enum.dart';
import 'package:vegas_lit/config/extensions.dart';
import 'package:vegas_lit/data/models/bet.dart';
import 'package:vegas_lit/data/models/mlb/mlb_bet.dart';
import 'package:vegas_lit/data/models/nba/nba_bet.dart';
import 'package:vegas_lit/data/models/ncaab/ncaab_bet.dart';
import 'package:vegas_lit/data/models/ncaaf/ncaaf_bet.dart';
import 'package:vegas_lit/data/models/nfl/nfl_bet.dart';
import 'package:vegas_lit/data/models/nhl/nhl_bet.dart';
import 'package:vegas_lit/data/models/parlay/parlay_bet.dart';
import 'package:vegas_lit/data/repositories/bets_repository.dart';

import '../../../../../../../config/extensions.dart';

part 'parlay_bet_button_state.dart';

class ParlayBetButtonCubit extends Cubit<ParlayBetButtonState> {
  ParlayBetButtonCubit({@required BetsRepository betsRepository})
      : assert(betsRepository != null),
        _betsRepository = betsRepository,
        super(
          const ParlayBetButtonState(),
        );

  final BetsRepository _betsRepository;

  Future<void> openParlay({
    @required List<BetData> betDataList,
    @required String league,
    @required String uid,
  }) async {
    if (betDataList.length > 3) {
    } else {
      final toWinAmount = await parlayWinAmountCalculation(
          betDataList: betDataList, betAmount: state.betAmount);
      final betIdList = betDataList.map((e) => e.id).toList()..sort();
      var allIdString = '';
      await Future.wait(
        betIdList.map((e) async => allIdString = '$allIdString-$e'),
      );
      final uniqueId = '${league.toUpperCase()}-$allIdString';

      emit(ParlayBetButtonState(
        betAmount: state.betAmount,
        toWinAmount: toWinAmount,
        league: league,
        betList: betDataList,
        uid: uid,
        uniqueId: uniqueId,
      ));
    }
  }

  Future<void> placeBet({
    @required bool isMinimumVersion,
    @required BuildContext context,
    @required int balanceAmount,
    @required String username,
    @required List<BetData> betList,
    @required String currentUserId,
  }) async {
    // final isBetExists = await _betsRepository.isBetExist(
    //   betId: state.uniqueId,
    //   uid: state.uid,
    // );

    final isStartTimeList = betList.map(
      (bet) {
        if (bet is MlbBetData) {
          return DateTime.parse(bet.gameStartDateTime).isBefore(
            ESTDateTime.fetchTimeEST(),
          );
        } else if (bet is NbaBetData) {
          return DateTime.parse(bet.gameStartDateTime).isBefore(
            ESTDateTime.fetchTimeEST(),
          );
        } else if (bet is NcaabBetData) {
          return DateTime.parse(bet.gameStartDateTime).isBefore(
            ESTDateTime.fetchTimeEST(),
          );
        } else if (bet is NcaafBetData) {
          return DateTime.parse(bet.gameStartDateTime).isBefore(
            ESTDateTime.fetchTimeEST(),
          );
        } else if (bet is NflBetData) {
          return DateTime.parse(bet.gameStartDateTime).isBefore(
            ESTDateTime.fetchTimeEST(),
          );
        } else if (bet is NhlBetData) {
          return DateTime.parse(bet.gameStartDateTime).isBefore(
            ESTDateTime.fetchTimeEST(),
          );
        } else {
          return false;
        }
      },
    ).toList();
    final isTimeExceeds = isStartTimeList.contains(true);

    if (isMinimumVersion) {
      if (isTimeExceeds) {
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
        if (state.betAmount != null &&
            state.betAmount != 0 &&
            state.toWinAmount != 0) {
          if (balanceAmount - state.betAmount < 0) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  duration: Duration(milliseconds: 2000),
                  content: Text(
                    "You're out of funds. Try watching the video in your bet slip.",
                  ),
                ),
              );
          } else {
            emit(state.copyWith(status: ParlayBetButtonStatus.placing));
            await context.read<ParlayBetButtonCubit>().updateOpenBets(
                  betAmount: state.betAmount,
                  betsData: ParlayBets(
                    username: username,
                    betAmount: state.betAmount,
                    isClosed: false,
                    league: state.league,
                    id: state.uniqueId,
                    betProfit: state.toWinAmount,
                    uid: currentUserId,
                    dateTime: ESTDateTime.fetchTimeEST().toString(),
                    week: ESTDateTime.fetchTimeEST().weekStringVL,
                    clientVersion: await _getAppVersion(),
                    dataProvider: 'sportsdata.io',
                    bets: betList,
                  ),
                  currentUserId: currentUserId,
                );

            emit(state.copyWith(status: ParlayBetButtonStatus.placed));
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

  Future<void> updateBetAmount(
      {@required int betAmount, @required List<BetData> betList}) async {
    final toWinAmount = await parlayWinAmountCalculation(
      betDataList: betList,
      betAmount: betAmount,
    );
    emit(
      state.copyWith(betAmount: betAmount, toWinAmount: toWinAmount),
    );
  }

  Future<String> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<int> parlayWinAmountCalculation({
    @required List<BetData> betDataList,
    @required int betAmount,
  }) async {
    final decimalOddsList = betDataList.map((bet) {
      if (bet is MlbBetData) {
        if (bet.odds.isNegative) {
          final decimalOdds = (100 / bet.odds.abs()) + 1;
          return double.parse(decimalOdds.abs().toStringAsFixed(2));
        } else {
          final decimalOdds = (bet.odds / 100) + 1;
          return double.parse(decimalOdds.abs().toStringAsFixed(2));
        }
      } else if (bet is NbaBetData) {
        if (bet.odds.isNegative) {
          final decimalOdds = (100 / bet.odds.abs()) + 1;
          return double.parse(decimalOdds.abs().toStringAsFixed(2));
        } else {
          final decimalOdds = (bet.odds / 100) + 1;
          return double.parse(decimalOdds.abs().toStringAsFixed(2));
        }
      } else if (bet is NcaabBetData) {
        if (bet.odds.isNegative) {
          final decimalOdds = (100 / bet.odds.abs()) + 1;
          return double.parse(decimalOdds.abs().toStringAsFixed(2));
        } else {
          final decimalOdds = (bet.odds / 100) + 1;
          return double.parse(decimalOdds.abs().toStringAsFixed(2));
        }
      } else if (bet is NcaafBetData) {
        if (bet.odds.isNegative) {
          final decimalOdds = (100 / bet.odds.abs()) + 1;
          return double.parse(decimalOdds.abs().toStringAsFixed(2));
        } else {
          final decimalOdds = (bet.odds / 100) + 1;
          return double.parse(decimalOdds.abs().toStringAsFixed(2));
        }
      } else if (bet is NflBetData) {
        if (bet.odds.isNegative) {
          final decimalOdds = (100 / bet.odds.abs()) + 1;
          return double.parse(decimalOdds.abs().toStringAsFixed(2));
        } else {
          final decimalOdds = (bet.odds / 100) + 1;
          return double.parse(decimalOdds.abs().toStringAsFixed(2));
        }
      } else if (bet is NhlBetData) {
        if (bet.odds.isNegative) {
          final decimalOdds = (100 / bet.odds.abs()) + 1;
          return double.parse(decimalOdds.abs().toStringAsFixed(2));
        } else {
          final decimalOdds = (bet.odds / 100) + 1;
          return double.parse(decimalOdds.abs().toStringAsFixed(2));
        }
      } else {
        const localOdds = 100;
        if (localOdds.isNegative) {
          const decimalOdds = (100 / localOdds) + 1;
          return double.parse(decimalOdds.abs().toStringAsFixed(2));
        } else {
          const decimalOdds = (localOdds / 100) + 1;
          return double.parse(decimalOdds.abs().toStringAsFixed(2));
        }
      }
    }).toList();
    var multiplyValue = 1.00;
    await Future.wait(
      decimalOddsList.map((e) async => multiplyValue = multiplyValue * e),
    );
    final grossProfit = multiplyValue * betAmount;
    final parlayProfit = grossProfit - betAmount;

    return parlayProfit.toInt().abs();
  }

  String whichBetSystemToSave({@required Bet betType}) {
    if (betType == Bet.ml) {
      return 'moneyline';
    } else if (betType == Bet.pts) {
      return 'pointspread';
    } else if (betType == Bet.tot) {
      return 'total';
    } else if (betType == Bet.parlay) {
      return 'parlay';
    } else {
      return 'error';
    }
  }
}
