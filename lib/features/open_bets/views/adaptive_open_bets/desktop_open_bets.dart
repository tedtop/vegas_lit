import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:intl/intl.dart';

import '../../../../config/extensions.dart';
import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../utils/bottom_bar.dart';
import '../../../home/home.dart';
import '../../cubit/open_bets_cubit.dart';

class DesktopOpenBets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _DesktopOpenBetsHeading(),
        const _DesktopOpenBetsDescription(),
        const _DesktopOpenBetsContent(),
        const BottomBar()
      ],
    );
  }
}

class _DesktopOpenBetsHeading extends StatelessWidget {
  const _DesktopOpenBetsHeading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AutoSizeText(
            'OPEN BETS',
            style: Styles.pageTitle,
          ),
        ),
      ],
    );
  }
}

class _DesktopOpenBetsDescription extends StatelessWidget {
  const _DesktopOpenBetsDescription({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 4,
      ),
      child: RichText(
        text: TextSpan(
          style: Styles.openBetsNormalText,
          children: <TextSpan>[
            const TextSpan(
              text:
                  // ignore: lines_longer_than_80_chars
                  'Bets shown here cannot be modified and are awaiting the outcome of the event. Once bets have been closed they will appear in your',
            ),
            TextSpan(
                text: ' BET HISTORY ',
                style: Styles.openBetsTextButton,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.read<HomeCubit>().homeChange(4);
                  }),
            const TextSpan(
              text: 'page.',
            ),
          ],
        ),
      ),
    );
  }
}

class _DesktopOpenBetsContent extends StatelessWidget {
  const _DesktopOpenBetsContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.select((OpenBetsCubit cubit) => cubit.state.status);
    final bets = context.select((OpenBetsCubit cubit) => cubit.state.bets);
    switch (status) {
      case OpenBetsStatus.success:
        if (bets.isEmpty) {
          return const _DesktopOpenBetsTableEmpty();
        } else {
          return const _DesktopOpenBetsTable();
        }
        break;
      case OpenBetsStatus.initial:
        return const SizedBox();
        break;
      case OpenBetsStatus.loading:
        return const CircularProgressIndicator(
          color: Palette.cream,
        );
        break;
      case OpenBetsStatus.failure:
        return const Center(
          child: AutoSizeText("Couldn't load bet history data"),
        );
        break;
      default:
        return const SizedBox();
        break;
    }
  }
}

