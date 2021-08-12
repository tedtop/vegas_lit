import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegas_lit/config/extensions.dart';

class SharedPrefHelper {
  static Future<bool> isFirstTime({SharedPreferences sharedPref}) async {
    final isFirstTime = sharedPref.getBool('first_time');
    if (isFirstTime != null && !isFirstTime) {
      await sharedPref.setBool('first_time', false);
      return false;
    } else {
      await sharedPref.setBool('first_time', false);
      return true;
    }
  }

  static Future<bool> isRulesShown({SharedPreferences sharedPref}) async {
    final currentWeek = ESTDateTime.fetchTimeEST().weekStringVL;
    final storedWeek = sharedPref.getString('week');
    if (storedWeek != currentWeek) {
      await sharedPref.setString('week', currentWeek);
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> shouldAskReview({SharedPreferences sharedPref}) async {
    final today = ESTDateTime.fetchTimeEST();
    final reviewDayStr = sharedPref.getString('review_day');
    if (reviewDayStr != null) {
      final reviewDay = DateTime.parse(reviewDayStr);
      if (!reviewDay.isBefore(today.subtract(const Duration(days: 28)))) {
        return false;
      }
    }
    await sharedPref.setString('review_day', today.toString());
    return true;
  }
}
