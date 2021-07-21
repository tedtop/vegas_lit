import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/config/extensions.dart';
import 'package:vegas_lit/data/helpers/bets_data_helper.dart';
import 'package:vegas_lit/data/helpers/timer_helper.dart';

import '../../../../../../../config/enum.dart';
import '../../../../../../../config/palette.dart';
import '../../../../../../../config/styles.dart';
import '../../../../../../authentication/authentication.dart';
import '../../../../../../bet_slip/cubit/bet_slip_cubit.dart';
import '../../../../../../bet_slip/models/bet_slip_card.dart';
import '../../../../../../home/cubit/version_cubit.dart';
import '../../../../../../home/home.dart';
import '../../../../../../shared_widgets/abstract_card.dart';
import '../../../../../../shared_widgets/default_button.dart';
import '../cubit/bet_button_cubit.dart';

// ignore: must_be_immutable
class NflBetSlipCard extends StatefulWidget {
  const NflBetSlipCard._({Key key, @required this.betSlipCardData})
      : super(key: key);

  static Builder route({
    @required BetSlipCardData betSlipCardData,
  }) {
    return Builder(
      builder: (context) {
        return NflBetSlipCard._(
          betSlipCardData: betSlipCardData,
        );
      },
    );
  }

  final BetSlipCardData betSlipCardData;

  @override
  _BetSlipCardState createState() => _BetSlipCardState();
}

class _BetSlipCardState extends State<NflBetSlipCard> {
  final _formKey = GlobalKey<FormState>();

  bool isBetPlaced = true;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isMinimumVersion = context
            .select((VersionCubit cubit) => cubit.state.isMinimumVersion);
        final betButtonState = context.watch<NflBetButtonCubit>().state;

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
        return AbstractCard(
          padding: const EdgeInsets.fromLTRB(12.5, 12, 12.5, 0),
          crossAxisAlignment: CrossAxisAlignment.start,
          widgets: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                betButtonState.winTeam == BetButtonWin.home
                    ? isMoneyline
                        ? Text(
                            '${betButtonState.homeTeamData.name.toUpperCase()} TO WIN',
                            maxLines: 1,
                            style: GoogleFonts.nunito(
                              fontSize: 24,
                              color: Palette.cream,
                              // fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container()
                    : isMoneyline
                        ? Text(
                            '${betButtonState.awayTeamData.name.toUpperCase()} TO WIN',
                            maxLines: 1,
                            style: GoogleFonts.nunito(
                              fontSize: 24,
                              color: Palette.cream,
                              // fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container(),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              betButtonState.awayTeamData.city,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                fontSize: 12,
                                color: Palette.cream,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              betButtonState.awayTeamData.name.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: Styles.awayTeam,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 11,
                        ),
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(
                                        value:
                                            context.read<NflBetButtonCubit>(),
                                      ),
                                    ],
                                    child: BetAmountPage(
                                      betAmount: betButtonState.betAmount,
                                      betSlipCardData: widget.betSlipCardData,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Palette.cream,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                height: 90,
                                width: 170,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                        child: SizedBox(),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(
                                            // ignore: lines_longer_than_80_chars
                                            '${betButtonState.betAmount}',
                                            style: GoogleFonts.nunito(
                                              color: Palette.green,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Palette.darkGrey,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  topRight: Radius.circular(6),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Palette.darkGrey,
                                    blurRadius: 10.0,
                                    offset: Offset(0.0, 0.75),
                                  ),
                                ],
                              ),
                              height: 40,
                              width: 174,
                              child: Center(
                                child: Text(
                                  'BET AMOUNT',
                                  style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    color: Palette.cream,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 11.0),
                          child: Text(
                            (BetsDataHelper.whichBetSystemFromEnum(
                                betButtonState.betType)),
                            maxLines: 1,
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              color: Palette.cream,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          width: 174,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Visibility(
                            visible: betButtonState.status ==
                                    NflBetButtonStatus.placing
                                ? false
                                : true,
                            replacement: Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 6.5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircularProgressIndicator(
                                    color: Palette.cream,
                                  ),
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 9),
                              child: DefaultButton(
                                text: 'PLACE BET',
                                action: () async {
                                  await context
                                      .read<NflBetButtonCubit>()
                                      .placeBet(
                                        isMinimumVersion: isMinimumVersion,
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 190),
                    child: Text(
                      '@',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Palette.cream,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              betButtonState.homeTeamData.city,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Palette.green,
                              ),
                            ),
                            Text(
                              betButtonState.homeTeamData.name.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Palette.green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Palette.cream,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              height: 90,
                              width: 170,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      child: SizedBox(),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          '${betButtonState.toWinAmount}',
                                          style: GoogleFonts.nunito(
                                            color: Palette.green,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Palette.darkGrey,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  topRight: Radius.circular(6),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Palette.darkGrey,
                                    blurRadius: 10.0,
                                    offset: Offset(0.0, 0.75),
                                  ),
                                ],
                              ),
                              height: 40,
                              width: 174,
                              child: Center(
                                child: Text(
                                  'TO WIN',
                                  style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    color: Palette.cream,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            betButtonState.text,
                            maxLines: 1,
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              color: Palette.cream,
                            ),
                          ),
                        ),
                        Container(
                          width: 174,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DefaultButton(
                            color: Palette.red,
                            elevation: 0,
                            text: 'CANCEL',
                            action: () {
                              context
                                  .read<NflBetButtonCubit>()
                                  .unclickBetButton();
                              context.read<BetSlipCubit>().removeBetSlip(
                                    uniqueId: betButtonState.uniqueId,
                                  );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Center(
                child: Text(
                    DateFormat('E, MMMM, c, y @ hh:mm a').format(
                      betButtonState.game.dateTime.toLocal(),
                    ),
                    style: GoogleFonts.nunito(
                      color: Palette.cream,
                      fontSize: 14,
                    )),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: CountdownTimer(
                  endTime: ESTDateTime.getESTmillisecondsSinceEpoch(
                      betButtonState.game.dateTime),
                  widgetBuilder: (_, CurrentRemainingTime time) {
                    if (time == null) {
                      return Text(
                        betButtonState.game.status,
                        style: GoogleFonts.nunito(
                          color: Palette.red,
                          fontSize: 15,
                        ),
                      );
                    }

                    return Text(
                      'Starting in  ${TimerHelper.getRemainingTimeText(time: time)}',
                      style: GoogleFonts.nunito(
                        fontSize: 15,
                        color: Palette.red,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
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
    @required this.betSlipCardData,
    @required this.betAmount,
  }) : super(key: key);

  final BetSlipCardData betSlipCardData;
  final int betAmount;

  @override
  _BetAmountPageState createState() => _BetAmountPageState();
}

class _BetAmountPageState extends State<BetAmountPage> {
  int newBetAmount;
  final carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final betButtonState = context.watch<NflBetButtonCubit>().state;
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

                            context.read<NflBetButtonCubit>().updateBetAmount(
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

                            context.read<NflBetButtonCubit>().updateBetAmount(
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
