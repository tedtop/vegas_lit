import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../data/models/wallet.dart';
import '../../cubit/leaderboard_cubit.dart';
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Last Updated: ',
                style: Styles.matchupTime,
              ),
              Text(
                DateFormat('E, MMMM, c, y @ hh:00 a').format(
                  fetchTimeEST(),
                ),
                style: Styles.matchupTime,
              ),
              Text(
                ' EST',
                style: Styles.matchupTime,
              ),
            ],
          ),
        )
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: PageNumberView(pages: 0),
        //     ),
        //   ],
        // )
      ],
    );
  }

  DateTime fetchTimeEST() {
    tz.initializeTimeZones();
    final locationNY = tz.getLocation('America/New_York');
    final nowNY = tz.TZDateTime.now(locationNY);
    final dateTimeNY = DateTime(nowNY.year, nowNY.month, nowNY.day, nowNY.hour,
        nowNY.minute, nowNY.second);
    return dateTimeNY;
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 380,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Palette.cream,
          ),
          borderRadius: BorderRadius.circular(12),
          color: Palette.lightGrey,
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: expanded ? Palette.lightGrey : Palette.darkGrey,
            child: Text(
              widget.player.username.substring(0, 1).toUpperCase(),
              style: Styles.leaderboardUsername,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.rank}. ${widget.player.username}',
                style: Styles.normalTextBold,
              ),
              Text(
                '\$${widget.player.accountBalance + widget.player.totalRiskedAmount}',
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  color: Palette.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'W/L/O/T: ${widget.player.totalBetsWon}/${widget.player.totalBetsLost}/${widget.player.totalOpenBets}/${widget.player.totalBets}',
                style: Styles.awayTeam,
              ),
              Text(
                'W/L: ${((widget.player.totalBetsWon / widget.player.totalBets) * 100).toStringAsFixed(0)}%',
                style: Styles.awayTeam,
              ),
            ],
          ),
          tileColor: Palette.lightGrey,
        ),
      ),
    );
  }
}
