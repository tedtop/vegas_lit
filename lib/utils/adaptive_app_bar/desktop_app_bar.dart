import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/assets.dart';
import '../../../../../config/palette.dart';
import '../../features/bet_slip/cubit/bet_slip_cubit.dart';
import '../../features/home/cubit/home_cubit.dart';

AppBar desktopAppBar({int? balanceAmount, int? pageIndex}) {
  return AppBar(
    iconTheme: const IconThemeData(color: Palette.cream),
    toolbarHeight: 80,
    title: Row(
      children: [
        Image.asset(
          Images.topLogo,
          fit: BoxFit.contain,
          height: 80,
        ),
        pageIndex != null
            ? Row(
                children: [
                  DesktopAppBarItem(
                    title: 'Sportsbook',
                    index: 0,
                    width: 130,
                    isSelected: pageIndex == 0,
                  ),
                  // InteractiveNavItem(
                  //   title: 'Bet Slip',
                  //   index: 1,
                  //   isSelected: pageIndex == 1,
                  // ),
                  DesktopAppBarItem(
                    title: 'Leaderboard',
                    index: 2,
                    width: 135,
                    isSelected: pageIndex == 2,
                  ),
                  DesktopAppBarItem(
                    title: 'Open Bets',
                    index: 3,
                    width: 115,
                    isSelected: pageIndex == 3,
                  ),
                  DesktopAppBarItem(
                    title: 'History',
                    index: 4,
                    width: 90,
                    isSelected: pageIndex == 4,
                  )
                ],
              )
            : const SizedBox(),
      ],
    ),
    actions: balanceAmount != null
        ? [
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 9, 10, 11),
                    child: GestureDetector(
                      onTap: () {
                        context.read<HomeCubit>().homeChange(4);
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(),
                          color: Palette.green,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Balance',
                                style: GoogleFonts.nunito(
                                  color: Palette.cream,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 1,
                              ),
                              Text(
                                '$balanceAmount',
                                style: GoogleFonts.nunito(
                                  color: Palette.cream,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ));
              },
            ),
          ]
        : [],
  );
}

class DesktopAppBarItem extends StatefulWidget {
  DesktopAppBarItem({
    Key? key,
    required this.title,
    required this.index,
    required this.isSelected,
    required this.width,
  }) : super(key: key);
  final String title;
  final int index;
  final double width;
  final bool isSelected;
  @override
  _DesktopAppBarItemState createState() => _DesktopAppBarItemState();
}

class _DesktopAppBarItemState extends State<DesktopAppBarItem> {
  var _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocProvider(
            create: (context) => BetSlipCubit(),
            child: InkWell(
              onHover: (value) {
                setState(() {
                  _isHovering = value;
                });
              },
              hoverColor: Colors.transparent,
              onTap: () => context.read<HomeCubit>().homeChange(widget.index),
              child: Text(
                widget.title,
                style: _isHovering || widget.isSelected
                    ? GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Palette.cream,
                      )
                    : GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Palette.cream),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Visibility(
            maintainAnimation: true,
            maintainState: true,
            maintainSize: true,
            visible: widget.isSelected,
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
