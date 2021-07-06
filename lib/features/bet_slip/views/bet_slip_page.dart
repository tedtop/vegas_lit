import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'adaptive_bet_slip_page/desktop_bet_slip_page.dart';
import 'adaptive_bet_slip_page/mobile_bet_slip_page.dart';
import 'adaptive_bet_slip_page/tablet_bet_slip_page.dart';

class BetSlip extends StatefulWidget {
  @override
  _BetSlipState createState() => _BetSlipState();
}

class _BetSlipState extends State<BetSlip> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ScreenTypeLayout(
      mobile: const MobileBetSlipPage(),
      desktop: const DesktopBetSlipPage(),
      tablet: const TabletBetSlipPage(),
    );
  }
}
