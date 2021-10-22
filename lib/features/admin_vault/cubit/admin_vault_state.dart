

part of 'admin_vault_cubit.dart';

enum AdminVaultStatus { initial, loading, success, failure }

class AdminVaultState extends Equatable {
  const AdminVaultState({
    this.status = AdminVaultStatus.initial,
    this.cumulativeData,
    this.dailyData = const [],
  });

  final AdminVaultStatus status;
  final VaultItem? cumulativeData;
  final List<VaultItem> dailyData;

  @override
  List<Object?> get props => [status, cumulativeData, dailyData];
}
