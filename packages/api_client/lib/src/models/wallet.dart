import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Wallet extends Equatable {
  Wallet({
    @required this.uid,
    @required this.username,
    @required this.totalProfit,
    @required this.accountBalance,
    @required this.totalBets,
    @required this.totalWinBets,
    @required this.totalLoseBets,
    @required this.totalOpenBets,
    @required this.potentialWinAmount,
    @required this.biggestWinAmount,
    @required this.totalRiskedAmount,
  });

  factory Wallet.fromFirestore(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final map = snapshot.data();

    return Wallet(
      uid: map['uid'] ?? '',
      username: map['username'],
      totalProfit: map['totalProfit'],
      accountBalance: map['accountBalance'],
      totalBets: map['totalBets'],
      totalWinBets: map['totalWinBets'],
      totalLoseBets: map['totalLoseBets'],
      totalOpenBets: map['totalOpenBets'],
      potentialWinAmount: map['potentialWinAmount'],
      biggestWinAmount: map['biggestWinAmount'],
      totalRiskedAmount: map['totalRiskedAmount'],
    );
  }

  factory Wallet.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Wallet(
      uid: map['uid'],
      username: map['username'],
      totalProfit: map['totalProfit'],
      accountBalance: map['accountBalance'],
      totalBets: map['totalBets'],
      totalWinBets: map['totalWinBets'],
      totalLoseBets: map['totalLoseBets'],
      totalOpenBets: map['totalOpenBets'],
      potentialWinAmount: map['potentialWinAmount'],
      biggestWinAmount: map['biggestWinAmount'],
      totalRiskedAmount: map['totalRiskedAmount'],
    );
  }

  final String uid;
  final String username;
  final int totalProfit;
  final int accountBalance;
  final int totalBets;
  final int totalWinBets;
  final int totalLoseBets;
  final int totalOpenBets;
  final int totalRiskedAmount;
  final int potentialWinAmount;
  final int biggestWinAmount;

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'username': username,
        'totalProfit': totalProfit,
        'accountBalance': accountBalance,
        'totalBets': totalBets,
        'totalWinBets': totalWinBets,
        'totalLoseBets': totalLoseBets,
        'totalOpenBets': totalOpenBets,
        'potentialWinAmount': potentialWinAmount,
        'biggestWinAmount': biggestWinAmount,
        'totalRiskedAmount': totalRiskedAmount,
      };

  Wallet copyWith({
    String uid,
    String username,
    int totalProfit,
    int accountBalance,
    int totalBets,
    int totalWinBets,
    int totalLoseBets,
    int totalOpenBets,
    int potentialWinAmount,
    int biggestWinAmount,
    int totalRiskedAmount,
  }) {
    return Wallet(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      totalProfit: totalProfit ?? this.totalProfit,
      accountBalance: accountBalance ?? this.accountBalance,
      totalBets: totalBets ?? this.totalBets,
      totalWinBets: totalWinBets ?? this.totalWinBets,
      totalLoseBets: totalLoseBets ?? this.totalLoseBets,
      totalOpenBets: totalOpenBets ?? this.totalOpenBets,
      potentialWinAmount: potentialWinAmount ?? this.potentialWinAmount,
      biggestWinAmount: biggestWinAmount ?? this.biggestWinAmount,
      totalRiskedAmount: totalRiskedAmount ?? this.totalRiskedAmount,
    );
  }

  @override
  List<Object> get props {
    return [
      uid,
      username,
      totalProfit,
      accountBalance,
      totalBets,
      totalWinBets,
      totalLoseBets,
      totalOpenBets,
      totalRiskedAmount,
      potentialWinAmount,
      biggestWinAmount,
    ];
  }
}
