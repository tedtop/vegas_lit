import 'package:cloud_firestore/cloud_firestore.dart';

class OlympicsGame {
  OlympicsGame({
    this.sport,
    this.date,
    this.player1,
    this.player1Country,
    this.player2,
    this.player2Country,
    this.winner,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory OlympicsGame.fromFirestore(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final map = snapshot.data();

    return OlympicsGame(
      sport: map['sport'],
      date: map['date']?.toDate(),
      player1: map['player1'],
      player1Country: map['player1Country'],
      player2: map['player2'],
      player2Country: map['player2Country'],
      winner: map['winner'],
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory OlympicsGame.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return OlympicsGame(
      sport: map['sport'],
      date: map['date']?.toDate(),
      player1: map['player1'],
      player1Country: map['player1Country'],
      player2: map['player2'],
      player2Country: map['player2Country'],
      winner: map['winner'],
    );
  }

  Map<String, dynamic> toMap() => {
        'sport': sport,
        'date': date,
        'player1': player1,
        'player1Country': player1Country,
        'player2': player2,
        'player2Country': player2Country,
        'winner': winner,
      };

  OlympicsGame copyWith({
    String sport,
    DateTime date,
    String player1,
    String player1Country,
    String player2,
    String player2Country,
    String winner,
  }) {
    return OlympicsGame(
      sport: sport ?? this.sport,
      date: date ?? this.date,
      player1: player1 ?? this.player1,
      player1Country: player1Country ?? this.player1Country,
      player2: player2 ?? this.player2,
      player2Country: player2Country ?? this.player2Country,
      winner: winner ?? this.winner,
    );
  }

  final String sport;
  final DateTime date;
  final String player1;
  final String player1Country;
  final String player2;
  final String player2Country;
  final String winner;
  final DocumentSnapshot snapshot;
  final DocumentReference reference;
  final String documentID;

  @override
  String toString() {
    return '${sport.toString()}, ${date.toString()}, ${player1.toString()}, ${player1Country.toString()}, ${player2.toString()}, ${player2Country.toString()}, ${winner.toString()}, ';
  }
}
