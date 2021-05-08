import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  InternetCubit({@required this.connectivity}) : super(InternetLoading()) {
    monitorInternetConnection();
  }

  final Connectivity connectivity;
  StreamSubscription connectivityStreamSubscription;

  Future<StreamSubscription<ConnectivityResult>>
      monitorInternetConnection() async {
    final logger = Logger();
    final currentStatus = await connectivity.checkConnectivity();
    if (currentStatus == ConnectivityResult.wifi) {
      logger.d("WIFI");
      emitInternetConnected(ConnectionType.wifi);
    } else if (currentStatus == ConnectivityResult.mobile) {
      logger.d("Mobile");
      emitInternetConnected(ConnectionType.mobile);
    } else if (currentStatus == ConnectivityResult.none) {
      logger.d("Disconnected");
      emitInternetDisconnected();
    }
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen(
      (connectivityResult) {
        if (connectivityResult == ConnectivityResult.wifi) {
          logger.d("WIFI");
          emitInternetConnected(ConnectionType.wifi);
        } else if (connectivityResult == ConnectivityResult.mobile) {
          logger.d("Mobile");
          emitInternetConnected(ConnectionType.mobile);
        } else if (connectivityResult == ConnectivityResult.none) {
          logger.d("Disconnected");
          emitInternetDisconnected();
        }
      },
    );
  }

  void emitInternetConnected(ConnectionType _connectionType) =>
      emit(InternetConnected(connectionType: _connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
