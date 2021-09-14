import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../bet.dart';

class OlympicsBetData extends BetData {
  OlympicsBetData({
    @required this.betTeam,
    @required this.winner,
    @required gameStartDateTime,
    @required this.venue,
    @required this.event,
    @required this.eventType,
    @required this.matchCode,
    @required this.gameName,
    @required this.playerName,
    @required this.playerCountry,
    @required this.rivalName,
    @required this.rivalCountry,
    @required this.gameId,
    this.snapshot,
    this.reference,
    this.documentID,
    @required id,
    @required betAmount,
    @required betProfit,
    @required username,
    @required dataProvider,
    @required clientVersion,
    @required uid,
    @required dateTime,
    @required week,
    @required isClosed,
    @required league,
  }) : super(
          gameStartDateTime: gameStartDateTime,
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

  @override
  factory OlympicsBetData.fromFirestore(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final map = snapshot.data();
    return OlympicsBetData(
      id: map['id'] as String,
      betAmount: map['betAmount'] as int,
      betProfit: map['betProfit'] as int,
      uid: map['uid'] as String,
      username: map['username'] as String,
      dataProvider: map['dataProvider'] as String,
      clientVersion: map['clientVersion'] as String,
      dateTime: map['dateTime'] as String,
      week: map['week'] as String,
      isClosed: map['isClosed'] as bool,
      league: map['league'] as String,
      betTeam: map['betTeam'],
      winner: map['winner'],
      gameStartDateTime: map['gameStartDateTime'].toString(),
      venue: map['venue'],
      event: map['event'],
      eventType: map['eventType'],
      matchCode: map['matchCode'],
      gameName: map['gameName'],
      playerName: map['playerName'],
      playerCountry: map['playerCountry'],
      rivalName: map['rivalName'],
      rivalCountry: map['rivalCountry'],
      gameId: map['gameId'],
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'betAmount': betAmount,
        'betProfit': betProfit,
        'uid': uid,
        'username': username,
        'clientVersion': clientVersion,
        'dataProvider': dataProvider,
        'dateTime': dateTime,
        'week': week,
        'isClosed': isClosed,
        'league': league,
        'betTeam': betTeam,
        'winner': winner,
        'gameStartDateTime': gameStartDateTime.toString(),
        'venue': venue,
        'event': event,
        'eventType': eventType,
        'matchCode': matchCode,
        'gameName': gameName,
        'playerName': playerName,
        'playerCountry': playerCountry,
        'rivalName': rivalName,
        'rivalCountry': rivalCountry,
        'gameId': gameId,
      };

  final String betTeam;
  final String winner;
  final String venue;
  final String event;
  final String eventType;

  final String matchCode;
  final String gameName;
  final String playerName;
  final String playerCountry;
  final String rivalName;
  final String rivalCountry;
  final String gameId;
  final DocumentSnapshot snapshot;
  final DocumentReference reference;
  final String documentID;

  @override
  List<Object> get props => super.props
    ..addAll([
      betTeam,
      winner,
      gameStartDateTime,
      venue,
      event,
      eventType,
      matchCode,
      gameName,
      playerName,
      playerCountry,
      rivalName,
      rivalCountry,
      gameId,
      snapshot,
      reference,
      documentID,
    ]);
}
