import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class BetData extends Equatable {
  BetData({
    @required this.amountWin,
    @required this.awayTeam,
    @required this.homeTeam,
    @required this.awayTeamScore,
    @required this.homeTeamScore,
    @required this.finalWinTeam,
    @required this.dateTime,
    @required this.id,
    @required this.betType,
    @required this.winTeam,
    @required this.gameID,
    @required this.league,
    @required this.isClosed,
    @required this.odd,
    @required this.amountBet,
  });

  factory BetData.fromFirestore(DocumentSnapshot documentSnapshot) {
    final Map data = documentSnapshot.data();
    return BetData(
      id: data['id'] as String,
      gameID: data['gameID'] as int,
      league: data['league'] as String,
      amountBet: data['amountBet'] as int,
      awayTeam: data['awayTeam'] as String,
      homeTeam: data['homeTeam'] as String,
      winTeam: data['winTeam'] as String ?? 'home',
      betType: data['betType'] as String,
      amountWin: data['amountWin'] as int,
      dateTime: data['dateTime'] as String,
      odd: data['odd'] as int,
      isClosed: data['isClosed'] as bool,
      awayTeamScore: data['awayTeamScore'] as int,
      finalWinTeam: data['finalWinTeam'] as String,
      homeTeamScore: data['homeTeamScore'] as int,
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
  final bool isClosed;
  final int awayTeamScore;
  final int homeTeamScore;
  final String finalWinTeam;
  final String winTeam;
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
      'betType': betType,
      'dateTime': dateTime,
      'amountWin': amountWin,
      'homeTeamScore': homeTeamScore,
      'awayTeamScore': awayTeamScore,
      'finalWinTeam': finalWinTeam,
      'winTeam': winTeam,
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
      isClosed,
      winTeam,
      id,
      finalWinTeam,
      awayTeamScore,
      homeTeamScore,
      betType,
      league,
      odd,
      dateTime,
      amountWin,
    ];
  }
}
