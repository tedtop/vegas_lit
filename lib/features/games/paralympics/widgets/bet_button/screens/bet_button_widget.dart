import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vegas_lit/config/extensions.dart';
import 'package:vegas_lit/data/models/paralympics/paralympics.dart';
import 'package:vegas_lit/data/models/paralympics/paralympics_bet.dart';
import 'package:vegas_lit/features/home/home.dart';

import '../../../../../../config/palette.dart';
import '../../../../../../data/repositories/bets_repository.dart';
import '../../../../../authentication/authentication.dart';
import '../../../../../bet_slip/bet_slip.dart';
import '../cubit/paralympics_bet_button_cubit.dart';
import 'parlay_bet_slip_card.dart';
import 'single_bet_slip_card.dart';

class BetButton extends StatelessWidget {
  const BetButton._({Key? key}) : super(key: key);

  static Builder route({
    required ParalympicsGame game,
    required String league,
    required BetButtonWin winTeam,
  }) {
    return Builder(
      builder: (context) {
        final currentUserId = context.select(
          (AuthenticationBloc authenticationBloc) =>
              authenticationBloc.state.user?.uid,
        );
        return BlocProvider(
          create: (_) => ParalympicsBetButtonCubit(
            betsRepository: context.read<BetsRepository>(),
          )..openBetButton(
              uid: currentUserId,
              game: game,
              league: league,
              winTeam: winTeam,
            ),
          child: const BetButton._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ParalympicsBetButtonCubit, ParalympicsBetButtonState>(
      listener: (context, state) {
        switch (state.status) {
          case ParalympicsBetButtonStatus.alreadyPlaced:
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text(
                    "You've already placed a bet on this game.",
                  ),
                ),
              );
            break;
          case ParalympicsBetButtonStatus.placed:
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  duration: Duration(milliseconds: 2000),
                  content: Text('Your bet has been placed.'),
                ),
              );
            context.read<BetSlipCubit>().removeBetSlip(
                  betSlipDataId: state.uniqueId,
                );
            break;
          default:
        }
      },
      child: Builder(
        builder: (context) {
          final ParalympicsBetButtonState betButtonState =
              context.watch<ParalympicsBetButtonCubit>().state;
          switch (betButtonState.status) {
            case ParalympicsBetButtonStatus.unclicked:
              return BetButtonUnclicked();

            case ParalympicsBetButtonStatus.clicked:
              return BetButtonClicked();

            case ParalympicsBetButtonStatus.placed:
              return BetButtonDone();

            case ParalympicsBetButtonStatus.alreadyPlaced:
              return BetButtonDone();

            case ParalympicsBetButtonStatus.placing:
              return const CircularProgressIndicator(
                color: Palette.green,
              );

            default:
              return const CircularProgressIndicator(
                color: Palette.cream,
              );
          }
        },
      ),
    );
  }
}

class BetButtonUnclicked extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ParalympicsBetButtonState betButtonState =
        context.watch<ParalympicsBetButtonCubit>().state;
    final username = context.select(
      (HomeCubit homeBloc) => homeBloc.state.userData?.username,
    );

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: 350,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: ElevatedButton(
          style: ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Palette.darkGrey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  countryFlagFromCode(
                    countryCode: betButtonState.winTeam == BetButtonWin.player
                        ? betButtonState.game!.playerCountry!
                        : betButtonState.game!.rivalCountry!,
                  ),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    betButtonState.winTeam == BetButtonWin.player
                        ? betButtonState.game!.player!
                        : betButtonState.game!.rival!,
                    maxLines: 2,
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      color: Palette.cream,
                    ),
                  ),
                ),
              ],
            ),
          ),
          onPressed: () async {
            final isBetExist = await context
                .read<ParalympicsBetButtonCubit>()
                .clickBetButton();
            final appVersion = await _getAppVersion();
            isBetExist
                // ignore: unnecessary_statements
                ? null
                : context.read<BetSlipCubit>().addBetSlip(
                      betData: ParalympicsBetData(
                        username: username,
                        betAmount: betButtonState.betAmount,
                        isClosed: betButtonState.game!.isClosed,
                        league: betButtonState.league!.toLowerCase(),
                        id: betButtonState.uniqueId,
                        betProfit: betButtonState.toWinAmount,
                        uid: betButtonState.uid,
                        dateTime: ESTDateTime.fetchTimeEST().toString(),
                        week: ESTDateTime.fetchTimeEST().weekStringVL,
                        clientVersion: appVersion,
                        dataProvider: 'paralympics.com',
                        gameName: betButtonState.game!.gameName,
                        playerName: betButtonState.game!.player,
                        rivalCountry: betButtonState.game!.rivalCountry,
                        rivalName: betButtonState.game!.rival,
                        eventType: betButtonState.game!.eventType,
                        betTeam: betButtonState.winTeam == BetButtonWin.player
                            ? 'player'
                            : 'rival',
                        event: betButtonState.game!.event,
                        gameId: betButtonState.game!.gameId,
                        playerCountry: betButtonState.game!.playerCountry,
                        gameStartDateTime:
                            betButtonState.game!.startTime.toString(),
                        winner: null,
                      ),
                      singleBetSlipCard: BlocProvider.value(
                        key: Key(betButtonState.uniqueId!),
                        value: context.read<ParalympicsBetButtonCubit>(),
                        child: ParalympicsSingleBetSlipCard(),
                      ),
                      parlayBetSlipCard: BlocProvider.value(
                        key: Key(betButtonState.uniqueId!),
                        value: context.read<ParalympicsBetButtonCubit>(),
                        child: ParalympicsParlayBetSlipCard(),
                      ),
                    );
          },
        ),
      ),
    );
  }
}

class BetButtonClicked extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ParalympicsBetButtonState betButtonState =
        context.watch<ParalympicsBetButtonCubit>().state;
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: 350,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: ElevatedButton(
          style: ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: MaterialStateProperty.all(4),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Palette.green),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  countryFlagFromCode(
                    countryCode: betButtonState.winTeam == BetButtonWin.player
                        ? betButtonState.game!.playerCountry!
                        : betButtonState.game!.rivalCountry!,
                  ),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    betButtonState.winTeam == BetButtonWin.player
                        ? betButtonState.game!.player!
                        : betButtonState.game!.rival!,
                    maxLines: 2,
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      color: Palette.cream,
                    ),
                  ),
                ),
              ],
            ),
          ),
          onPressed: () {
            context.read<ParalympicsBetButtonCubit>().unclickBetButton();
            context.read<BetSlipCubit>().removeBetSlip(
                  betSlipDataId: betButtonState.uniqueId,
                );
          },
        ),
      ),
    );
  }
}

class BetButtonDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: 350,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: ElevatedButton(
          style: ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: MaterialStateProperty.all(4),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Palette.darkGrey),
          ),
          child: Center(
            child: Text(
              'BET PLACED',
              maxLines: 1,
              style: GoogleFonts.nunito(
                fontSize: 18,
                color: Palette.cream,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}

String countryFlagFromCode({required String countryCode}) {
  return String.fromCharCode(countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6) +
      String.fromCharCode(countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6);
}

Future<String> _getAppVersion() async {
  final packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}
