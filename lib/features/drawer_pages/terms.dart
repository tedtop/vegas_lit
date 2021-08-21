import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/assets.dart';
import '../../config/palette.dart';
import '../../config/styles.dart';

class TermsOfService extends StatelessWidget {
  const TermsOfService._({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const TermsOfService._(),
      settings: const RouteSettings(name: 'TermsOfService'),
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
          const _TermsOfServiceHeading(),
          const _TermsOfServiceContent(),
        ],
      ),
    );
  }
}

class _TermsOfServiceHeading extends StatelessWidget {
  const _TermsOfServiceHeading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          'TERMS OF SERVICE',
          style: Styles.pageTitle,
        ),
      ],
    );
  }
}

class _TermsOfServiceContent extends StatelessWidget {
  const _TermsOfServiceContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 120),
      child: AutoSizeText(
        // ignore: lines_longer_than_80_chars
        'WORK IN PROGRESS\n Come Back Later.',
        textAlign: TextAlign.center,
        style: GoogleFonts.nunito(
          color: Palette.cream,
          fontSize: 22,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
