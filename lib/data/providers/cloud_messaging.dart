import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:vegas_lit/utils/logger.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  logger.i('Handling a background message: ${message.messageId}');
}

class CloudMessagingClient {
  CloudMessagingClient({FirebaseMessaging firebaseMessaging})
      : _firebaseMessaging = firebaseMessaging ?? FirebaseMessaging.instance;

  final FirebaseMessaging _firebaseMessaging;

  Future<void> handleBackgroundNotification() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<NotificationSettings> requestNotificationPermission() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    return settings;
  }

  Stream<RemoteMessage> handleForegroundNotification() {
    return FirebaseMessaging.onMessage;
  }

  Future<RemoteMessage> checkInitialPushMessage() async {
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    return initialMessage;
  }

  Stream<RemoteMessage> handleOpenBackgroundNotification() {
    return FirebaseMessaging.onMessageOpenedApp;
  }
}
