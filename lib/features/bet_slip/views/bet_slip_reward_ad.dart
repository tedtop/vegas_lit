import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/data/repositories/user_repository.dart';
import 'package:vegas_lit/features/home/cubit/home_cubit.dart';
import 'package:vegas_lit/features/home/widgets/bottombar.dart';
import 'package:vegas_lit/features/interstitial/reward_ad.dart';
import 'package:vegas_lit/features/profile/cubit/profile_cubit.dart';
import 'package:vegas_lit/features/shared_widgets/abstract_card.dart';

import 'bet_slip_page.dart';

class RewardedBetSlip extends StatelessWidget {
  RewardedBetSlip();
  @override
  Widget build(BuildContext context) {
    final currentUid =
        BlocProvider.of<ProfileCubit>(context).state.userData.uid;
    final balance =
        BlocProvider.of<HomeCubit>(context).state.userWallet.accountBalance;
    final size = MediaQuery.of(context).size;
    final buttonWidthHeight = size.width * .22;

    return SingleChildScrollView(
      child: Column(
        children: [
          BetSlipUpper(),
          AbstractCard(
            crossAxisAlignment: CrossAxisAlignment.start,
            widgets: [
              Text(
                'Your bets are placed!',
                style: GoogleFonts.nunito(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Palette.cream),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textPoints(
                        'Need more funds to bet?',
                      ),
                      textPoints(
                        '1. Click the button',
                      ),
                      textPoints(
                        '2. Watch an Ad',
                      ),
                      textPoints(
                        '3. Earn \$100 of Vegas Bucks!',
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      final onRewardCallBack = (
                        RewardedAd rewardedAd,
                        RewardItem rewardItem,
                      ) async {
                        await UserRepository().rewardForVideoAd(
                          uid: currentUid,
                          rewardValue: rewardItem.amount.toInt(),
                        );
                      };
                      RewardAdManager(
                        balance,
                        onRewardCallBack,
                      )..show();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Palette.green,
                        borderRadius: BorderRadius.circular(buttonWidthHeight),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                          )
                        ],
                      ),
                      width: buttonWidthHeight,
                      height: buttonWidthHeight,
                      child: const Center(child: Text('Button')),
                    ),
                  )
                ],
              ),
            ],
          ),
          kIsWeb ? const BottomBar() : const SizedBox(),
        ],
      ),
    );
  }

  Widget textPoints(String text) {
    return Column(
      children: [
        Text(
          text,
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.w200,
            color: Palette.cream,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
