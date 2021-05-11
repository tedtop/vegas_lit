part of 'version_cubit.dart';

enum VersionStatus { initial, fetched }

class VersionState extends Equatable {
  const VersionState._({
    this.minimumVersion,
    this.isMinimumVersion,
    this.status = VersionStatus.initial,
  });

  const VersionState.initial() : this._();

  const VersionState.fetched({String minimumVersion, bool isMinimumVersion})
      : this._(
          minimumVersion: minimumVersion,
          isMinimumVersion: isMinimumVersion,
        );

  final String minimumVersion;
  final bool isMinimumVersion;
  final VersionStatus status;

  @override
  List<Object> get props => [minimumVersion, isMinimumVersion, status];
}
