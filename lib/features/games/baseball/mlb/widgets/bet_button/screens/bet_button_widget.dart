import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/features/authentication/authentication.dart';

import '../../../../../../../config/enum.dart';
import '../../../../../../../config/palette.dart';
import '../../../../../../../data/models/mlb/mlb_game.dart';
import '../../../../../../../data/repositories/bet_repository.dart';
import '../../../../../../bet_slip/cubit/bet_slip_cubit.dart';
import '../../../../../../bet_slip/widgets/parlay_bet_button/cubit/parlay_bet_button_cubit.dart';
import '../../../../../../home/home.dart';
import '../../../models/mlb_team.dart';
import '../cubit/bet_button_cubit.dart';

class BetButton extends StatelessWidget {
  const BetButton._({Key? key}) : super(key: key);

  static Builder route({
    required String text,
    required MlbGame game,
    required Bet betType,
    required String mainOdds,
    required MlbTeam awayTeamData,
    required String league,
    required MlbTeam homeTeamData,
    required double spread,
    required BetButtonWin winTeam,
  }) {
    return Builder(
      builder: (context) {
        final currentUserId = context.select(
          (AuthenticationCubit authenticationBloc) =>
              authenticationBloc.state.user?.uid,
        );
        return BlocProvider(
          create: (_) => MlbBetButtonCubit(
            betsRepository: context.read<BetRepository>(),
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
    final betId =
        context.select((MlbBetButtonCubit cubit) => cubit.state.uniqueId);
    return BlocListener<ParlayBetButtonCubit, ParlayBetButtonState>(
      listener: (context, state) {
        if (state.status == ParlayBetButtonStatus.placed) {
          final betList =
              state.betList.where((element) => element.id == betId).toList();
          if (betList.isNotEmpty) {
            context.read<MlbBetButtonCubit>().unclickBetButton();
          }
        }
      },
      child: BlocListener<MlbBetButtonCubit, MlbBetButtonState>(
        listener: (context, state) {
          switch (state.status) {
            case MlbBetButtonStatus.placed:
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
            final betButtonState = context.watch<MlbBetButtonCubit>().state;
            switch (betButtonState.status) {
              case MlbBetButtonStatus.unclicked:
                return BetButtonUnclicked();

              case MlbBetButtonStatus.clicked:
                return BetButtonClicked();

              case MlbBetButtonStatus.placed:
                return BetButtonUnclicked();

              case MlbBetButtonStatus.placing:
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
      ),
    );
  }
}

class BetButtonUnclicked extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final betButtonState = context.watch<MlbBetButtonCubit>().state;

    final username = context.select(
      (HomeCubit homeBloc) => homeBloc.state.userData?.username,
    );

    return Padding(
      padding: const EdgeInsets.all(3),
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
            await context.read<MlbBetButtonCubit>().clickBetButton(
                  username: username,
                  betSlipCubit: context.read<BetSlipCubit>(),
                  mlbBetButtonCubit: context.read<MlbBetButtonCubit>(),
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
    final betButtonState = context.watch<MlbBetButtonCubit>().state;
    return Padding(
      padding: const EdgeInsets.all(3),
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
            context.read<MlbBetButtonCubit>().unclickBetButton();
            context.read<BetSlipCubit>().removeBetSlip(
                  betSlipDataId: betButtonState.uniqueId,
                );
          },
        ),
      ),
    );
  }
}

String whichBetSystemToSave({required Bet betType}) {
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
