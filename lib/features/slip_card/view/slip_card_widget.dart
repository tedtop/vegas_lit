import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/enum.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/features/widgets/generic_card.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/features/slip/bet_slip.dart';
import 'package:vegas_lit/features/bet_button/cubit/bet_button_cubit.dart';
import 'package:vegas_lit/features/widgets/default_button.dart';

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

  final _betAmountController = TextEditingController(text: '10');
  final _focusNode = FocusNode();

  int toWinAmount = 100;

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
    return GenericCard(
      padding: const EdgeInsets.fromLTRB(12.5, 12, 12.5, 0),
      crossAxisAlignment: CrossAxisAlignment.start,
      widgets: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AutoSizeText(
              '${betButtonState.game.teams.home.mascot.toUpperCase()} TO WIN',
              maxLines: 1,
              style: GoogleFonts.nunito(
                fontSize: 16,
                color: Palette.cream,
                fontWeight: FontWeight.w400,
              ),
            ),
            AutoSizeText(
              whichBetSystem(betType: betButtonState.betType),
              maxLines: 1,
              style: GoogleFonts.nunito(
                fontSize: 16,
                color: Palette.cream,
                fontWeight: FontWeight.w400,
              ),
            ),
            AutoSizeText(
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
                    Text(
                      betButtonState.game.teams.away.mascot.toUpperCase(),
                      // maxLines: 1,
                      textAlign: TextAlign.center,
                      style: Styles.defaultSizeBoldCream,
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
                                          toWinAmount = (100 /
                                                  int.parse(
                                                      betButtonState.mainOdds) *
                                                  int.parse(text))
                                              .toInt();
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
                            child: Text(
                              'BET AMOUNT',
                              style: Styles.defaultCream,
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
                                  context
                                      .read<BetButtonCubit>()
                                      .confirmBetButton();
                                  context
                                      .read<BetSlipCardCubit>()
                                      .betSlipCardConfirm(
                                        betAmount: _betAmountController.text,
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
                  style: Styles.defaultSizeBoldCream,
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
                                  child: Text('\$${toWinAmount.toString()}',
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
                            child: Text(
                              'TO WIN',
                              style: Styles.defaultCream,
                            ),
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
