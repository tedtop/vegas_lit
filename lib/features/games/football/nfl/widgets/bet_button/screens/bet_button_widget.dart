import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vegas_lit/config/extensions.dart';
import 'package:vegas_lit/data/models/nfl/nfl_bet.dart';
import 'package:vegas_lit/features/home/home.dart';

import '../../../../../../../config/enum.dart';
import '../../../../../../../config/palette.dart';
import '../../../../../../../data/models/nfl/nfl_game.dart';
import '../../../../../../../data/repositories/bets_repository.dart';
import '../../../../../../authentication/bloc/authentication_bloc.dart';
import '../../../../../../bet_slip/cubit/bet_slip_cubit.dart';
import '../../../models/nfl_team.dart';
import '../cubit/bet_button_cubit.dart';
import 'parlay_bet_slip_card.dart';
import 'single_bet_slip_card.dart';

class BetButton extends StatelessWidget {
  const BetButton._({Key key}) : super(key: key);

  static Builder route({
    @required String text,
    @required NflGame game,
    @required Bet betType,
    @required String mainOdds,
    @required NflTeam awayTeamData,
    @required String league,
    @required NflTeam homeTeamData,
    @required int gameId,
    @required double spread,
    @required BetButtonWin winTeam,
    @required bool isClosed,
  }) {
    return Builder(
      builder: (context) {
        final currentUserId = context.select(
          (AuthenticationBloc authenticationBloc) =>
              authenticationBloc.state?.user?.uid,
        );
        return BlocProvider(
          create: (_) => NflBetButtonCubit(
            betsRepository: context.read<BetsRepository>(),
          )..openBetButton(
              uid: currentUserId,
              text: text,
              spread: spread,
              winTeam: winTeam,
              game: game,
              mainOdds: mainOdds,
              betType: betType,
              homeTeamData: homeTeamData,
              awayTeamData: awayTeamData,
              league: league,
            ),
          child: const BetButton._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NflBetButtonCubit, NflBetButtonState>(
      listener: (context, state) {
        switch (state.status) {
          case NflBetButtonStatus.alreadyPlaced:
            return ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text(
                    "You've already placed a bet on this game.",
                  ),
                ),
              );
            break;
          case NflBetButtonStatus.placed:
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
            break;
        }
      },
      child: Builder(
        builder: (context) {
          final betButtonState = context.watch<NflBetButtonCubit>().state;
          switch (betButtonState.status) {
            case NflBetButtonStatus.unclicked:
              return BetButtonUnclicked();
              break;
            case NflBetButtonStatus.clicked:
              return BetButtonClicked();
              break;
            case NflBetButtonStatus.placed:
              return BetButtonDone();
              break;
            case NflBetButtonStatus.alreadyPlaced:
              return BetButtonDone();
              break;
            case NflBetButtonStatus.placing:
              return const CircularProgressIndicator(
                color: Palette.green,
              );
              break;
            default:
              return const CircularProgressIndicator(
                color: Palette.cream,
              );
              break;
          }
        },
      ),
    );
  }
}

class BetButtonUnclicked extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final betButtonState = context.watch<NflBetButtonCubit>().state;
    final username = context.select(
      (HomeCubit homeBloc) => homeBloc.state?.userData?.username,
    );

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: 150,
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
          child: Text(
            betButtonState.text ?? '100',
            maxLines: 1,
            style: GoogleFonts.nunito(
              fontSize: 14,
              color: Palette.cream,
            ),
          ),
          onPressed: () async {
            final isBetExist =
                await context.read<NflBetButtonCubit>().clickBetButton();
            final appVersion = await _getAppVersion();
            isBetExist
                // ignore: unnecessary_statements
                ? null
                : context.read<BetSlipCubit>().addBetSlip(
                      betData: NflBetData(
                        stillOpen: false,
                        username: username,
                        homeTeamCity: betButtonState.homeTeamData.city,
                        awayTeamCity: betButtonState.awayTeamData.city,
                        betAmount: betButtonState.betAmount,
                        gameId: betButtonState.game.globalGameId,
                        isClosed: betButtonState.game.closed,
                        homeTeam: betButtonState.game.homeTeam,
                        awayTeam: betButtonState.game.awayTeam,
                        winningTeam: null,
                        winningTeamName: null,
                        status: betButtonState.game.status.toString(),
                        league: betButtonState.league,
                        betOverUnder: betButtonState.game.overUnder,
                        betPointSpread: betButtonState.game.pointSpread,
                        awayTeamName: betButtonState.awayTeamData.name,
                        homeTeamName: betButtonState.homeTeamData.name,
                        totalGameScore: null,
                        id: betButtonState.uniqueId,
                        betType: whichBetSystemToSave(
                            betType: betButtonState.betType),
                        odds: int.parse(betButtonState.mainOdds),
                        betProfit: betButtonState.toWinAmount,
                        gameStartDateTime:
                            betButtonState.game.dateTime.toString(),
                        awayTeamScore: betButtonState.game.awayScore,
                        homeTeamScore: betButtonState.game.homeScore,
                        uid: betButtonState.uid,
                        betTeam: betButtonState.winTeam == BetButtonWin.home
                            ? 'home'
                            : 'away',
                        dateTime: ESTDateTime.fetchTimeEST().toString(),
                        week: ESTDateTime.fetchTimeEST().weekStringVL,
                        clientVersion: appVersion,
                        dataProvider: 'sportsdata.io',
                      ),
                      singleBetSlipCard: BlocProvider.value(
                        key: Key(betButtonState.uniqueId),
                        value: context.read<NflBetButtonCubit>(),
                        child: NflSingleBetSlipCard(),
                      ),
                      parlayBetSlipCard: BlocProvider.value(
                        key: Key(betButtonState.uniqueId),
                        value: context.read<NflBetButtonCubit>(),
                        child: NflParlayBetSlipCard(),
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
    final betButtonState = context.watch<NflBetButtonCubit>().state;
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: 150,
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
          child: Text(
            betButtonState.text ?? '100',
            maxLines: 1,
            style: GoogleFonts.nunito(
              fontSize: 14,
              color: Palette.cream,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            context.read<NflBetButtonCubit>().unclickBetButton();
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
        width: 150,
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
          child: Text(
            'BET PLACED',
            maxLines: 1,
            style: GoogleFonts.nunito(
              fontSize: 14,
              color: Palette.cream,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}

Future<String> _getAppVersion() async {
  final packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
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
