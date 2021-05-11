import 'package:api_client/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'version_state.dart';

class VersionCubit extends Cubit<VersionState> {
  VersionCubit({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(const VersionState.initial());

  final UserRepository _userRepository;

  Future<void> checkMinimumVersion() async {
    final minimumVersion = await _userRepository.fetchMinimumVersion();
    final currentVersion = await _getAppVersion();
    final currentVersionNumber = int.parse(currentVersion.split('.').last);
    final minimumVersionNumber = int.parse(minimumVersion.split('.').last);
    final isUsingMinimumVersion = currentVersionNumber >= minimumVersionNumber;
    emit(
      VersionState.fetched(
        minimumVersion: minimumVersion,
        isMinimumVersion: isUsingMinimumVersion,
      ),
    );
  }

  Future<String> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();

    final versionString = packageInfo.version;
    return versionString;
  }
}
