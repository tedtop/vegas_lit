import 'package:flutter/material.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/features/nascar_mock/nascar_button.dart';

import 'constants.dart';
import 'end_page.dart';

class WaitingPage extends StatelessWidget {
  const WaitingPage({Key? key}) : super(key: key);

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
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Race has started!\n',
                    style: NascarStyles.normalBoldText,
                    children: <TextSpan>[
                      TextSpan(
                        text: '45 ',
                        style: NascarStyles.mediumText
                            .copyWith(color: NascarPalette.red),
                      ),
                      const TextSpan(text: 'laps before your next pick')
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: NascarButton(
                    text: 'More ways to bet? CLICK HERE!',
                    action: () => Navigator.push(
                        context,
                        MaterialPageRoute<Widget>(
                            builder: (context) => const EndPage())),
                  ),
                ),
                const NascarOptionsCard(
                  picPath: '${Images.nascarAssetsPath}watch-live.png',
                  text: 'Watch Live!',
                ),
                const NascarOptionsCard(
                  picPath: '${Images.nascarAssetsPath}highlights.png',
                  text: 'Highlights',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NascarOptionsCard extends StatelessWidget {
  const NascarOptionsCard({Key? key, required this.picPath, required this.text})
      : super(key: key);

  final String picPath, text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 340,
      // decoration: BoxDecoration(
      //     borderRadius: const BorderRadius.all(Radius.circular(8)),
      //     border: Border.all(color: NascarPalette.cream, width: 2)),
      child: Center(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Image.asset(picPath),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(NascarPalette.red)),
                child: Text(text, style: NascarStyles.buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
