import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';

class Rules extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => Rules(),
      settings: const RouteSettings(name: 'Rules'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'drawerHeader',
          child: Image.asset(
            Images.topLogo,
            fit: BoxFit.fitWidth,
            height: 50,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                'The Vegas Lit Games Free2Play Sportsbook allows you to place bets on real sports with virtual currency and track your  progress over time. You\'ll be gifted \$1000 in virtual currency each week. Bet on sports over the week using the app. ',
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
              RulesList(),
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
                          recognizer: TapGestureRecognizer()
                            ..onTap = _launchRules)
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  final _rulesUrl = 'https://vegaslit.web.app/rules.html';
  void _launchRules() async => await canLaunch(_rulesUrl)
      ? await launch(_rulesUrl)
      : throw 'Could not launch $_rulesUrl';
}

class RulesList extends StatelessWidget {
  final List<String> texts = [
    'Players get \$1000 every Thursday at 3AM PST when the weekly game starts. Each weekly game ends the following Wednesday night at midnight PST.',
    'Once you register, you\'ll get \$1000 in virtual currency to play with each week. You can easily see how you did on each bet and also track how much you\'re making over time.',
    'Players can only participate in the contest with a single Vegas Lit account. ',
    'Every week (3AM PST Thursday) player accounts are reset at \$1000 and the game restarts.',
    'Players can choose from a daily list of active games in the sportsbook.',
    'Players can make moneyline, points spread, and total (under/over) bets on any active games during the contest week.',
    'The max a player can bet on a single game is \$100 and the min is \$10. ',
    'Each player in the contest must make a minimum of 3 bets during the weekly contest to qualify for the winning prize.',
    'The max number of picks each day of the contest is 25.',
    'The winner is the player with the highest profit after the weekly contest ends at Wednesday midnight PST. In the case of a tie, the player who placed a higher number of correct bets is the winner.'
  ];

  @override
  Widget build(BuildContext context) {
    final widgetList = <Widget>[];
    var counter = 0;
    for (final text in texts) {
      counter++;
      widgetList
        ..add(OrderedListItem(counter, text))
        ..add(const SizedBox(height: 5.0));
    }

    return Column(children: widgetList);
  }
}

class OrderedListItem extends StatelessWidget {
  OrderedListItem(this.counter, this.text);
  final int counter;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$counter. ',
          style: const TextStyle(color: Palette.cream),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Palette.cream),
          ),
        ),
      ],
    );
  }
}