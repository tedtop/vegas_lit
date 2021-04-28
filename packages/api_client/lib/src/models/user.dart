import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserData extends Equatable {
  const UserData({
    @required this.uid,
    @required this.username,
    @required this.email,
    @required this.phone,
    @required this.location,
    @required this.rank,
    @required this.profit,
    @required this.accountBalance,
    @required this.numberBets,
    @required this.correctBets,
    @required this.openBets,
    @required this.potentialWinnings,
    @required this.biggestWin,
    @required this.lastWeeksRank,
  });

  factory UserData.fromFirestore(DocumentSnapshot documentSnapshot) {
    final Map data = documentSnapshot.data();
    return UserData(
      uid: data['uid'] as String,
      email: data['email'] as String,
      username: data['username'] as String,
      phone: data['phone'] as int,
      location: data['location'] as String,
      accountBalance: data['accountBalance'] as int,
      biggestWin: data['biggestWin'] as int,
      openBets: data['openBets'] as int,
      lastWeeksRank: data['lastWeeksRank'] as int,
      correctBets: data['correctBets'] as int,
      numberBets: data['numberBets'] as int,
      potentialWinnings: data['potentialWinnings'] as int,
      profit: data['profit'] as int,
      rank: data['rank'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'phone': phone,
      'location': location,
      'uid': uid,
      'accountBalance': accountBalance,
      'biggestWin': biggestWin,
      'openBets': openBets,
      'lastWeeksRank': lastWeeksRank,
      'correctBets': correctBets,
      'numberBets': numberBets,
      'potentialWinnings': potentialWinnings,
      'profit': profit,
      'rank': rank,
    };
  }

  final String uid;
  final String username;
  final String email;
  final int phone;
  final String location;
  final int rank;
  final int profit;
  final int accountBalance;
  final int numberBets;
  final int correctBets;
  final int openBets;
  final int potentialWinnings;
  final int biggestWin;
  final int lastWeeksRank;

  @override
  List<Object> get props {
    return [
      uid,
      username,
      email,
      phone,
      location,
      rank,
      profit,
      accountBalance,
      numberBets,
      correctBets,
      openBets,
      potentialWinnings,
      biggestWin,
      lastWeeksRank,
    ];
  }
}
