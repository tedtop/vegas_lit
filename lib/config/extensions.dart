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
}
