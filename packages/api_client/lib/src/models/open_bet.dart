import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class OpenBetsData extends Equatable {
  OpenBetsData({
    @required this.amountWin,
    @required this.awayTeam,
    @required this.homeTeam,
    @required this.winTeam,
    @required this.dateTime,
    @required this.id,
    @required this.betType,
    @required this.gameID,
    @required this.league,
    @required this.isClosed,
    @required this.odd,
    @required this.amountBet,
  });

  factory OpenBetsData.fromFirestore(DocumentSnapshot documentSnapshot) {
    final Map data = documentSnapshot.data();
    return OpenBetsData(
      id: data['id'] as String,
      gameID: data['gameID'] as int,
      league: data['league'] as String,
      amountBet: data['amountBet'] as int,
      awayTeam: data['awayTeam'] as String,
      winTeam: data['winTeam'] as String,
      homeTeam: data['homeTeam'] as String,
      betType: data['betType'] as String,
      amountWin: data['amountWin'] as int,
      dateTime: data['dateTime'] as String,
      odd: data['odd'] as int,
      isClosed: data['isClosed'] as bool,
    );
  }

  final int amountBet;
  final String league;
  final String awayTeam;
  final String homeTeam;
  final String id;
  final String betType;
  final int amountWin;
  final int gameID;
  final String winTeam;
  final bool isClosed;
  final String dateTime;
  final int odd;

  Map<String, dynamic> toMap() {
    return {
      'amountBet': amountBet,
      'awayTeam': awayTeam,
      'homeTeam': homeTeam,
      'isClosed': isClosed,
      'id': id,
      'gameID': gameID,
      'winTeam': winTeam,
      'betType': betType,
      'dateTime': dateTime,
      'amountWin': amountWin,
      'odd': odd,
      'league': league,
    };
  }

  @override
  List<Object> get props {
    return [
      amountBet,
      awayTeam,
      homeTeam,
      gameID,
      winTeam,
      isClosed,
      id,
      betType,
      league,
      odd,
      dateTime,
      amountWin,
    ];
  }
}
