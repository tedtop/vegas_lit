import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/home/cubit/home_cubit.dart';
import 'package:vegas_lit/home/widgets/bottombar.dart';
import '../cubit/open_bets_cubit.dart';
import 'open_bet_card.dart';

class OpenBets extends StatelessWidget {
  const OpenBets._({Key key}) : super(key: key);

  static Builder route() {
    return Builder(
      builder: (context) {
        return const OpenBets._();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.darkGrey,
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'OPEN BETS',
                  style: Styles.pageTitle,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 4,
            ),
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Palette.cream,
                ),
                children: <TextSpan>[
                  const TextSpan(
                    text:
                        // ignore: lines_longer_than_80_chars
                        'Bets shown here cannot be modified and are awaiting the outcome of the event. Once bets have been closed they will appear in your',
                  ),
                  TextSpan(
                      text: ' BET HISTORY ',
                      style: GoogleFonts.nunito(
                        color: Palette.green,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.read<HomeCubit>().homeChange(4);
                        }),
                  const TextSpan(
                    text: 'page.',
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<OpenBetsCubit, OpenBetsState>(
            builder: (context, state) {
              switch (state.status) {
                case OpenBetsStatus.opened:
                  if (state.openBetsDataList.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 120),
                      child: Text(
                        // ignore: lines_longer_than_80_chars
                        'No bets placed. \nPlace some bets to show them here.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          color: Palette.cream,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    key: Key('${state.openBetsDataList.length}'),
                    itemCount: state.openBetsDataList.length,
                    itemBuilder: (context, index) {
                      return OpenBetsSlip(
                        openBets: state.openBetsDataList[index],
                      );
                    },
                  );
                  break;
                default:
                  return const CircularProgressIndicator();
              }
            },
          ),
          kIsWeb ? const BottomBar() : const SizedBox(),
        ],
      ),
    );
  }
}

class TextBar extends StatelessWidget {
  const TextBar({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Container(
          color: Palette.green,
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          height: 40,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Palette.cream,
                ),
              ),
              const Icon(
                LineAwesomeIcons.arrow_circle_down,
                size: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
