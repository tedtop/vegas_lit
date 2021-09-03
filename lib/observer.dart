import 'package:bloc/bloc.dart';
import 'package:vegas_lit/utils/logger.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    logger.d('${bloc.runtimeType} $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    logger.d('${bloc.runtimeType} $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(Cubit cubit) {
    logger.d('Closed: $cubit');
    super.onClose(cubit);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    if (cubit is! Bloc) {
      logger.d('${cubit.runtimeType} $change');
    }
    super.onChange(cubit, change);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    logger.d('${cubit.runtimeType} $error $stackTrace');
    super.onError(cubit, error, stackTrace);
  }
}
