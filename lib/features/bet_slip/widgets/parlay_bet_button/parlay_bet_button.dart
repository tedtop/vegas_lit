import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

import '../../../../config/enum.dart';
import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../data/models/bet.dart';
import '../../../authentication/bloc/authentication_bloc.dart';
import '../../../home/cubit/version_cubit.dart';
import '../../../home/home.dart';
import '../../bet_slip.dart';
import 'cubit/parlay_bet_button_cubit.dart';

class ParlayBetSlipButton extends StatelessWidget {
  const ParlayBetSlipButton._({Key? key, required this.betList})
      : super(key: key);

  static Builder route({
    required List<BetData>? betDataList,
  }) {
    return Builder(
      builder: (context) {
        final uid = context.watch<HomeCubit>().state.userData!.uid;
        context.read<ParlayBetButtonCubit>().openParlay(
              betDataList: betDataList!,
              league: 'Parlay',
              uid: uid,
            );
        return ParlayBetSlipButton._(
          betList: betDataList,
        );
      },
    );
  }

  final List<BetData>? betList;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isMinimumVersion = context
            .select((VersionCubit cubit) => cubit.state.isMinimumVersion);
        final betButtonState = context.watch<ParlayBetButtonCubit>().state;
        final currentUserId = context.select(
          (AuthenticationBloc authenticationBloc) =>
              authenticationBloc.state.user?.uid,
        );
        final username = context.select(
          (HomeCubit authenticationBloc) =>
              authenticationBloc.state.userData!.username,
        );

        final balanceAmount = context.select((HomeCubit homeCubit) =>
            homeCubit.state.userWallet!.accountBalance);

        return BlocListener<BetSlipCubit, BetSlipState>(
          listener: (context, state) async {
            if (state.status == BetSlipStatus.opened) {
              await context.read<ParlayBetButtonCubit>().openParlay(
                    league: 'Parlay',
                    betDataList: state.betDataList!,
                    uid: currentUserId,
                  );
            }
          },
          child: BlocListener<ParlayBetButtonCubit, ParlayBetButtonState>(
            listener: (context, state) {
              switch (state.status) {
                case ParlayBetButtonStatus.placed:
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 2000),
                        content: Text('Your bet has been placed.'),
                      ),
                    );

                  context.read<BetSlipCubit>().openBetSlip(
                    singleBetSlipGames: [],
                    parlayBetSlipGames: [],
                    betDataList: [],
                  );
                  break;
                default:
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: 2,
                bottom: 15,
                left: 6,
                right: 6,
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                width: 380,
                decoration: BoxDecoration(
                    color: Palette.lightGrey,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    border: Border.all(color: Palette.cream)),
                //crossAxisAlignment: CrossAxisAlignment.start,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (_) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: context.read<ParlayBetButtonCubit>(),
                              ),
                            ],
                            child: BetAmountPage(
                              betAmount: betButtonState.betAmount,
                              betList: betList,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Palette.cream,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        height: 38,
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
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
                    Expanded(
                      flex: 5,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Win ${betButtonState.toWinAmount}',
                                style: Styles.betSlipSmallBoldText,
                              ),
                              Text(
                                'Payout ${betButtonState.toWinAmount + betButtonState.betAmount}',
                                style: Styles.betSlipSmallBoldText
                                    .copyWith(color: Palette.green),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 6),
                          child: Text(
                            '${betButtonState.betList.length} leg',
                            style: Styles.betSlipBoxNormalText,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Visibility(
                        visible: betButtonState.status ==
                                ParlayBetButtonStatus.placing
                            ? false
                            : true,
                        replacement: const Padding(
                          padding: EdgeInsets.only(bottom: 13),
                          child: Center(
                            child: SizedBox(
                              height: 33,
                              width: 33,
                              child: CircularProgressIndicator(
                                color: Palette.cream,
                              ),
                            ),
                          ),
                        ),
                        child: SizedBox(
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
                                  elevation: MaterialStateProperty.all(
                                      Styles.normalElevation),
                                  shape: MaterialStateProperty.all(
                                      Styles.smallRadius),
                                  textStyle: MaterialStateProperty.all(
                                    const TextStyle(color: Palette.cream),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all(Palette.green),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap),
                              child: Text(
                                'PLACE BET',
                                style: Styles.betSlipButtonText,
                              ),
                              onPressed: () async {
                                await context
                                    .read<ParlayBetButtonCubit>()
                                    .placeBet(
                                      isMinimumVersion: isMinimumVersion,
                                      context: context,
                                      balanceAmount: balanceAmount,
                                      username: username,
                                      currentUserId: currentUserId,
                                      betList: betList,
                                    );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class BetAmountPage extends StatefulWidget {
  const BetAmountPage({
    Key? key,
    required this.betAmount,
    required this.betList,
  }) : super(key: key);

  final int betAmount;
  final List<BetData>? betList;

  @override
  _BetAmountPageState createState() => _BetAmountPageState();
}

class _BetAmountPageState extends State<BetAmountPage> {
  int? newBetAmount;
  final carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final betValues = List.generate(11, (index) => index * 10);

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Palette.darkGrey,
          border: Border.all(color: Palette.cream),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
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
                            ? betValues.indexOf(newBetAmount!)
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

                          context.read<ParlayBetButtonCubit>().updateBetAmount(
                                betAmount: betValues[i],
                                betList: widget.betList!,
                              );
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
                            Palette.darkGrey.withOpacity(0.05),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
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
                            Palette.darkGrey.withOpacity(0.05),
                          ].reversed.toList(),
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
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

String getRemainingTimeText({required CurrentRemainingTime time}) {
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

class AbstractCard extends StatelessWidget {
  const AbstractCard({
    Key? key,
    required this.widgets,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 12.5,
      vertical: 12,
    ),
  }) : super(key: key);

  final List<Widget> widgets;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: 390,
        decoration: BoxDecoration(
          border: Border.all(
            color: Palette.cream,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Card(
          margin: EdgeInsets.zero,
          color: Palette.lightGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: padding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: crossAxisAlignment,
                children: widgets,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
