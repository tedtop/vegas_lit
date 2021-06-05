import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../config/styles.dart';
import '../../home/widgets/bottombar.dart';
import 'adaptive_bet_history/desktop_bet_history.dart';
import 'adaptive_bet_history/mobile_bet_history.dart';
import 'adaptive_bet_history/tablet_bet_history.dart';

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
          ScreenTypeLayout(
            breakpoints: Styles.screenBreakpoints,
            mobile: MobileBetHistory(),
            tablet: TabletBetHistory(),
            desktop: DesktopBetHistory(),
          ),
          kIsWeb ? const BottomBar() : const SizedBox(),
        ],
      ),
    );
  }
}
