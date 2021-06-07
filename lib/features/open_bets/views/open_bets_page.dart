import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'adaptive_open_bets/desktop_open_bets.dart';
import 'adaptive_open_bets/mobile_open_bets.dart';
import 'adaptive_open_bets/tablet_open_bets.dart';

class OpenBets extends StatelessWidget {
  const OpenBets._({Key key}) : super(key: key);

  static Builder route({@required String uid}) {
    return Builder(
      builder: (context) {
        return const OpenBets._();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ScreenTypeLayout(
            mobile: MobileOpenBets(),
            tablet: TabletOpenBets(),
            desktop: DesktopOpenBets(),
          ),
        ],
      ),
    );
  }
}
