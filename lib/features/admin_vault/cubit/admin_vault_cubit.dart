import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/vault_data.dart';
import '../../../data/repositories/user_repository.dart';

part 'admin_vault_state.dart';

class AdminVaultCubit extends Cubit<AdminVaultState> {
  AdminVaultCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const AdminVaultState());

  final UserRepository _userRepository;
  StreamSubscription? _adminVaultSubscription;

  Future<void> fetchAdminVault() async {
    emit(const AdminVaultState(status: AdminVaultStatus.loading));

    final cumulativeData = await _userRepository.fetchAdminVaultCumulative();
    final dailyDataStream = _userRepository.fetchAdminVaultDaily();

    await _adminVaultSubscription?.cancel();
    _adminVaultSubscription = dailyDataStream.listen(
      (dailyData) {
        final reversedList = dailyData.reversed.toList();
        emit(
          AdminVaultState(
            status: AdminVaultStatus.success,
            cumulativeData: cumulativeData,
            dailyData: reversedList,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    await _adminVaultSubscription?.cancel();
    return super.close();
  }
}
