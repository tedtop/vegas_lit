import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/features/shared_widgets/bottom_bar.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../home/cubit/home_cubit.dart';
import '../../cubit/open_bets_cubit.dart';
import '../open_bets_card.dart';

class TabletOpenBets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _TabletOpenBetsHeading(),
        const _TabletOpenBetsDescription(),
        const _TabletOpenBetsContent(),
        const BottomBar()
      ],
    );
  }
}

class _TabletOpenBetsHeading extends StatelessWidget {
  const _TabletOpenBetsHeading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'OPEN BETS',
            style: Styles.pageTitle,
          ),
        ),
      ],
    );
  }
}

class _TabletOpenBetsDescription extends StatelessWidget {
  const _TabletOpenBetsDescription({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 4,
      ),
      child: Center(
        child: RichText(
          text: TextSpan(
            style: Styles.openBetsNormalText,
            children: <TextSpan>[
              const TextSpan(
                text:
                    // ignore: lines_longer_than_80_chars
                    'Bets shown here cannot be modified and are awaiting the outcome of the event. Once bets have been closed they will appear in your',
              ),
              TextSpan(
                text: ' BET HISTORY ',
                style: Styles.openBetsTextButton,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.read<HomeCubit>().homeChange(4);
                  },
              ),
              const TextSpan(
                text: 'page.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabletOpenBetsContent extends StatelessWidget {
  const _TabletOpenBetsContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.select((OpenBetsCubit cubit) => cubit.state.status);
    final bets = context.select((OpenBetsCubit cubit) => cubit.state.bets);
    switch (status) {
      case OpenBetsStatus.success:
        if (bets.isEmpty) {
          return const _TabletOpenBetsContentEmpty();
        }
        return const _TabletOpenBetsContentList();
        break;
      case OpenBetsStatus.initial:
        return const SizedBox();
        break;
      case OpenBetsStatus.loading:
        return const CircularProgressIndicator(
          color: Palette.cream,
        );
        break;
      case OpenBetsStatus.failure:
        return const Center(
          child: Text('Some Error Occured'),
        );
        break;
      default:
        return const SizedBox();
        break;
    }
  }
}

class _TabletOpenBetsContentList extends StatelessWidget {
  const _TabletOpenBetsContentList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bets = context.select((OpenBetsCubit cubit) => cubit.state.bets);
    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: GridView.count(
        primary: true,
        childAspectRatio: 2.5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        shrinkWrap: true,
        key: Key('${bets.length}'),
        children: bets
            .map(
              (openBets) => FittedBox(
                child: OpenBetsSlip(openBets: openBets),
                fit: BoxFit.scaleDown,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _TabletOpenBetsContentEmpty extends StatelessWidget {
  const _TabletOpenBetsContentEmpty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 120),
      child: Text(
          // ignore: lines_longer_than_80_chars
          'No bets placed. \nPlace some bets to show them here.',
          textAlign: TextAlign.center,
          style: Styles.openBetsEmpty),
    );
  }
}
