import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/home/cubit/home_cubit.dart';
import 'package:vegas_lit/home/widgets/bottombar.dart';
import 'package:vegas_lit/open_bets/screens/adaptive_views/desktop_open_bets.dart';
import 'package:vegas_lit/open_bets/screens/adaptive_views/mobile_open_bets.dart';
import 'package:vegas_lit/open_bets/screens/adaptive_views/tablet_open_bets.dart';
import '../cubit/open_bets_cubit.dart';

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
    return Container(
      color: Palette.darkGrey,
      child: ListView(
        shrinkWrap: true,
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
