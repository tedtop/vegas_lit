part of 'version_cubit.dart';

abstract class VersionState extends Equatable {
  const VersionState();

  @override
  List<Object> get props => [];
}

class VersionInitial extends VersionState {}

class VersionFetched extends VersionState {
  VersionFetched({
    @required this.minimumVersion,
    @required this.isMinimumVersion,
  });
  final String minimumVersion;
  final bool isMinimumVersion;

  @override
  List<Object> get props => [minimumVersion, isMinimumVersion];
}
