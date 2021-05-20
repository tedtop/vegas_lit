import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/home/widgets/bottombar.dart';
import 'package:vegas_lit/open_bets/screens/adaptive_views/desktop_open_bets.dart';
import 'package:vegas_lit/open_bets/screens/adaptive_views/mobile_open_bets.dart';
import 'package:vegas_lit/open_bets/screens/adaptive_views/tablet_open_bets.dart';

class OpenBets extends StatelessWidget {
  const OpenBets._({Key key}) : super(key: key);

  static Builder route() {
    return Builder(
      builder: (context) {
        return const OpenBets._();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ScreenTypeLayout(
          mobile: MobileOpenBets(),
          tablet: TabletOpenBets(),
          desktop: DesktopOpenBets(),
        ),
        kIsWeb ? const BottomBar() : const SizedBox(),
      ],
    );
  }
}
