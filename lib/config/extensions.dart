import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'palette.dart';

extension ESTDateTime on DateTime {
  static DateTime fetchTimeEST() {
    tz.initializeTimeZones();
    final locationNY = tz.getLocation('America/New_York');
    final nowNY = tz.TZDateTime.now(locationNY);
    final dateTimeNY = DateTime(
      nowNY.year,
      nowNY.month,
      nowNY.day,
      nowNY.hour,
      nowNY.minute,
      nowNY.second,
    );
    return dateTimeNY;
  }

  static int getESTmillisecondsSinceEpoch(DateTime time) {
    tz.initializeTimeZones();
    final locationNY = tz.getLocation('America/New_York');
    final nowNY = tz.TZDateTime.now(locationNY);
    final easternTime = DateTime(
      nowNY.year,
      nowNY.month,
      nowNY.day,
      nowNY.hour,
      nowNY.minute,
      nowNY.second,
      nowNY.millisecond,
      nowNY.microsecond,
    );
    final localTime = DateTime.now().toLocal();
    final diff = localTime.difference(easternTime);
    return time.add(diff).millisecondsSinceEpoch;
  }

  // Don't pass anything in parameter if weeknumber of the year is needed keeping thursday as the week's start
  static int get weekNumberVL {
    final firstDayOfThatYear = DateTime(
      ESTDateTime.fetchTimeEST().year,
    ).weekday;
    const firstDayOfEveryWeek = DateTime.sunday;
    final firstWeekLength = firstDayOfThatYear < firstDayOfEveryWeek
        ? (firstDayOfEveryWeek - firstDayOfThatYear)
        : (firstDayOfEveryWeek - firstDayOfThatYear + 7);
    final yearNumberNow =
        int.parse(DateFormat('D').format(ESTDateTime.fetchTimeEST()));
    final weekNumberNow = yearNumberNow <= firstWeekLength
        ? 1
        : (((yearNumberNow - firstWeekLength) / 7).ceil() + 1);
    return weekNumberNow;
  }

  // ignore: missing_return
  String get weekStringVL {
    final weekNumber = ESTDateTime.weekNumberVL;
    switch (weekday) {
      case DateTime.sunday:
      case DateTime.monday:
      case DateTime.tuesday:
      case DateTime.wednesday:
        return '$year-${weekNumber - 1}-$weekNumber';
      case DateTime.thursday:
      case DateTime.friday:
      case DateTime.saturday:
        return '$year-$weekNumber-${weekNumber + 1}';
      default:
        return '$year-${weekNumber - 1}-$weekNumber';
    }
  }

  String get previousWeekStringVL {
    final weekNumber = ESTDateTime.weekNumberVL;
    switch (weekday) {
      case DateTime.sunday:
      case DateTime.monday:
      case DateTime.tuesday:
      case DateTime.wednesday:
        return '$year-${weekNumber - 1 - 1}-${weekNumber - 1}';
      case DateTime.thursday:
      case DateTime.friday:
      case DateTime.saturday:
        return '$year-${weekNumber - 1}-${weekNumber + 1 - 1}';
      default:
        return '$year-${weekNumber - 1 - 1}-${weekNumber - 1}';
    }
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay plusMinutes(int minutes) {
    if (minutes == 0) {
      return this;
    } else {
      final mofd = hour * 60 + minute;
      final newMofd = ((minutes % 1440) + mofd + 1440) % 1440;
      if (mofd == newMofd) {
        return this;
      } else {
        final newHour = newMofd ~/ 60;
        final newMinute = newMofd % 60;
        return TimeOfDay(hour: newHour, minute: newMinute);
      }
    }
  }
}

extension VLTextStyle on TextStyle {
  static TextStyle get nunito => GoogleFonts.nunito();
  static TextStyle get emoji => GoogleFonts.notoColorEmojiCompat();

  TextStyle size(double s) => copyWith(fontSize: s);

  TextStyle weight(FontWeight w) => copyWith(fontWeight: w);
  TextStyle get w100 => weight(FontWeight.w100);
  TextStyle get w200 => weight(FontWeight.w200);
  TextStyle get w300 => weight(FontWeight.w300);
  TextStyle get w400 => weight(FontWeight.w400);
  TextStyle get w500 => weight(FontWeight.w500);
  TextStyle get w600 => weight(FontWeight.w600);
  TextStyle get w700 => weight(FontWeight.w700);
  TextStyle get w800 => weight(FontWeight.w800);
  TextStyle get w900 => weight(FontWeight.w900);
  TextStyle get bold => w700;
  TextStyle get semiBold => w500;
  TextStyle get normal => w400;

  TextStyle color(Color c) => copyWith(color: c);
  TextStyle get creamColored => color(Palette.cream);
  TextStyle get greenColored => color(Palette.green);
  TextStyle get redColored => color(Palette.red);

  TextStyle withShadows(List<Shadow> sh) => copyWith(shadows: sh);
}
