import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../config/styles.dart';
import '../../home/widgets/bottombar.dart';
import 'adaptive_widgets/mobile_bet_history.dart';
import 'adaptive_widgets/tablet_bet_history.dart';
import 'adaptive_widgets/web_bet_history.dart';

class History extends StatelessWidget {
  const History._({Key key}) : super(key: key);

  static Builder route({@required String uid}) {
    return Builder(
      builder: (context) {
        return const History._();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const _HistoryHeading(),
          ScreenTypeLayout(
            breakpoints: Styles.screenBreakpoints,
            mobile: MobileHistory(),
            tablet: TabletHistory(),
            desktop: WebHistory(),
          ),
          kIsWeb ? const BottomBar() : const SizedBox(),
        ],
      ),
    );
  }
}

class _HistoryHeading extends StatelessWidget {
  const _HistoryHeading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'BET HISTORY',
            style: Styles.pageTitle,
          ),
        ),
      ],
    );
  }
}
