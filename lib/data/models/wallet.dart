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
    @required this.pendingRiskedAmount,
    @required this.rank,
    @required this.biggestWinAmount,
    @required this.totalRiskedAmount,
    @required this.avatarUrl,
    @required this.todayRewards,
  });

  factory Wallet.fromFirestore(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final map = snapshot.data() as Map;

    return Wallet(
        uid: map['uid'],
        username: map['username'],
        totalRewards: map['totalRewards'],
        totalLoss: map['totalLoss'],
        rank: map['rank'],
        totalProfit: map['totalProfit'],
        accountBalance: map['accountBalance'],
        totalBets: map['totalBets'],
        pendingRiskedAmount: map['pendingRiskedAmount'],
        totalBetsWon: map['totalBetsWon'],
        totalBetsLost: map['totalBetsLost'],
        totalOpenBets: map['totalOpenBets'],
        todayRewards: map['todayRewards'],
        potentialWinAmount: map['potentialWinAmount'],
        biggestWinAmount: map['biggestWinAmount'],
        totalRiskedAmount: map['totalRiskedAmount'],
        avatarUrl: map['avatarUrl']);
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
        pendingRiskedAmount: map['pendingRiskedAmount'],
        rank: map['rank'],
        todayRewards: map['todayRewards'],
        totalBets: map['totalBets'],
        totalBetsWon: map['totalBetsWon'],
        totalBetsLost: map['totalBetsLost'],
        totalOpenBets: map['totalOpenBets'],
        potentialWinAmount: map['potentialWinAmount'],
        biggestWinAmount: map['biggestWinAmount'],
        totalRiskedAmount: map['totalRiskedAmount'],
        avatarUrl: map['avatarUrl']);
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
  final int pendingRiskedAmount;
  final int rank;
  final int todayRewards;
  final String avatarUrl;

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
        'todayRewards': todayRewards,
        'pendingRiskedAmount': pendingRiskedAmount,
        'rank': rank,
        'totalOpenBets': totalOpenBets,
        'potentialWinAmount': potentialWinAmount,
        'biggestWinAmount': biggestWinAmount,
        'totalRiskedAmount': totalRiskedAmount,
        'avatarUrl': avatarUrl
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
    int pendingRiskedAmount,
    int todayRewards,
    int rank,
    String avatarUrl,
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
      todayRewards: todayRewards ?? this.todayRewards,
      totalBetsLost: totalBetsLost ?? this.totalBetsLost,
      totalOpenBets: totalOpenBets ?? this.totalOpenBets,
      potentialWinAmount: potentialWinAmount ?? this.potentialWinAmount,
      biggestWinAmount: biggestWinAmount ?? this.biggestWinAmount,
      totalRiskedAmount: totalRiskedAmount ?? this.totalRiskedAmount,
      pendingRiskedAmount: pendingRiskedAmount ?? this.pendingRiskedAmount,
      rank: rank ?? this.rank,
      avatarUrl: avatarUrl ?? this.avatarUrl,
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
      todayRewards,
      rank,
      totalBetsWon,
      pendingRiskedAmount,
      totalBetsLost,
      totalOpenBets,
      totalRiskedAmount,
      potentialWinAmount,
      biggestWinAmount,
      avatarUrl
    ];
  }
}
