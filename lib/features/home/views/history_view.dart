import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/features/authentication/authentication.dart';
import 'package:vegas_lit/features/bet_history/view/bet_history_view.dart';
import 'package:vegas_lit/features/open_bets/views/open_bets_page.dart';

class BetHistory extends StatelessWidget {
  const BetHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid =
        context.select((AuthenticationCubit cubit) => cubit.state.user?.uid);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Palette.green,
            tabs: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'OPEN BETS',
                      style: Styles.pageTitle.copyWith(fontSize: 20),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'BET HISTORY',
                      style: Styles.pageTitle.copyWith(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OpenBets.route(uid: uid),
            History.route(uid: uid),
          ],
        ),
      ),
    );
  }
}
