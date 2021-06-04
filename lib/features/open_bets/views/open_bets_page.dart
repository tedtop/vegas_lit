import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../home/widgets/bottombar.dart';

import 'adaptive_views/desktop_open_bets.dart';
import 'adaptive_views/mobile_open_bets.dart';
import 'adaptive_views/tablet_open_bets.dart';

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
          kIsWeb ? const BottomBar() : const SizedBox(),
        ],
      ),
    );
  }
}
