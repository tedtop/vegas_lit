import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:vegas_lit/config/ads.dart';

import '../../../../../data/repositories/user_repository.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(
          const AdsState.initial(),
        );

  final UserRepository _userRepository;

  Future<void> openInterstitialAd() async {
    emit(
      const AdsState.loading(),
    );
    await InterstitialAd.load(
      adUnitId: InterstitialAd.testAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd interstitialAd) async {
          interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (InterstitialAd ad) {
              print('$ad onAdShowedFullScreenContent.');
            },
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              print('$ad onAdDismissedFullScreenContent.');
              ad.dispose();
            },
            onAdWillDismissFullScreenContent: (InterstitialAd ad) {
              print('$ad onAdWillDismissFullScreenContent.');
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) {
              print('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
            },
            onAdImpression: (InterstitialAd ad) =>
                print('$ad impression occurred.'),
          );
          await interstitialAd.show();
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
          emit(
            const AdsState.failure(),
          );
        },
      ),
    );
  }

  Future<void> openRewardedAd() async {
    emit(
      const AdsState.loading(),
    );
    final currentUser = await _userRepository.getCurrentUser();
    await RewardedAd.loadWithAdManagerAdRequest(
      adUnitId:
          kDebugMode ? RewardedAd.testAdUnitId : AdsConfig.interstitialAdUnitId,
      // adUnitId: RewardedAd.testAdUnitId,
      adManagerRequest: const AdManagerAdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd rewardedAd) async {
          print('_rewardedADs $rewardedAd');
          rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (RewardedAd ad) {
              print('$ad onAdShowedFullScreenContent.');
              emit(
                const AdsState.initial(),
              );
            },
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              print('$ad onAdDismissedFullScreenContent.');

              ad.dispose();
            },
            onAdWillDismissFullScreenContent: (RewardedAd ad) {
              print('$ad onAdWillDismissFullScreenContent.');
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              print('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
              emit(
                const AdsState.failure(),
              );
            },
            onAdImpression: (RewardedAd ad) =>
                print('$ad impression occurred.'),
          );
          await rewardedAd.show(
            onUserEarnedReward:
                (RewardedAd rewardedAd, RewardItem rewardItem) async {
              print(
                  'Reward Amount ${rewardItem.amount}\n Reward Type ${rewardItem.type}');
              await _userRepository
                  .rewardForVideoAd(
                uid: currentUser!.uid,
                rewardValue: 100,
              )
                  .then(
                (value) async {
                  emit(
                    const AdsState.success(rewardAmount: 100),
                  );
                },
              );
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: ${error.message}');

          emit(
            const AdsState.failure(),
          );
        },
      ),
    );
  }
}
