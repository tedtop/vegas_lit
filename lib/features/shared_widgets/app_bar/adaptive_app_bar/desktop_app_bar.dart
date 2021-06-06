import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/features/bet_slip/bet_slip.dart';
import 'package:vegas_lit/features/home/home.dart';

import '../../../../../config/assets.dart';
import '../../../../../config/palette.dart';

AppBar desktopAppBar({int balanceAmount, int pageIndex}) {
  return AppBar(
      iconTheme: const IconThemeData(color: Palette.cream),
      toolbarHeight: 80.0,
      title: Row(
        children: [
          Image.asset(
            Images.topLogo,
            fit: BoxFit.contain,
            height: 80,
          ),
          DesktopAppBarItem(
            title: 'Sportsbook',
            index: 0,
          ),
          // InteractiveNavItem(
          //   title: 'Bet Slip',
          //   index: 1,
          //   isSelected: pageIndex == 1,
          // ),
          DesktopAppBarItem(
            title: 'Leaderboard',
            index: 2,
          ),
          DesktopAppBarItem(
            title: 'Open Bets',
            index: 3,
          ),
          DesktopAppBarItem(
            title: 'History',
            index: 4,
          )
        ],
      ));
}

class DesktopAppBarItem extends StatefulWidget {
  DesktopAppBarItem({
    Key key,
    this.title,
    this.index,
  }) : super(key: key);
  final String title;
  final int index;

  @override
  _DesktopAppBarItemState createState() => _DesktopAppBarItemState();
}

class _DesktopAppBarItemState extends State<DesktopAppBarItem> {
  var _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.select(
      (HomeCubit homeCubit) => homeCubit.state.pageIndex,
    );
    final _isSelected = selectedIndex == widget.index;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocProvider(
            create: (context) => BetSlipCubit(),
            child: InkWell(
              onHover: (value) {
                _isHovering = value;
              },
              onTap: () => context.read<HomeCubit>().homeChange(widget.index),
              child: Text(
                widget.title,
                style: _isHovering || _isSelected
                    ? GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Palette.cream,
                      )
                    : GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Palette.cream),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Visibility(
            maintainAnimation: true,
            maintainState: true,
            maintainSize: true,
            visible: _isHovering || _isSelected,
            child: Container(
              height: 2,
              width: 40,
              color: Palette.cream,
            ),
          )
        ],
      ),
    );
  }
}
