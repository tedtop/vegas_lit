import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/data/models/nascar/nascar_race.dart';
import 'package:vegas_lit/data/repositories/nascar_repository.dart';
import 'package:vegas_lit/features/nascar/constants/constants.dart';
import 'package:vegas_lit/features/nascar/race_play/cubit/race_play_cubit.dart';
import 'package:vegas_lit/features/nascar_mock/waiting_page.dart';

class RacePlay extends StatelessWidget {
  const RacePlay._({Key? key}) : super(key: key);

  static Route route({required Race race}) {
    return MaterialPageRoute<void>(
      builder: (context) => BlocProvider(
        create: (_) => RacePlayCubit(
          nascarRepository: context.read<NascarRepository>(),
        )..openRacePlayPage(race: race),
        child: const RacePlay._(),
      ),
    );
  }

  Widget _textWithStroke({required String text, required Color textColor}) {
    return Stack(
      children: <Widget>[
        Text(
          text,
          style: NascarStyles.largeText.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.5
              ..color = NascarPalette.darkBlack,
          ),
        ),
        Text(
          text,
          style: NascarStyles.largeText.copyWith(color: textColor),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: NascarStyles.theme,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(140),
          child: AppBar(
            backgroundColor: NascarPalette.darkBlack,
            automaticallyImplyLeading: false,
            flexibleSpace: Column(
              children: [
                const SizedBox(height: 60),
                Image.asset('${Images.nascarAssetsPath}NASCAR-logo.png'),
                const SizedBox(height: 8),
                Image.asset('${Images.nascarAssetsPath}draft-partner.png'),
              ],
            ),
          ),
        ),
        backgroundColor: NascarPalette.darkBlack,
        body: BlocBuilder<RacePlayCubit, RacePlayState>(
          builder: (context, state) {
            switch (state.status) {
              case RacePlayStatus.initial:
                return const SizedBox();
              case RacePlayStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(
                    color: NascarPalette.blue,
                  ),
                );
              case RacePlayStatus.success:
                return Center(
                  child: SizedBox(
                    width: 380,
                    child: ListView(
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Race starts in',
                            style: NascarStyles.normalBoldText,
                            children: <TextSpan>[
                              TextSpan(
                                text: ' 9 ',
                                style: NascarStyles.mediumText
                                    .copyWith(color: NascarPalette.red),
                              ),
                              const TextSpan(text: 'minutes')
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'The race is about to start...',
                          textAlign: TextAlign.center,
                          style: NascarStyles.normalLightText,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Which driver will help you through the traffic?',
                          textAlign: TextAlign.center,
                          style: NascarStyles.normalLightText,
                        ),
                        const SizedBox(height: 20),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            FittedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 180,
                                    child: InkWell(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute<Widget>(
                                              builder: (context) =>
                                                  const WaitingPage())),
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Image.asset(
                                              '${Images.nascarAssetsPath}nascar-car1.png'),
                                          _textWithStroke(
                                            text: '18',
                                            textColor: NascarPalette.cream,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 180,
                                    child: InkWell(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute<Widget>(
                                              builder: (context) =>
                                                  const WaitingPage())),
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Image.asset(
                                              '${Images.nascarAssetsPath}nascar-car2.png'),
                                          _textWithStroke(
                                            text: '24',
                                            textColor: NascarPalette.yellow,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CircleAvatar(
                              radius: 40,
                              backgroundColor:
                                  NascarPalette.cream.withOpacity(0.7),
                              child: Text(
                                'or',
                                style: NascarStyles.largeText.copyWith(
                                    color: NascarPalette.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
                break;
              case RacePlayStatus.failure:
                return const Center(
                  child: Text("Couldn't load the page"),
                );
            }
          },
        ),
      ),
    );
  }
}
