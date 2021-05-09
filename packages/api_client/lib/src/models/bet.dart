import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class BetData extends Equatable {
  BetData({
    @required this.id,
    @required this.betAmount,
    @required this.betProfit,
    @required this.betType,
    @required this.betTeam,
    @required this.winTeam,
    @required this.betPointSpread,
    @required this.betOverUnder,
    @required this.awayTeamScore,
    @required this.homeTeamScore,
    @required this.totalGameScore,
    @required this.homeTeam,
    @required this.awayTeam,
    @required this.gameDateTime,
    @required this.dateTime,
    @required this.gameId,
    @required this.isClosed,
    @required this.league,
    @required this.odds,
  });

  factory BetData.fromFirestore(DocumentSnapshot snapshot) {
    final Map data = snapshot.data();
    return BetData(
      id: data['id'] as String,
      betAmount: data['betAmount'] as int,
      betProfit: data['betProfit'] as int,
      betType: data['betType'] as String,
      betTeam: data['betTeam'] as String,
      winTeam: data['winTeam'] as String,
      betPointSpread: data['betPointSpread'] as double,
      betOverUnder: data['betOverUnder'] as double,
      awayTeamScore: data['awayTeamScore'] as int,
      homeTeamScore: data['homeTeamScore'] as int,
      totalGameScore: data['totalGameScore'] as int,
      homeTeam: data['homeTeam'] as String,
      awayTeam: data['awayTeam'] as String,
      gameDateTime: data['gameDateTime'] as String,
      dateTime: data['dateTime'] as String,
      gameId: data['gameId'] as int,
      isClosed: data['isClosed'] as bool,
      league: data['league'] as String,
      odds: data['odds'] as int,
    );
  }

  final String id;
  final int betAmount;
  final int betProfit;
  final String betType;
  final String betTeam;
  final String winTeam;
  final double betPointSpread;
  final double betOverUnder;
  final int awayTeamScore;
  final int homeTeamScore;
  final int totalGameScore;
  final String homeTeam;
  final String awayTeam;
  final String gameDateTime;
  final String dateTime;
  final int gameId;
  final bool isClosed;
  final String league;
  final int odds;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'betAmount': betAmount,
      'betProfit': betProfit,
      'betType': betType,
      'betTeam': betTeam,
      'winTeam': winTeam,
      'betPointSpread': betPointSpread,
      'betOverUnder': betOverUnder,
      'awayTeamScore': awayTeamScore,
      'homeTeamScore': homeTeamScore,
      'totalGameScore': totalGameScore,
      'homeTeam': homeTeam,
      'awayTeam': awayTeam,
      'gameDateTime': gameDateTime,
      'dateTime': dateTime,
      'gameId': gameId,
      'isClosed': isClosed,
      'league': league,
      'odds': odds
    };
  }

  @override
  List<Object> get props {
    return [
      id,
      betAmount,
      betProfit,
      betType,
      betTeam,
      winTeam,
      betPointSpread,
      betOverUnder,
      awayTeamScore,
      homeTeamScore,
      totalGameScore,
      homeTeam,
      awayTeam,
      gameDateTime,
      dateTime,
      gameId,
      isClosed,
      league,
      odds,
    ];
  }
}
