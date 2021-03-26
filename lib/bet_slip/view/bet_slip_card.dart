import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/bet_slip/models/bet_slip_card.dart';
import 'package:vegas_lit/config/enum.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/home/cubit/home_cubit.dart';
import 'package:vegas_lit/intertitial/intertitial_page.dart';
import 'package:vegas_lit/open_bets/cubit/open_bets_cubit.dart';
import 'package:vegas_lit/shared_widgets/abstract_card.dart';
import 'package:vegas_lit/shared_widgets/default_button.dart';
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

  TextEditingController _betAmountController;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _betAmountController = TextEditingController(
      text: '${widget.betSlipCardData.betAmount}',
    );
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
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
                    Text(betButtonState.game.teams.away.mascot.toUpperCase(),
                        // maxLines: 1,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Palette.cream,
                        )),
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
                                            final toWinAmount = (100 /
                                                    int.parse(betButtonState
                                                        .mainOdds) *
                                                    int.parse(text))
                                                .round()
                                                .abs();

                                            context
                                                .read<BetSlipCubit>()
                                                .updateBetAmount(
                                                  toWinAmount: toWinAmount,
                                                  betAmount: int.parse(text),
                                                  uniqueId:
                                                      widget.betSlipCardData.id,
                                                );
                                          } else {
                                            final toWinAmount = (int.parse(
                                                        betButtonState
                                                            .mainOdds) /
                                                    100 *
                                                    int.parse(text))
                                                .round()
                                                .abs();

                                            context
                                                .read<BetSlipCubit>()
                                                .updateBetAmount(
                                                  toWinAmount: toWinAmount,
                                                  betAmount: int.parse(text),
                                                  uniqueId:
                                                      widget.betSlipCardData.id,
                                                );
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
                      child:
                          //  widget.betSlipCardData.betAmount != 0
                          //     ? const Center(
                          //         child: Padding(
                          //           padding: EdgeInsets.all(8.0),
                          //           child: Text(
                          //             'BET PLACED',
                          //           ),
                          //         ),
                          //       )
                          //     :
                          DefaultButton(
                        text: 'PLACE BET',
                        action: () {
                          if (_formKey.currentState.validate()) {
                            context.read<OpenBetsCubit>().updateOpenBets(
                                  openBetsData: OpenBetsData(
                                    amount:
                                        int.parse(_betAmountController.text),
                                    away: betButtonState.game.teams.away.mascot
                                        .toUpperCase(),
                                    home: betButtonState.game.teams.home.mascot
                                        .toUpperCase(),
                                    id: betButtonState.uniqueId,
                                    type: whichBetSystem(
                                        betType: betButtonState.betType),
                                    mlAmount:
                                        int.parse(betButtonState.mainOdds),
                                    win: widget.betSlipCardData.toWinAmount,
                                  ),
                                );
                            context.read<HomeCubit>().balanceChange(
                                  balanceAmount:
                                      int.parse(_betAmountController.text),
                                );
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  content: Text('Your bet has been placed!'),
                                ),
                              );
                            Navigator.of(context).push(
                              Interstitial.route(),
                            );

                            context.read<BetButtonCubit>().confirmBetButton();
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
                                      '\$${widget.betSlipCardData.toWinAmount}',
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
                          //  widget.betSlipCardData.betAmount != 0
                          //     ? Container()
                          //     :
                          DefaultButton(
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

    if (betType == Bet.pts) {
      return 'POINT SPREAD';
    }
    if (betType == Bet.tot) {
      return 'TOTAL SPREAD';
    } else {
      return 'Error';
    }
  }
}
