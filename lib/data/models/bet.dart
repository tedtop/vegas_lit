import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class BetData extends Equatable {
  BetData({
    @required this.id,
    @required this.betAmount,
    @required this.betProfit,
    @required this.betType,
    @required this.stillOpen,
    @required this.username,
    @required this.status,
    @required this.dataProvider,
    @required this.clientVersion,
    @required this.uid,
    @required this.gameStartDateTime,
    @required this.dateTime,
    @required this.week,
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

  final String id;
  final int betAmount;
  final int betProfit;
  final String betType;
  final String username;
  final bool stillOpen;
  final String uid;
  final String gameStartDateTime;
  final String clientVersion;
  final String dataProvider;
  final String dateTime;
  final String week;
  final bool isClosed;
  final String league;
  final String status;
  final int odds;

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

  @override
  List<Object> get props {
    return [
      id,
      betAmount,
      uid,
      betProfit,
      betType,
      status,
      stillOpen,
      username,
      clientVersion,
      dataProvider,
      gameStartDateTime,
      dateTime,
      week,
      isClosed,
      league,
      odds,
    ];
  }
}
