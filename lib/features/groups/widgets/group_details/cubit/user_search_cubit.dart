import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../data/models/user.dart';
import '../../../../../data/repositories/user_repository.dart';

part 'user_search_state.dart';

class UserSearchCubit extends Cubit<UserSearchState> {
  UserSearchCubit({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(
          const UserSearchState(),
        );

  final UserRepository _userRepository;

  Future<void> searchUserResults({@required String query}) async {
    emit(
      const UserSearchState(
        status: UserSearchStatus.loading,
      ),
    );

    try {
      final users = await _userRepository.searchUserResults(query: query);
      emit(
        UserSearchState(
          status: UserSearchStatus.success,
          users: users,
        ),
      );
    } catch (_) {
      emit(
        const UserSearchState(
          status: UserSearchStatus.failure,
        ),
      );
    }
  }

  Future<void> searchUserSuggestions({@required String query}) async {
    emit(
      const UserSearchState(
        status: UserSearchStatus.loading,
      ),
    );

    try {
      final users = await _userRepository.searchUserSuggestions(query: query);
      emit(
        UserSearchState(
          status: UserSearchStatus.success,
          users: users,
        ),
      );
    } catch (_) {
      emit(
        const UserSearchState(
          status: UserSearchStatus.failure,
        ),
      );
    }
  }
}
