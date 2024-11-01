import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../config/palette.dart';
import 'cubit/banner_ad_cubit.dart';

class BannerAdCard extends StatelessWidget {
  const BannerAdCard._({Key? key}) : super(key: key);

  static Widget instance() {
    return BlocProvider(
      create: (context) => BannerAdCubit()..loadBannerAd(),
      child: const BannerAdCard._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerAdCubit, BannerAdState>(
        builder: (BuildContext ctxt, BannerAdState state) {
      switch (state.status) {
        case BannerAdStatus.success:
          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: state.bannerAd!.size.width.toDouble(),
              height: state.bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: state.bannerAd!),
            ),
          );
        case BannerAdStatus.failure:
          return const SizedBox();
        default:
          return const SizedBox(
            width: 320,
            height: 50,
            child: Center(
              child: CircularProgressIndicator(
                color: Palette.cream,
              ),
            ),
          );
      }
    });
  }
}
