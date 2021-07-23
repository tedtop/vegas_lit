part of 'ads_cubit.dart';

enum AdsStatus { initial, loading, success, failure, cancelled }

class AdsState extends Equatable {
  const AdsState._({
    this.status = AdsStatus.initial,
    this.rewardAmount,
  });

  const AdsState.initial() : this._();

  const AdsState.loading() : this._(status: AdsStatus.loading);

  const AdsState.success({@required int rewardAmount})
      : this._(
          status: AdsStatus.success,
          rewardAmount: rewardAmount,
        );

  const AdsState.failure() : this._(status: AdsStatus.failure);

  const AdsState.cancelled() : this._(status: AdsStatus.cancelled);

  final AdsStatus status;
  final int rewardAmount;

  @override
  List<Object> get props => [status, rewardAmount];
}
