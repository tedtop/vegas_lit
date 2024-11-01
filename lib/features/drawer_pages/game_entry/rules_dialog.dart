import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vegas_lit/features/bet_slip/widgets/bet_slip_ad/cubit/ads_cubit.dart';

import '../../../config/assets.dart';
import '../../../config/palette.dart';
import '../../../config/styles.dart';
import 'cubit/game_entry_cubit.dart';

class RulesDialog extends StatelessWidget {
  const RulesDialog._({Key? key}) : super(key: key);

  static Route route(
      {required GameEntryCubit cubit, required AdsCubit cubit2}) {
    return MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (_) => BlocProvider.value(
        value: cubit2,
        child: BlocProvider.value(
          value: cubit,
          child: const RulesDialog._(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          Images.topLogo,
          fit: BoxFit.fitWidth,
          height: 50,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<GameEntryCubit, GameEntryState>(
                builder: (context, state) {
                  switch (state.status) {
                    case GameEntryStatus.initial:
                      return const SizedBox();
                    case GameEntryStatus.loading:
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Palette.green,
                        ),
                      );
                    case GameEntryStatus.success:
                      late String cool;
                      if (state.previousWeekWallet!.rank == 0) {
                        cool = 'Welcome back!\nWe missed you!';
                      } else if (state.previousWeekWallet!.rank! > 10) {
                        cool =
                            'Rank: ${state.previousWeekWallet!.rank}\nBetter Luck Next Time!';
                      } else {
                        cool =
                            'Congratulations,\nYou came in ${state.previousWeekWallet!.rank} place!';
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
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
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      Text(
                                        cool,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.nunito(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 30,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );

                    case GameEntryStatus.failure:
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
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
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Welcome back!\nWe missed you!',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.nunito(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 30,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'RULES',
                    style: Styles.pageTitle,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  'WEEKLY CONTEST RULES',
                  textAlign: TextAlign.start,
                  style: Styles.normalText.copyWith(fontSize: 28),
                ),
              ),
              const Text(
                'The Vegas Lit Games Free2Play Sportsbook allows you to place bets on real sports with virtual currency and track your  progress over time. You\'ll be gifted 1000 in virtual currency each week. Bet on sports over the week using the app. ',
                style: TextStyle(color: Palette.cream),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Earn as much as possible through your correct picks and climb the leaderboard to become the Vegas Lit Champion! The player with the highest profit each week will be declared the winner and awarded cold hard plastic! (Cash Card)',
                style: TextStyle(color: Palette.cream),
              ),
              const SizedBox(
                height: 20,
              ),
              _RulesDialogList(),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Please Note: Apple is not a participant in or sponsor of this promotion.',
                style: TextStyle(color: Palette.cream),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  text: 'For more details please read the ',
                  style: Styles.normalText,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Complete Contest Rules.',
                      style: Styles.greenText
                          .copyWith(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()..onTap = _launchRules,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: TextButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(8),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          ),
          backgroundColor: MaterialStateProperty.all(Palette.green),
        ),
        onPressed: () async {
          Navigator.of(context).pop();
          await context.read<AdsCubit>().openInterstitialAd();
        },
        child: Text('Let\'s Play!', style: Styles.normalTextBold),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  static const _rulesURL = 'https://vegaslit.web.app/rules.html';

  Future<void> _launchRules() async => await canLaunch(_rulesURL)
      ? await launch(_rulesURL)
      : throw LaunchWebsiteFailure();
}

class _RulesDialogList extends StatelessWidget {
  final List<String> rules = [
    'Players get 1000 every Thursday at 3AM PST when the weekly game starts. Each weekly game ends the following Wednesday night at midnight PST.',
    'Once you register, you\'ll get 1000 in virtual currency to play with each week. You can easily see how you did on each bet and also track how much you\'re making over time.',
    'Players can only participate in the contest with a single Vegas Lit account. ',
    'Every week (3AM PST Thursday) player accounts are reset at 1000 and the game restarts.',
    'Players can choose from a daily list of active games in the sportsbook.',
    'Players can make moneyline, points spread, and total (under/over) bets on any active games during the contest week.',
    'The max a player can bet on a single game is 100 and the min is 10. ',
    'Each player in the contest must make a minimum of 3 bets during the weekly contest to qualify for the winning prize.',
    'The max number of picks each day of the contest is 25.',
    'The winner is the player with the highest profit after the weekly contest ends at Wednesday midnight PST. In the case of a tie, the player who placed a higher number of correct bets is the winner.'
  ];

  @override
  Widget build(BuildContext context) {
    final widgetList = <Widget>[];
    var counter = 0;
    for (final rule in rules) {
      counter++;
      widgetList
        ..add(
          _OrderedListItem(index: counter, rule: rule),
        )
        ..add(
          const SizedBox(height: 5),
        );
    }
    return Column(children: widgetList);
  }
}

class _OrderedListItem extends StatelessWidget {
  const _OrderedListItem({
    Key? key,
    required this.index,
    required this.rule,
  }) : super(key: key);

  final int index;
  final String rule;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$index. ',
          style: const TextStyle(color: Palette.cream),
        ),
        Expanded(
          child: Text(
            rule,
            style: const TextStyle(color: Palette.cream),
          ),
        ),
      ],
    );
  }
}

class LaunchWebsiteFailure implements Exception {}
