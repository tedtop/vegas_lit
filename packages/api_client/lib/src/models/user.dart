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
    @required this.profit,
    @required this.accountBalance,
    @required this.numberBets,
    @required this.correctBets,
    @required this.openBets,
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
      openBets: data['openBets'] as int,
      correctBets: data['correctBets'] as int,
      numberBets: data['numberBets'] as int,
      profit: data['profit'] as int,
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
      'openBets': openBets,
      'correctBets': correctBets,
      'numberBets': numberBets,
      'profit': profit,
    };
  }

  final String uid;
  final String username;
  final String email;
  final int phone;
  final String location;
  final int profit;
  final int accountBalance;
  final int numberBets;
  final int correctBets;
  final int openBets;
  // int potentialWinnings;
  // int lastWeeksRank
  // int rank
  // double biggestWin

  @override
  List<Object> get props {
    return [
      uid,
      username,
      email,
      phone,
      location,
      profit,
      accountBalance,
      numberBets,
      correctBets,
      openBets,
    ];
  }
}
