import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/data/models/wallet.dart';
import 'package:vegas_lit/features/leaderboard/cubit/leaderboard_cubit.dart';

import '../pagenumberview.dart';
import '../textbar.dart';

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
        TextBar(
          text: leaderboardState.day,
          textList: leaderboardState.days,
          onPress: (String value) {
            context.read<LeaderboardCubit>().changeWeek(week: value);
          },
        ),
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
                  child: CircularProgressIndicator(
                    color: Palette.cream,
                  ),
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

class MobileLeaderboardTile extends StatefulWidget {
  MobileLeaderboardTile({@required this.player, @required this.rank});
  final Wallet player;
  final int rank;

  @override
  _MobileLeaderboardTileState createState() => _MobileLeaderboardTileState();
}

class _MobileLeaderboardTileState extends State<MobileLeaderboardTile> {
  bool expanded = false;

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
          onExpansionChanged: (isExpanded) {
            setState(() {
              expanded = isExpanded;
            });
          },
          leading: CircleAvatar(
            backgroundColor: expanded ? Palette.lightGrey : Palette.darkGrey,
            child: Text(
              widget.player.username.substring(0, 1).toUpperCase(),
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                color: Palette.cream,
              ),
            ),
          ),
          title: Text(
            '${widget.rank}. ${widget.player.username}',
            style: Styles.normalTextBold,
          ),
          subtitle: Row(
            children: [
              Text(
                'Profit: \$${widget.player.totalProfit}',
                style: Styles.homeTeam,
              ),
              const SizedBox(width: 5),
              Text(
                'Balance: \$${widget.player.accountBalance}',
                style: Styles.awayTeam,
              ),
            ],
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
                    '${widget.player.totalBetsWon} out of ${widget.player.totalBets} Correct Bets!',
                    style: Styles.awayTeam,
                  ),
                  Text(
                    'Total Lost Bets: ${widget.player.totalBetsLost}',
                    style: Styles.awayTeam,
                  ),
                  Text(
                    'Open Bets: ${widget.player.totalOpenBets}',
                    style: Styles.awayTeam,
                  ),
                  Text(
                    'Account Balance: \$${widget.player.accountBalance}',
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

  // String profitOrLoss({@required int number}) {
  //   return 'Profit: \$$number';
  // }
}
