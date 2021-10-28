

part of 'profileavatar_cubit.dart';

enum ProfileAvatarStatus { initial, loading, success, failure }

class ProfileAvatarState extends Equatable {
  const ProfileAvatarState({
    this.status = ProfileAvatarStatus.initial,
  });

  final ProfileAvatarStatus status;

  @override
  List<Object> get props => [status];
}
