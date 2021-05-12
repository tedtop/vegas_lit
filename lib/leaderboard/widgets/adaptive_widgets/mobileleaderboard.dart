import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/leaderboard/cubit/leaderboard_cubit.dart';
import 'package:vegas_lit/leaderboard/widgets/pagenumberview.dart';
import 'package:vegas_lit/leaderboard/widgets/textbar.dart';

class MobileLeaderboard extends StatefulWidget {
  MobileLeaderboard({@required this.players});
  final List<Wallet> players;
  @override
  _MobileLeaderboardState createState() => _MobileLeaderboardState();
}

class _MobileLeaderboardState extends State<MobileLeaderboard> {
  @override
  Widget build(BuildContext context) {
    final leaderboardState = context.watch<LeaderboardCubit>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
          child: Text(
            'Current Leaderboard',
            style: Styles.normalTextBold,
          ),
        ),
        TextBar(
          text: leaderboardState.day,
          textList: leaderboardState.days,
          onPress: (String value) {
            context.read<LeaderboardCubit>().changeWeek(day: value);
          },
        ),
        // const TextBar(
        //   text: 'All Leagues',
        //   textList: ['All Leagues'],
        //   onPress: print,
        // ),
        // const TextBar(
        //   text: 'All Bet Types',
        //   textList: ['All Bet Types'],
        //   onPress: print,
        // ),
        const SizedBox(
          height: 10,
        ),
        Builder(
          builder: (context) {
            switch (leaderboardState.status) {
              case LeaderboardStatus.opened:
                return leaderboardState.rankedUserList.isNotEmpty
                    ? Column(
                        children: widget.players
                            .asMap()
                            .entries
                            .map((entry) => MobileLeaderboardTile(
                                  player: entry.value,
                                  rank: entry.key + 1,
                                ))
                            .toList(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 120),
                        child: Text(
                          // ignore: lines_longer_than_80_chars
                          'No records found',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            color: Palette.cream,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      );
                break;
              case LeaderboardStatus.weekChanged:
                return leaderboardState.rankedUserList.isNotEmpty
                    ? Column(
                        children: widget.players
                            .asMap()
                            .entries
                            .map((entry) => MobileLeaderboardTile(
                                  player: entry.value,
                                  rank: entry.key + 1,
                                ))
                            .toList(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 120),
                        child: Text(
                          // ignore: lines_longer_than_80_chars
                          'No records found',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                            color: Palette.cream,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      );
              default:
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 120),
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PageNumberView(pages: 0),
            ),
          ],
        )
      ],
    );
  }
}

class MobileLeaderboardTile extends StatelessWidget {
  MobileLeaderboardTile({@required this.player, @required this.rank});
  final Wallet player;
  final int rank;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Palette.cream,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ExpansionTile(
          title: Text(
            '$rank. ${player.username}',
            style: Styles.normalTextBold,
          ),
          subtitle: Text(
            'Total Profit: \$${player.totalProfit}',
            style: Styles.homeTeam,
          ),
          collapsedBackgroundColor: Palette.lightGrey,
          backgroundColor: Palette.darkGrey,
          children: [
            Container(
              width: 380,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${player.totalWinBets} out of ${player.totalBets} Correct Bets!',
                    style: Styles.awayTeam,
                  ),
                  // Text(
                  //   'Biggest win: \$${player.biggestWin}',
                  //   style: Styles.awayTeam,
                  // ),
                  Text(
                    'Account Balance: \$${player.accountBalance}',
                    style: Styles.awayTeam,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
