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
    @required this.winningTeamName,
    @required this.winningTeam,
    @required this.betPointSpread,
    @required this.betOverUnder,
    @required this.username,
    @required this.homeTeam,
    @required this.awayTeam,
    @required this.awayTeamScore,
    @required this.homeTeamCity,
    @required this.gameEndDateTime,
    @required this.awayTeamCity,
    @required this.homeTeamScore,
    @required this.totalGameScore,
    @required this.uid,
    @required this.homeTeamName,
    @required this.awayTeamName,
    @required this.gameStartDateTime,
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
      winningTeam: data['winningTeam'] as String,
      betAmount: data['betAmount'] as int,
      betProfit: data['betProfit'] as int,
      uid: data['uid'] as String,
      betType: data['betType'] as String,
      awayTeamCity: data['awayTeamCity'] as String,
      homeTeamCity: data['homeTeamCity'] as String,
      homeTeam: data['homeTeam'] as String,
      awayTeam: data['awayTeam'] as String,
      betTeam: data['betTeam'] as String,
      winningTeamName: data['winningTeamName'] as String,
      username: data['username'] as String,
      betPointSpread: data['betPointSpread'] as double,
      betOverUnder: data['betOverUnder'] as double,
      awayTeamScore: data['awayTeamScore'] as int,
      homeTeamScore: data['homeTeamScore'] as int,
      totalGameScore: data['totalGameScore'] as int,
      homeTeamName: data['homeTeamName'] as String,
      awayTeamName: data['awayTeamName'] as String,
      gameStartDateTime: data['gameStartDateTime'] as String,
      gameEndDateTime: data['gameEndDateTime'] as String,
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
  final String winningTeamName;
  final double betPointSpread;
  final double betOverUnder;
  final int awayTeamScore;
  final int homeTeamScore;
  final int totalGameScore;
  final String homeTeamCity;
  final String awayTeamCity;
  final String username;
  final String homeTeamName;
  final String homeTeam;
  final String awayTeamName;
  final String awayTeam;
  final String uid;
  final String gameStartDateTime;
  final String gameEndDateTime;
  final String dateTime;
  final int gameId;
  final String winningTeam;
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
      'uid': uid,
      'winningTeamName': winningTeamName,
      'betPointSpread': betPointSpread,
      'betOverUnder': betOverUnder,
      'awayTeamScore': awayTeamScore,
      'homeTeamScore': homeTeamScore,
      'username': username,
      'homeTeamCity': homeTeamCity,
      'awayTeamCity': awayTeamCity,
      'totalGameScore': totalGameScore,
      'winningTeam': winningTeam,
      'homeTeamName': homeTeamName,
      'awayTeamName': awayTeamName,
      'gameEndDateTime': gameEndDateTime,
      'gameStartDateTime': gameStartDateTime,
      'dateTime': dateTime,
      'homeTeam': homeTeam,
      'awayTeam': awayTeam,
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
      uid,
      betProfit,
      betType,
      betTeam,
      winningTeamName,
      betPointSpread,
      betOverUnder,
      winningTeam,
      homeTeam,
      gameEndDateTime,
      username,
      awayTeam,
      awayTeamScore,
      homeTeamScore,
      totalGameScore,
      homeTeamName,
      awayTeamName,
      gameStartDateTime,
      dateTime,
      gameId,
      homeTeamCity,
      awayTeamCity,
      isClosed,
      league,
      odds,
    ];
  }
}
