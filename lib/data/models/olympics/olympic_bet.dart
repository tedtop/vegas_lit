import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../bet.dart';

class OlympicsBetData extends BetData {
  OlympicsBetData({
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
    @required this.betPointSpread,
    @required this.betOverUnder,
    @required this.awayTeamScore,
    @required this.homeTeamScore,
    @required this.totalGameScore,
    @required this.homeTeamCity,
    @required this.awayTeamCity,
    @required this.homeTeamName,
    @required this.homeTeam,
    @required this.awayTeamName,
    @required this.awayTeam,
    @required this.gameId,
    @required this.winningTeam,
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
  factory OlympicsBetData.fromFirestore(DocumentSnapshot snapshot) {
    final Map data = snapshot.data();
    return OlympicsBetData(
      id: data['id'] as String,
      betAmount: data['betAmount'] as int,
      betProfit: data['betProfit'] as int,
      uid: data['uid'] as String,
      stillOpen: data['stillOpen'] as bool,
      betType: data['betType'] as String,
      username: data['username'] as String,
      dataProvider: data['dataProvider'] as String,
      clientVersion: data['clientVersion'] as String,
      gameStartDateTime: data['gameStartDateTime'] as String,
      dateTime: data['dateTime'] as String,
      week: data['week'] as String,
      status: data['status'] as String,
      isClosed: data['isClosed'] as bool,
      league: data['league'] as String,
      odds: data['odds'] as int,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'betAmount': betAmount,
      'betProfit': betProfit,
      'betType': betType,
      'uid': uid,
      'username': username,
      'clientVersion': clientVersion,
      'stillOpen': stillOpen,
      'dataProvider': dataProvider,
      'status': status,
      'gameStartDateTime': gameStartDateTime,
      'dateTime': dateTime,
      'week': week,
      'isClosed': isClosed,
      'league': league,
      'odds': odds
    };
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
  List<Object> get props {
    return super.props..addAll([]);
  }
}
