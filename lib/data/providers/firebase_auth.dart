import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class FirebaseAuthentication {
  FirebaseAuthentication({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  Stream<User> get getUser {
    return _firebaseAuth.authStateChanges().map(
      (firebaseUser) {
        return firebaseUser ?? firebaseUser;
      },
    );
  }

  Future<User> get getCurrentUser async {
    return _firebaseAuth.currentUser;
  }

  Future<void> signUp({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!credential.user.emailVerified) {
        await credential.user.sendEmailVerification();
      }
    } on FirebaseAuthException catch (error) {
      String errorMessage;
      switch (error.code) {
        case 'ERROR_EMAIL_ALREADY_IN_USE':
        case 'account-exists-with-different-credential':
        case 'email-already-in-use':
          errorMessage = 'An account with this email already exists.';
          break;
        case 'ERROR_WRONG_PASSWORD':
        case 'wrong-password':
          errorMessage = 'Wrong password. Try resetting it.';
          break;
        case 'ERROR_USER_NOT_FOUND':
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'ERROR_USER_DISABLED':
        case 'user-disabled':
          errorMessage = 'User disabled.';
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
        case 'operation-not-allowed':
          errorMessage = 'Wrong password. Try resetting it.';
          break;
        case 'ERROR_INVALID_EMAIL':
        case 'invalid-email':
          errorMessage = 'Email address is invalid.';
          break;
        default:
          errorMessage = 'Signup failed. Try again later.';
          break;
      }
      throw SignUpFailure(
        errorMessage: errorMessage,
      );
    }
  }

  Future<void> sendEmailVerification({@required User user}) async {
    await user.sendEmailVerification();
  }

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
    } on FirebaseAuthException catch (error) {
      String errorMessage;
      switch (error.code) {
        case 'ERROR_EMAIL_ALREADY_IN_USE':
        case 'account-exists-with-different-credential':
        case 'email-already-in-use':
          errorMessage = 'An account with this email already exists.';
          break;
        case 'ERROR_WRONG_PASSWORD':
        case 'wrong-password':
          errorMessage = 'Wrong password. Try resetting it.';
          break;
        case 'ERROR_USER_NOT_FOUND':
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'ERROR_USER_DISABLED':
        case 'user-disabled':
          errorMessage = 'User disabled.';
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
        case 'operation-not-allowed':
          errorMessage = 'Too many login attempts. Try again later.';
          break;
        case 'ERROR_INVALID_EMAIL':
        case 'invalid-email':
          errorMessage = 'Email address is invalid.';
          break;
        default:
          errorMessage = 'Login failed. Try again later.';
          break;
      }
      throw LogInWithEmailAndPasswordFailure(
        errorMessage: errorMessage,
      );
    }
  }

  Future<void> resetPasswordEmail({
    @required String email,
  }) async {
    final signInList = await _firebaseAuth.fetchSignInMethodsForEmail(email);
    if (signInList.isEmpty) {
      throw ResetPasswordEmailNotExists();
    } else {
      try {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } on Exception {
        throw ResetPasswordEmailFailure();
      }
    }
  }

  Future<void> signOutUser() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }
}

class LogOutFailure implements Exception {}

class SignUpFailure implements Exception {
  SignUpFailure({@required this.errorMessage});
  final String errorMessage;
}

class ResetPasswordEmailNotExists implements Exception {}

class ResetPasswordEmailFailure implements Exception {}

class LogInWithEmailAndPasswordFailure implements Exception {
  LogInWithEmailAndPasswordFailure({@required this.errorMessage});
  final String errorMessage;
}
