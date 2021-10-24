import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../data/models/wallet.dart';
import '../../../home/home.dart';
import '../../../leaderboard_profile/leaderboard_profile.dart';
import '../../cubit/leaderboard_cubit.dart';

class DesktopLeaderboard extends StatefulWidget {
  const DesktopLeaderboard({this.players});
  final List<Wallet>? players;
  @override
  _DesktopLeaderboardState createState() => _DesktopLeaderboardState();
}

class _DesktopLeaderboardState extends State<DesktopLeaderboard> {
  @override
  Widget build(BuildContext context) {
    final leaderboardState = context.watch<LeaderboardCubit>().state;
    final textList = leaderboardState.days;
    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Current Leaderboard',
                    style: Styles.normalTextBold,
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                  ),
                  height: 40,
                  width: 220,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Container(
                      color: Palette.green,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      width: double.infinity,
                      child: Center(
                        child: DropdownButton<String>(
                          dropdownColor: Palette.green,
                          isDense: true,
                          value: leaderboardState.day,
                          icon: const Icon(
                            FontAwesome.angle_down,
                            color: Palette.cream,
                          ),
                          isExpanded: true,
                          underline: Container(
                            height: 0,
                          ),
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                          ),
                          onChanged: (String? value) {
                            context
                                .read<LeaderboardCubit>()
                                .changeWeek(week: value!);
                          },
                          items: textList!.isNotEmpty == true
                              ? textList.map<DropdownMenuItem<String>>(
                                  (String weekValue) {
                                    String weekFormat;
                                    if (weekValue != 'Current Week') {
                                      final formatValue = weekValue.split('-');

                                      weekFormat =
                                          'Week ${formatValue[1]}, ${formatValue[0]}';

                                      // final dateTime = DateTime(
                                      //   int.parse(formatValue[0]),
                                      //   int.parse(formatValue[1]),
                                      //   int.parse(formatValue[2]),
                                      // );
                                      // dateFormat = DateFormat('MMMM c, y').format(dateTime);
                                    } else {
                                      weekFormat = weekValue;
                                    }
                                    return DropdownMenuItem<String>(
                                      value: weekValue,
                                      child: Text(
                                        weekFormat,
                                        textAlign: TextAlign.left,
                                        style: Styles.leaderboardDropdown,
                                      ),
                                    );
                                  },
                                ).toList()
                              : const [],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20.0),
          decoration: BoxDecoration(
              border: Border.all(
                color: Palette.cream,
              ),
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 1220),
                height: 80,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  color: Palette.darkGrey,
                ),
                child: Center(
                  child: Text(
                    'CONTEST WINNINGS',
                    style: Styles.largeTextBold,
                  ),
                ),
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 1220),
                height: 8,
                color: Palette.green,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1220),
                  child: Column(
                    children: [
                      LeaderboardColumns(),
                      Column(
                        children: widget.players!
                            .asMap()
                            .entries
                            .map(
                              (entry) => WebLeaderboardItem(
                                player: entry.value,
                                rank: entry.key + 1,
                              ),
                            )
                            .toList(),
                      ),
                      Container(
                        height: 8,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Palette.lightGrey,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Container(
        //   constraints: const BoxConstraints(maxWidth: 1200),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.all(20.0),
        //         child: PageNumberView(pages: 15),
        //       ),
        //     ],
        //   ),
        // )
      ],
    );
  }
}

class LeaderboardColumns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Palette.lightGrey,
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 60,
            child: Text(
              'Rank',
              style: Styles.leaderboardDesktopField,
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              'Player',
              style: Styles.leaderboardDesktopField,
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              'Profit',
              style: Styles.leaderboardDesktopField,
            ),
          ),
          SizedBox(
            width: 150,
            child: Text(
              'Account Balance',
              style: Styles.leaderboardDesktopField,
            ),
          ),
          SizedBox(
            width: 95,
            child: Text(
              '# of Bets',
              style: Styles.leaderboardDesktopField,
            ),
          ),
          SizedBox(
            width: 140,
            child: Text(
              '# of Correct Bets',
              style: Styles.leaderboardDesktopField,
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              'Open Bets',
              style: Styles.leaderboardDesktopField,
            ),
          ),
          SizedBox(
            width: 145,
            child: Text(
              'Potential Winnings',
              style: Styles.leaderboardDesktopField,
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              'Biggest Win',
              style: Styles.leaderboardDesktopField,
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              'Last Week\'s Rank',
              style: Styles.leaderboardDesktopField,
            ),
          ),
        ],
      ),
    );
  }
}

class WebLeaderboardItem extends StatelessWidget {
  const WebLeaderboardItem({Key? key, this.player, this.rank})
      : super(key: key);
  final Wallet? player;
  final int? rank;
  @override
  Widget build(BuildContext context) {
    final currentUserUid =
        context.select((HomeCubit cubit) => cubit.state.userWallet?.uid);
    final week = context.watch<LeaderboardCubit>().state.day;
    return InkWell(
      onTap: () {
        currentUserUid == player!.uid
            ? context.read<HomeCubit>().homeChange(4)
            : Navigator.of(context).push<void>(
                LeaderboardProfile.route(
                  uid: player!.uid,
                  homeCubit: context.read<HomeCubit>(),
                  week: week,
                ),
              );
      },
      child: Container(
        height: 50,
        color: Palette.lightGrey,
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 60,
              child: Text(
                '$rank',
                style: Styles.leaderboardDesktopItem,
              ),
            ),
            SizedBox(
              width: 120,
              child: Text(
                '${player!.username}',
                style: Styles.leaderboardDesktopItem,
              ),
            ),
            SizedBox(
              width: 120,
              child: Text(
                '${player!.totalProfit}',
                style: Styles.leaderboardDesktopItem,
              ),
            ),
            SizedBox(
              width: 150,
              child: Text(
                '${player!.accountBalance}',
                style: Styles.leaderboardDesktopItem,
              ),
            ),
            SizedBox(
              width: 95,
              child: Text(
                '${player!.totalBets}',
                style: Styles.leaderboardDesktopItem,
              ),
            ),
            SizedBox(
              width: 140,
              child: Text(
                '${player!.totalBetsWon}',
                style: Styles.leaderboardDesktopItem,
              ),
            ),
            SizedBox(
              width: 110,
              child: Text(
                '${player!.totalOpenBets}',
                style: Styles.leaderboardDesktopItem,
              ),
            ),
            SizedBox(
              width: 145,
              child: Text(
                'N/A',
                style: Styles.leaderboardDesktopItem,
              ),
            ),
            SizedBox(
              width: 120,
              child: Text(
                'N/A',
                style: Styles.leaderboardDesktopItem,
              ),
            ),
            SizedBox(
              width: 120,
              child: Text(
                'N/A',
                style: Styles.leaderboardDesktopItem,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
