

part of 'profile_cubit.dart';

enum ProfileStatus { loading, opened }

class ProfileState extends Equatable {
  const ProfileState._({
    this.status = ProfileStatus.loading,
    this.userData,
  });

  const ProfileState.loading() : this._();

  const ProfileState.opened({required UserData userData})
      : this._(
          userData: userData,
          status: ProfileStatus.opened,
        );

  final ProfileStatus status;
  final UserData? userData;

  @override
  List<Object?> get props => [status, userData];
}
