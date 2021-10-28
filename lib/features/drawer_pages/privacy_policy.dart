

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/assets.dart';
import '../../config/palette.dart';
import '../../config/styles.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy._({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const PrivacyPolicy._(),
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
          const _PrivacyPolicyHeader(),
          const _PrivacyPolicyContent(),
        ],
      ),
    );
  }
}

class _PrivacyPolicyHeader extends StatelessWidget {
  const _PrivacyPolicyHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'PRIVACY POLICY',
          style: Styles.pageTitle,
        ),
      ],
    );
  }
}

class _PrivacyPolicyContent extends StatelessWidget {
  const _PrivacyPolicyContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 120),
      child: Text(
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
