import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/config/assets.dart';

import '../../../../../../../config/enum.dart';
import '../../../../../../../config/palette.dart';
import '../../../../../../../config/styles.dart';
import '../../../../../../authentication/authentication.dart';
import '../../../../../../bet_slip/cubit/bet_slip_cubit.dart';
import '../../../../../../home/cubit/version_cubit.dart';
import '../../../../../../home/home.dart';
import '../cubit/bet_button_cubit.dart';

class NhlSingleBetSlipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isMinimumVersion = context
            .select((VersionCubit cubit) => cubit.state.isMinimumVersion);
        final betButtonState = context.watch<NhlBetButtonCubit>().state;
        final currentUserId = context.select(
          (AuthenticationBloc authenticationBloc) =>
              authenticationBloc.state.user?.uid,
        );
        final username = context.select(
          (HomeCubit authenticationBloc) =>
              authenticationBloc.state.userData.username,
        );

        final balanceAmount = context.select(
            (HomeCubit homeCubit) => homeCubit.state.userWallet.accountBalance);
        final isMoneyline = betButtonState.betType == Bet.ml;
        final isPointSpread = betButtonState.betType == Bet.pts;

        return Container(
          width: 390,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: InkWell(
                  onTap: () {
                    context.read<NhlBetButtonCubit>().unclickBetButton();
                    context.read<BetSlipCubit>().removeBetSlip(
                          betSlipDataId: betButtonState.uniqueId,
                        );
                  },
                  child: const CircleAvatar(
                    radius: 10,
                    backgroundColor: Palette.cream,
                    child: Icon(
                      Icons.close,
                      color: Palette.darkGrey,
                      size: 16,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(8, 6, 8, 0),
                    decoration: BoxDecoration(
                      backgroundBlendMode: BlendMode.srcOver,
                      image: const DecorationImage(
                        image: AssetImage('${Images.betGameBGPath}nhl.png'),
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                      ),
                      color: Palette.lightGrey,
                      border: Border.all(
                        color: Palette.cream,
                      ),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text:
                                '${betButtonState.winTeam == BetButtonWin.home ? '${betButtonState.homeTeamData.city ?? ''} ${betButtonState.homeTeamData.name}' : '${betButtonState.awayTeamData.city ?? ''} ${betButtonState.awayTeamData.name}'}',
                            style: Styles.betSlipAwayTeam,
                            children: <TextSpan>[
                              isMoneyline
                                  ? TextSpan(
                                      text:
                                          ' (${betButtonState.text.split(' ').last})',
                                      //style: Styles.betSlipHomeTeam,
                                    )
                                  : isPointSpread
                                      ? TextSpan(
                                          text:
                                              ' (${betButtonState.text.split(' ').first})'
                                          //     PTS (${betButtonState.text.split(' ').last})',
                                          //style: Styles.betSlipHomeTeam,
                                          )
                                      : TextSpan(
                                          text:
                                              ' (${betButtonState.winTeam == BetButtonWin.away ? 'OVER' : 'UNDER'} ${betButtonState.text.split(' ').first.substring(1)})'
                                          //     TOT ${betButtonState.text.split(' ').last}',
                                          //style: Styles.betSlipHomeTeam,
                                          ),
                            ],
                          ),
                        ),
                        Text(
                          whichBetSystemFromEnum(betButtonState.betType)
                              .toUpperCase(),
                          style: Styles.betSlipHomeTeam,
                        ),
                        RichText(
                          text: TextSpan(
                            text:
                                '${betButtonState.winTeam == BetButtonWin.home ? betButtonState.homeTeamData.name.toUpperCase() : betButtonState.awayTeamData.name.toUpperCase()}',
                            style: Styles.betSlipHomeTeam,
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    ' @ ${betButtonState.winTeam == BetButtonWin.away ? betButtonState.homeTeamData.name.toUpperCase() : betButtonState.awayTeamData.name.toUpperCase()}',
                                style: Styles.betSlipAwayTeam,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(
                                        value:
                                            context.read<NhlBetButtonCubit>(),
                                      ),
                                    ],
                                    child: BetAmountPage(
                                      betAmount: betButtonState.betAmount,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Palette.cream,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                height: 35,
                                width: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Center(
                                    child: Text(
                                      'wager ${betButtonState.betAmount}',
                                      style: Styles.betSlipSmallText
                                          .copyWith(color: Palette.green),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Win ${betButtonState.toWinAmount}',
                                      style: Styles.betSlipSmallBoldText,
                                    ),
                                    Text(
                                      'Payout ${betButtonState.toWinAmount + betButtonState.betAmount}',
                                      style: Styles.betSlipSmallBoldText,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 45),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Visibility(
                                  visible: betButtonState.status ==
                                          NhlBetButtonStatus.placing
                                      ? false
                                      : true,
                                  replacement: const Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 15),
                                    child: Center(
                                      child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                          color: Palette.cream,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 9),
                                    child: DefaultButton(
                                      text: 'PLACE BET',
                                      action: () async {
                                        await context
                                            .read<NhlBetButtonCubit>()
                                            .placeBet(
                                              isMinimumVersion:
                                                  isMinimumVersion,
                                              betButtonState: betButtonState,
                                              context: context,
                                              balanceAmount: balanceAmount,
                                              username: username,
                                              currentUserId: currentUserId,
                                            );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}

// ignore: must_be_immutable
class BetAmountPage extends StatefulWidget {
  BetAmountPage({
    Key key,
    @required this.betAmount,
  }) : super(key: key);

  final int betAmount;

  @override
  _BetAmountPageState createState() => _BetAmountPageState();
}

class _BetAmountPageState extends State<BetAmountPage> {
  int newBetAmount;
  final carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final betButtonState = context.watch<NhlBetButtonCubit>().state;
    final betValues = List.generate(11, (index) => index * 10);

    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Palette.darkGrey,
            border: Border.all(color: Palette.cream),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        padding: const EdgeInsets.all(15),
        width: 390,
        height: 170,
        child: Material(
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      child: const Icon(
                        FontAwesome.angle_up,
                        size: 32,
                      ),
                      onTap: () {
                        carouselController.previousPage(
                            curve: Curves.easeIn,
                            duration: const Duration(microseconds: 100));
                      }),
                  InkWell(
                      child: const Icon(
                        FontAwesome.angle_down,
                        size: 32,
                      ),
                      onTap: () {
                        carouselController.nextPage(
                            curve: Curves.easeIn,
                            duration: const Duration(microseconds: 100));
                      }),
                ],
              ),
              Stack(
                fit: StackFit.passthrough,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 2),
                    width: 60,
                    height: 120,
                    child: CarouselSlider(
                      items: betValues
                          .map(
                            (betValue) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: 20,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Palette.green,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      '$betValue',
                                      style: Styles.normalText,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                        initialPage: newBetAmount != null
                            ? betValues.indexOf(newBetAmount)
                            : betValues.indexOf(widget.betAmount),
                        scrollDirection: Axis.vertical,
                        viewportFraction: 0.36,
                        enlargeCenterPage: true,
                        onPageChanged: (i, reason) {
                          setState(
                            () {
                              newBetAmount = betValues[i];
                            },
                          );
                          if (int.parse(betButtonState.mainOdds).isNegative) {
                            final toWinAmount = (100 /
                                    int.parse(betButtonState.mainOdds) *
                                    betValues[i])
                                .round()
                                .abs();

                            context.read<NhlBetButtonCubit>().updateBetAmount(
                                  toWinAmount: toWinAmount,
                                  betAmount: betValues[i],
                                );
                          } else {
                            final toWinAmount =
                                (int.parse(betButtonState.mainOdds) /
                                        100 *
                                        betValues[i])
                                    .round()
                                    .abs();

                            context.read<NhlBetButtonCubit>().updateBetAmount(
                                  toWinAmount: toWinAmount,
                                  betAmount: betValues[i],
                                );
                          }
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 10,
                    child: Container(
                      height: 35,
                      width: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Palette.darkGrey,
                              Palette.darkGrey.withOpacity(0.9),
                              Palette.darkGrey.withOpacity(0.7),
                              Palette.darkGrey.withOpacity(0.05)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 10,
                    child: Container(
                      height: 35,
                      width: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Palette.darkGrey,
                              Palette.darkGrey.withOpacity(0.9),
                              Palette.darkGrey.withOpacity(0.7),
                              Palette.darkGrey.withOpacity(0.05)
                            ].reversed.toList(),
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Bet Amount',
                          style: Styles.normalTextBold.copyWith(fontSize: 22),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Scroll to select your bet amount and press to confirm',
                          style: Styles.normalText,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String getRemainingTimeText({CurrentRemainingTime time}) {
  final days = time.days == null ? '' : '${time.days}d ';
  final hours = time.hours == null ? '' : '${time.hours}hr';
  final min = time.min == null ? '' : ' ${time.min}m';
  final sec = time.sec == null ? '' : ' ${time.sec}s';
  return days + hours + min + sec;
}

String whichBetSystemFromEnum(Bet betType) {
  if (betType == Bet.ml) {
    return 'MONEYLINE';
  }
  if (betType == Bet.pts) {
    return 'POINT SPREAD';
  }
  if (betType == Bet.tot) {
    return 'TOTAL O/U';
  } else {
    return 'Error';
  }
}

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    @required this.text,
    @required this.action,
    this.color = Palette.green,
    this.elevation = Styles.normalElevation,
  })  : assert(text != null),
        super(key: key);

  final String text;
  final Function action;
  final Color color;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: 110,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        child: ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  vertical: 10,
                ),
              ),
              elevation: MaterialStateProperty.all(elevation),
              shape: MaterialStateProperty.all(Styles.smallRadius),
              textStyle: MaterialStateProperty.all(
                const TextStyle(color: Palette.cream),
              ),
              backgroundColor: MaterialStateProperty.all(color),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          child: Text(
            text,
            style: Styles.betSlipButtonText,
          ),
          onPressed: action,
        ),
      ),
    );
  }
}
