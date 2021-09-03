import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/utils/logger.dart';

import '../../../../../data/repositories/user_repository.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
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
              logger.i('$ad onAdShowedFullScreenContent.');
            },
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              logger.i('$ad onAdDismissedFullScreenContent.');
              ad.dispose();
            },
            onAdWillDismissFullScreenContent: (InterstitialAd ad) {
              logger.i('$ad onAdWillDismissFullScreenContent.');
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) {
              logger.i('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
            },
            onAdImpression: (InterstitialAd ad) =>
                logger.i('$ad impression occurred.'),
          );
          await interstitialAd.show();
        },
        onAdFailedToLoad: (LoadAdError error) {
          logger.i('InterstitialAd failed to load: $error');
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
    final rewardedAdID = Platform.isIOS
        ? 'ca-app-pub-8972894064340370/9802303712'
        : 'ca-app-pub-8972894064340370/8321701085';
    final currentUser = await _userRepository.getCurrentUser();
    await RewardedAd.loadWithAdManagerAdRequest(
      adUnitId: kDebugMode ? RewardedAd.testAdUnitId : rewardedAdID,
      // adUnitId: RewardedAd.testAdUnitId,
      adManagerRequest: const AdManagerAdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd rewardedAd) async {
          logger.i('_rewardedADs $rewardedAd');
          rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (RewardedAd ad) {
              logger.i('$ad onAdShowedFullScreenContent.');
              emit(
                const AdsState.initial(),
              );
            },
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              logger.i('$ad onAdDismissedFullScreenContent.');

              ad.dispose();
            },
            onAdWillDismissFullScreenContent: (RewardedAd ad) {
              logger.i('$ad onAdWillDismissFullScreenContent.');
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              logger.i('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
              emit(
                const AdsState.failure(),
              );
            },
            onAdImpression: (RewardedAd ad) =>
                logger.i('$ad impression occurred.'),
          );
          await rewardedAd.show(
            onUserEarnedReward:
                (RewardedAd rewardedAd, RewardItem rewardItem) async {
              logger.i(
                  'Reward Amount ${rewardItem.amount}\n Reward Type ${rewardItem.type}');
              await _userRepository
                  .rewardForVideoAd(
                uid: currentUser.uid,
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
          logger.i('RewardedAd failed to load: ${error.message}');

          emit(
            const AdsState.failure(),
          );
        },
      ),
    );
  }
}
