import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vegas_lit/config/palette.dart';

class CountdownTimer extends StatelessWidget {
  const CountdownTimer({
    Key key,
    @required this.estTimeZone,
    @required this.endDateTime,
  }) : super(key: key);

  final DateTime estTimeZone;
  final DateTime endDateTime;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1), (i) => i),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          final DateFormat minuteFormat = DateFormat('mm');
          final DateFormat secondsFormat = DateFormat('ss');
          var now = estTimeZone.millisecondsSinceEpoch;
          var remaining =
              Duration(milliseconds: endDateTime.millisecondsSinceEpoch - now);
          var isBefore = estTimeZone.isBefore(endDateTime);
          var hourString =
              remaining.inHours == 0 ? '' : '${remaining.inHours}hr ';

          var dateString =
              'Starting in $hourString${minuteFormat.format(DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds))}m ${secondsFormat.format(DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds))}s';

          return Container(
            alignment: Alignment.center,
            child: isBefore
                ? Text(
                    dateString,
                    style: GoogleFonts.nunito(
                      color: Palette.red,
                    ),
                  )
                : Container(),
          );
        });
  }
}
