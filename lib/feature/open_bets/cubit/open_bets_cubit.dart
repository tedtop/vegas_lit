import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vegas_lit/data/models/open_bets.dart';
import 'package:vegas_lit/data/repositories/bets_repository.dart';

part 'open_bets_state.dart';

class OpenBetsCubit extends Cubit<OpenBetsState> {
  OpenBetsCubit({@required BetsRepository betsRepository})
      : assert(betsRepository != null),
        _betsRepository = betsRepository,
        super(
          OpenBetsInitial(),
        );

  final BetsRepository _betsRepository;
  StreamSubscription _openBetsSubscription;

  Future<void> openBetsOpen({String currentUserId}) async {
    emit(
      OpenBetsOpened(
        openBets: [],
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

  @override
  Future<void> close() async {
    await _openBetsSubscription?.cancel();
    return super.close();
  }
}
