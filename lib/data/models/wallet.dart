import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Wallet extends Equatable {
  Wallet({
    @required this.uid,
    @required this.username,
    @required this.totalProfit,
    @required this.totalLoss,
    @required this.accountBalance,
    @required this.totalBets,
    @required this.totalBetsWon,
    @required this.totalRewards,
    @required this.totalBetsLost,
    @required this.totalOpenBets,
    @required this.potentialWinAmount,
    @required this.riskedAmount,
    @required this.biggestWinAmount,
    @required this.totalRiskedAmount,
  });

  factory Wallet.fromFirestore(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final map = snapshot.data();

    return Wallet(
      uid: map['uid'],
      username: map['username'],
      totalRewards: map['totalRewards'],
      totalLoss: map['totalLoss'],
      totalProfit: map['totalProfit'],
      accountBalance: map['accountBalance'],
      totalBets: map['totalBets'],
      riskedAmount: map['riskedAmount'],
      totalBetsWon: map['totalBetsWon'],
      totalBetsLost: map['totalBetsLost'],
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
      totalLoss: map['totalLoss'],
      totalProfit: map['totalProfit'],
      totalRewards: map['totalRewards'],
      accountBalance: map['accountBalance'],
      riskedAmount: map['riskedAmount'],
      totalBets: map['totalBets'],
      totalBetsWon: map['totalBetsWon'],
      totalBetsLost: map['totalBetsLost'],
      totalOpenBets: map['totalOpenBets'],
      potentialWinAmount: map['potentialWinAmount'],
      biggestWinAmount: map['biggestWinAmount'],
      totalRiskedAmount: map['totalRiskedAmount'],
    );
  }

  final String uid;
  final String username;
  final int totalProfit;
  final int totalLoss;
  final int accountBalance;
  final int totalBets;
  final int totalBetsWon;
  final int totalRewards;
  final int totalBetsLost;
  final int totalOpenBets;
  final int totalRiskedAmount;
  final int potentialWinAmount;
  final int biggestWinAmount;
  final int riskedAmount;

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'username': username,
        'totalProfit': totalProfit,
        'totalLoss': totalLoss,
        'accountBalance': accountBalance,
        'totalRewards': totalRewards,
        'totalBets': totalBets,
        'totalBetsWon': totalBetsWon,
        'totalBetsLost': totalBetsLost,
        'riskedAmount': riskedAmount,
        'totalOpenBets': totalOpenBets,
        'potentialWinAmount': potentialWinAmount,
        'biggestWinAmount': biggestWinAmount,
        'totalRiskedAmount': totalRiskedAmount,
      };

  Wallet copyWith({
    String uid,
    String username,
    int totalProfit,
    int totalLoss,
    int accountBalance,
    int totalBets,
    int totalBetsWon,
    int totalRewards,
    int totalBetsLost,
    int totalOpenBets,
    int potentialWinAmount,
    int biggestWinAmount,
    int totalRiskedAmount,
    int riskedAmount,
  }) {
    return Wallet(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      totalProfit: totalProfit ?? this.totalProfit,
      totalLoss: totalLoss ?? this.totalLoss,
      totalRewards: totalRewards ?? this.totalRewards,
      accountBalance: accountBalance ?? this.accountBalance,
      totalBets: totalBets ?? this.totalBets,
      totalBetsWon: totalBetsWon ?? this.totalBetsWon,
      totalBetsLost: totalBetsLost ?? this.totalBetsLost,
      totalOpenBets: totalOpenBets ?? this.totalOpenBets,
      potentialWinAmount: potentialWinAmount ?? this.potentialWinAmount,
      biggestWinAmount: biggestWinAmount ?? this.biggestWinAmount,
      totalRiskedAmount: totalRiskedAmount ?? this.totalRiskedAmount,
      riskedAmount: riskedAmount ?? this.riskedAmount,
    );
  }

  @override
  List<Object> get props {
    return [
      uid,
      username,
      totalProfit,
      totalRewards,
      totalLoss,
      accountBalance,
      totalBets,
      totalBetsWon,
      riskedAmount,
      totalBetsLost,
      totalOpenBets,
      totalRiskedAmount,
      potentialWinAmount,
      biggestWinAmount,
    ];
  }
}
