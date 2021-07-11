import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';

import '../olympics.dart';

class OlympicsScreen extends StatelessWidget {
  const OlympicsScreen._({Key key}) : super(key: key);

  static Builder route() {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (context) => OlympicsCubit(),
          child: const OlympicsScreen._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: 390,
            decoration: BoxDecoration(
              border: Border.all(
                color: Palette.cream,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 12,
            ),
            child: Card(
                margin: EdgeInsets.zero,
                color: Palette.lightGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    '${Images.olympicsIconsPath}Shooting.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'SHOOTING',
                                    style: Styles.normalTextBold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Image.asset(
                              '${Images.olympicsIconsPath}Olympics.png',
                              height: 35,
                              width: 35,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                              width: 330,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Palette.darkGrey),
                              child: Row(
                                children: [
                                  Image.asset(
                                    '${Images.countryIconsPath}GB.png',
                                    height: 25,
                                    width: 25,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Nigel Wheatstone',
                                    style: Styles.normalText,
                                  ),
                                ],
                              ))),
                      Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                              width: 330,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Palette.green),
                              child: Row(
                                children: [
                                  Image.asset(
                                    '${Images.countryIconsPath}RU.png',
                                    height: 25,
                                    width: 25,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Ted Toporkov',
                                    style: Styles.normalText,
                                  ),
                                ],
                              ))),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sat, June, 26, 2021 @ 01:10 PM',
                              style: Styles.matchupTime,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))),
        Container(
            width: 390,
            decoration: BoxDecoration(
              border: Border.all(
                color: Palette.cream,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 12,
            ),
            child: Card(
                margin: EdgeInsets.zero,
                color: Palette.lightGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    '${Images.olympicsIconsPath}Badminton.png',
                                    height: 35,
                                    width: 35,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'BADMINTON',
                                    style: Styles.normalTextBold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Image.asset(
                              '${Images.olympicsIconsPath}Olympics.png',
                              height: 35,
                              width: 35,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                              width: 330,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Palette.green),
                              child: Row(
                                children: [
                                  Image.asset(
                                    '${Images.countryIconsPath}CA.png',
                                    height: 25,
                                    width: 25,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Brad Pitt',
                                    style: Styles.normalText,
                                  ),
                                ],
                              ))),
                      Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                              width: 330,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Palette.darkGrey),
                              child: Row(
                                children: [
                                  Image.asset(
                                    '${Images.countryIconsPath}GH.png',
                                    height: 25,
                                    width: 25,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Chris Evans',
                                    style: Styles.normalText,
                                  ),
                                ],
                              ))),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sat, June, 26, 2021 @ 01:10 PM',
                              style: Styles.matchupTime,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))),
      ],
    );
  }
}
