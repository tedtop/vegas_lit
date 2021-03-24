import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/enum.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/feature/open_bets/cubit/open_bets_cubit.dart';
import 'package:vegas_lit/feature/sportsbook/subfeature/bet_button/cubit/bet_button_cubit.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/widgets/default_button.dart';
import 'package:vegas_lit/widgets/abstract_card.dart';

import '../../../bet_slip.dart';
import '../cubit/bet_slip_card_cubit.dart';
import 'slip_card_intertitial.dart';

class BetSlipCard extends StatefulWidget {
  BetSlipCard._({Key key}) : super(key: key);

  static Builder route({
    @required Key key,
    @required BetButtonCubit betButtonCubit,
    @required Bet betType,
  }) {
    return Builder(
      key: key,
      builder: (context) {
        return BlocProvider<BetSlipCardCubit>(
          create: (_) => BetSlipCardCubit()
            ..openBetSlipCard(
              betType: betType,
            ),
          child: BlocProvider.value(
            value: betButtonCubit,
            child: BetSlipCard._(),
          ),
        );
      },
    );
  }

  @override
  _BetSlipCardState createState() => _BetSlipCardState();
}

class _BetSlipCardState extends State<BetSlipCard> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BetSlipCardCubit, BetSlipCardState>(
      listener: (context, state) {
        if (state.status == BetSlipCardStatus.confirmed) {
          Navigator.of(context).push<void>(
            Interstitial.route(),
          );
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case BetSlipCardStatus.opened:
            return BetSlipCardView();
            break;
          case BetSlipCardStatus.confirmed:
            return BetSlipCardView();
            break;
          default:
            return const CircularProgressIndicator();
            break;
        }
      },
    );
  }
}

// ignore: must_be_immutable
class BetSlipCardView extends StatefulWidget {
  @override
  _BetSlipCardViewState createState() => _BetSlipCardViewState();
}

class _BetSlipCardViewState extends State<BetSlipCardView> {
  final _formKey = GlobalKey<FormState>();

  final _betAmountController = TextEditingController(text: '0');
  final _focusNode = FocusNode();

  double toWinAmount = 0;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(
      () {
        if (_focusNode.hasFocus) {
          _betAmountController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: _betAmountController.text.length,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final betButtonState = context.watch<BetButtonCubit>().state;
    final betSlipCardState = context.watch<BetSlipCardCubit>().state;
    return AbstractCard(
      padding: const EdgeInsets.fromLTRB(12.5, 12, 12.5, 0),
      crossAxisAlignment: CrossAxisAlignment.start,
      widgets: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '${betButtonState.game.teams.home.mascot.toUpperCase()} TO WIN',
              maxLines: 1,
              style: GoogleFonts.nunito(
                fontSize: 16,
                color: Palette.cream,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              whichBetSystem(betType: betButtonState.betType),
              maxLines: 1,
              style: GoogleFonts.nunito(
                fontSize: 16,
                color: Palette.cream,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              betButtonState.text,
              maxLines: 1,
              style: GoogleFonts.nunito(
                fontSize: 16,
                color: Palette.cream,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Form(
          key: _formKey,
          child: Row(
            children: [
              Flexible(
                child: Column(
                  children: [
                    Text(betButtonState.game.teams.away.mascot.toUpperCase(),
                        // maxLines: 1,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Palette.cream,
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Palette.cream,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          height: 80,
                          width: 170,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: _betAmountController,
                                    focusNode: _focusNode,
                                    onChanged: (text) {
                                      setState(
                                        () {
                                          if (double.parse(
                                                  betButtonState.mainOdds)
                                              .isNegative) {
                                            toWinAmount = (100 /
                                                    double.parse(betButtonState
                                                        .mainOdds) *
                                                    double.parse(text))
                                                .toDouble()
                                                .abs();
                                          } else {
                                            toWinAmount = (double.parse(
                                                        betButtonState
                                                            .mainOdds) /
                                                    100 *
                                                    double.parse(text))
                                                .toDouble()
                                                .abs();
                                          }
                                        },
                                      );
                                    },
                                    style: GoogleFonts.nunito(
                                      color: Palette.darkGrey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    maxLength: 3,
                                    decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 8),
                                      border: InputBorder.none,
                                      counterText: '',
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Empty Box';
                                      }
                                      if (int.parse(value) >= 101) {
                                        return '100\$ Limit Reached';
                                      }
                                      if (int.parse(value) == 0) {
                                        return 'Write Some Amount';
                                      }
                                      if (int.parse(value).isNegative) {
                                        return 'Put Positive Amount';
                                      }
                                      return null;
                                    },
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
                            child: Text('BET AMOUNT',
                                style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  color: Palette.cream,
                                )),
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: 174,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: betSlipCardState.status ==
                              BetSlipCardStatus.confirmed
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'BET PLACED',
                                ),
                              ),
                            )
                          : DefaultButton(
                              text: 'PLACE BET',
                              action: () {
                                if (_formKey.currentState.validate()) {
                                  context.read<OpenBetsCubit>().updateOpenBets(
                                        openBetsData: OpenBetsData(
                                          amount: int.parse(
                                              _betAmountController.text),
                                          away: betButtonState
                                              .game.teams.away.mascot
                                              .toUpperCase(),
                                          home: betButtonState
                                              .game.teams.home.mascot
                                              .toUpperCase(),
                                          id: betButtonState.uniqueId,
                                          type: whichBetSystem(
                                              betType: betButtonState.betType),
                                          mlAmount: int.parse(
                                              betButtonState.mainOdds),
                                          win: double.parse(
                                              toWinAmount.toStringAsFixed(2)),
                                        ),
                                      );
                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Your bet has been placed!'),
                                      ),
                                    );
                                  context
                                      .read<BetButtonCubit>()
                                      .confirmBetButton();
                                  context.read<BetSlipCubit>().removeBetSlip(
                                        uniqueId: betButtonState.uniqueId,
                                      );
                                }
                              },
                            ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   width: 18,
              // ),
              Padding(
                padding: const EdgeInsets.only(bottom: 160),
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
                    Text(
                      betButtonState.game.teams.home.mascot.toUpperCase(),
                      // maxLines: 1,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Palette.green,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Palette.cream,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          height: 80,
                          width: 170,
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                Center(
                                  child: Text(
                                      '\$${toWinAmount.toStringAsFixed(2)}',
                                      style: GoogleFonts.nunito(
                                        color: Palette.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      )),
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
                            child: Text('TO WIN',
                                style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  color: Palette.cream,
                                )),
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: 174,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:
                          betSlipCardState.status == BetSlipCardStatus.confirmed
                              ? Container()
                              : DefaultButton(
                                  color: Palette.red,
                                  elevation: 0,
                                  text: 'CANCEL',
                                  action: () {
                                    context
                                        .read<BetButtonCubit>()
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
          padding: const EdgeInsets.only(bottom: 8),
          child: Center(
            child: Text(
                DateFormat('EEEE, MMMM, c, y @ hh:mm a').format(
                  betButtonState.game.schedule.date.toLocal(),
                ),
                style: GoogleFonts.nunito(
                  color: Palette.cream,
                  fontSize: 13,
                )),
          ),
        ),
      ],
    );
  }

  String whichBetSystem({@required Bet betType}) {
    if (betType == Bet.ml) {
      return 'MONEYLINE';
    }
    {
      if (betType == Bet.pts) {
        return 'POINTS';
      }
      if (betType == Bet.tot) {
        return 'TOTAL';
      } else {
        return 'Error';
      }
    }
  }
}
