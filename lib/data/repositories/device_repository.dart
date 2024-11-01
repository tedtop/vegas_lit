import 'package:firebase_messaging/firebase_messaging.dart';

import '../providers/app_review.dart';
import '../providers/cloud_messaging.dart';
import '../providers/remote_config.dart';
import '../providers/shared_prefs.dart';

class DeviceRepository {
  DeviceRepository({
    CloudMessagingClient? messagingProvider,
    AppReviewClient? appReviewProvider,
    RemoteConfigClient? remoteConfigProvider,
  })  : _messagingProvider = messagingProvider ?? CloudMessagingClient(),
        _appReviewProvider = appReviewProvider ?? AppReviewClient(),
        _remoteConfigProvider = remoteConfigProvider ?? RemoteConfigClient();

  static Future<DeviceRepository> create() async {
    final component = DeviceRepository();
    await component.initSharedPrefs();
    return component;
  }

  final CloudMessagingClient _messagingProvider;
  final AppReviewClient _appReviewProvider;
  final RemoteConfigClient _remoteConfigProvider;
  late SharedPreferencesClient _sharedPreferencesProvider;

  Future<void> initSharedPrefs() async =>
      _sharedPreferencesProvider = await SharedPreferencesClient.create();

  Future<void> handleBackgroundNotification() =>
      _messagingProvider.handleBackgroundNotification();

  Future<NotificationSettings> requestNotificationPermission() =>
      _messagingProvider.requestNotificationPermission();

  Stream<RemoteMessage> handleForegroundNotification() =>
      _messagingProvider.handleForegroundNotification();

  Future<RemoteMessage?> checkInitialPushMessage() =>
      _messagingProvider.checkInitialPushMessage();

  Stream<RemoteMessage> handleOpenBackgroundNotification() =>
      _messagingProvider.handleOpenBackgroundNotification();

  Future<void> openAppReview() => _appReviewProvider.openAppReview();

  Future<void> setDefaultLeague({required String league}) =>
      _remoteConfigProvider.setDefaultLeague(league: league);

  Future<void> fetchAndActivateRemote() =>
      _remoteConfigProvider.fetchAndActivateRemote();

  String fetchRemoteLeague() => _remoteConfigProvider.fetchRemoteLeague;

  Future<bool> shouldAskReview() =>
      _sharedPreferencesProvider.shouldAskReview();

  Future<bool> isFirstTime() => _sharedPreferencesProvider.isFirstTime();

  Future<bool> isRulesShown() => _sharedPreferencesProvider.isRulesShown();
}
