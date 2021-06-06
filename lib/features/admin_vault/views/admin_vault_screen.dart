import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/features/shared_widgets/app_bar/app_bar.dart';

import '../../../config/palette.dart';
import '../../../config/styles.dart';
import '../../../data/repositories/user_repository.dart';
import '../cubit/admin_vault_cubit.dart';
import '../widgets/admin_record_box.dart';

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
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: adaptiveAppBar(width: width),
        body: BlocBuilder<AdminVaultCubit, AdminVaultState>(
          builder: (context, state) {
            if (state is AdminVaultDataFetched) {
              final totalData = state.totalData.reversed.toList();
              return ListView(
                children: [
                  Center(
                    child: Text(
                      'ADMIN VAULT',
                      style: Styles.adminVaultTitle,
                    ),
                  ),
                  ...totalData.map((data) => AdminRecordBox(
                        item: data,
                      ))
                ],
              );
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                color: Palette.cream,
              ));
            }
          },
        ));
  }
}
