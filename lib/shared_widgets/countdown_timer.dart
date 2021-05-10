// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:jiffy/jiffy.dart';
// import 'package:vegas_lit/config/palette.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// class CountdownTimer extends StatelessWidget {
//   const CountdownTimer({Key key, @required this.endDateTime}) : super(key: key);

//   final DateTime endDateTime;

//   DateTime fetchTimeEST() {
//     tz.initializeTimeZones();
//     final locationNY = tz.getLocation('America/New_York');
//     final nowNY = tz.TZDateTime.now(locationNY);

//     return nowNY;
//   }

//   num jiffyTest({@required DateTime endTime}) {
//     final est = fetchTimeEST();
//     final jiffy3 = Jiffy(endTime).diff(est);
//     return jiffy3;
//   }

//   void handleTick() {
//     final eventTime = DateTime.parse('2021-01-09 03:41:00');
//     int timeDiff = eventTime.difference(DateTime.now()).inSeconds;
//     if (timeDiff > 0) {
//       if (isActive) {
//         setState(() {
//           if (eventTime != DateTime.now()) {
//             timeDiff = timeDiff - 1;
//           } else {
//             print('Times up!');
//             //Do something
//           }
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: Stream.periodic(Duration(seconds: 1), (i) => i),
//       builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
//         // DateFormat format = DateFormat("mm:ss");
//         // int now = fetchTimeEST().millisecondsSinceEpoch;
//         // print('End Date Time: $endDateTime');
//         // Duration remaining =
//         //     Duration(milliseconds: endDateTime.millisecondsSinceEpoch - now);
//         // print('Remaining $remaining');
//         // var dateString =
//         //     '${remaining.inHours}:${format.format(DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds))}';
//         // print(dateString);
//         return Container(
//           color: Colors.greenAccent.withOpacity(0.3),
//           alignment: Alignment.center,
//           child: Text(dateString.toString()),
//         );
//       },
//     );
//     // return StreamBuilder(
//     //   stream: Stream.periodic(const Duration(seconds: 1), (i) => i),
//     //   builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
//     //     final DateFormat minuteFormat = DateFormat('mm');
//     //     final DateFormat secondsFormat = DateFormat('ss');
//     //     var now = estTimeZone.millisecondsSinceEpoch;
//     //     var remaining =
//     //         Duration(milliseconds: endDateTime.millisecondsSinceEpoch - now);
//     //     var isBefore = estTimeZone.isBefore(endDateTime);
//     //     var hourString =
//     //         remaining.inHours == 0 ? '' : '${remaining.inHours}hr ';

//     //     var dateString =
//     //         'Starting in $hourString${minuteFormat.format(DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds))}m ${secondsFormat.format(DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds))}s';

//     //     return Container(
//     //       alignment: Alignment.center,
//     //       child: isBefore
//     //           ? Text(
//     //               dateString,
//     //               style: GoogleFonts.nunito(
//     //                 color: Palette.red,
//     //               ),
//     //             )
//     //           : Container(),
//     //     );
//     //   },
//     // );
//   }
// }
