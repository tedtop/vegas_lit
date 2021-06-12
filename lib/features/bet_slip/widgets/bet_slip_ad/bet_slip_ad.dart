import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/data/repositories/user_repository.dart';
import 'package:vegas_lit/features/home/cubit/home_cubit.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../shared_widgets/abstract_card.dart';
import 'cubit/ads_cubit.dart';

class RewardedBetSlip extends StatelessWidget {
  const RewardedBetSlip._({Key key}) : super(key: key);

  static Builder route() {
    return Builder(builder: (context) {
      return BlocProvider<AdsCubit>(
        create: (_) => AdsCubit(
          userRepository: context.read<UserRepository>(),
        ),
        child: const RewardedBetSlip._(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonWidthHeight = size.width * .30;
    final totalRewards = context
        .select((HomeCubit cubit) => cubit.state?.userWallet?.totalRewards);
    return SingleChildScrollView(
      child: Column(
        children: [
          AbstractCard(
            widgets: [
              Text(
                'Your bets are placed!',
                style: Styles.betSlipBoxLargeText,
              ),
              const SizedBox(
                height: 20,
              ),
              totalRewards >= 400
                  ? Text(
                      'Sorry. You\'ve exceeded the rewards amount.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(fontSize: 20),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Column(
                        children: [
                          textPoints(
                            'Need more funds to bet?',
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          BlocConsumer<AdsCubit, AdsState>(
                            listener: (context, state) {
                              if (state.status == AdsStatus.success) {
                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(
                                    const SnackBar(
                                      duration: Duration(milliseconds: 1000),
                                      content: Text(
                                        'Success. 100\$ added to your account.',
                                      ),
                                    ),
                                  );
                              } else if (state.status == AdsStatus.failure) {
                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(
                                    const SnackBar(
                                      duration: Duration(milliseconds: 1000),
                                      content: Text(
                                        'Error',
                                      ),
                                    ),
                                  );
                              }
                            },
                            builder: (context, state) {
                              switch (state.status) {
                                case AdsStatus.loading:
                                  return const CircularProgressIndicator(
                                    color: Palette.cream,
                                  );
                                  break;
                                default:
                                  return InkWell(
                                    onTap: () {
                                      context.read<AdsCubit>().openRewardedAd();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Palette.green,
                                        borderRadius: BorderRadius.circular(
                                            buttonWidthHeight),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(.25),
                                            offset: const Offset(0, 4),
                                            blurRadius: 4,
                                          )
                                        ],
                                      ),
                                      width: buttonWidthHeight,
                                      height: buttonWidthHeight,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Watch',
                                              style: GoogleFonts.nunito(
                                                color: Palette.cream,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              'Video',
                                              style: GoogleFonts.nunito(
                                                color: Palette.cream,
                                                fontSize: 20,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                              }
                            },
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Widget textPoints(String text) {
    return Column(
      children: [
        Text(
          text,
          style: Styles.betSlipBoxNormalText,
        ),
      ],
    );
  }
}
