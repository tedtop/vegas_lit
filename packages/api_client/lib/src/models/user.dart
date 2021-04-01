import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserData extends Equatable {
  const UserData({
    @required this.uid,
    @required this.username,
    @required this.email,
    @required this.phoneNumber,
    @required this.americanState,
    // @required this.name,
    // @required this.googlePhoto,
    // @required this.uploadPhoto,
    // @required this.age,
    // @required this.bio,
  })  : assert(uid != null),
        assert(email != null),
        // assert(uploadPhoto != null),
        assert(username != null);

  factory UserData.fromFirestore(DocumentSnapshot documentSnapshot) {
    final Map data = documentSnapshot.data();
    return UserData(
      uid: documentSnapshot.id,
      email: data['email'] as String,
      username: data['username'] as String,
      phoneNumber: data['number'] as String,
      americanState: data['state'] as String,
      // name: data['name'] as String,
      // googlePhoto: data['googlePhoto'] as String,
      // uploadPhoto: data['uploadPhoto'] as String,
      // age: data['age'] as int,
      // bio: data['bio'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'number': phoneNumber,
      'state': americanState,
      'id': uid,
    };
  }

  final String uid;
  final String username;
  final String email;
  final String phoneNumber;
  final String americanState;
  // final String googlePhoto;
  // final String uploadPhoto;
  // final int age;
  // final String username;
  // final String bio;

  @override
  List<Object> get props => [
        uid,
        username,
        email,
        phoneNumber,
        americanState,
        // name,
        // googlePhoto,
        // uploadPhoto,
        // age,
        // bio,
      ];
}
