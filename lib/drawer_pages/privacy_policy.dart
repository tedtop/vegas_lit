import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';

class PrivacyPolicy extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => PrivacyPolicy(),
      settings: const RouteSettings(name: 'PrivacyPolicy'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'drawerHeader',
          child: Image.asset(
            Images.topLogo,
            fit: BoxFit.fitWidth,
            height: 50,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'PRIVACY POLICY',
                style: Styles.pageTitle,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 120),
            child: Text(
              // ignore: lines_longer_than_80_chars
              'WORK IN PROGRESS\n Come Back Later.',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                color: Palette.cream,
                fontSize: 22,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
