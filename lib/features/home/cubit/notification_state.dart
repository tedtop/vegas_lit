

part of 'notification_cubit.dart';

enum NotificationStatus {
  initial,
  loading,
  success,
  failure,
}

class NotificationState extends Equatable {
  const NotificationState({
    this.status = NotificationStatus.initial,
    this.notification,
    this.errorMessage,
  });

  final NotificationStatus status;
  final PushNotification? notification;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, errorMessage, notification];
}
