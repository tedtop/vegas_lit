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
  });

  factory UserData.fromFirestore(DocumentSnapshot documentSnapshot) {
    final Map data = documentSnapshot.data();
    return UserData(
      uid: data['uid'] as String,
      email: data['email'] as String,
      username: data['username'] as String,
      phone: data['phone'] as int,
      location: data['location'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'phone': phone,
      'location': location,
      'uid': uid,
    };
  }

  final String uid;
  final String username;
  final String email;
  final int phone;
  final String location;

  @override
  List<Object> get props {
    return [
      uid,
      username,
      email,
      phone,
      location,
    ];
  }
}
