import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import '../bet.dart';

class ParalympicsBetData extends BetData {
  ParalympicsBetData({
    @required String id,
    @required int betAmount,
    @required int betProfit,
    @required String username,
    @required String dataProvider,
    @required String clientVersion,
    @required String uid,
    @required String dateTime,
    @required String week,
    @required bool isClosed,
    @required String league,
    @required String gameStartDateTime,
    @required this.betTeam,
    @required this.winner,
    @required this.event,
    @required this.eventType,
    @required this.gameName,
    @required this.playerName,
    @required this.playerCountry,
    @required this.rivalName,
    @required this.rivalCountry,
    @required this.gameId,
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
          gameStartDateTime: gameStartDateTime,
          isClosed: isClosed,
          league: league,
        );

  @override
  factory ParalympicsBetData.fromFirestore(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final map = snapshot.data() as Map;
    return ParalympicsBetData(
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
      event: map['event'],
      eventType: map['eventType'],
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
  Map<String, Object> toMap() => {
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
        'gameStartDateTime': gameStartDateTime,
        'event': event,
        'eventType': eventType,
        'gameName': gameName,
        'playerName': playerName,
        'playerCountry': playerCountry,
        'rivalName': rivalName,
        'rivalCountry': rivalCountry,
        'gameId': gameId,
      };

  final String betTeam;
  final String winner;
  final String event;
  final String eventType;
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
      event,
      eventType,
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
