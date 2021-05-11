import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'admin_vault_state.dart';

class AdminVaultCubit extends Cubit<AdminVaultState> {
  AdminVaultCubit() : super(AdminVaultInitial());
}
