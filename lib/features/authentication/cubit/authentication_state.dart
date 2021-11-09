part of 'authentication_cubit.dart';

enum AuthenticationStatus { initial, loading, success, failure }

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.initial,
    this.user,
  });

  const AuthenticationState.initial() : this._();

  const AuthenticationState.loading()
      : this._(
          status: AuthenticationStatus.loading,
        );

  const AuthenticationState.success(
    User? user,
  ) : this._(
          status: AuthenticationStatus.success,
          user: user,
        );

  const AuthenticationState.failure()
      : this._(
          status: AuthenticationStatus.failure,
        );

  final User? user;
  final AuthenticationStatus status;

  @override
  List<Object?> get props => [user, status];
}
