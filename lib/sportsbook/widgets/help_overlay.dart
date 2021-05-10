import 'package:flutter/material.dart';
import 'package:vegas_lit/config/assets.dart';

Future<void> showOverlay(
    {BuildContext context, GlobalKey key1, GlobalKey key2}) async {
  final RenderBox currentRenderObject1 = key1.currentContext.findRenderObject();
  final RenderBox currentRenderObject2 = key2.currentContext.findRenderObject();

  final betTypesOverlay =
      currentRenderObject1.localToGlobal(const Offset(0, 0));
  final sportsTypesOverlay =
      currentRenderObject2.localToGlobal(const Offset(0, 0));
  final overlayEntry = OverlayEntry(builder: (context) {
    final size = MediaQuery.of(context).size;
    final topSafeSpacePadding = MediaQuery.of(context).viewPadding.top;

    return Stack(children: [
      Positioned(
        //BET TYPES
        top: betTypesOverlay.dy + 100,
        child: Image.asset(
          Images.betTypesHelpOverlay,
          fit: BoxFit.contain,
          width: size.width,
        ),
      ),
      Positioned(
          //typeOfSports
          top: topSafeSpacePadding + 15,
          left: 25,
          child: Image.asset(
            Images.sportTypesHelpOverlay,
            fit: BoxFit.contain,
            height: sportsTypesOverlay.dy - topSafeSpacePadding,
          )),
      Positioned(
          //coin Balance
          top: topSafeSpacePadding + 15,
          right: 50,
          child: Image.asset(
            Images.coinBalanceHelpOverlay,
            fit: BoxFit.contain,
            height: 60,
          )),
      Positioned(
          //Placing a bet
          left: size.width * 0.3,
          top: topSafeSpacePadding + 15,
          child: Image.asset(
            Images.placeBetHelpOverlay,
            fit: BoxFit.contain,
            height: betTypesOverlay.dy + 130, //TRICKY
          )),
      Positioned(
          //Number of bets
          right: 40,
          top: topSafeSpacePadding + 75,
          child: Image.asset(
            Images.numberOfBetsHelpOverlay,
            fit: BoxFit.contain,
            height: sportsTypesOverlay.dy - topSafeSpacePadding - 55, //TRICKY
          ))
    ]);
  });

  Overlay.of(context).insert(overlayEntry);
  await Future.delayed(
    const Duration(seconds: 5),
  );
  overlayEntry.remove();
}
