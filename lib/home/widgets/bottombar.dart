import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/drawer_pages/faq.dart';
import 'package:vegas_lit/drawer_pages/privacy_policy.dart';
import 'package:vegas_lit/drawer_pages/rules.dart';
import 'package:vegas_lit/drawer_pages/terms.dart';
import 'package:vegas_lit/home/widgets/home_drawer.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.all(30),
          color: Palette.darkGrey,
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.center,
            direction: width > 870 ? Axis.horizontal : Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton(
                  child: Text('RULES', style: Styles.normalText),
                  onPressed: () {
                    Navigator.of(context).push(
                      Rules.route(),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton(
                  child: Text('FAQ', style: Styles.normalText),
                  onPressed: () {
                    Navigator.of(context).push(
                      FAQ.route(),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton(
                  child: Text('TERMS OF SERVICE', style: Styles.normalText),
                  onPressed: () {
                    Navigator.of(context).push(
                      TermsOfService.route(),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton(
                  child: Text('PRIVACY POLICY', style: Styles.normalText),
                  onPressed: () {
                    Navigator.of(context).push(
                      PrivacyPolicy.route(),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton(
                  child: Text('CONTACT US', style: Styles.normalText),
                  onPressed: () {
                    launch(''
                        //emailLaunchUri.toString(),
                        );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}