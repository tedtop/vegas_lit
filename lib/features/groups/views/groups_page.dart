import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/palette.dart';
import '../../../config/styles.dart';
import '../../../data/repositories/groups_repository.dart';
import '../../../data/repositories/storage_repository.dart';
import '../../home/cubit/home_cubit.dart';
import '../widgets/group_add/group_add.dart';
import '../widgets/group_details/group_details.dart';
import '../widgets/group_requests/group_requests_page.dart';
import '../widgets/group_scanner/cubit/group_scanner_cubit.dart';
import '../widgets/group_scanner/group_scanner.dart';
import '../widgets/private_groups/private_groups_page.dart';
import '../widgets/public_groups/public_groups_page.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage._({Key? key}) : super(key: key);

  static MaterialPageRoute route({required HomeCubit cubit}) {
    return MaterialPageRoute<void>(
      builder: (context) {
        return BlocProvider(
          create: (_) => GroupScannerCubit(
            groupsRepository: context.read<GroupsRepository>(),
          ),
          child: RepositoryProvider(
            create: (context) => StorageRepository(),
            child: BlocProvider.value(
              value: cubit,
              child: const GroupsPage._(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final uid = context.select((HomeCubit cubit) => cubit.state.userData?.uid);
    return BlocListener<GroupScannerCubit, GroupScannerState>(
      listenWhen: (pre, cur) => pre.status != cur.status,
      listener: (context, state) async {
        if (state.status == GroupScannerStatus.remove) {
          final isExist = await context
              .read<GroupScannerCubit>()
              .isGroupExists(groupId: state.result!.code);
          if (isExist) {
            await Navigator.pushReplacement<void, void>(
              context,
              GroupDetails.route(
                storageRepository: context.read<StorageRepository>(),
                groupId: state.result!.code,
                userId: uid,
              ),
            );
          } else {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text(
                    'Couldn\'t find group.',
                  ),
                ),
              );
          }
        }
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('GROUPS', style: Styles.pageTitle),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    GroupScanner.route(
                      cubit: context.read<GroupScannerCubit>(),
                    ),
                  );
                },
                icon: const Icon(Icons.qr_code_scanner),
              )
            ],
            bottom: TabBar(
              indicatorColor: Palette.green,
              labelPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              tabs: [
                Text(
                  'Public',
                  style: GoogleFonts.nunito(fontSize: 15),
                ),
                Text(
                  'Private',
                  style: GoogleFonts.nunito(fontSize: 15),
                ),
                Text(
                  'Requests',
                  style: GoogleFonts.nunito(fontSize: 15),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              PublicGroups.route(),
              PrivateGroups.route(uid: uid),
              GroupRequests.route(uid: uid),
            ],
          ),
          floatingActionButton: TextButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Palette.green),
            ),
            onPressed: () {
              Navigator.push<void>(
                context,
                GroupAdd.route(
                  homeCubit: context.read<HomeCubit>(),
                  storageRepository: context.read<StorageRepository>(),
                ),
              );
            },
            label: Text('CREATE', style: Styles.normalTextBold),
            icon: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
