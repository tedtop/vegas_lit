import 'package:flutter/material.dart';
import 'package:vegas_lit/config/assets.dart';

class OlympicHelper {
  static String countryFlagFromCode({String countryCode}) {
    return String.fromCharCode(countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6) +
        String.fromCharCode(countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6);
  }

  static Widget badgeFromEventType({String eventType}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        eventType == 'gold'
            ? const Text(
                '🥇',
                style: TextStyle(fontSize: 20),
              )
            : eventType == 'silver'
                ? const Text(
                    '🥈',
                    style: TextStyle(fontSize: 20),
                  )
                : eventType == 'bronze'
                    ? const Text(
                        '🥉',
                        style: TextStyle(fontSize: 20),
                      )
                    : const Text(
                        '🥇',
                        style: TextStyle(fontSize: 20),
                      ),
        Image.asset(
          '${Images.olympicsIconsPath}Olympics.png',
          height: 18,
        )
      ],
    );
  }
}
