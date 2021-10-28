

import 'package:flutter/material.dart';
import '../../../../config/assets.dart';
import '../../../../config/palette.dart';
import 'dummy_match_card.dart';

class HelpOverlayView extends StatelessWidget {
  const HelpOverlayView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: HelpOverlayLoader.appLoader.loaderShowingNotifier,
      builder: (context, value, child) {
        if (value) {
          return const HelpOverlay();
        } else {
          return Container();
        }
      },
    );
  }
}

class HelpOverlay extends StatelessWidget {
  const HelpOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topSafeSpacePadding = MediaQuery.of(context).viewPadding.top;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: HelpOverlayLoader.appLoader.hideLoader,
      child: Stack(
        children: [
          Positioned(
              top: topSafeSpacePadding + 108,
              left: 25,
              child: Image.asset(Images.sportTypesHelpOverlay,
                  fit: BoxFit.contain, width: 285)),
          Positioned(
              top: topSafeSpacePadding + 18,
              right: 22,
              child: Image.asset(Images.coinBalanceHelpOverlay,
                  fit: BoxFit.contain, width: 300)),
          Positioned(
              top: topSafeSpacePadding + 245,
              child: Stack(
                children: [
                  Container(
                    color: Palette.darkGrey,
                    width: size.width,
                    height: size.height - (topSafeSpacePadding + 245),
                  ),
                  const DummyMatchCard(),
                  Positioned(
                    left: size.width / 2 - 110,
                    child: Image.asset(Images.placeBetHelpOverlay,
                        fit: BoxFit.contain, width: 220),
                  ),
                ],
              )),
          Positioned(
            right: 17,
            top: topSafeSpacePadding + 55.7,
            child: Image.asset(Images.numberOfBetsHelpOverlay,
                fit: BoxFit.contain, width: 300),
          ),
          Positioned(
            bottom: 0,
            child: Image.asset(
              Images.betTypesHelpOverlay,
              fit: BoxFit.contain,
              width: size.width,
            ),
          ),
        ],
      ),
    );
  }
}

class HelpOverlayLoader {
  static final HelpOverlayLoader appLoader = HelpOverlayLoader();
  ValueNotifier<bool> loaderShowingNotifier = ValueNotifier(false);

  void showLoader() {
    loaderShowingNotifier.value = true;
  }

  void hideLoader() {
    loaderShowingNotifier.value = false;
  }
}
