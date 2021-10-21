import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../data/models/golf/golf.dart';
import '../cubit/golf_cubit.dart';
import 'textbar.dart';

class GolfMatchup extends StatefulWidget {
  GolfMatchup(
      {this.player, this.name, this.venue, this.location, this.tournamentID});
  final int tournamentID;
  final String name, venue, location;
  final GolfPlayer player;
  @override
  _GolfMatchupState createState() => _GolfMatchupState();
}

class _GolfMatchupState extends State<GolfMatchup> {
  int roundNumber = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextBar(
            text: 'PLAYER BETS',
            textList: ['PLAYER BETS'],
            onPress: (String value) {}),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                padding: const EdgeInsets.all(10),
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  BlocProvider.of<GolfCubit>(context).fetchTournamentDetails(
                      tournamentID: widget.tournamentID);
                }),
            Expanded(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      widget.name,
                      style: Styles.greenTextBold.copyWith(fontSize: 24),
                    ),
                  ),
                  Center(
                    child: Text(
                      widget.venue,
                      style: Styles.awayTeam,
                    ),
                  ),
                  Center(
                    child: Text(
                      widget.location,
                      style: Styles.awayTeam,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RoundNumberBox(
                onPressed: () {
                  setState(() {
                    if (roundNumber != 0) roundNumber = 0;
                  });
                },
                text: 'Overall',
                isSelected: roundNumber == 0,
              ),
              RoundNumberBox(
                onPressed: () {
                  setState(() {
                    if (roundNumber != 1) roundNumber = 1;
                  });
                },
                text: 'Round 1',
                isSelected: roundNumber == 1,
              ),
              RoundNumberBox(
                onPressed: () {
                  setState(() {
                    if (roundNumber != 2) roundNumber = 2;
                  });
                },
                text: 'Round 2',
                isSelected: roundNumber == 2,
              ),
              RoundNumberBox(
                onPressed: () {
                  setState(() {
                    if (roundNumber != 3) roundNumber = 3;
                  });
                },
                text: 'Round 3',
                isSelected: roundNumber == 3,
              ),
              RoundNumberBox(
                onPressed: () {
                  setState(() {
                    if (roundNumber != 4) roundNumber = 4;
                  });
                },
                text: 'Round 4',
                isSelected: roundNumber == 4,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: [
              Text('GOLFER', style: Styles.normalTextBold),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Palette.cream),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text('${widget.player.name}',
                        style: Styles.normalTextBold),
                  ),
                ),
              )
            ],
          ),
        ),
        roundNumber == 0
            ? OverallBetBoxes()
            : RoundBasedBetBoxes(
                roundNo: roundNumber,
              )
      ],
    );
  }
}

class OverallBetBoxes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: OverallBetBox(
                text: 'MOST BIRDIES',
                isSelected: false,
                onPressed: () {},
              ),
            ),
            Expanded(
              child: OverallBetBox(
                text: 'MOST BOGEYS',
                isSelected: false,
                onPressed: () {},
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: OverallBetBox(
                text: 'MOST EAGLES',
                isSelected: false,
                onPressed: () {},
              ),
            ),
            Expanded(
              child: OverallBetBox(
                text: 'HOLE IN ONE',
                isSelected: false,
                onPressed: () {},
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: OverallBetBox(
                text: 'LEAST BOGEYS',
                isSelected: false,
                onPressed: () {},
              ),
            ),
            Expanded(
              child: OverallBetBox(
                text: 'MOST PARS',
                isSelected: false,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RoundBasedBetBoxes extends StatelessWidget {
  RoundBasedBetBoxes({this.roundNo});
  final int roundNo;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: RoundBetBox(
                onPressed: () {},
                isSelected: false,
                text: Text(
                  'DOUBLE EAGLE +500',
                  style: Styles.awayTeam,
                ),
              ),
            ),
            Expanded(
              child: RoundBetBox(
                onPressed: () {},
                isSelected: false,
                text: Text(
                  'MAKE TOP 5 +500',
                  style: Styles.awayTeam,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: RoundBetBox(
                onPressed: () {},
                isSelected: false,
                text: Text(
                  'HOLE IN ONE +2000',
                  style: Styles.awayTeam,
                ),
              ),
            ),
            Expanded(
              child: RoundBetBox(
                onPressed: () {},
                isSelected: false,
                text: Text(
                  '15+ PARS +1000',
                  style: Styles.awayTeam,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: RoundBetBox(
                onPressed: () {},
                isSelected: false,
                text: Text(
                  '2+ EAGLES +500',
                  style: Styles.awayTeam,
                ),
              ),
            ),
            Expanded(
              child: RoundBetBox(
                onPressed: () {},
                isSelected: false,
                text: Text(
                  '9+ BIRDIES +1000',
                  style: Styles.awayTeam,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: RoundBetBox(
                onPressed: () {},
                isSelected: false,
                text: Text(
                  '6+ BIRDIES +500',
                  style: Styles.awayTeam,
                ),
              ),
            ),
            Expanded(
              child: RoundBetBox(
                onPressed: () {},
                isSelected: false,
                text: Text(
                  'BOGEY FREE +1000',
                  style: Styles.awayTeam,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class OverallBetBox extends StatelessWidget {
  OverallBetBox({this.text, this.isSelected = false, this.onPressed});
  final String text;
  final bool isSelected;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        decoration: BoxDecoration(
            border: Border.all(color: Palette.cream),
            borderRadius: BorderRadius.circular(8),
            color: isSelected ? Palette.green : Palette.darkGrey),
        child: Center(
          child: Text(
            text,
            style: Styles.normalText.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class RoundNumberBox extends StatelessWidget {
  RoundNumberBox({this.text, this.isSelected = false, this.onPressed});
  final String text;
  final bool isSelected;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isSelected ? Palette.green : Palette.lightGrey),
        child: Text(
          text,
          style: Styles.awayTeam.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class RoundBetBox extends StatelessWidget {
  RoundBetBox({this.text, this.onPressed, this.isSelected = false});
  final Widget text;
  final bool isSelected;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Palette.green : Palette.lightGrey),
      child: GestureDetector(
        child: Center(child: text),
        onTap: () => onPressed,
      ),
    );
  }
}
