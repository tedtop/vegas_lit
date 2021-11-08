import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../../../../config/enum.dart';
import '../../../../../../../config/extensions.dart';
import '../../../../../../../data/models/bet.dart';
import '../../../../../../../data/models/nfl/nfl_bet.dart';
import '../../../../../../../data/models/nfl/nfl_game.dart';
import '../../../../../../../data/repositories/bet_repository.dart';
import '../../../../../../bet_slip/bet_slip.dart';
import '../../../models/nfl_team.dart';
import '../screens/parlay_bet_slip_card.dart';
import '../screens/single_bet_slip_card.dart';

part 'bet_button_state.dart';

class NflBetButtonCubit extends Cubit<NflBetButtonState> {
  NflBetButtonCubit({required BetRepository betsRepository})
      : _betsRepository = betsRepository,
        super(
          const NflBetButtonState(),
        );

  final BetRepository _betsRepository;

  void openBetButton({
    required String text,
    required NflGame game,
    required Bet betType,
    required String? uid,
    required String mainOdds,
    required BetButtonWin winTeam,
    required double spread,
    required NflTeam awayTeamData,
    required String league,
    required NflTeam homeTeamData,
  }) {
    final winTeamString = winTeam == BetButtonWin.away ? 'away' : 'home';
    final gameStartTimeFormat =
        DateFormat('yyyy-MM-dd-hh-mm').format(game.dateTime!);
    final betTypeString = betType == Bet.ml
        ? 'ml'
        : betType == Bet.pts
            ? 'pts'
            : 'tot';
    final uniqueId =
        '${league.toUpperCase()}-${game.awayTeam!.toUpperCase()}-${game.homeTeam!.toUpperCase()}-${betTypeString.toUpperCase()}-${winTeamString.toUpperCase()}-${game.globalGameId}-${gameStartTimeFormat.toUpperCase()}-$uid';

    final toWinAmount =
        toWinAmountCalculation(odds: mainOdds, betAmount: state.betAmount);

    emit(
      NflBetButtonState(
        text: text,
        status: NflBetButtonStatus.unclicked,
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

  Future<void> clickBetButton({
    required BetSlipCubit betSlipCubit,
    required NflBetButtonCubit nflBetButtonCubit,
    required String? username,
  }) async {
    final appVersion = await _getAppVersion();
    final betSlipListExists = betSlipCubit.state.betDataList!
        .where((element) => element.id == state.uniqueId);
    if (betSlipListExists.isEmpty) {
      betSlipCubit.addBetSlip(
        betData: NflBetData(
          stillOpen: false,
          username: username,
          homeTeamCity: state.homeTeamData!.city,
          awayTeamCity: state.awayTeamData!.city,
          betAmount: state.betAmount,
          gameId: state.game!.globalGameId,
          isClosed: state.game!.closed,
          homeTeam: state.game!.homeTeam,
          awayTeam: state.game!.awayTeam,
          winningTeam: null,
          winningTeamName: null,
          status: state.game!.status.toString(),
          league: state.league,
          betOverUnder: state.game!.overUnder,
          betPointSpread: state.game!.pointSpread,
          awayTeamName: state.awayTeamData!.name,
          homeTeamName: state.homeTeamData!.name,
          totalGameScore: null,
          id: state.uniqueId,
          betType: whichBetSystemToSave(betType: state.betType),
          odds: int.parse(state.mainOdds!),
          betProfit: state.toWinAmount,
          gameStartDateTime: state.game!.dateTime.toString(),
          awayTeamScore: state.game!.awayScore as int?,
          homeTeamScore: state.game!.homeScore as int?,
          uid: state.uid,
          betTeam: state.winTeam == BetButtonWin.home ? 'home' : 'away',
          dateTime: ESTDateTime.fetchTimeEST().toString(),
          week: ESTDateTime.fetchTimeEST().weekStringVL,
          clientVersion: appVersion,
          dataProvider: 'sportsdata.io',
        ),
        singleBetSlipCard: BlocProvider.value(
          key: Key(state.uniqueId!),
          value: nflBetButtonCubit,
          child: NflSingleBetSlipCard(),
        ),
        parlayBetSlipCard: BlocProvider.value(
          key: Key(state.uniqueId!),
          value: nflBetButtonCubit,
          child: NflParlayBetSlipCard(),
        ),
      );
      emit(
        state.copyWith(status: NflBetButtonStatus.clicked),
      );
    }
  }

  void unclickBetButton() {
    emit(
      state.copyWith(status: NflBetButtonStatus.unclicked),
    );
  }

  Future<void> placeBet({
    required bool? isMinimumVersion,
    required NflBetButtonState betButtonState,
    required BuildContext buildContext,
    required int? balanceAmount,
    required String? username,
    required String? currentUserId,
  }) async {
    final context = buildContext;
    emit(state.copyWith(status: NflBetButtonStatus.placing));
    final isBetExists = await _betsRepository.isBetExist(
      betId: state.uniqueId,
      uid: state.uid,
    );
    if (isBetExists) {
      emit(state.copyWith(status: NflBetButtonStatus.clicked));
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              "You've already placed a bet on this game.",
            ),
          ),
        );
    } else {
      if (!isMinimumVersion!) {
        emit(state.copyWith(status: NflBetButtonStatus.clicked));
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
      } else {
        if (betButtonState.game!.dateTime!
            .isBefore(ESTDateTime.fetchTimeEST())) {
          emit(state.copyWith(status: NflBetButtonStatus.clicked));
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
          if (betButtonState.betAmount == null ||
              betButtonState.betAmount == 0 ||
              betButtonState.toWinAmount == 0) {
            emit(state.copyWith(status: NflBetButtonStatus.clicked));
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  duration: Duration(milliseconds: 2000),
                  content: Text(
                    'Invalid Bet Amount!',
                  ),
                ),
              );
          } else {
            if (balanceAmount! - betButtonState.betAmount < 0) {
              emit(state.copyWith(status: NflBetButtonStatus.clicked));
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
              await updateOpenBets(
                betAmount: betButtonState.betAmount,
                betsData: NflBetData(
                  stillOpen: false,
                  username: username,
                  homeTeamCity: betButtonState.homeTeamData!.city,
                  awayTeamCity: betButtonState.awayTeamData!.city,
                  betAmount: betButtonState.betAmount,
                  gameId: betButtonState.game!.globalGameId,
                  isClosed: betButtonState.game!.closed,
                  homeTeam: betButtonState.game!.homeTeam,
                  awayTeam: betButtonState.game!.awayTeam,
                  winningTeam: null,
                  winningTeamName: null,
                  status: betButtonState.game!.status,
                  league: betButtonState.league,
                  betOverUnder: betButtonState.game!.overUnder,
                  betPointSpread: betButtonState.game!.pointSpread,
                  awayTeamName: betButtonState.awayTeamData!.name,
                  homeTeamName: betButtonState.homeTeamData!.name,
                  totalGameScore: null,
                  id: betButtonState.uniqueId,
                  betType:
                      whichBetSystemToSave(betType: betButtonState.betType),
                  odds: int.parse(betButtonState.mainOdds!),
                  betProfit: betButtonState.toWinAmount,
                  gameStartDateTime: betButtonState.game!.dateTime.toString(),
                  awayTeamScore: betButtonState.game!.awayScore as int?,
                  homeTeamScore: betButtonState.game!.homeScore as int?,
                  uid: currentUserId,
                  betTeam: betButtonState.winTeam == BetButtonWin.home
                      ? 'home'
                      : 'away',
                  dateTime: ESTDateTime.fetchTimeEST().toString(),
                  week: ESTDateTime.fetchTimeEST().weekStringVL,
                  clientVersion: await _getAppVersion(),
                  dataProvider: 'sportsdata.io',
                ),
                currentUserId: currentUserId,
              );
              emit(state.copyWith(status: NflBetButtonStatus.placed));
            }
          }
        }
      }
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

  int toWinAmountCalculation({required String odds, required int betAmount}) {
    if (int.parse(odds).isNegative) {
      final toWinAmount = (100 / int.parse(odds) * betAmount).round().abs();
      return toWinAmount;
    } else {
      final toWinAmount = (int.parse(odds) / 100 * betAmount).round().abs();
      return toWinAmount;
    }
  }

  Future<String> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  String whichBetSystemToSave({required Bet? betType}) {
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
}
