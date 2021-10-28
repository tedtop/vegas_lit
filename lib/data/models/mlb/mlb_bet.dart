import 'package:cloud_firestore/cloud_firestore.dart';

import '../bet.dart';

class MlbBetData extends BetData {
  const MlbBetData({
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
    required this.betType,
    required this.status,
    required this.stillOpen,
    required this.odds,
    required this.betTeam,
    required this.winningTeamName,
    required this.winningTeam,
    required this.betPointSpread,
    required this.betOverUnder,
    required this.homeTeam,
    required this.awayTeam,
    required this.awayTeamScore,
    required this.homeTeamCity,
    required this.awayTeamCity,
    required this.homeTeamScore,
    required this.totalGameScore,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.gameId,
  }) : super(
          id: id,
          betAmount: betAmount,
          betProfit: betProfit,
          gameStartDateTime: gameStartDateTime,
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
  factory MlbBetData.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;
    return MlbBetData(
      id: data['id'] as String?,
      winningTeam: data['winningTeam'] as String?,
      betAmount: data['betAmount'] as int?,
      betProfit: data['betProfit'] as int?,
      uid: data['uid'] as String?,
      stillOpen: data['stillOpen'] as bool?,
      betType: data['betType'] as String?,
      awayTeamCity: data['awayTeamCity'] as String?,
      homeTeamCity: data['homeTeamCity'] as String?,
      homeTeam: data['homeTeam'] as String?,
      awayTeam: data['awayTeam'] as String?,
      betTeam: data['betTeam'] as String?,
      winningTeamName: data['winningTeamName'] as String?,
      username: data['username'] as String?,
      dataProvider: data['dataProvider'] as String?,
      clientVersion: data['clientVersion'] as String?,
      betPointSpread: double.tryParse(data['betPointSpread'].toString()),
      betOverUnder: double.tryParse(data['betOverUnder'].toString()),
      awayTeamScore: data['awayTeamScore'] as int?,
      homeTeamScore: data['homeTeamScore'] as int?,
      totalGameScore: data['totalGameScore'] as int?,
      homeTeamName: data['homeTeamName'] as String?,
      awayTeamName: data['awayTeamName'] as String?,
      gameStartDateTime: data['gameStartDateTime'] as String?,
      dateTime: data['dateTime'] as String?,
      week: data['week'] as String?,
      status: data['status'] as String?,
      gameId: data['gameId'] as int?,
      isClosed: data['isClosed'] as bool?,
      league: data['league'] as String?,
      odds: data['odds'] as int?,
    );
  }

  factory MlbBetData.fromMap(Map data) {
    return MlbBetData(
      id: data['id'] as String?,
      winningTeam: data['winningTeam'] as String?,
      betAmount: data['betAmount'] as int?,
      betProfit: data['betProfit'] as int?,
      uid: data['uid'] as String?,
      stillOpen: data['stillOpen'] as bool?,
      betType: data['betType'] as String?,
      awayTeamCity: data['awayTeamCity'] as String?,
      homeTeamCity: data['homeTeamCity'] as String?,
      homeTeam: data['homeTeam'] as String?,
      awayTeam: data['awayTeam'] as String?,
      betTeam: data['betTeam'] as String?,
      winningTeamName: data['winningTeamName'] as String?,
      username: data['username'] as String?,
      dataProvider: data['dataProvider'] as String?,
      clientVersion: data['clientVersion'] as String?,
      betPointSpread: double.tryParse(data['betPointSpread'].toString()),
      betOverUnder: double.tryParse(data['betOverUnder'].toString()),
      awayTeamScore: data['awayTeamScore'] as int?,
      homeTeamScore: data['homeTeamScore'] as int?,
      totalGameScore: data['totalGameScore'] as int?,
      homeTeamName: data['homeTeamName'] as String?,
      awayTeamName: data['awayTeamName'] as String?,
      gameStartDateTime: data['gameStartDateTime'] as String?,
      dateTime: data['dateTime'] as String?,
      week: data['week'] as String?,
      status: data['status'] as String?,
      gameId: data['gameId'] as int?,
      isClosed: data['isClosed'] as bool?,
      league: data['league'] as String?,
      odds: data['odds'] as int?,
    );
  }

  final String? betTeam;
  final String? winningTeamName;
  final double? betPointSpread;
  final double? betOverUnder;
  final int? awayTeamScore;
  final int? homeTeamScore;
  final int? totalGameScore;
  final String? homeTeamCity;
  final String? awayTeamCity;
  final String? homeTeamName;
  final String? homeTeam;
  final String? awayTeamName;
  final String? awayTeam;
  final int? gameId;
  final String? betType;
  final bool? stillOpen;
  final String? status;
  final int? odds;
  final String? winningTeam;

  @override
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'betAmount': betAmount,
      'betProfit': betProfit,
      'betType': betType,
      'betTeam': betTeam,
      'uid': uid,
      'winningTeamName': winningTeamName,
      'betPointSpread': betPointSpread,
      'betOverUnder': betOverUnder,
      'awayTeamScore': awayTeamScore,
      'homeTeamScore': homeTeamScore,
      'username': username,
      'homeTeamCity': homeTeamCity,
      'awayTeamCity': awayTeamCity,
      'clientVersion': clientVersion,
      'stillOpen': stillOpen,
      'dataProvider': dataProvider,
      'status': status,
      'totalGameScore': totalGameScore,
      'winningTeam': winningTeam,
      'homeTeamName': homeTeamName,
      'awayTeamName': awayTeamName,
      'gameStartDateTime': gameStartDateTime,
      'dateTime': dateTime,
      'week': week,
      'homeTeam': homeTeam,
      'awayTeam': awayTeam,
      'gameId': gameId,
      'isClosed': isClosed,
      'league': league,
      'odds': odds
    };
  }

  @override
  List<Object?> get props {
    return super.props
      ..addAll([
        betTeam,
        winningTeamName,
        betPointSpread,
        betOverUnder,
        winningTeam,
        betType,
        stillOpen,
        gameStartDateTime,
        status,
        odds,
        homeTeam,
        awayTeam,
        awayTeamScore,
        homeTeamScore,
        totalGameScore,
        homeTeamName,
        awayTeamName,
        gameId,
        homeTeamCity,
        awayTeamCity,
      ]);
  }
}
