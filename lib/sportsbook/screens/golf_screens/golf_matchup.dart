import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/sportsbook/bloc/sportsbook_bloc.dart';

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
  int selectedDay = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                padding: const EdgeInsets.all(10),
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  BlocProvider.of<SportsbookBloc>(context)
                      .add(GolfDetailOpen(tournamentID: widget.tournamentID));
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  if (selectedDay != 1) selectedDay = 1;
                });
              },
              child: GolfBetBox(
                text: 'Day 1',
                isSelected: selectedDay == 1,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (selectedDay != 2) selectedDay = 2;
                });
              },
              child: GolfBetBox(
                text: 'Day 2',
                isSelected: selectedDay == 2,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (selectedDay != 3) selectedDay = 3;
                });
              },
              child: GolfBetBox(
                text: 'Day 3',
                isSelected: selectedDay == 3,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (selectedDay != 4) selectedDay = 4;
                });
              },
              child: GolfBetBox(
                text: 'Final',
                isSelected: selectedDay == 4,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class GolfBetBox extends StatelessWidget {
  GolfBetBox({this.text, this.isSelected = false});
  final String text;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Palette.green : Palette.lightGrey),
      child: Text(
        text,
        style: Styles.normalTextBold,
      ),
    );
  }
}
