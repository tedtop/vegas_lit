import 'package:flutter/material.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/features/nascar/constants/nascar_button.dart';

import '../nascar/constants/constants.dart';

class EndPage extends StatelessWidget {
  const EndPage({Key? key}) : super(key: key);
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
        Text(text, style: NascarStyles.largeText.copyWith(color: textColor)),
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
        body: Center(
          child: SizedBox(
            width: 380,
            child: ListView(
              children: [
                Text(
                  'Congratulations!',
                  style: NascarStyles.largeLightText,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  '18 beat 24 and you moved up',
                  textAlign: TextAlign.center,
                  style: NascarStyles.normalLightText,
                ),
                const SizedBox(height: 5),
                Text(
                  '4 positions in the race!',
                  textAlign: TextAlign.center,
                  style: NascarStyles.normalLightText,
                ),
                const SizedBox(height: 20),
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 180,
                        child: InkWell(
                          onTap: () {},
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              ColorFiltered(
                                colorFilter: const ColorFilter.mode(
                                    NascarPalette.green, BlendMode.multiply),
                                child: Image.asset(
                                    '${Images.nascarAssetsPath}nascar-car1.png'),
                              ),
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
                          onTap: () {},
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
                const SizedBox(height: 10),
                Text(
                  'Position',
                  style: NascarStyles.largeLightText,
                  textAlign: TextAlign.center,
                ),
                Text(
                  '36/40',
                  textAlign: TextAlign.center,
                  style: NascarStyles.titleText,
                ),
                const SizedBox(height: 20),
                const Center(child: NascarButton(text: 'Next Draft Partner'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
