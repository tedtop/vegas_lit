import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:vegas_lit/data/providers/cloud_messaging.dart';
import 'package:vegas_lit/data/providers/device_provider.dart';
import 'package:vegas_lit/data/providers/remote_config.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/providers/shared_preferences.dart';

class DeviceRepository {
  final _messagingProvider = CloudMessagingClient();
  final _deviceProvider = DeviceProvider();
  final _remoteConfigProvider = RemoteConfigClient();
  final _sharedPreferencesProvider = SharedPreferencesClient();

  Future<void> handleBackgroundNotification() =>
      _messagingProvider.handleBackgroundNotification();

  Future<NotificationSettings> requestNotificationPermission() =>
      _messagingProvider.requestNotificationPermission();

  Stream<RemoteMessage> handleForegroundNotification() =>
      _messagingProvider.handleForegroundNotification();

  Future<RemoteMessage> checkInitialPushMessage() =>
      _messagingProvider.checkInitialPushMessage();

  Stream<RemoteMessage> handleOpenBackgroundNotification() =>
      _messagingProvider.handleOpenBackgroundNotification();

  Future<void> openAppReview() => _deviceProvider.openAppReview();

  Future<void> setDefaultLeague({@required String league}) =>
      _remoteConfigProvider.setDefaultLeague(league: league);

  Future<void> fetchAndActivateRemote() =>
      _remoteConfigProvider.fetchAndActivateRemote();

  String fetchRemoteLeague() => _remoteConfigProvider.fetchRemoteLeague;

  Future<bool> shouldAskReview() =>
      _sharedPreferencesProvider.shouldAskReview();

  Future<bool> isFirstTime() => _sharedPreferencesProvider.isFirstTime();

  Future<bool> isRulesShown() => _sharedPreferencesProvider.isRulesShown();
}
