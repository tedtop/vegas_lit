part of 'profileavatar_cubit.dart';

enum ProfileAvatarStatus { none, updating }

class ProfileAvatarState extends Equatable {
  const ProfileAvatarState._({
    this.status = ProfileAvatarStatus.none,
    // this.avatarUrl
  });

  const ProfileAvatarState.none() : this._();

  const ProfileAvatarState.updating(
      //{@required String avatarUrl}
      )
      : this._(
          status: ProfileAvatarStatus.updating,
          //avatarUrl: avatarUrl
        );

  final ProfileAvatarStatus status;
  // final String avatarUrl;
  @override
  List<Object> get props => [
        //avatarUrl
      ];
}
