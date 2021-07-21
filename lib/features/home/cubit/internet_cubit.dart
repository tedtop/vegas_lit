import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
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
    final currentStatus = await connectivity.checkConnectivity();
    if (currentStatus == ConnectivityResult.wifi) {
      emitInternetConnected(ConnectionType.wifi);
    } else if (currentStatus == ConnectivityResult.mobile) {
      emitInternetConnected(ConnectionType.mobile);
    } else if (currentStatus == ConnectivityResult.none) {
      emitInternetDisconnected();
    }
    await connectivityStreamSubscription?.cancel();
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen(
      (connectivityResult) {
        if (connectivityResult == ConnectivityResult.wifi) {
          emitInternetConnected(ConnectionType.wifi);
        } else if (connectivityResult == ConnectivityResult.mobile) {
          emitInternetConnected(ConnectionType.mobile);
        } else if (connectivityResult == ConnectivityResult.none) {
          emitInternetDisconnected();
        }
      },
    );
  }

  Future<void> checkInternetConnection() async {
    final currentStatus = await connectivity.checkConnectivity();
    if (currentStatus == ConnectivityResult.wifi) {
      emitInternetConnected(ConnectionType.wifi);
    } else if (currentStatus == ConnectivityResult.mobile) {
      emitInternetConnected(ConnectionType.mobile);
    } else if (currentStatus == ConnectivityResult.none) {
      emitInternetDisconnected();
    }
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
