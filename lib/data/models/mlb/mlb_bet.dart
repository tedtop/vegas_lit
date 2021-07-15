import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../bet.dart';

class MlbBetData extends BetData {
  MlbBetData({
    @required id,
    @required betAmount,
    @required betProfit,
    @required betType,
    @required stillOpen,
    @required username,
    @required status,
    @required dataProvider,
    @required clientVersion,
    @required uid,
    @required gameStartDateTime,
    @required dateTime,
    @required week,
    @required isClosed,
    @required league,
    @required odds,
    @required this.betTeam,
    @required this.winningTeamName,
    @required this.winningTeam,
    @required this.betPointSpread,
    @required this.betOverUnder,
    @required this.homeTeam,
    @required this.awayTeam,
    @required this.awayTeamScore,
    @required this.homeTeamCity,
    @required this.awayTeamCity,
    @required this.homeTeamScore,
    @required this.totalGameScore,
    @required this.homeTeamName,
    @required this.awayTeamName,
    @required this.gameId,
  }) : super(
          id: id,
          betAmount: betAmount,
          betProfit: betProfit,
          betType: betType,
          stillOpen: stillOpen,
          username: username,
          status: status,
          dataProvider: dataProvider,
          clientVersion: clientVersion,
          uid: uid,
          gameStartDateTime: gameStartDateTime,
          dateTime: dateTime,
          week: week,
          isClosed: isClosed,
          league: league,
          odds: odds,
        );

  @override
  factory MlbBetData.fromFirestore(DocumentSnapshot snapshot) {
    final Map data = snapshot.data();
    return MlbBetData(
      id: data['id'] as String,
      winningTeam: data['winningTeam'] as String,
      betAmount: data['betAmount'] as int,
      betProfit: data['betProfit'] as int,
      uid: data['uid'] as String,
      stillOpen: data['stillOpen'] as bool,
      betType: data['betType'] as String,
      awayTeamCity: data['awayTeamCity'] as String,
      homeTeamCity: data['homeTeamCity'] as String,
      homeTeam: data['homeTeam'] as String,
      awayTeam: data['awayTeam'] as String,
      betTeam: data['betTeam'] as String,
      winningTeamName: data['winningTeamName'] as String,
      username: data['username'] as String,
      dataProvider: data['dataProvider'] as String,
      clientVersion: data['clientVersion'] as String,
      betPointSpread: double.tryParse(data['betPointSpread'].toString()),
      betOverUnder: double.tryParse(data['betOverUnder'].toString()),
      awayTeamScore: data['awayTeamScore'] as int,
      homeTeamScore: data['homeTeamScore'] as int,
      totalGameScore: data['totalGameScore'] as int,
      homeTeamName: data['homeTeamName'] as String,
      awayTeamName: data['awayTeamName'] as String,
      gameStartDateTime: data['gameStartDateTime'] as String,
      dateTime: data['dateTime'] as String,
      week: data['week'] as String,
      status: data['status'] as String,
      gameId: data['gameId'] as int,
      isClosed: data['isClosed'] as bool,
      league: data['league'] as String,
      odds: data['odds'] as int,
    );
  }

  final String betTeam;
  final String winningTeamName;
  final double betPointSpread;
  final double betOverUnder;
  final int awayTeamScore;
  final int homeTeamScore;
  final int totalGameScore;
  final String homeTeamCity;
  final String awayTeamCity;
  final String homeTeamName;
  final String homeTeam;
  final String awayTeamName;
  final String awayTeam;
  final int gameId;
  final String winningTeam;

  @override
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
      'clientVersion': clientVersion,
      'stillOpen': stillOpen,
      'dataProvider': dataProvider,
      'status': status,
      'totalGameScore': totalGameScore,
      'winningTeam': winningTeam,
      'homeTeamName': homeTeamName,
      'awayTeamName': awayTeamName,
      'gameStartDateTime': gameStartDateTime,
      'dateTime': dateTime,
      'week': week,
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
    return super.props
      ..addAll([
        betTeam,
        winningTeamName,
        betPointSpread,
        betOverUnder,
        winningTeam,
        homeTeam,
        awayTeam,
        awayTeamScore,
        homeTeamScore,
        totalGameScore,
        homeTeamName,
        awayTeamName,
        gameId,
        homeTeamCity,
        awayTeamCity,
      ]);
  }
}
