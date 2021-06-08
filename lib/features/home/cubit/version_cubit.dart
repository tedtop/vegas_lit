import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../data/repositories/user_repository.dart';

part 'version_state.dart';

class VersionCubit extends Cubit<VersionState> {
  VersionCubit({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(const VersionState.initial());

  final UserRepository _userRepository;
  StreamSubscription _versionSubscription;

  Future<void> checkMinimumVersion() async {
    final currentVersion = await _getAppVersion();
    final currentVersionNumber = int.parse(currentVersion.split('.').join(''));
    final minimumVersion = _userRepository.fetchMinimumVersion();
    await _versionSubscription?.cancel();
    _versionSubscription = minimumVersion.listen(
      (event) {
        final minimumVersionNumber = int.parse(event.split('.').join(''));
        final isUsingMinimumVersion =
            currentVersionNumber >= minimumVersionNumber;
        emit(
          VersionState.fetched(
            minimumVersion: event,
            isMinimumVersion: isUsingMinimumVersion,
          ),
        );
      },
    );
  }

  Future<String> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final versionString = packageInfo.version;
    return versionString;
  }

  @override
  Future<void> close() async {
    await _versionSubscription?.cancel();
    return super.close();
  }
}
