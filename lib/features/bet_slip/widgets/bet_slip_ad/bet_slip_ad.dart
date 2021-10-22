import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/config/extensions.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../home/cubit/home_cubit.dart';
import 'cubit/ads_cubit.dart';

class RewardedBetSlip extends StatelessWidget {
  const RewardedBetSlip._({Key? key}) : super(key: key);

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
    final todayRewards = context
        .select((HomeCubit cubit) => cubit.state.userWallet?.todayRewards!);
    return SingleChildScrollView(
      child: Column(
        children: [
          AbstractCard(
            widgets: [
              Text(
                'Your bet was placed.',
                style: Styles.betSlipBoxLargeText,
              ),
              const SizedBox(
                height: 20,
              ),
              if (todayRewards! >= 300)
                Builder(builder: (context) {
                  final timeNow = ESTDateTime.fetchTimeEST();
                  // To find the reward hour {Ex: 3 AM, 6 AM,...}
                  final nThRewardHour =
                      Duration(hours: timeNow.hour, minutes: timeNow.minute)
                              .inHours ~/
                          3;
                  final nextRewardTime = DateTime(timeNow.year, timeNow.month,
                      timeNow.day, 3 * (nThRewardHour + 1));
                  return CountdownTimer(
                    endTime: ESTDateTime.getESTmillisecondsSinceEpoch(
                        nextRewardTime),
                    widgetBuilder: (_, CurrentRemainingTime? time) {
                      if (time == null) {
                        return Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Last Reward at ',
                              style: Styles.normalText,
                              children: <TextSpan>[
                                TextSpan(
                                    text: DateFormat('hh:mm a').format(
                                      timeNow,
                                    ),
                                    style: Styles.greenTextBold),
                              ],
                            ),
                          ),
                        );
                      }

                      return Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Check back in ',
                            style: Styles.normalText,
                            children: <TextSpan>[
                              TextSpan(
                                  text: getRemainingTimeText(time: time),
                                  style: Styles.greenTextBold),
                              const TextSpan(text: ' for more rewards')
                            ],
                          ),
                        ),
                      );
                    },
                  );
                })
              else
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Column(
                    children: [
                      textPoints(
                        'Need more funds to play?',
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
                                SnackBar(
                                  duration: const Duration(milliseconds: 2000),
                                  content: Text(
                                    'You just earned another ${state.rewardAmount} to play with!',
                                  ),
                                ),
                              );
                          } else if (state.status == AdsStatus.failure) {
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  duration: Duration(milliseconds: 2000),
                                  content: Text(
                                    'There was an error displaying the ad.',
                                  ),
                                ),
                              );
                          } else if (state.status == AdsStatus.cancelled) {
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  duration: Duration(milliseconds: 2000),
                                  content: Text(
                                    'Ad Reward Cancelled.',
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
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(buttonWidthHeight),
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
                                clipBehavior: Clip.antiAlias,
                                child: Material(
                                  child: InkWell(
                                    //customBorder: const CircleBorder(),
                                    // borderRadius: BorderRadius.circular(
                                    //     buttonWidthHeight),
                                    splashColor: Palette.cream,
                                    onTap: () {
                                      context.read<AdsCubit>().openRewardedAd();
                                    },
                                    child: Ink(
                                      color: Palette.green,
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

  String getRemainingTimeText({required CurrentRemainingTime time}) {
    final hours = time.hours == null ? '' : '${time.hours}hr';
    final min = time.min == null ? '' : ' ${time.min}m';
    final sec = time.sec == null ? '' : ' ${time.sec}s';
    return hours + min + sec;
  }
}

class AbstractCard extends StatelessWidget {
  const AbstractCard({
    Key? key,
    required this.widgets,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 12.5,
      vertical: 12.0,
    ),
  }) : super(key: key);

  final List<Widget> widgets;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Container(
        width: 390,
        decoration: BoxDecoration(
          border: Border.all(
            color: Palette.cream,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Card(
          margin: EdgeInsets.zero,
          color: Palette.lightGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: padding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: crossAxisAlignment,
                children: widgets,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
