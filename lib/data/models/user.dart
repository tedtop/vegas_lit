import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  const UserData({
    required this.uid,
    required this.username,
    required this.email,
    required this.location,
    required this.groups,
    this.isAdmin,
    this.avatarUrl,
  });

  factory UserData.fromFirestore(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map;
    return UserData(
        groups: data['groups'] != null ? data['groups'] as List? : <String>[],
        isAdmin: data['isAdmin'] as bool? ?? false,
        uid: data['uid'] as String?,
        email: data['email'] as String?,
        username: data['username'] as String?,
        location: data['location'] as String?,
        avatarUrl:
            data['avatarUrl'] != null ? data['avatarUrl'] as String? : null);
  }

  Map<String, Object?> toMap() {
    return {
      'email': email,
      'username': username,
      'location': location,
      'uid': uid,
      'groups': groups,
      'isAdmin': false,
      'avatarUrl': avatarUrl
    };
  }

  final String? uid;
  final String? username;
  final String? email;
  final String? location;
  final bool? isAdmin;
  final List? groups;
  final String? avatarUrl;

  @override
  List<Object?> get props =>
      [uid, username, email, location, isAdmin, avatarUrl, groups];

  UserData copyWith({
    String? uid,
    List? groups,
    String? username,
    String? email,
    String? location,
    bool? isAdmin,
    String? avatarUrl,
  }) {
    return UserData(
      groups: groups ?? this.groups,
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      location: location ?? this.location,
      isAdmin: isAdmin ?? this.isAdmin,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
