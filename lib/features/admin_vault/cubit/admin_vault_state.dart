part of 'admin_vault_cubit.dart';

abstract class AdminVaultState extends Equatable {
  const AdminVaultState();

  @override
  List<Object> get props => [];
}

class AdminVaultInitial extends AdminVaultState {}

class AdminVaultDataFetched extends AdminVaultState {
  AdminVaultDataFetched({this.cumulativeData, this.totalData});
  final VaultItem cumulativeData;
  final List<VaultItem> totalData;
}
