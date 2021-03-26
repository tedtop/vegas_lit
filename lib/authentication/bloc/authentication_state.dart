part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  halfauthenticated,
  splashscreen,
}

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.splashscreen,
    this.user,
    this.userData,
  });

  const AuthenticationState.splashscreen() : this._();

  const AuthenticationState.authenticated(
    // UserData userData,
    User user,
  ) : this._(
          status: AuthenticationStatus.authenticated,
          user: user,
        );

  const AuthenticationState.halfauthenticated(User user)
      : this._(
          status: AuthenticationStatus.halfauthenticated,
          user: user,
        );

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final User user;
  final UserData userData;
  final AuthenticationStatus status;

  @override
  List<Object> get props => [user, userData, status];
}
