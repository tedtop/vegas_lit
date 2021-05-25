import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/data/repositories/user_repository.dart';
import 'package:vegas_lit/features/admin_vault/cubit/admin_vault_cubit.dart';
import 'package:vegas_lit/features/admin_vault/widgets/admin_vault_box.dart';
import 'package:vegas_lit/features/shared_widgets/app_bar.dart';

class AdminVaultScreen extends StatelessWidget {
  AdminVaultScreen._();

  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (_) {
        return BlocProvider(
          create: (context) => AdminVaultCubit(userRepository: UserRepository())
            ..fetchAdminVaultData(),
          child: AdminVaultScreen._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(),
        body: BlocBuilder<AdminVaultCubit, AdminVaultState>(
          builder: (context, state) {
            if (state is AdminVaultDataFetched) {
              final totalData = state.totalData.reversed.toList();
              return ListView(
                children: [
                  Center(
                    child: Text(
                      'ADMIN VAULT',
                      style: GoogleFonts.nunito(
                        fontSize: 28,
                        color: Palette.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...totalData.map((data) => AdminRecordBox(
                        item: data,
                      ))
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
