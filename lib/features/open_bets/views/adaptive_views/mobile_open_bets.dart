import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/features/home/home.dart';
import 'package:vegas_lit/features/open_bets/cubit/open_bets_cubit.dart';
import 'package:vegas_lit/features/open_bets/views/open_bets_card.dart';

class MobileOpenBets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _MobileOpenBetsHeading(),
        const _MobileOpenBetsDescription(),
        const _MobileOpenBetsContent(),
      ],
    );
  }
}

class _MobileOpenBetsHeading extends StatelessWidget {
  const _MobileOpenBetsHeading({Key key}) : super(key: key);

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

class _MobileOpenBetsDescription extends StatelessWidget {
  const _MobileOpenBetsDescription({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 4,
      ),
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
                  }),
            const TextSpan(
              text: 'page.',
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileOpenBetsContent extends StatelessWidget {
  const _MobileOpenBetsContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.select((OpenBetsCubit cubit) => cubit.state.status);
    final bets = context.select((OpenBetsCubit cubit) => cubit.state.bets);
    switch (status) {
      case OpenBetsStatus.success:
        if (bets.isEmpty) {
          return const _MobileOpenBetsContentEmpty();
        }
        return const _MobileOpenBetsContentList();
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

class _MobileOpenBetsContentList extends StatelessWidget {
  const _MobileOpenBetsContentList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bets = context.select((OpenBetsCubit cubit) => cubit.state.bets);
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      key: Key('${bets.length}'),
      itemCount: bets.length,
      itemBuilder: (context, index) {
        return OpenBetsSlip(
          openBets: bets[index],
        );
      },
    );
  }
}

class _MobileOpenBetsContentEmpty extends StatelessWidget {
  const _MobileOpenBetsContentEmpty({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 120),
      child: Text(
        // ignore: lines_longer_than_80_chars
        'No bets placed. \nPlace some bets to show them here.',
        textAlign: TextAlign.center,
        style: Styles.openBetsEmpty,
      ),
    );
  }
}
