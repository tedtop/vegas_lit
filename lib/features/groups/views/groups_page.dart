import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/palette.dart';
import '../../../config/styles.dart';
import '../../home/cubit/home_cubit.dart';
import '../widgets/group_add/group_add.dart';
import '../widgets/group_requests/group_requests_page.dart';
import '../widgets/private_groups/private_groups_page.dart';
import '../widgets/public_groups/public_groups_page.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage._({Key key}) : super(key: key);

  static MaterialPageRoute route({@required HomeCubit cubit}) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider.value(
          value: cubit,
          child: const GroupsPage._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final uid =
        context.select((HomeCubit cubit) => cubit?.state?.userData?.uid);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('GROUPS', style: Styles.pageTitle),
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
            Navigator.push(
              context,
              GroupAdd.route(
                homeCubit: context.read<HomeCubit>(),
              ),
            );
          },
          label: Text('CREATE', style: Styles.normalTextBold),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
