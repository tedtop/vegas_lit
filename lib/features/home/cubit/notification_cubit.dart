import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';
import '../../../data/models/notification.dart';
import '../../../data/repositories/device_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({@required DeviceRepository deviceRepository})
      : assert(deviceRepository != null),
        _deviceRepository = deviceRepository,
        super(
          const NotificationState(),
        );

  final DeviceRepository _deviceRepository;
  StreamSubscription _foregroundNotification;
  StreamSubscription _backgroundNotificationOpened;

  Future<void> initializePushNotification() async {
    emit(
      const NotificationState(status: NotificationStatus.loading),
    );
    await _deviceRepository.handleBackgroundNotification();
    final settings = await _deviceRepository.requestNotificationPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      final pushNotiStream = _deviceRepository.handleForegroundNotification();
      await _foregroundNotification?.cancel();
      _foregroundNotification = pushNotiStream.listen(
        (message) {
          print(
              'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');

          emit(
            NotificationState(
              status: NotificationStatus.success,
              notification: PushNotification(
                title: message.notification?.title,
                body: message.notification?.body,
                dataTitle: message.data['title'],
                dataBody: message.data['body'],
              ),
            ),
          );

          // showSimpleNotification(
          //  Text(_notificationInfo.title),
          //   leading: NotificationBadge(totalNotifications: _totalNotifications),
          //   subtitle:Text(_notificationInfo.body),
          //   background: Colors.cyan.shade700,
          //   duration: Duration(seconds: 2),
          // );
        },
      );
      final initialMessage = await _deviceRepository.checkInitialPushMessage();
      if (initialMessage != null) {
        // ignore: avoid_print
        print('Initial Message Found!');
        emit(
          NotificationState(
            status: NotificationStatus.success,
            notification: PushNotification(
              title: initialMessage.notification?.title,
              body: initialMessage.notification?.body,
              dataTitle: initialMessage.data['title'],
              dataBody: initialMessage.data['body'],
            ),
          ),
        );
      } else {
        // ignore: avoid_print
        print('Initial Message Not Found!');
      }
      final backgroundMessageOpened =
          _deviceRepository.handleOpenBackgroundNotification();
      await _backgroundNotificationOpened?.cancel();
      _backgroundNotificationOpened = backgroundMessageOpened.listen((event) {
        // ignore: avoid_print
        print('Background Notification Clicked');
      });
    } else {
      // ignore: avoid_print
      print('User declined or has not accepted permission');
      emit(
        const NotificationState(
          status: NotificationStatus.failure,
          errorMessage: 'Permission Denied',
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    await _backgroundNotificationOpened?.cancel();
    await _foregroundNotification?.cancel();
    return super.close();
  }
}
