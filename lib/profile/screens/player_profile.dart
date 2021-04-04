import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';

class PlayerProfile extends StatelessWidget {
  const PlayerProfile._({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const PlayerProfile._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'PLAYER PROFILE',
              textAlign: TextAlign.center,
              style: Styles.pageTitle,
            ),
            const SizedBox(
              height: 35,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 20,
              ),
              height: 220,
              width: double.infinity,
              color: Palette.cream,
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage(
                          Images.placeholderImage,
                        ),
                        radius: 35,
                      ),
                      const SizedBox(
                        width: 26,
                      ),
                      Column(
                        children: [
                          Text(
                            'Carson Wentz',
                            style: GoogleFonts.nunito(
                              color: Palette.darkGrey,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '#11 QB Philadelphia Eagles',
                            style: GoogleFonts.nunito(
                              color: Palette.darkGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                'Height/Weight',
                                textAlign: TextAlign.right,
                                style: GoogleFonts.nunito(
                                  color: Palette.darkGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              '6\'h" / 275 LBS.',
                              style: GoogleFonts.nunito(
                                color: Palette.darkGrey,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                'Date of Birth (Age)',
                                textAlign: TextAlign.right,
                                style: GoogleFonts.nunito(
                                  color: Palette.darkGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              'Dec 30, 1992 (26)',
                              style: GoogleFonts.nunito(
                                color: Palette.darkGrey,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                'Experience',
                                textAlign: TextAlign.right,
                                style: GoogleFonts.nunito(
                                  color: Palette.darkGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              '4th Season',
                              style: GoogleFonts.nunito(
                                color: Palette.darkGrey,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                'Drafted',
                                textAlign: TextAlign.right,
                                style: GoogleFonts.nunito(
                                  color: Palette.darkGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              '2016 / Rd. 1 / Pk. 2(PH)',
                              style: GoogleFonts.nunito(
                                color: Palette.darkGrey,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                'College',
                                textAlign: TextAlign.right,
                                style: GoogleFonts.nunito(
                                  color: Palette.darkGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              'Dorth Dakota State',
                              style: GoogleFonts.nunito(
                                color: Palette.darkGrey,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 24,
                ),
                Card(
                  elevation: 0,
                  color: Palette.green,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: SizedBox(
                    height: 40,
                    width: 60,
                    child: Center(
                      child: Text(
                        'Season',
                        style: GoogleFonts.nunito(
                          color: Palette.cream,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(),
                Card(
                  elevation: 0,
                  color: Palette.green,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: SizedBox(
                    height: 40,
                    width: 52,
                    child: Center(
                      child: Text(
                        'Game',
                        style: GoogleFonts.nunito(
                          color: Palette.cream,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(),
                Card(
                  elevation: 0,
                  color: Palette.green,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: SizedBox(
                    height: 40,
                    width: 48,
                    child: Center(
                      child: Text(
                        '2018',
                        style: GoogleFonts.nunito(
                          color: Palette.cream,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                const Icon(
                  Icons.arrow_circle_down,
                  size: 25,
                  color: Palette.cream,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
