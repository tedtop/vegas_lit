import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import '../base_provider.dart';

class FirebaseAuthentication extends AuthenticationProvider {
  FirebaseAuthentication({
    FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  @override
  Stream<User> get getUser {
    return _firebaseAuth.authStateChanges().map(
      (firebaseUser) {
        return firebaseUser ?? firebaseUser;
      },
    );
  }

  @override
  Future<User> get getCurrentUser async {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<void> signUp({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw SignUpFailure();
    }
  }

  @override
  Future<void> logInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> resetPasswordEmail({
    @required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on Exception {
      throw ResetPasswordEmailFailure();
    }
  }

  @override
  Future<void> signOutUser() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }
}

class LogOutFailure implements Exception {}

class SignUpFailure implements Exception {}

class ResetPasswordEmailFailure implements Exception {}

class LogInWithEmailAndPasswordFailure implements Exception {}
