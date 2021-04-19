import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:vegas_lit/authentication/authentication.dart';
import 'package:vegas_lit/bet_slip/models/bet_slip_card.dart';
import 'package:vegas_lit/config/enum.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/config/strings.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/home/cubit/home_cubit.dart';
import 'package:vegas_lit/interstitial/interstitial_page.dart';
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

  // TextEditingController _betAmountController;
  // final _focusNode = FocusNode();

  // @override
  // void initState() {
  //   super.initState();
  //   _betAmountController = TextEditingController(
  //     text: '${widget.betSlipCardData.betAmount}',
  //   );
  //   _focusNode.addListener(
  //     () {
  //       if (_focusNode.hasFocus) {
  //         _betAmountController.selection = TextSelection(
  //           baseOffset: 0,
  //           extentOffset: _betAmountController.text.length,
  //         );
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final betButtonState = context.watch<BetButtonCubit>().state;
    final betPlacedCount = context.select(
      (BetSlipCubit betSlipCubit) => betSlipCubit.state.betPlacedCount,
    );
    final currentUserId = context.select(
      (AuthenticationBloc authenticationBloc) =>
          authenticationBloc.state.user?.uid,
    );
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
            Text(
              '${betButtonState.homeTeamData.name.toUpperCase()} TO WIN',
              maxLines: 1,
              style: GoogleFonts.nunito(
                fontSize: 24,
                color: Palette.cream,
                // fontWeight: FontWeight.bold,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (_) => MultiBlocProvider(
                                            providers: [
                                              BlocProvider.value(
                                                value: context
                                                    .read<BetSlipCubit>(),
                                              ),
                                              BlocProvider.value(
                                                value: context
                                                    .read<BetButtonCubit>(),
                                              ),
                                            ],
                                            child: SingleChildScrollView(
                                              child: BetAmountPage(
                                                betAmount: widget
                                                    .betSlipCardData.betAmount,
                                                betSlipCardData:
                                                    widget.betSlipCardData,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
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
                        whichBetSystem(betType: betButtonState.betType),
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
                        action: () async {
                          if (widget.betSlipCardData.betAmount != null &&
                              widget.betSlipCardData.betAmount != 0) {
                            await context.read<OpenBetsCubit>().updateOpenBets(
                                  openBetsData: OpenBetsData(
                                    gameId: betButtonState.gameId,
                                    isClosed: betButtonState.isClosed,
                                    league: betButtonState.league,
                                    amount: widget.betSlipCardData.betAmount,
                                    away: betButtonState.awayTeamData.name
                                        .toUpperCase(),
                                    home: betButtonState.homeTeamData.name
                                        .toUpperCase(),
                                    id: betButtonState.uniqueId,
                                    type: whichBetSystem(
                                        betType: betButtonState.betType),
                                    mlAmount:
                                        int.parse(betButtonState.mainOdds),
                                    win: widget.betSlipCardData.toWinAmount,
                                    dateTime:
                                        DateFormat('EEEE, MMMM, c, y @ hh:mm a')
                                            .format(
                                      betButtonState.game.dateTime.toLocal(),
                                    ),
                                  ).toMap(),
                                  currentUserId: currentUserId,
                                );
                            context.read<HomeCubit>().balanceChange(
                                  balanceAmount:
                                      widget.betSlipCardData.betAmount,
                                );

                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  duration: Duration(milliseconds: 1000),
                                  content: Text('Your bet has been placed!'),
                                ),
                              );

                            context.read<BetButtonCubit>().confirmBetButton();
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
                          height: 90,
                          width: 170,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
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
                  betButtonState.game.dateTime.toLocal(),
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

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}

class New extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                Expanded(
                  child: TextFormField(
                    // controller: _betAmountController,
                    // focusNode: _focusNode,
                    onChanged: (text) {},
                    style: GoogleFonts.nunito(
                      color: Palette.darkGrey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    maxLength: 3,
                    decoration: InputDecoration(
                      errorStyle: GoogleFonts.nunito(
                        fontSize: 12.0,
                        height: 1.2,
                      ),
                      errorMaxLines: 1,
                      contentPadding: const EdgeInsets.only(bottom: 8),
                      border: InputBorder.none,
                      counterText: '',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return Strings.minimumWager;
                      }
                      // if (!isNumeric(value)) {
                      //   return Strings.minimumWager;
                      // }
                      if (int.parse(value) > 100) {
                        return Strings.maximumWager;
                      }
                      if (int.parse(value) == 0) {
                        return Strings.minimumWager;
                      }
                      if (int.parse(value).isNegative) {
                        return Strings.minimumWager;
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
              style: GoogleFonts.nunito(
                fontSize: 18,
                color: Palette.cream,
              ),
            ),
          ),
        )
      ],
    );
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
  @override
  Widget build(BuildContext context) {
    final betButtonState = context.watch<BetButtonCubit>().state;

    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Palette.lightGrey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Bet Amount',
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              fontSize: 26.0,
              color: Palette.cream,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              Text(
                'Select your Bet Amount',
                style: GoogleFonts.nunito(
                  color: Palette.cream,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  NumberPicker(
                    value: newBetAmount ?? widget.betAmount,
                    minValue: 0,
                    maxValue: 100,
                    onChanged: (num number) {
                      setState(() {
                        newBetAmount = number;
                      });
                      if (double.parse(betButtonState.mainOdds).isNegative) {
                        final toWinAmount =
                            (100 / int.parse(betButtonState.mainOdds) * number)
                                .round()
                                .abs();

                        context.read<BetSlipCubit>().updateBetAmount(
                              toWinAmount: toWinAmount,
                              betAmount: number,
                              uniqueId: widget.betSlipCardData.id,
                            );
                      } else {
                        final toWinAmount =
                            (int.parse(betButtonState.mainOdds) / 100 * number)
                                .round()
                                .abs();

                        context.read<BetSlipCubit>().updateBetAmount(
                              toWinAmount: toWinAmount,
                              betAmount: number,
                              uniqueId: widget.betSlipCardData.id,
                            );
                      }
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Years',
                    style: GoogleFonts.nunito(
                      color: Palette.cream,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          FlatButton(
            child: Text(
              'Done',
              style: GoogleFonts.nunito(
                color: Palette.cream,
              ),
            ),
            color: Palette.green,
            onPressed: () async {
              // await context.read<LoginCubit>().resetPassword(email: email);
              // FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
