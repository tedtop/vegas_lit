import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(
          const HomeState.initial(),
        );

  void homeChange(int pageIndex) {
    emit(
      HomeState.changed(pageIndex: pageIndex),
    );
  }
}
