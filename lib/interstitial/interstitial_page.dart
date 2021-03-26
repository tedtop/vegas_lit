import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';

class Interstitial extends StatelessWidget {
  const Interstitial._({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (context) {
        return const Interstitial._();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Interstitial Ad',
              style: GoogleFonts.nunito(
                color: Palette.cream,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
              child: Text(
                'Continue',
                style: GoogleFonts.nunito(
                  color: Palette.cream,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
