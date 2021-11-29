import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/data/models/nascar/nascar_race.dart';
import 'package:vegas_lit/data/repositories/nascar_repository.dart';
import 'package:vegas_lit/features/nascar/constants/constants.dart';
import 'package:vegas_lit/features/nascar/constants/nascar_button.dart';
import 'package:vegas_lit/features/nascar/race_play/race_play.dart';

import 'cubit/race_page_cubit.dart';

class NascarPage extends StatelessWidget {
  const NascarPage._({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
        create: (context) => RacePageCubit(
          nascarRepository: context.read<NascarRepository>(),
        )..openRacePage(),
        child: const NascarPage._(),
      ),
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
        body: BlocBuilder<RacePageCubit, RacePageState>(
          builder: (context, state) {
            switch (state.status) {
              case RacePageStatus.initial:
                return const SizedBox();
              case RacePageStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(
                    color: NascarPalette.blue,
                  ),
                );
              case RacePageStatus.success:
                return Center(
                  child: SizedBox(
                    width: 380,
                    child: ListView.builder(
                      key: Key('${state.raceList.length}'),
                      itemCount: state.raceList.length,
                      itemBuilder: (context, index) {
                        return RaceCard(
                          race: state.raceList[index],
                        );
                      },
                    ),
                  ),
                );
              case RacePageStatus.failure:
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

class RaceCard extends StatelessWidget {
  const RaceCard({
    Key? key,
    required this.race,
  }) : super(key: key);

  final Race race;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: NascarPalette.lightBlack,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(color: NascarPalette.lightBlack, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'NASCAR',
            style: NascarStyles.largeText,
          ),
          Text(
            race.name!,
            style: NascarStyles.mediumText,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: NascarPalette.darkBlack,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'FEE: ',
                        style: NascarStyles.smallLightText,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'FREE',
                            style: NascarStyles.smallBoldText,
                          )
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'ENTRIES: ',
                        style: NascarStyles.smallLightText,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'UNLIMITED',
                            style: NascarStyles.smallBoldText,
                          )
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'est. PRIZE: ',
                        style: NascarStyles.smallLightText,
                        children: <TextSpan>[
                          TextSpan(
                            text: r'$100',
                            style: NascarStyles.smallBoldText,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                NascarButton(
                  text: 'ENTER',
                  action: () => Navigator.of(context)
                      .push<void>(RacePlay.route(race: race)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
