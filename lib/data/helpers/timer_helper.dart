import 'package:flutter_countdown_timer/current_remaining_time.dart';

class TimerHelper {
  static String getRemainingTimeText({CurrentRemainingTime time}) {
    final days = time.days == null ? '' : '${time.days}d ';
    final hours = time.hours == null ? '' : '${time.hours}hr';
    final min = time.min == null ? '' : ' ${time.min}m';
    final sec = time.sec == null ? '' : ' ${time.sec}s';
    return days + hours + min + sec;
  }
}
