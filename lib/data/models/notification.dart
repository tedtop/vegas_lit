import 'package:equatable/equatable.dart';

class PushNotification extends Equatable {
  const PushNotification({
    required this.title,
    required this.body,
    this.dataTitle,
    this.dataBody,
  });

  factory PushNotification.fromMap(Map<String, dynamic> map) {
    return PushNotification(
      title: map['title'] as String?,
      body: map['body'] as String?,
      dataTitle: map['dataTitle'] as String?,
      dataBody: map['dataBody'] as String?,
    );
  }

  PushNotification copyWith({
    String? title,
    String? body,
    String? dataTitle,
    String? dataBody,
  }) {
    return PushNotification(
      title: title ?? this.title,
      body: body ?? this.body,
      dataTitle: dataTitle ?? this.dataTitle,
      dataBody: dataBody ?? this.dataBody,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'title': title,
      'body': body,
      'dataTitle': dataTitle,
      'dataBody': dataBody,
    };
  }

  final String? title;
  final String? body;
  final String? dataTitle;
  final String? dataBody;

  @override
  String toString() {
    return 'PushNotification(title: $title, body: $body, dataTitle: $dataTitle, dataBody: $dataBody)';
  }

  @override
  List<Object?> get props => [
        title,
        body,
        dataTitle,
        dataBody,
      ];
}
