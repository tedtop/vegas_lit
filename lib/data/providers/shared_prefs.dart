import 'package:shared_preferences/shared_preferences.dart';
import '../../config/extensions.dart';

class SharedPreferencesClient {
  SharedPreferences _sharedPreferences;

  static Future<SharedPreferencesClient> create() async {
    final component = SharedPreferencesClient();
    await component.initSharedPrefs();
    return component;
  }

  Future<SharedPreferences> initSharedPrefs() async =>
      _sharedPreferences = await SharedPreferences.getInstance();

  Future<bool> shouldAskReview() async {
    final today = ESTDateTime.fetchTimeEST();
    final reviewDayStr = _sharedPreferences.getString('review_day');
    if (reviewDayStr != null) {
      final reviewDay = DateTime.parse(reviewDayStr);
      if (!reviewDay.isBefore(today.subtract(const Duration(days: 28)))) {
        return false;
      }
    }
    await _sharedPreferences.setString('review_day', today.toString());
    return true;
  }

  Future<bool> isFirstTime() async {
    final isFirstTime = _sharedPreferences.getBool('first_time');
    if (isFirstTime != null && !isFirstTime) {
      await _sharedPreferences.setBool('first_time', false);
      return false;
    } else {
      await _sharedPreferences.setBool('first_time', false);
      return true;
    }
  }

  Future<bool> isRulesShown() async {
    final currentWeek = ESTDateTime.fetchTimeEST().weekStringVL;
    final storedWeek = _sharedPreferences.getString('week');
    if (storedWeek != currentWeek) {
      await _sharedPreferences.setString('week', currentWeek);
      return false;
    } else {
      return true;
    }
  }
}
