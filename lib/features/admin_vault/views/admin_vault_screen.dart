import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/palette.dart';
import '../../../config/styles.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../utils/app_bar.dart';
import '../cubit/admin_vault_cubit.dart';
import '../widgets/admin_record_box.dart';

class AdminVaultScreen extends StatelessWidget {
  const AdminVaultScreen._({Key? key}) : super(key: key);

  static MaterialPageRoute route() {
    return MaterialPageRoute<void>(
      builder: (_) {
        return BlocProvider(
          create: (context) => AdminVaultCubit(
            userRepository: context.read<UserRepository>(),
          )..fetchAdminVault(),
          child: const AdminVaultScreen._(),
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
          switch (state.status) {
            case AdminVaultStatus.initial:
              return const SizedBox();

            case AdminVaultStatus.loading:
              return const Center(
                child: CircularProgressIndicator(
                  color: Palette.cream,
                ),
              );

            case AdminVaultStatus.success:
              return Column(
                children: [
                  Center(
                    child: Text(
                      'ADMIN VAULT',
                      style: Styles.adminVaultTitle,
                    ),
                  ),
                  AdminVaultCumulativeTile(
                    vaultItem: state.cumulativeData,
                  ),
                  ListView.builder(
                    key: Key('${state.dailyData.length}'),
                    itemCount: state.dailyData.length,
                    itemBuilder: (context, index) {
                      return AdminVaultDailyList(
                        vaultItem: state.dailyData[index],
                      );
                    },
                  ),
                ],
              );

            default:
              return Center(
                child: Text(
                  'Couldn\'t load admin vault',
                  style: GoogleFonts.nunito(),
                ),
              );
          }
        },
      ),
    );
  }
}
