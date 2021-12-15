// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print('${bloc.runtimeType} $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('${bloc.runtimeType} $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onCreate(BlocBase bloc) {
    print('${bloc.runtimeType} ${bloc.state}');
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    print('${bloc.runtimeType} ${bloc.state}');
    super.onClose(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    if (bloc is! Bloc) {
      print('${bloc.runtimeType} $change');
    }
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
