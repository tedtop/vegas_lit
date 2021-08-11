import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:vegas_lit/data/providers/cloud_messaging.dart';
import 'package:vegas_lit/data/providers/device_provider.dart';

class DeviceRepository {
  final _messagingProvider = CloudMessagingClient();
  final _deviceProvider = DeviceProvider();

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
}
