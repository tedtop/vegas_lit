// ignore: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/features/authentication/authentication.dart';
import 'package:vegas_lit/features/bet_slip/bet_slip.dart';
import 'package:vegas_lit/features/games/olympics/widgets/bet_button/cubit/olympics_bet_button_cubit.dart';
import 'package:vegas_lit/features/home/cubit/version_cubit.dart';
import 'package:vegas_lit/features/home/home.dart';

class OlympicsSingleBetSlipCard extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isMinimumVersion = context
            .select((VersionCubit cubit) => cubit.state.isMinimumVersion);
        final OlympicsBetButtonState betButtonState =
            context.watch<OlympicsBetButtonCubit>().state;
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

        return AbstractCard(
          padding: const EdgeInsets.fromLTRB(12.5, 12, 12.5, 0),
          crossAxisAlignment: CrossAxisAlignment.center,
          widgets: [
            Text(
              '${betButtonState.winTeam == BetButtonWin.player ? CountryParser.parseCountryCode(betButtonState.game!.playerCountry!).name.toUpperCase() : CountryParser.parseCountryCode(betButtonState.game!.rivalCountry!).name.toUpperCase()} TO WIN',
              maxLines: 3,
              style: GoogleFonts.nunito(
                fontSize: 24,
                color: Palette.cream,
                // fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  betButtonState.game!.gameName!.replaceAll(RegExp('-'), '\/'),
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    color: Palette.cream,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Form(
              key: _formKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              countryFlagFromCode(
                                  countryCode:
                                      betButtonState.game!.playerCountry!),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                fontSize: 25,
                                color: Palette.cream,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              betButtonState.game!.player!,
                              textAlign: TextAlign.center,
                              style: Styles.awayTeam,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog<void>(
                                  context: context,
                                  builder: (_) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(
                                        value: context
                                            .read<OlympicsBetButtonCubit>(),
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
                                            bottom: 8.0,
                                          ),
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
                        Container(
                          width: 174,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Visibility(
                            visible: betButtonState.status ==
                                    OlympicsBetButtonStatus.placing
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
                              padding: const EdgeInsets.only(top: 8),
                              child: DefaultButton(
                                text: 'PLACE BET',
                                action: () async {
                                  await context
                                      .read<OlympicsBetButtonCubit>()
                                      .placeBet(
                                        isMinimumVersion: isMinimumVersion!,
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
                    padding:
                        const EdgeInsets.only(bottom: 120, left: 5, right: 5),
                    child: badgeFromEventTypeColumn(
                        eventType: betButtonState.game!.eventType),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              countryFlagFromCode(
                                  countryCode:
                                      betButtonState.game!.rivalCountry!),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                fontSize: 25,
                                color: Palette.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              betButtonState.game!.rival!,
                              textAlign: TextAlign.center,
                              style: Styles.homeTeam,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
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
                                        padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                        ),
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
                        Container(
                          width: 174,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: DefaultButton(
                              color: Palette.red,
                              elevation: 0,
                              text: 'CANCEL',
                              action: () {
                                context
                                    .read<OlympicsBetButtonCubit>()
                                    .unclickBetButton();
                                context.read<BetSlipCubit>().removeBetSlip(
                                      betSlipDataId: betButtonState.uniqueId,
                                    );
                              },
                            ),
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
                      betButtonState.game!.startTime!.toLocal(),
                    ),
                    style: GoogleFonts.nunito(
                      color: Palette.cream,
                      fontSize: 14,
                    )),
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
    Key? key,
    required this.betAmount,
  }) : super(key: key);

  final int betAmount;

  @override
  _BetAmountPageState createState() => _BetAmountPageState();
}

class _BetAmountPageState extends State<BetAmountPage> {
  int? newBetAmount;
  final carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final OlympicsBetButtonState betButtonState =
        context.watch<OlympicsBetButtonCubit>().state;
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

                          final toWinAmount =
                              (betButtonState.mainOdds / 100 * betValues[i])
                                  .round()
                                  .abs();

                          context
                              .read<OlympicsBetButtonCubit>()
                              .updateBetAmount(
                                toWinAmount: toWinAmount,
                                betAmount: betValues[i],
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

String countryFlagFromCode({required String countryCode}) {
  return String.fromCharCode(countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6) +
      String.fromCharCode(countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6);
}

Widget badgeFromEventTypeColumn({String? eventType}) {
  return Column(
    children: [
      Image.asset(
        '${Images.olympicsIconsPath}Olympics.png',
        height: 18,
      ),
      const SizedBox(
        height: 40,
      ),
      eventType == 'gold'
          ? const Text(
              '🥇',
              style: TextStyle(fontSize: 20),
            )
          : eventType == 'silver'
              ? const Text(
                  '🥈',
                  style: TextStyle(fontSize: 20),
                )
              : eventType == 'bronze'
                  ? const Text(
                      '🥉',
                      style: TextStyle(fontSize: 20),
                    )
                  : const SizedBox.shrink(),
    ],
  );
}

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.action,
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
      width: 174,
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
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => action,
        ),
      ),
    );
  }
}

class AbstractCard extends StatelessWidget {
  const AbstractCard({
    Key? key,
    required this.widgets,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 12.5,
      vertical: 12.0,
    ),
  }) : super(key: key);

  final List<Widget> widgets;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
