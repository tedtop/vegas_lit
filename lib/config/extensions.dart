import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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

  // Don't pass anything in parameter if weeknumber of the year is needed keeping thursday as the week's start
  static int get weekNumberVL {
    final firstDayOfThatYear =
        DateTime(ESTDateTime.fetchTimeEST().year, 1, 1).weekday;
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
  static String get weekStringVL {
    final time = ESTDateTime.fetchTimeEST();
    final weekNumber = ESTDateTime.weekNumberVL;
    switch (time.weekday) {
      case DateTime.sunday:
      case DateTime.monday:
      case DateTime.tuesday:
      case DateTime.wednesday:
        return '${time.year}-${weekNumber - 1}-$weekNumber';
        break;
      case DateTime.thursday:
      case DateTime.friday:
      case DateTime.saturday:
        return '${time.year}-$weekNumber-${weekNumber + 1}';
        break;
    }
  }
}
