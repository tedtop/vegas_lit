import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/features/bet_slip/cubit/bet_slip_cubit.dart';
import '../cubit/home_cubit.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final betSlipStatus = context.watch<BetSlipCubit>().state;
        final pageIndex =
            context.select((HomeCubit homeCubit) => homeCubit.state.pageIndex);
        if (betSlipStatus.status == BetSlipStatus.opened) {
          final showBadge = betSlipStatus.betSlipCardData.isNotEmpty;
          final badgeCount = betSlipStatus.betSlipCardData.length;
          return BottomNavigationBar(
            selectedLabelStyle: GoogleFonts.nunito(),
            selectedFontSize: 14,
            unselectedFontSize: 12,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Palette.green,
            unselectedItemColor: Palette.cream,
            backgroundColor: Palette.darkGrey,
            currentIndex: pageIndex,
            onTap: (value) {
              context.read<HomeCubit>().homeChange(value);
            },
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                  icon: Icon(Feather.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Stack(
                    children: <Widget>[
                      const Icon(Feather.file_plus),
                      Positioned(
                        right: 0,
                        child: showBadge
                            ? Container(
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 14,
                                  minHeight: 14,
                                ),
                                child: Text(
                                  '$badgeCount',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Container(),
                      )
                    ],
                  ),
                  label: 'Bet Slip'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.emoji_events), label: 'Leaders'),
              const BottomNavigationBarItem(
                  icon: Icon(Feather.file_text), label: 'Open Bets'),
              const BottomNavigationBarItem(
                  icon: Icon(Feather.calendar), label: 'History'),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
