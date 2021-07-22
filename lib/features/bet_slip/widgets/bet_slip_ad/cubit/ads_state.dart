part of 'ads_cubit.dart';

enum AdsStatus { initial, loading, success, failure, cancelled }

class AdsState extends Equatable {
  const AdsState._({
    this.status = AdsStatus.initial,
  });

  const AdsState.initial() : this._();

  const AdsState.loading() : this._(status: AdsStatus.loading);

  const AdsState.success() : this._(status: AdsStatus.success);

  const AdsState.failure() : this._(status: AdsStatus.failure);

  const AdsState.cancelled() : this._(status: AdsStatus.cancelled);

  final AdsStatus status;

  @override
  List<Object> get props => [status];
}