class _DesktopOpenBetsTableEmpty extends StatelessWidget {
  const _DesktopOpenBetsTableEmpty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Palette.cream),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1220),
              child: Column(
                children: [
                  const _OpenBetsTableHeading(),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 1220),
                    height: 8,
                    color: Palette.green,
                  ),
                  const Center(
                    child: AutoSizeText('No Open Bets Found'),
                  ),
                  Container(
                    height: 8,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      color: Palette.lightGrey,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DesktopOpenBetsTable extends StatelessWidget {
  const _DesktopOpenBetsTable({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bets = context.select((OpenBetsCubit cubit) => cubit.state.bets);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Palette.cream),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1220),
              child: Column(
                children: [
                  const _OpenBetsTableHeading(),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 1220),
                    height: 8,
                    color: Palette.green,
                  ),
                  Column(
                    children: bets
                        .map((entry) => _DesktopOpenBetsTableRow(
                              openBets: entry,
                            ))
                        .toList(),
                  ),
                  Container(
                    height: 8,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      color: Palette.lightGrey,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OpenBetsTableHeading extends StatelessWidget {
  const _OpenBetsTableHeading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 5,
      ),
      color: Palette.lightGrey,
      child: Row(
        children: tableHeadingsWithWidth.keys
            .map(
              (entry) => SizedBox(
                child: AutoSizeText(entry, style: Styles.openBetsDesktopField),
                width: tableHeadingsWithWidth[entry].toDouble(),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _DesktopOpenBetsTableRow extends StatelessWidget {
  const _DesktopOpenBetsTableRow({Key key, @required this.openBets})
      : assert(openBets != null),
        super(key: key);

  final dynamic openBets;

  @override
  Widget build(BuildContext context) {
    final odd = openBets.odds.isNegative
        ? openBets.odds.toString()
        : '+${openBets.odds}';

    var isMoneyline = true;
    var betSpread = 0.0;
    var spread = '0';

    if (openBets.betOverUnder != null || openBets.betPointSpread != null) {
      isMoneyline = openBets.betType == 'moneyline';
      betSpread = openBets.betType == 'total'
          ? openBets.betOverUnder
          : openBets.betPointSpread;
      spread = betSpread == 0
          ? ''
          : betSpread.isNegative
              ? betSpread.toString()
              : '+$betSpread';
    }

    return Container(
      constraints: const BoxConstraints(minHeight: 50),
      color: Palette.lightGrey,
      child: Row(
        children: tableHeadingsWithWidth.keys
            .map((entry) => SizedBox(
                  child: Builder(
                    builder: (context) {
                      switch (entry) {
                        case 'Game':
                          return Stack(
                            fit: StackFit.passthrough,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(8),
                                            topLeft: Radius.circular(8)),
                                        color: Palette.darkGrey,
                                      ),
                                      width:
                                          (tableHeadingsWithWidth[entry] / 2) -
                                              15,
                                      child: Center(
                                        child: AutoSizeText(
                                          '${openBets.awayTeamName.toUpperCase()}',
                                          style: Styles.openBetsDesktopItem,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(8),
                                            topRight: Radius.circular(8)),
                                        color: Palette.darkGrey,
                                      ),
                                      width:
                                          (tableHeadingsWithWidth[entry] / 2) -
                                              15,
                                      child: Center(
                                        child: AutoSizeText(
                                          '${openBets.homeTeamName.toUpperCase()}',
                                          style: Styles.openBetsDesktopItem
                                              .copyWith(color: Palette.green),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 23, vertical: 18),
                                child: Center(child: AutoSizeText('@')),
                              )
                            ],
                          );
                        // case 'Bet Type':
                        //   return Padding(
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 23, vertical: 18),
                        //     child:AutoSizeText(openBets.betType,
                        //         style: GoogleFonts.nunito(
                        //           fontSize: 18,
                        //           fontWeight: FontWeight.w300,
                        //           color: Palette.cream,
                        //         )),
                        //   );
                        case 'Bet':
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 18),
                            child: AutoSizeText(
                                '${whichBetSystemFromString(openBets.betType)}  ${isMoneyline ? '' : spread}  $odd',
                                style: Styles.openBetsDesktopItem),
                          );
                        case 'Risking':
                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 18),
                              child: AutoSizeText('${openBets.betAmount}',
                                  style: Styles.openBetsDesktopItem));
                        case 'To Win':
                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 18),
                              child: AutoSizeText('${openBets.betProfit}',
                                  style: Styles.openBetsDesktopItem));
                        case 'Time Remaining':
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 18),
                            child: CountdownTimer(
                              endTime: ESTDateTime.getESTmillisecondsSinceEpoch(
                                DateTime.parse(openBets.gameStartDateTime),
                              ),
                              widgetBuilder: (_, CurrentRemainingTime time) {
                                if (time == null) {
                                  final startTime = DateTime.parse(
                                      openBets.gameStartDateTime);
                                  return Center(
                                    child: AutoSizeText(
                                      'Started at ${DateFormat('hh:mm a').format(
                                        startTime,
                                      )} EST',
                                      style: Styles.openBetsDesktopTime,
                                    ),
                                  );
                                }

                                return Center(
                                  child: AutoSizeText(
                                    'Starting in  ${getRemainingTimeText(time: time)}',
                                    style: Styles.openBetsDesktopTime,
                                  ),
                                );
                              },
                            ),
                          );
                        default:
                          return const SizedBox();
                      }
                    },
                  ),
                  width: tableHeadingsWithWidth[entry].toDouble(),
                ))
            .toList(),
      ),
    );
  }
}

const tableHeadingsWithWidth = {
  '': 20,
  'Game': 300,
  'Bet': 300,
  'Risking': 150,
  'To Win': 160,
  'Time Remaining': 280
};

String getRemainingTimeText({CurrentRemainingTime time}) {
  final days = time.days == null ? '' : '${time.days}d ';
  final hours = time.hours == null ? '' : '${time.hours}hr';
  final min = time.min == null ? '' : ' ${time.min}m';
  final sec = time.sec == null ? '' : ' ${time.sec}s';
  return days + hours + min + sec;
}

String whichBetSystemFromString(String betType) {
  if (betType == 'moneyline') {
    return 'MONEYLINE';
  }
  if (betType == 'pointspread') {
    return 'POINT SPREAD';
  }
  if (betType == 'total') {
    return 'TOTAL O/U';
  }
  if (betType == 'olympics') {
    return 'OLYMPICS';
  } else {
    return 'ERROR';
  }
}
