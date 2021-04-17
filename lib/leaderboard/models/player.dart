import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:vegas_lit/config/palette.dart';

List<LeaderBoardPlayer> playerFromJson(String str) =>
    List<LeaderBoardPlayer>.from(
        json.decode(str).map((x) => LeaderBoardPlayer.fromJson(x)));

String playerToJson(List<LeaderBoardPlayer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaderBoardPlayer {
  final int rank;
  final String player;
  final double profit;
  final double accountBalance;
  final int noOfBets;
  final int noOfCorrectBets;
  final double openBets;
  final double potentialWinnings;
  final double biggestWin;
  final int lastWeeksRank;
  LeaderBoardPlayer({
    this.rank,
    this.player,
    this.accountBalance,
    this.biggestWin,
    this.lastWeeksRank,
    this.noOfBets,
    this.noOfCorrectBets,
    this.openBets,
    this.potentialWinnings,
    this.profit,
  });

  PlutoRow toPlutoRow() => PlutoRow(cells: {
        'rank': PlutoCell(value: rank),
        'player': PlutoCell(value: player),
        'profit': PlutoCell(value: profit),
        'accountBalance': PlutoCell(value: accountBalance),
        'noOfBets': PlutoCell(value: noOfBets),
        'noOfCorrectBets': PlutoCell(value: noOfCorrectBets),
        'openBets': PlutoCell(value: openBets),
        'potentialWinnings': PlutoCell(value: potentialWinnings),
        'biggestWin': PlutoCell(value: biggestWin),
        'lastWeeksRank': PlutoCell(value: lastWeeksRank),
      });

  factory LeaderBoardPlayer.fromJson(Map<String, dynamic> json) =>
      LeaderBoardPlayer(
        rank: json["rank"],
        player: json["player"],
        profit: json["profit"].toDouble(),
        accountBalance: json["accountBalance"].toDouble(),
        noOfBets: json["noOfBets"],
        noOfCorrectBets: json["noOfCorrectBets"],
        openBets: json["openBets"].toDouble(),
        potentialWinnings: json["potentialWinnings"].toDouble(),
        biggestWin: json["biggestWin"].toDouble(),
        lastWeeksRank: json["lastWeeksRank"],
      );

  Map<String, dynamic> toJson() => {
        "rank": rank,
        "player": player,
        "profit": profit,
        "accountBalance": accountBalance,
        "noOfBets": noOfBets,
        "noOfCorrectBets": noOfCorrectBets,
        "openBets": openBets,
        "potentialWinnings": potentialWinnings,
        "biggestWin": biggestWin,
        "lastWeeksRank": lastWeeksRank,
      };
}
