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

  Future<void> openBetsOpen({@required String currentUserId}) async {
    // emit(
    //   OpenBetsState.opened(
    //     openBetsDataList: openBetsDataList,
    //   ),
    // );
    final openBetsData = _betsRepository.fetchOpenBetsByUserId(currentUserId);
    await _openBetsSubscription?.cancel();
    _openBetsSubscription = openBetsData.listen(
      (event) {
        emit(
          OpenBetsState.opened(openBetsDataList: event),
        );
      },
    );
  }

  Future<void> updateOpenBets({
    // OpenBetsData openBetsData,
    @required String currentUserId,
    @required Map openBetsData,
  }) async {
    // final newList = state.openBetsDataList..add(openBetsData);

    // emit(
    //   OpenBetsState.opened(
    //     openBetsDataList: List.of(newList),
    //   ),
    // );

    await _betsRepository.saveOpenBetsById(
      currentUserId: currentUserId,
      openBetsData: openBetsData,
    );
  }

  @override
  Future<void> close() async {
    await _openBetsSubscription?.cancel();
    return super.close();
  }
}
