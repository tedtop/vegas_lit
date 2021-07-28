import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PushNotification extends Equatable {
  PushNotification({
    @required this.title,
    @required this.body,
    this.dataTitle,
    this.dataBody,
  });

  factory PushNotification.fromMap(Map<String, dynamic> map) {
    return PushNotification(
      title: map['title'],
      body: map['body'],
      dataTitle: map['dataTitle'],
      dataBody: map['dataBody'],
    );
  }

  PushNotification copyWith({
    String title,
    String body,
    String dataTitle,
    String dataBody,
  }) {
    return PushNotification(
      title: title ?? this.title,
      body: body ?? this.body,
      dataTitle: dataTitle ?? this.dataTitle,
      dataBody: dataBody ?? this.dataBody,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'dataTitle': dataTitle,
      'dataBody': dataBody,
    };
  }

  final String title;
  final String body;
  final String dataTitle;
  final String dataBody;

  @override
  String toString() {
    return 'PushNotification(title: $title, body: $body, dataTitle: $dataTitle, dataBody: $dataBody)';
  }

  @override
  List<Object> get props => [
        title,
        body,
        dataTitle,
        dataBody,
      ];
}
