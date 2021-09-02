import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../config/enum.dart';
import '../../../../../../../config/palette.dart';
import '../../../../../../../data/models/ncaaf/ncaaf_game.dart';
import '../../../../../../../data/repositories/bets_repository.dart';
import '../../../../../../authentication/bloc/authentication_bloc.dart';
import '../../../../../../bet_slip/cubit/bet_slip_cubit.dart';
import '../../../../../../bet_slip/models/bet_slip_card.dart';
import '../../../models/ncaaf_team.dart';
import '../cubit/bet_button_cubit.dart';
import 'bet_slip_card.dart';

class BetButton extends StatelessWidget {
  const BetButton._({Key key}) : super(key: key);

  static Builder route({
    @required String text,
    @required NcaafGame game,
    @required Bet betType,
    @required String mainOdds,
    @required NcaafTeam awayTeamData,
    @required String league,
    @required NcaafTeam homeTeamData,
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
          create: (_) => NcaafBetButtonCubit(
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
    return BlocListener<NcaafBetButtonCubit, NcaafBetButtonState>(
      listener: (context, state) {
        switch (state.status) {
          case NcaafBetButtonStatus.alreadyPlaced:
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
          case NcaafBetButtonStatus.placed:
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  duration: Duration(milliseconds: 2000),
                  content: Text('Your bet has been placed.'),
                ),
              );
            context.read<BetSlipCubit>().removeBetSlip(
                  singleBetSlipId: state.uniqueId,
                  parlayBetSlipId: state.uniqueId,
                );
            break;
          default:
            break;
        }
      },
      child: Builder(
        builder: (context) {
          final betButtonState = context.watch<NcaafBetButtonCubit>().state;
          switch (betButtonState.status) {
            case NcaafBetButtonStatus.unclicked:
              return BetButtonUnclicked();
              break;
            case NcaafBetButtonStatus.clicked:
              return BetButtonClicked();
              break;

            case NcaafBetButtonStatus.placed:
              return BetButtonDone();
              break;
            case NcaafBetButtonStatus.alreadyPlaced:
              return BetButtonDone();
              break;
            case NcaafBetButtonStatus.placing:
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
    final betButtonState = context.watch<NcaafBetButtonCubit>().state;
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
                await context.read<NcaafBetButtonCubit>().clickBetButton();
            isBetExist
                // ignore: unnecessary_statements
                ? null
                : context.read<BetSlipCubit>().addBetSlip(
                      singleBetSlipCard: BlocProvider.value(
                        key: Key(betButtonState.uniqueId),
                        value: context.read<NcaafBetButtonCubit>(),
                        child: NcaafBetSlipCard.route(
                          betSlipCardData: BetSlipCardData(
                            odds: betButtonState.mainOdds,
                            league: betButtonState.league,
                            id: betButtonState.uniqueId,
                            betType: betButtonState.betType,
                            betButtonCubit: context.read<NcaafBetButtonCubit>(),
                          ),
                        ),
                      ),
                      parlayBetSlipCard: BlocProvider.value(
                        key: Key(betButtonState.uniqueId),
                        value: context.read<NcaafBetButtonCubit>(),
                        child: NcaafBetSlipCard.route(
                          betSlipCardData: BetSlipCardData(
                            odds: betButtonState.mainOdds,
                            league: betButtonState.league,
                            id: betButtonState.uniqueId,
                            betType: betButtonState.betType,
                            betButtonCubit: context.read<NcaafBetButtonCubit>(),
                          ),
                        ),
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
    final betButtonState = context.watch<NcaafBetButtonCubit>().state;
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
            context.read<NcaafBetButtonCubit>().unclickBetButton();
            context.read<BetSlipCubit>().removeBetSlip(
                  singleBetSlipId: betButtonState.uniqueId,
                  parlayBetSlipId: betButtonState.uniqueId,
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
