

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

part 'banner_ad_state.dart';

class BannerAdCubit extends Cubit<BannerAdState> {
  BannerAdCubit() : super(const BannerAdState.initial());

  BannerAd? _bannerAd;

  Future<void> loadBannerAd() async {
    emit(const BannerAdState.loading());
    _bannerAd = BannerAd(
      // TODO: change to real ad unit id
      adUnitId: kDebugMode
          ? BannerAd.testAdUnitId
          :
          // AdsConfig.bannerAdUnitId
          BannerAd.testAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          emit(BannerAdState.success(bannerAd: _bannerAd));
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          emit(const BannerAdState.failure());
          ad.dispose();
        },
      ),
    );
    await _bannerAd!.load();
  }

  @override
  Future<void> close() {
    _bannerAd!.dispose();
    return super.close();
  }
}
