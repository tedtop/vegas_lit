import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'open_bets_state.dart';

class OpenBetsCubit extends Cubit<OpenBetsState> {
  OpenBetsCubit({@required BetsRepository betsRepository})
      : assert(betsRepository != null),
        _betsRepository = betsRepository,
        super(
          const OpenBetsState.initial(),
        );

  final BetsRepository _betsRepository;
  StreamSubscription _openBetsSubscription;

  Future<void> openBetsOpen({List<OpenBetsData> openBetsDataList}) async {
    emit(
      OpenBetsState.opened(
        openBetsDataList: openBetsDataList,
      ),
    );
    // final openBetsData = _betsRepository.fetchOpenBetsByUserId(currentUserId);
    // await _openBetsSubscription?.cancel();
    // _openBetsSubscription = openBetsData.listen(
    //   (event) {
    //     emit(
    //       OpenBetsOpened(openBets: event),
    //     );
    //   },
    // );
  }

  void updateOpenBets({OpenBetsData openBetsData}) {
    final newList = state.openBetsDataList..add(openBetsData);

    emit(
      OpenBetsState.opened(
        openBetsDataList: List.of(newList),
      ),
    );
  }

  @override
  Future<void> close() async {
    await _openBetsSubscription?.cancel();
    return super.close();
  }
}