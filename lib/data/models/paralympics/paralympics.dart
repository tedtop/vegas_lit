import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ParalympicsGame extends Equatable {
  const ParalympicsGame({
    this.startTime,
    this.event,
    this.gameName,
    this.eventType,
    this.player,
    this.playerCountry,
    this.rival,
    this.rivalCountry,
    this.winner,
    this.gameId,
    this.isClosed,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory ParalympicsGame.fromFirestore(DocumentSnapshot snapshot) {
    final map = snapshot.data() as Map;

    return ParalympicsGame(
      startTime: map['startTime'] == null
          ? null
          : DateTime.parse(
              map['startTime'] as String,
            ),
      event: map['event'] as String?,
      gameName: map['gameName'] as String?,
      eventType: map['eventType'] as String?,
      player: map['player'] as String?,
      playerCountry: map['playerCountry'] as String?,
      rival: map['rival'] as String?,
      rivalCountry: map['rivalCountry'] as String?,
      winner: map['winner'] as String?,
      gameId: map['gameId'] as String?,
      isClosed: map['isClosed'] as bool?,
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory ParalympicsGame.fromMap(Map<String, dynamic> map) {
    return ParalympicsGame(
      startTime: map['startTime'] == null
          ? null
          : DateTime.parse(
              map['startTime'] as String,
            ),
      event: map['event'] as String?,
      gameName: map['gameName'] as String?,
      eventType: map['eventType'] as String?,
      player: map['player'] as String?,
      playerCountry: map['playerCountry'] as String?,
      rival: map['rival'] as String?,
      rivalCountry: map['rivalCountry'] as String?,
      winner: map['winner'] as String?,
      gameId: map['gameId'] as String?,
      isClosed: map['isClosed'] as bool?,
    );
  }

  final DateTime? startTime;
  final String? event;
  final String? gameName;
  final String? eventType;
  final String? player;
  final String? playerCountry;
  final String? rival;
  final String? rivalCountry;
  final String? winner;
  final String? gameId;
  final bool? isClosed;
  final DocumentSnapshot? snapshot;
  final DocumentReference? reference;
  final String? documentID;

  Map<String, Object?> toMap() => {
        'startTime': startTime.toString(),
        'event': event,
        'gameName': gameName,
        'eventType': eventType,
        'player': player,
        'playerCountry': playerCountry,
        'rival': rival,
        'rivalCountry': rivalCountry,
        'winner': winner,
        'gameId': gameId,
        'isClosed': isClosed,
      };

  ParalympicsGame copyWith({
    DateTime? startTime,
    String? event,
    String? gameName,
    String? eventType,
    String? player,
    String? playerCountry,
    String? rival,
    String? rivalCountry,
    String? winner,
    String? gameId,
    bool? isClosed,
  }) {
    return ParalympicsGame(
      startTime: startTime ?? this.startTime,
      event: event ?? this.event,
      gameName: gameName ?? this.gameName,
      eventType: eventType ?? this.eventType,
      player: player ?? this.player,
      playerCountry: playerCountry ?? this.playerCountry,
      rival: rival ?? this.rival,
      rivalCountry: rivalCountry ?? this.rivalCountry,
      winner: winner ?? this.winner,
      gameId: gameId ?? this.gameId,
      isClosed: isClosed ?? this.isClosed,
    );
  }

  @override
  List<Object?> get props {
    return [
      startTime,
      event,
      gameName,
      eventType,
      player,
      playerCountry,
      rival,
      rivalCountry,
      winner,
      gameId,
      isClosed,
      snapshot,
      reference,
      documentID,
    ];
  }
}
