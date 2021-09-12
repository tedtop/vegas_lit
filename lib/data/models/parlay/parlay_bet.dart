import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../bet.dart';

class ParlayBets extends BetData {
  ParlayBets({
    @required id,
    @required uid,
    @required betAmount,
    @required betProfit,
    @required username,
    @required clientVersion,
    @required dataProvider,
    @required dateTime,
    @required week,
    @required isClosed,
    @required league,
    @required this.bets,
    this.snapshot,
    this.reference,
    this.documentID,
  }) : super(
          id: id,
          betAmount: betAmount,
          betProfit: betProfit,
          username: username,
          dataProvider: dataProvider,
          clientVersion: clientVersion,
          uid: uid,
          dateTime: dateTime,
          week: week,
          isClosed: isClosed,
          league: league,
        );

  factory ParlayBets.fromFirestore(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final map = snapshot.data();

    return ParlayBets(
      bets: map['bets'] != null ? List<BetData>.from(map['bets']) : null,
      id: map['id'],
      uid: map['uid'],
      betAmount: map['betAmount'],
      betProfit: map['betProfit'],
      username: map['username'],
      clientVersion: map['clientVersion'],
      dataProvider: map['dataProvider'],
      dateTime: map['dateTime'],
      week: map['week'],
      isClosed: map['isClosed'],
      league: map['league'],
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory ParlayBets.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ParlayBets(
      bets: map['bets'] != null ? List<BetData>.from(map['bets']) : null,
      id: map['id'],
      uid: map['uid'],
      betAmount: map['betAmount'],
      betProfit: map['betProfit'],
      username: map['username'],
      clientVersion: map['clientVersion'],
      dataProvider: map['dataProvider'],
      dateTime: map['dateTime'],
      week: map['week'],
      isClosed: map['isClosed'],
      league: map['league'],
    );
  }

  @override
  Map<String, dynamic> toMap() => {
        'bets': bets.map((e) => e.toMap()).toList(),
        'id': id,
        'uid': uid,
        'betAmount': betAmount,
        'betProfit': betProfit,
        'username': username,
        'clientVersion': clientVersion,
        'dataProvider': dataProvider,
        'dateTime': dateTime,
        'week': week,
        'isClosed': isClosed,
        'league': league,
      };

  ParlayBets copyWith({
    List<BetData> bets,
    String id,
    String uid,
    int betAmount,
    int betProfit,
    String username,
    String clientVersion,
    String dataProvider,
    String dateTime,
    String week,
    bool isClosed,
    String league,
  }) {
    return ParlayBets(
      bets: bets ?? this.bets,
      id: id ?? this.id,
      uid: uid ?? this.uid,
      betAmount: betAmount ?? this.betAmount,
      betProfit: betProfit ?? this.betProfit,
      username: username ?? this.username,
      clientVersion: clientVersion ?? this.clientVersion,
      dataProvider: dataProvider ?? this.dataProvider,
      dateTime: dateTime ?? this.dateTime,
      week: week ?? this.week,
      isClosed: isClosed ?? this.isClosed,
      league: league ?? this.league,
    );
  }

  final List<BetData> bets;

  final DocumentSnapshot snapshot;
  final DocumentReference reference;
  final String documentID;
}
