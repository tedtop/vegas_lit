import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class BetData extends Equatable {
  const BetData({
    required this.id,
    required this.betAmount,
    required this.betProfit,
    required this.gameStartDateTime,
    required this.username,
    required this.dataProvider,
    required this.clientVersion,
    required this.uid,
    required this.dateTime,
    required this.week,
    required this.isClosed,
    required this.league,
  });

  factory BetData.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;
    return BetData(
      id: data['id'] as String?,
      gameStartDateTime: data['gameStartDateTime'] as String?,
      betAmount: data['betAmount'] as int?,
      betProfit: data['betProfit'] as int?,
      uid: data['uid'] as String?,
      username: data['username'] as String?,
      dataProvider: data['dataProvider'] as String?,
      clientVersion: data['clientVersion'] as String?,
      dateTime: data['dateTime'] as String?,
      week: data['week'] as String?,
      isClosed: data['isClosed'] as bool?,
      league: data['league'] as String?,
    );
  }

  final String? id;
  final String? uid;
  final int? betAmount;
  final int? betProfit;
  final String? username;
  final String? clientVersion;
  final String? dataProvider;
  final String? dateTime;
  final String? gameStartDateTime;
  final String? week;
  final bool? isClosed;
  final String? league;

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'betAmount': betAmount,
      'betProfit': betProfit,
      'gameStartDateTime': gameStartDateTime,
      'uid': uid,
      'username': username,
      'clientVersion': clientVersion,
      'dataProvider': dataProvider,
      'dateTime': dateTime,
      'week': week,
      'isClosed': isClosed,
      'league': league,
    };
  }

  @override
  List<Object?> get props {
    return [
      id,
      betAmount,
      gameStartDateTime,
      uid,
      betProfit,
      username,
      clientVersion,
      dataProvider,
      dateTime,
      week,
      isClosed,
      league,
    ];
  }
}
