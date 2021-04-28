import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserBets extends Equatable {
  UserBets({
    @required this.rank,
    @required this.player,
    @required this.profit,
    @required this.accountBalance,
    @required this.noOfBets,
    @required this.noOfCorrectBets,
    @required this.openBets,
    @required this.potentialWinnings,
    @required this.biggestWin,
    @required this.lastWeeksRank,
  });

  factory UserBets.fromFirestore(DocumentSnapshot documentSnapshot) {
    final Map data = documentSnapshot.data();
    return UserBets(
      rank: data['rank'],
      player: data['player'],
      profit: data['profit'],
      accountBalance: data['accountBalance'],
      noOfBets: data['noOfBets'],
      noOfCorrectBets: data['noOfCorrectBets'],
      openBets: data['openBets'],
      potentialWinnings: data['potentialWinnings'],
      biggestWin: data['biggestWin'],
      lastWeeksRank: data['lastWeeksRank'],
    );
  }

  UserBets copyWith({
    int rank,
    String player,
    double profit,
    double accountBalance,
    int noOfBets,
    int noOfCorrectBets,
    double openBets,
    double potentialWinnings,
    double biggestWin,
    int lastWeeksRank,
  }) {
    return UserBets(
      rank: rank ?? this.rank,
      player: player ?? this.player,
      profit: profit ?? this.profit,
      accountBalance: accountBalance ?? this.accountBalance,
      noOfBets: noOfBets ?? this.noOfBets,
      noOfCorrectBets: noOfCorrectBets ?? this.noOfCorrectBets,
      openBets: openBets ?? this.openBets,
      potentialWinnings: potentialWinnings ?? this.potentialWinnings,
      biggestWin: biggestWin ?? this.biggestWin,
      lastWeeksRank: lastWeeksRank ?? this.lastWeeksRank,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rank': rank,
      'player': player,
      'profit': profit,
      'accountBalance': accountBalance,
      'noOfBets': noOfBets,
      'noOfCorrectBets': noOfCorrectBets,
      'openBets': openBets,
      'potentialWinnings': potentialWinnings,
      'biggestWin': biggestWin,
      'lastWeeksRank': lastWeeksRank,
    };
  }

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

  @override
  List<Object> get props {
    return [
      rank,
      player,
      profit,
      accountBalance,
      noOfBets,
      noOfCorrectBets,
      openBets,
      potentialWinnings,
      biggestWin,
      lastWeeksRank,
    ];
  }
}
