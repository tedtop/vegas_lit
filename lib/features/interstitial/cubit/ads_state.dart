part of 'ads_cubit.dart';

enum AdsStatus { loading, completed }

class AdsState extends Equatable {
  const AdsState._({
    this.status = AdsStatus.loading,
  });

  const AdsState.loading() : this._(status: AdsStatus.loading);

  const AdsState.completed() : this._(status: AdsStatus.completed);

  final AdsStatus status;
  @override
  List<Object> get props => [status];
}
