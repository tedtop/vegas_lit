

part of 'banner_ad_cubit.dart';

enum BannerAdStatus { initial, loading, success, failure }

class BannerAdState extends Equatable {
  const BannerAdState._({
    this.status = BannerAdStatus.initial,
    this.bannerAd,
  });
  const BannerAdState.initial() : this._();

  const BannerAdState.loading() : this._(status: BannerAdStatus.loading);

  const BannerAdState.success({required BannerAd? bannerAd})
      : this._(
          status: BannerAdStatus.success,
          bannerAd: bannerAd,
        );

  const BannerAdState.failure() : this._(status: BannerAdStatus.failure);

  final BannerAdStatus status;
  final BannerAd? bannerAd;

  @override
  List<Object?> get props => [status, bannerAd];
}
