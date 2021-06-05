import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/features/bet_slip/views/adaptive_bet_slip_page/desktop_bet_slip_page/desktop_bet_slip_page.dart';
import 'package:vegas_lit/features/bet_slip/views/adaptive_bet_slip_page/mobile_bet_slip_page/mobile_bet_slip_page.dart';
import 'package:vegas_lit/features/bet_slip/views/adaptive_bet_slip_page/tablet_bet_slip_page/tablet_bet_slip_page.dart';

class BetSlip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      breakpoints: Styles.screenBreakpoints,
      mobile: const MobileBetSlipPage(),
      desktop: const DesktopBetSlipPage(),
      tablet: const TabletBetSlipPage(),
    );
  }
}
