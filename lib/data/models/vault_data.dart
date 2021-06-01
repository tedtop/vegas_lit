import 'package:cloud_firestore/cloud_firestore.dart';

class VaultItem {
  VaultItem({
    this.moneyIn,
    this.moneyOut,
    this.numberOfBets,
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
      numberOfBets: data['numberOfBets'],
      totalProfit: moneyIn - moneyOut,
      date: documentSnapshot.id,
    );
  }
  final int moneyIn;
  final int moneyOut;
  final int totalProfit;
  final int numberOfBets;
  final String date;

  Map<String, dynamic> toMap() {
    return {
      'moneyIn': moneyIn,
      'moneyOut': moneyOut,
      'totalProfit': totalProfit,
      'numberOfBets': numberOfBets,
    };
  }
}
