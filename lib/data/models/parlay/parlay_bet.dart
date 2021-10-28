import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:vegas_lit/data/models/mlb/mlb_bet.dart';
import 'package:vegas_lit/data/models/nba/nba_bet.dart';
import 'package:vegas_lit/data/models/ncaab/ncaab_bet.dart';
import 'package:vegas_lit/data/models/ncaaf/ncaaf_bet.dart';
import 'package:vegas_lit/data/models/nfl/nfl_bet.dart';
import 'package:vegas_lit/data/models/nhl/nhl_bet.dart';

import '../bet.dart';

class ParlayBets extends BetData {
  const ParlayBets({
    required String? id,
    required int? betAmount,
    required int? betProfit,
    required String? username,
    required String? dataProvider,
    required String? clientVersion,
    required String? uid,
    required String? dateTime,
    required String? week,
    required bool? isClosed,
    required String? league,
    required String? gameStartDateTime,
    required this.bets,
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
          gameStartDateTime: gameStartDateTime,
          dateTime: dateTime,
          week: week,
          isClosed: isClosed,
          league: league,
        );

  factory ParlayBets.fromFirestore(DocumentSnapshot snapshot) {
    final map = snapshot.data() as Map<String, dynamic>;

    return ParlayBets(
      bets: map['bets'] != null
          ? List<BetData>.from(
              map['bets'].map(
                (dynamic betValue) {
                  final bet = Map<String, dynamic>.from(
                      betValue as Map<dynamic, dynamic>);
                  switch (bet['league'] as String?) {
                    case 'mlb':
                      return MlbBetData.fromMap(bet);

                    case 'nba':
                      return NbaBetData.fromMap(bet);

                    case 'cbb':
                      return NcaabBetData.fromMap(bet);

                    case 'cfb':
                      return NcaafBetData.fromMap(bet);

                    case 'nfl':
                      return NflBetData.fromMap(bet);

                    case 'nhl':
                      return NhlBetData.fromMap(bet);
                  }
                },
              ) as Iterable<dynamic>,
            )
          : null,
      id: map['id'] as String?,
      gameStartDateTime: map['gameStartDateTime'] as String?,
      uid: map['uid'] as String?,
      betAmount: map['betAmount'] as int?,
      betProfit: map['betProfit'] as int?,
      username: map['username'] as String?,
      clientVersion: map['clientVersion'] as String?,
      dataProvider: map['dataProvider'] as String?,
      dateTime: map['dateTime'] as String?,
      week: map['week'] as String?,
      isClosed: map['isClosed'] as bool?,
      league: map['league'] as String?,
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory ParlayBets.fromMap(Map<String, dynamic> map) {
    return ParlayBets(
      bets: map['bets'] != null
          ? List<BetData>.from(
              map['bets'] as Iterable<dynamic>,
            )
          : null,
      id: map['id'] as String?,
      gameStartDateTime: map['gameStartDateTime'] as String?,
      uid: map['uid'] as String?,
      betAmount: map['betAmount'] as int?,
      betProfit: map['betProfit'] as int?,
      username: map['username'] as String?,
      clientVersion: map['clientVersion'] as String?,
      dataProvider: map['dataProvider'] as String?,
      dateTime: map['dateTime'] as String?,
      week: map['week'] as String?,
      isClosed: map['isClosed'] as bool?,
      league: map['league'] as String?,
    );
  }

  final List<BetData>? bets;

  final DocumentSnapshot? snapshot;
  final DocumentReference? reference;
  final String? documentID;

  @override
  Map<String, Object?> toMap() => {
        'bets': bets!.map((e) => e.toMap()).toList(),
        'id': id,
        'uid': uid,
        'betAmount': betAmount,
        'betProfit': betProfit,
        'username': username,
        'gameStartDateTime': gameStartDateTime,
        'clientVersion': clientVersion,
        'dataProvider': dataProvider,
        'dateTime': dateTime,
        'week': week,
        'isClosed': isClosed,
        'league': league,
      };

  ParlayBets copyWith({
    List<BetData>? bets,
    String? id,
    String? uid,
    int? betAmount,
    int? betProfit,
    String? username,
    String? gameStartDateTime,
    String? clientVersion,
    String? dataProvider,
    String? dateTime,
    String? week,
    bool? isClosed,
    String? league,
  }) {
    return ParlayBets(
      bets: bets ?? this.bets,
      gameStartDateTime: gameStartDateTime ?? this.gameStartDateTime,
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
}
