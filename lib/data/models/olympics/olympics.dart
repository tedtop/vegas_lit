import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class OlympicsGame extends Equatable {
  OlympicsGame({
    this.startTime,
    this.venue,
    this.event,
    this.gameName,
    this.eventType,
    this.sessionNo,
    this.sessionTime,
    this.matchCode,
    this.player,
    this.playerCountry,
    this.rival,
    this.rivalCountry,
    this.gameId,
    this.isClosed,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory OlympicsGame.fromFirestore(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final map = snapshot.data();

    return OlympicsGame(
      startTime:
          map['startTime'] == null ? null : DateTime.parse(map['startTime']),
      venue: map['venue'],
      event: map['event'],
      gameName: map['gameName'],
      eventType: map['eventType'],
      sessionNo: map['sessionNo'],
      sessionTime: map['sessionTime'],
      matchCode: map['matchCode'],
      player: map['player'],
      playerCountry: map['playerCountry'],
      rival: map['rival'],
      rivalCountry: map['rivalCountry'],
      gameId: map['gameId'],
      isClosed: map['isClosed'],
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory OlympicsGame.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return OlympicsGame(
      startTime: map['startTime'],
      venue: map['venue'],
      event: map['event'],
      gameName: map['gameName'],
      eventType: map['eventType'],
      sessionNo: map['sessionNo'],
      sessionTime: map['sessionTime'],
      matchCode: map['matchCode'],
      player: map['player'],
      playerCountry: map['playerCountry'],
      rival: map['rival'],
      rivalCountry: map['rivalCountry'],
      gameId: map['gameId'],
      isClosed: map['isClosed'],
    );
  }

  Map<String, dynamic> toMap() => {
        'startTime': startTime,
        'venue': venue,
        'event': event,
        'gameName': gameName,
        'eventType': eventType,
        'sessionNo': sessionNo,
        'sessionTime': sessionTime,
        'matchCode': matchCode,
        'player': player,
        'playerCountry': playerCountry,
        'rival': rival,
        'rivalCountry': rivalCountry,
        'gameId': gameId,
        'isClosed': isClosed,
      };

  final DateTime startTime;
  final String venue;
  final String event;
  final String gameName;
  final String eventType;
  final int sessionNo;
  final String sessionTime;
  final String matchCode;
  final String player;
  final String playerCountry;
  final String rival;
  final String rivalCountry;
  final String gameId;
  final bool isClosed;
  final DocumentSnapshot snapshot;
  final DocumentReference reference;
  final String documentID;

  OlympicsGame copyWith({
    DateTime startTime,
    String venue,
    String event,
    String gameName,
    String eventType,
    int sessionNo,
    String sessionTime,
    String matchCode,
    String player,
    String playerCountry,
    String rival,
    String rivalCountry,
    String gameId,
    bool isClosed,
  }) {
    return OlympicsGame(
      startTime: startTime ?? this.startTime,
      venue: venue ?? this.venue,
      event: event ?? this.event,
      gameName: gameName ?? this.gameName,
      eventType: eventType ?? this.eventType,
      sessionNo: sessionNo ?? this.sessionNo,
      sessionTime: sessionTime ?? this.sessionTime,
      matchCode: matchCode ?? this.matchCode,
      player: player ?? this.player,
      playerCountry: playerCountry ?? this.playerCountry,
      rival: rival ?? this.rival,
      rivalCountry: rivalCountry ?? this.rivalCountry,
      gameId: gameId ?? this.gameId,
      isClosed: isClosed ?? this.isClosed,
    );
  }

  @override
  List<Object> get props {
    return [
      startTime,
      venue,
      event,
      gameName,
      eventType,
      sessionNo,
      sessionTime,
      matchCode,
      player,
      playerCountry,
      rival,
      rivalCountry,
      gameId,
      isClosed,
      snapshot,
      reference,
      documentID,
    ];
  }
}
