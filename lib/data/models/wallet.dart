import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Wallet extends Equatable {
  const Wallet({
    required this.uid,
    required this.username,
    required this.totalProfit,
    required this.totalLoss,
    required this.accountBalance,
    required this.totalBets,
    required this.totalBetsWon,
    required this.totalRewards,
    required this.totalBetsLost,
    required this.totalOpenBets,
    required this.potentialWinAmount,
    required this.pendingRiskedAmount,
    required this.rank,
    required this.biggestWinAmount,
    required this.totalRiskedAmount,
    required this.avatarUrl,
    required this.todayRewards,
  });

  factory Wallet.fromFirestore(DocumentSnapshot snapshot) {
    final map = snapshot.data() as Map;

    return Wallet(
      uid: map['uid'] as String?,
      username: map['username'] as String?,
      totalRewards: map['totalRewards'] as int?,
      totalLoss: map['totalLoss'] as int?,
      rank: map['rank'] as int?,
      totalProfit: map['totalProfit'] as int?,
      accountBalance: map['accountBalance'] as int?,
      totalBets: map['totalBets'] as int?,
      pendingRiskedAmount: map['pendingRiskedAmount'] as int?,
      totalBetsWon: map['totalBetsWon'] as int?,
      totalBetsLost: map['totalBetsLost'] as int?,
      totalOpenBets: map['totalOpenBets'] as int?,
      todayRewards: map['todayRewards'] as int?,
      potentialWinAmount: map['potentialWinAmount'] as int?,
      biggestWinAmount: map['biggestWinAmount'] as int?,
      totalRiskedAmount: map['totalRiskedAmount'] as int?,
      avatarUrl: map['avatarUrl'] as String?,
    );
  }

  factory Wallet.fromMap(Map<String, dynamic> map) {
    return Wallet(
      uid: map['uid'] as String?,
      username: map['username'] as String?,
      totalLoss: map['totalLoss'] as int?,
      totalProfit: map['totalProfit'] as int?,
      totalRewards: map['totalRewards'] as int?,
      accountBalance: map['accountBalance'] as int?,
      pendingRiskedAmount: map['pendingRiskedAmount'] as int?,
      rank: map['rank'] as int?,
      todayRewards: map['todayRewards'] as int?,
      totalBets: map['totalBets'] as int?,
      totalBetsWon: map['totalBetsWon'] as int?,
      totalBetsLost: map['totalBetsLost'] as int?,
      totalOpenBets: map['totalOpenBets'] as int?,
      potentialWinAmount: map['potentialWinAmount'] as int?,
      biggestWinAmount: map['biggestWinAmount'] as int?,
      totalRiskedAmount: map['totalRiskedAmount'] as int?,
      avatarUrl: map['avatarUrl'] as String?,
    );
  }

  final String? uid;
  final String? username;
  final int? totalProfit;
  final int? totalLoss;
  final int? accountBalance;
  final int? totalBets;
  final int? totalBetsWon;
  final int? totalRewards;
  final int? totalBetsLost;
  final int? totalOpenBets;
  final int? totalRiskedAmount;
  final int? potentialWinAmount;
  final int? biggestWinAmount;
  final int? pendingRiskedAmount;
  final int? rank;
  final int? todayRewards;
  final String? avatarUrl;

  Map<String, Object?> toMap() => {
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
    String? uid,
    String? username,
    int? totalProfit,
    int? totalLoss,
    int? accountBalance,
    int? totalBets,
    int? totalBetsWon,
    int? totalRewards,
    int? totalBetsLost,
    int? totalOpenBets,
    int? potentialWinAmount,
    int? biggestWinAmount,
    int? totalRiskedAmount,
    int? pendingRiskedAmount,
    int? todayRewards,
    int? rank,
    String? avatarUrl,
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
  List<Object?> get props {
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
