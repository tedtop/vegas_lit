import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class VaultItem extends Equatable {
  VaultItem({
    this.moneyIn,
    this.moneyOut,
    this.totalBets,
    this.totalProfit,
    this.date,
  });

  factory VaultItem.fromFirestore(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data();
    final moneyIn = data['moneyIn'] as int ?? 0;
    final moneyOut = data['moneyOut'] as int ?? 0;
    return VaultItem(
      moneyIn: moneyIn,
      moneyOut: moneyOut,
      totalBets: data['totalBets'],
      totalProfit: moneyIn - moneyOut,
      date: documentSnapshot.id,
    );
  }

  final int moneyIn;
  final int moneyOut;
  final int totalProfit;
  final int totalBets;
  final String date;

  @override
  List<Object> get props {
    return [
      moneyIn,
      moneyOut,
      totalProfit,
      totalBets,
      date,
    ];
  }
}
