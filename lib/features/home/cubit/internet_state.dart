part of 'internet_cubit.dart';

enum ConnectionType {
  wifi,
  mobile,
}

@immutable
abstract class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  InternetConnected({@required this.connectionType});

  final ConnectionType connectionType;
}

class InternetDisconnected extends InternetState {}
