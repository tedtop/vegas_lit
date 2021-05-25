import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

enum AdType { interstitialAd, rewardedAd }
typedef OnRewardCallback = void Function(RewardedAd, RewardItem);

class RewardAdManager {
  RewardAdManager(this.balanceAmount, this.rewardCallback) {
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

  final interstitialAdId = Platform.isIOS
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/1033173712';
  final rewardedAdId = Platform.isIOS
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/5224354917';

  final testInterstitialAd = 'ca-app-pub-3940256099942544/1033173712';
  final testRewardedAd = 'ca-app-pub-3940256099942544/5224354917';

  bool isAdLoaded = false;

  void _buildAd() async {
    switch (adType) {
      case AdType.interstitialAd:
        _buildInterstitialAd();
        break;
      case AdType.rewardedAd:
        _buildRewardedAd();
        break;
    }
  }

  void _buildInterstitialAd() async {
    await InterstitialAd.load(
        adUnitId: interstitialAdId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) => _interstitialAd = ad,
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  void _buildRewardedAd() async {
    await RewardedAd.loadWithAdManagerAdRequest(
      adUnitId: rewardedAdId,
      adManagerRequest: const AdManagerAdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) => _rewardedAd = ad,
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  void show() async {
    switch (adType) {
      case AdType.interstitialAd:
        await Future.delayed(const Duration(seconds: 2), showInterstitialAd);
        break;
      case AdType.rewardedAd:
        Future.delayed(const Duration(seconds: 2), showRewardedAd);
        break;
    }
  }

  void showInterstitialAd() {
    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdShowedFullScreenContent.');
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
      },
      onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
    );
    _interstitialAd.show();
  }

  void showRewardedAd() {
    print('_rewardedADs $_rewardedAd');
    _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdShowedFullScreenContent.');
        isAdLoaded = true;
      },
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        isAdLoaded = true;
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        isAdLoaded = false;
        ad.dispose();
      },
      onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
    );
    _rewardedAd.show(onUserEarnedReward: rewardCallback);
  }
}
