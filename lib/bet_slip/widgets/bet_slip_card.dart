import 'dart:ui';

import 'package:api_client/api_client.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/authentication/authentication.dart';
import 'package:vegas_lit/bet_slip/models/bet_slip_card.dart';
import 'package:vegas_lit/config/enum.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/home/cubit/home_cubit.dart';
import 'package:vegas_lit/interstitial/interstitial_page.dart';
import 'package:vegas_lit/open_bets/cubit/open_bets_cubit.dart';
import 'package:vegas_lit/shared_widgets/abstract_card.dart';
import 'package:vegas_lit/shared_widgets/countdown_timer.dart';
import 'package:vegas_lit/shared_widgets/default_button.dart';
import 'package:vegas_lit/sportsbook/bloc/sportsbook_bloc.dart';
import 'package:vegas_lit/sportsbook/widgets/bet_button/bet_button.dart';
import '../bet_slip.dart';

// ignore: must_be_immutable
class BetSlipCard extends StatefulWidget {
  const BetSlipCard._({
    Key key,
    @required this.betSlipCardData,
  }) : super(key: key);

  static Builder route({
    @required BetSlipCardData betSlipCardData,
  }) {
    return Builder(
      builder: (context) {
        return BlocProvider.value(
          value: betSlipCardData.betButtonCubit,
          child: BetSlipCard._(
            betSlipCardData: betSlipCardData,
          ),
        );
      },
    );
  }

  final BetSlipCardData betSlipCardData;

  @override
  _BetSlipCardState createState() => _BetSlipCardState();
}

class _BetSlipCardState extends State<BetSlipCard> {
  final _formKey = GlobalKey<FormState>();

