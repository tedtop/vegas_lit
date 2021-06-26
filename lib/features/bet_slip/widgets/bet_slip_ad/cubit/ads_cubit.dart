import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/repositories/user_repository.dart';

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
              // ignore: avoid_print
              print('$ad onAdShowedFullScreenContent.');
            },
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              // ignore: avoid_print
              print('$ad onAdDismissedFullScreenContent.');
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) {
              // ignore: avoid_print
              print('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
            },
            onAdImpression: (InterstitialAd ad) =>
                // ignore: avoid_print
                print('$ad impression occurred.'),
          );
          await interstitialAd.show();
        },
        onAdFailedToLoad: (LoadAdError error) {
          // ignore: avoid_print
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
    final rewardedAdID = Platform.isIOS
        ? 'ca-app-pub-8972894064340370/3118061623'
        : 'ca-app-pub-8972894064340370/1258556174';
    final currentUser = await _userRepository.getCurrentUser();
    await RewardedAd.loadWithAdManagerAdRequest(
      // adUnitId: kDebugMode
      //     ? RewardedAd.testAdUnitId
      //     : Platform.isIOS
      //         ? RewardedAd.testAdUnitId
      //         : rewardedAdID,
      adUnitId: RewardedAd.testAdUnitId,
      adManagerRequest: const AdManagerAdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd rewardedAd) async {
          // ignore: avoid_print
          print('_rewardedADs $rewardedAd');
          rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (RewardedAd ad) {
              // ignore: avoid_print
              print('$ad onAdShowedFullScreenContent.');
            },
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              // ignore: avoid_print
              print('$ad onAdDismissedFullScreenContent.');
              ad.dispose();
              emit(
                const AdsState.success(),
              );
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              // ignore: avoid_print
              print('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
            },
            onAdImpression: (RewardedAd ad) =>
                // ignore: avoid_print
                print('$ad impression occurred.'),
          );
          await rewardedAd.show(
            onUserEarnedReward:
                (RewardedAd rewardedAd, RewardItem rewardItem) async {
              // ignore: avoid_print
              print('Reward Amount ${rewardItem.amount}');
              await _userRepository.rewardForVideoAd(
                uid: currentUser.uid,
                rewardValue: 100,
              );
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          // ignore: avoid_print
          print('RewardedAd failed to load: $error');
          emit(
            const AdsState.failure(),
          );
        },
      ),
    );
  }
}
