import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/features/bet_slip/widgets/parlay_bet_button/parlay_bet_button.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../utils/bottom_bar.dart';
import '../../../open_bets/cubit/open_bets_cubit.dart';
import '../../bet_slip.dart';
import '../../widgets/bet_slip_ad/bet_slip_ad.dart';
import '../../widgets/bet_slip_empty.dart';
import '../../widgets/bet_slip_list.dart';

class MobileBetSlipPage extends StatelessWidget {
  const MobileBetSlipPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Palette.green,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'SINGLE',
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'PARLAY',
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true,
          title: const MobileBetSlipUpper(),
        ),
        body: const TabBarView(
          children: [
            SingleBetSlip(),
            ParlayBetSlip(),
          ],
        ),
      ),
    );
  }
}

class SingleBetSlip extends StatelessWidget {
  const SingleBetSlip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isBetPlaced = context.watch<OpenBetsCubit>().state.bets.isNotEmpty;
    return ListView(
      padding: const EdgeInsets.only(top: 10),
      children: [
        BlocBuilder<BetSlipCubit, BetSlipState>(
          builder: (context, state) {
            switch (state.status) {
              case BetSlipStatus.opened:
                return Column(
                  children: [
                    if (state.singleBetSlipCard!.isEmpty)
                      isBetPlaced ? RewardedBetSlip.route() : EmptyBetSlip()
                    else
                      SingleBetSlipList(),
                    const BottomBar()
                  ],
                );

              default:
                return const CircularProgressIndicator(
                  color: Palette.cream,
                );
            }
          },
        ),
      ],
    );
  }
}

class ParlayBetSlip extends StatelessWidget {
  const ParlayBetSlip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isBetPlaced = context.watch<OpenBetsCubit>().state.bets.isNotEmpty;
    final parlayBetList = context.watch<BetSlipCubit>().state.betDataList;
    return ListView(
      padding: const EdgeInsets.only(top: 10),
      children: [
        BlocBuilder<BetSlipCubit, BetSlipState>(
          builder: (context, state) {
            switch (state.status) {
              case BetSlipStatus.opened:
                return Column(
                  children: [
                    state.parlayBetSlipCard!.isEmpty
                        ? isBetPlaced
                            ? RewardedBetSlip.route()
                            : EmptyBetSlip()
                        : Column(
                            children: [
                              if (state.parlayBetSlipCard!.length < 2)
                                const ParlayBetSlipWarning(isMinimum: true)
                              else
                                state.parlayBetSlipCard!.length > 6
                                    ? const ParlayBetSlipWarning(
                                        isMinimum: false)
                                    : ParlayBetSlipButton.route(
                                        betDataList: parlayBetList,
                                      ),
                              const ParlayBetSlipList(),
                            ],
                          ),
                    const BottomBar()
                  ],
                );

              default:
                return const CircularProgressIndicator(
                  color: Palette.cream,
                );
            }
          },
        ),
      ],
    );
  }
}

class MobileBetSlipUpper extends StatelessWidget {
  const MobileBetSlipUpper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      'BET SLIP',
      textAlign: TextAlign.center,
      style: Styles.pageTitle,
    );
  }
}
