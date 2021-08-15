import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // ignore: avoid_print
  print('Handling a background message: ${message.messageId}');
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