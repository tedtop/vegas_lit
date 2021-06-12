import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:vegas_lit/data/models/bet.dart';

extension ESTDateTime on DateTime {
  static DateTime fetchTimeEST() {
    tz.initializeTimeZones();
    final locationNY = tz.getLocation('America/New_York');
    final nowNY = tz.TZDateTime.now(locationNY);
    final dateTimeNY = DateTime(nowNY.year, nowNY.month, nowNY.day, nowNY.hour,
        nowNY.minute, nowNY.second);
    return dateTimeNY;
  }

  static int getESTmillisecondsSinceEpoch(DateTime time) {
    tz.initializeTimeZones();
    final locationNY = tz.getLocation('America/New_York');
    final nowNY = tz.TZDateTime.now(locationNY);
    final easternTime = DateTime(nowNY.year, nowNY.month, nowNY.day, nowNY.hour,
        nowNY.minute, nowNY.second, nowNY.millisecond, nowNY.microsecond);
    final localTime = DateTime.now().toLocal();
    final diff = localTime.difference(easternTime);
    return time.add(diff).millisecondsSinceEpoch;
  }

  bool get isLeapYear {
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  }

  int get ordinalDate {
    const offsets = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
    return offsets[month - 1] + day + (isLeapYear && month > 2 ? 1 : 0);
  }

  int get weekOfYear {
    final woy = ((ordinalDate - weekday + 10) ~/ 7);
    if (woy == 0) {
      return DateTime(year - 1, 12, 28).weekOfYear;
    }
    if (woy == 53 &&
        DateTime(year, 1, 1).weekday != DateTime.thursday &&
        DateTime(year, 12, 31).weekday != DateTime.thursday) {
      return 1;
    }
    return woy;
  }
}

extension BetDataUtility on BetData {
  // ignore: missing_return
  static String get getBetWeek {
    final time = ESTDateTime.fetchTimeEST();
    switch (time.weekday) {
      case DateTime.monday:
      case DateTime.tuesday:
      case DateTime.wednesday:
        return '${time.year}-${time.weekOfYear - 1}-${time.weekOfYear}';
        break;
      case DateTime.thursday:
      case DateTime.friday:
      case DateTime.saturday:
      case DateTime.sunday:
        return '${time.year}-${time.weekOfYear}-${time.weekOfYear + 1}';
        break;
    }
  }
}
