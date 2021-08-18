import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserData extends Equatable {
  const UserData({
    @required this.uid,
    @required this.username,
    @required this.email,
    @required this.location,
    this.isAdmin,
    this.avatarUrl,
  });

  factory UserData.fromFirestore(DocumentSnapshot documentSnapshot) {
    final Map data = documentSnapshot.data();
    return UserData(
        isAdmin: data['isAdmin'] ?? false,
        uid: data['uid'] as String,
        email: data['email'] as String,
        username: data['username'] as String,
        location: data['location'] as String,
        avatarUrl:
            data['avatarUrl'] != null ? data['avatarUrl'] as String : null);
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'location': location,
      'uid': uid,
      'isAdmin': false,
      'avatarUrl': avatarUrl
    };
  }

  final String uid;
  final String username;
  final String email;
  final String location;
  final bool isAdmin;
  final String avatarUrl;

  @override
  List<Object> get props =>
      [uid, username, email, location, isAdmin, avatarUrl];

  UserData copyWith({
    String uid,
    String username,
    String email,
    String location,
    bool isAdmin,
    String avatarUrl,
  }) {
    return UserData(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      location: location ?? this.location,
      isAdmin: isAdmin ?? this.isAdmin,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
