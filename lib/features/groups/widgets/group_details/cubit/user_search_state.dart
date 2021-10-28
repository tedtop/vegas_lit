

part of 'user_search_cubit.dart';

enum UserSearchStatus {
  initial,
  loading,
  success,
  failure,
}

class UserSearchState extends Equatable {
  const UserSearchState({
    this.status = UserSearchStatus.initial,
    this.users = const [],
  });

  final UserSearchStatus status;
  final List<UserData> users;

  @override
  List<Object> get props => [status, users];
}
