import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../data/models/vault_data.dart';
import '../../../data/repositories/user_repository.dart';

part 'admin_vault_state.dart';

class AdminVaultCubit extends Cubit<AdminVaultState> {
  AdminVaultCubit({@required this.userRepository}) : super(AdminVaultInitial());
  UserRepository userRepository;
  StreamSubscription _subscription;

  void fetchAdminVaultData() async {
    final cumulativeData = await userRepository.fetchCumulativeAdminVaultData();

    final adminDataStream = userRepository.fetchAllDataDateWise();
    await _subscription?.cancel();
    _subscription = adminDataStream.listen((adminData) {
      emit(AdminVaultDataFetched(
        cumulativeData: cumulativeData,
        totalData: adminData,
      ));
    });
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
