import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class OpenBetsData extends Equatable {
  OpenBetsData({
    @required this.amount,
    @required this.away,
    @required this.home,
    @required this.dateTime,
    @required this.id,
    @required this.type,
    @required this.mlAmount,
    @required this.win,
  });

  final int amount;
  final String away;
  final String home;
  final String id;
  final String type;
  final int win;
  final DateTime dateTime;
  final int mlAmount;

  factory OpenBetsData.fromFirestore(DocumentSnapshot documentSnapshot) {
    final Map data = documentSnapshot.data();
    return OpenBetsData(
      id: documentSnapshot.id,
      amount: data['amount'] as int,
      away: data['away'] as String,
      home: data['home'] as String,
      type: data['type'] as String,
      win: data['win'] as int,
      dateTime: data['date'] as DateTime,
      mlAmount: data['ml_amount'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'away': away,
      'home': home,
      'id': id,
      'type': type,
      'dateTime': dateTime,
      'win': win,
      'mlAmount': mlAmount,
    };
  }

  @override
  List<Object> get props {
    return [
      amount,
      away,
      home,
      id,
      type,
      mlAmount,
      dateTime,
      win,
    ];
  }
}