  bool isBetPlaced = true;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final estTimeZone =
            context.select((SportsbookBloc bloc) => bloc.state?.estTimeZone);
        final betButtonState = context.watch<BetButtonCubit>().state;
        final betPlacedCount = context.select(
          (BetSlipCubit betSlipCubit) => betSlipCubit.state.betPlacedCount,
        );
        final currentUserId = context.select(
          (AuthenticationBloc authenticationBloc) =>
              authenticationBloc.state.user?.uid,
        );
        final balanceAmount = context.select(
            (HomeCubit homeCubit) => homeCubit.state.userPurse.accountBalance);
        final isMoneyline = betButtonState.betType == Bet.ml;
        return AbstractCard(
          padding: const EdgeInsets.fromLTRB(12.5, 12, 12.5, 0),
          crossAxisAlignment: CrossAxisAlignment.start,
          widgets: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [],
            // ),
            // const SizedBox(
            //   height: 2,
            // ),
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
                          height: 8,
                        ),
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (_) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(
                                        value: context.read<BetSlipCubit>(),
                                      ),
                                      BlocProvider.value(
                                        value: context.read<BetButtonCubit>(),
                                      ),
                                    ],
                                    child: SingleChildScrollView(
                                      child: BetAmountPage(
                                        betAmount:
                                            widget.betSlipCardData.betAmount,
                                        betSlipCardData: widget.betSlipCardData,
                                      ),
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
                                            '\$${widget.betSlipCardData.betAmount}',
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
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            (whichBetSystem(betType: betButtonState.betType)),
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
                            visible: isBetPlaced,
                            replacement: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircularProgressIndicator(),
                                ],
                              ),
                            ),
                            child: DefaultButton(
                              text: 'PLACE BET',
                              action: () async {
                                if (widget.betSlipCardData.betAmount != null &&
                                    widget.betSlipCardData.betAmount != 0 &&
                                    widget.betSlipCardData.toWinAmount != 0) {
                                  if (balanceAmount -
                                          widget.betSlipCardData.betAmount <
                                      0) {
                                    ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(
                                        const SnackBar(
                                          duration:
                                              Duration(milliseconds: 1000),
                                          content: Text(
                                              // ignore: lines_longer_than_80_chars
                                              "You're out of funds!"),
                                        ),
                                      );
                                  } else {
                                    setState(() {
                                      isBetPlaced = false;
                                    });
                                    await context
                                        .read<OpenBetsCubit>()
                                        .updateOpenBets(
                                          betAmount:
                                              widget.betSlipCardData.betAmount,
                                          openBetsData: BetData(
                                            betAmount: widget
                                                .betSlipCardData.betAmount,
                                            gameId: betButtonState.gameId,
                                            isClosed: betButtonState.isClosed,
                                            winTeam: null,
                                            league: betButtonState.league,
                                            betOverUnder:
                                                betButtonState.game.overUnder,
                                            betPointSpread:
                                                betButtonState.game.pointSpread,
                                            awayTeam: betButtonState
                                                .awayTeamData.name
                                                .toUpperCase(),
                                            homeTeam: betButtonState
                                                .homeTeamData.name
                                                .toUpperCase(),
                                            totalGameScore: null,
                                            id: betButtonState.uniqueId,
                                            betType: whichBetSystemToSave(
                                                betType:
                                                    betButtonState.betType),
                                            odds: int.parse(
                                                betButtonState.mainOdds),
                                            betProfit: widget
                                                .betSlipCardData.toWinAmount,
                                            gameDateTime: DateFormat(
                                                    'E, MMMM, c, y @ hh:mm a')
                                                .format(
                                              betButtonState.game.dateTime
                                                  .toLocal(),
                                            ),
                                            awayTeamScore: betButtonState
                                                .game.awayTeamScore,
                                            homeTeamScore: betButtonState
                                                .game.homeTeamScore,
                                            betTeam: betButtonState.winTeam ==
                                                    BetButtonWin.home
                                                ? 'home'
                                                : 'away',
                                            dateTime: DateTime.now().toString(),
                                          ).toMap(),
                                          currentUserId: currentUserId,
                                        );

                                    ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(
                                        const SnackBar(
                                          duration:
                                              Duration(milliseconds: 1000),
                                          content:
                                              Text('Your bet has been placed!'),
                                        ),
                                      );

                                    context
                                        .read<BetButtonCubit>()
                                        .confirmBetButton();
                                    context.read<BetSlipCubit>().betPlaced(
                                          uniqueId: betButtonState.uniqueId,
                                          betPlacedCount: betPlacedCount + 1,
                                        );
                                    if (betPlacedCount % 4 == 0 &&
                                        betPlacedCount != 0) {
                                      await Navigator.of(context).push(
                                        Interstitial.route(),
                                      );
                                    }
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   width: 18,
                  // ),
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
                                          '\$${widget.betSlipCardData.toWinAmount}',
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
                              context.read<BetButtonCubit>().unclickBetButton();
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
                      fontSize: 13,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: CountdownTimer(
                estTimeZone: estTimeZone,
                endDateTime: betButtonState.game.dateTime,
              ),
            ),
          ],
        );
      },
    );
  }

  String whichBetSystem({@required Bet betType}) {
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

  String whichBetSystemToSave({@required Bet betType}) {
    if (betType == Bet.ml) {
      return 'moneyline';
    }
    if (betType == Bet.pts) {
      return 'pointSpread';
    }
    if (betType == Bet.tot) {
      return 'total';
    } else {
      return 'error';
    }
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
    final betButtonState = context.watch<BetButtonCubit>().state;
    final betValues = List.generate(11, (index) => index * 10);

    return Container(
      padding: const EdgeInsets.all(15),
      height: 170,
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  icon: const Icon(
                    FontAwesome.angle_up,
                    size: 32,
                  ),
                  onPressed: () {
                    carouselController.previousPage(
                        curve: Curves.easeIn,
                        duration: const Duration(microseconds: 100));
                  }),
              IconButton(
                  icon: const Icon(
                    FontAwesome.angle_down,
                    size: 32,
                  ),
                  onPressed: () {
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
                                  '\$$betValue',
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

                        context.read<BetSlipCubit>().updateBetAmount(
                              toWinAmount: toWinAmount,
                              betAmount: betValues[i],
                              uniqueId: widget.betSlipCardData.id,
                            );
                      } else {
                        final toWinAmount =
                            (int.parse(betButtonState.mainOdds) /
                                    100 *
                                    betValues[i])
                                .round()
                                .abs();

                        context.read<BetSlipCubit>().updateBetAmount(
                              toWinAmount: toWinAmount,
                              betAmount: betValues[i],
                              uniqueId: widget.betSlipCardData.id,
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
                    gradient: LinearGradient(colors: [
                      Palette.darkGrey,
                      Palette.darkGrey.withOpacity(0.9),
                      Palette.darkGrey.withOpacity(0.7),
                      Palette.darkGrey.withOpacity(0.05)
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
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
          )
        ],
      ),
    );
  }
}
