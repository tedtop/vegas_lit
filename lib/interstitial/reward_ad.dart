import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

enum AdType { interstitialAd, rewardedAd }
typedef OnRewardCallback = void Function(RewardedAd, RewardItem);

class RewardAd {
  RewardAd(this.balanceAmount, this.rewardCallback) {
    if (balanceAmount >= 700) {
      adType = AdType.interstitialAd;
    } else {
      adType = AdType.rewardedAd;
    }
    _buildAd();
  }

  final int balanceAmount;
  final OnRewardCallback rewardCallback;
  AdType adType;
  RewardedAd _rewardedAd;
  InterstitialAd _interstitialAd;

  final interstitialAd = Platform.isIOS
      ? 'ca-app-pub-8972894064340370/7835556907'
      : 'ca-app-pub-8972894064340370/7394743202';
  final rewardedAd = Platform.isIOS
      ? 'ca-app-pub-8972894064340370/3118061623'
      : 'ca-app-pub-8972894064340370/1258556174';

  final testInterstitialAd = 'ca-app-pub-3940256099942544/8691691433';
  final testRewardedAd = 'ca-app-pub-3940256099942544/5224354917';

  void _buildAd() {
    switch (adType) {
      case AdType.interstitialAd:
        _interstitialAd = _buildInterstitialAd();
        break;
      case AdType.rewardedAd:
        _rewardedAd = _buildRewardedAd();
        break;
    }
  }

  Future<void> loadAd() async {
    switch (adType) {
      case AdType.interstitialAd:
        await _interstitialAd.load();
        break;
      case AdType.rewardedAd:
        await _rewardedAd.load();
        break;
    }
  }

  Future<void> play() async {
    switch (adType) {
      case AdType.interstitialAd:
        await _interstitialAd.show();
        break;
      case AdType.rewardedAd:
        await _rewardedAd.show();
        break;
    }
  }

  InterstitialAd _buildInterstitialAd() {
    return InterstitialAd(
      adUnitId: kDebugMode
          ? testInterstitialAd
          : interstitialAd,
      request: const AdRequest(),
      listener: AdListener(
        onAdLoaded: (Ad ad) => play(),
        onAdFailedToLoad: onAdFailedToLoad,
      ),
    );
  }

  RewardedAd _buildRewardedAd() {
    return RewardedAd(
      adUnitId: kDebugMode
          ? testRewardedAd
          : rewardedAd,
      request: const AdRequest(),
      listener: AdListener(
        onRewardedAdUserEarnedReward: rewardCallback,
        onAdLoaded: (Ad ad) => play(),
        onAdFailedToLoad: onAdFailedToLoad,
      ),
    );
  }

  void onAdFailedToLoad(Ad ad, LoadAdError error) {
    // ignore: avoid_print
    print('Failed to Load ${ad.adUnitId}');
  }
}
