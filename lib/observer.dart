

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

  // @override
  // void onClose(Cubit cubit) {
  //   print('Closed: $cubit');
  //   super.onClose(cubit);
  // }

  // @override
  // void onChange(Cubit cubit, Change change) {
  //   if (cubit is! Bloc) {
  //     print('${cubit.runtimeType} $change');
  //   }
  //   super.onChange(cubit, change);
  // }

  // @override
  // void onError(Cubit cubit, Object error, StackTrace stackTrace) {
  //   print('${cubit.runtimeType} $error $stackTrace');
  //   super.onError(cubit, error, stackTrace);
  // }
}
