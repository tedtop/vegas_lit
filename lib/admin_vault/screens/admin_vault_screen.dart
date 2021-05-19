import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/admin_vault/cubit/admin_vault_cubit.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/shared_widgets/app_bar.dart';
import 'package:api_client/src/models/vault_data.dart';

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
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBarWidget(),
        body: BlocConsumer<AdminVaultCubit, AdminVaultState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AdminVaultDataFetched) {
              final totalData = state.totalData
                  .where((element) => element.date != 'cumulative')
                  .toList();
              return Column(
                children: [
                  Text(
                    'ADMIN VAULT',
                    style: GoogleFonts.nunito(
                      fontSize: 28,
                      color: Palette.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildRecordTable(totalData, state.cumulativeData)
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  Widget _buildRecordTable(
      List<VaultItem> totalData, VaultItem cumulativeData) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Table(
            columnWidths: {
              0: const FlexColumnWidth(1.5),
            },
            border: TableBorder.all(color: Palette.green),
            children: [
              const TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: TableCell(
                    child: Text(
                      'Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: TableCell(
                    child: Text(
                      'Bets',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: TableCell(
                    child: Text(
                      'Money In',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: TableCell(
                    child: Text(
                      'Money Out',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: TableCell(
                    child: Text(
                      'Profit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ]),
              ...totalData.map((item) => TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          item.date.toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      TableCell(
                        child: Text(
                          item.numberOfBets.toString(),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      TableCell(
                        child: Text(
                          '\$${item.moneyIn.toString()}',
                          textAlign: TextAlign.right,
                        ),
                      ),
                      TableCell(
                        child: Text(
                          '\$${item.moneyOut.toString()}',
                          textAlign: TextAlign.right,
                        ),
                      ),
                      TableCell(
                        child: Text(
                          '\$${item.totalProfit.toString()}',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  )),
              TableRow(children: [
                const TableCell(
                  child: Text(
                    'Total : ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TableCell(
                  child: Text(
                    cumulativeData.numberOfBets.toString(),
                    textAlign: TextAlign.right,
                  ),
                ),
                TableCell(
                  child: Text(
                    '\$${cumulativeData.moneyIn.toString()}',
                    textAlign: TextAlign.right,
                  ),
                ),
                TableCell(
                  child: Text(
                    '\$${cumulativeData.moneyOut.toString()}',
                    textAlign: TextAlign.right,
                  ),
                ),
                TableCell(
                  child: Text(
                    '\$${cumulativeData.totalProfit.toString()}',
                    textAlign: TextAlign.right,
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
