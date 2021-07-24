import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/models/group.dart';
import 'package:vegas_lit/features/groups/views/group_details/cubit/group_details_cubit.dart';
import 'package:vegas_lit/features/leaderboard/views/adaptive_leaderboard/desktop_leaderboard.dart';
import 'package:vegas_lit/features/leaderboard/views/adaptive_leaderboard/mobile_leaderboard.dart';
import 'package:vegas_lit/features/leaderboard/views/adaptive_leaderboard/tablet_leaderboard.dart';
import 'package:vegas_lit/features/shared_widgets/default_button.dart';

class GroupDetails extends StatelessWidget {
  GroupDetails._({Key key, this.group}) : super(key: key);

  static MaterialPageRoute route({@required Group group}) {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        // USE THE CUBIT TO GET LEADERBOARD
        create: (context) => GroupDetailsCubit(),
        child: GroupDetails._(
          group: group,
        ),
      );
    });
  }

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: Text(
                      'WIN OR GO BROKE',
                      style: Styles.pageTitle,
                    ),
                  ),
                ],
              ),
              const Center(
                child: Icon(
                  Icons.star,
                  size: 50,
                ),
              ),
              Table(
                border: TableBorder.all(color: Colors.transparent),
                columnWidths: {
                  0: const FixedColumnWidth(70),
                  1: const FlexColumnWidth()
                },
                children: [
                  TableRow(
                    children: [
                      Text(
                        'Motto',
                        style: Styles.normalText.copyWith(fontSize: 14),
                      ),
                      Text(
                        'assume this is a motto, okay? If you don\'t think this is anything like a motto, then you are right, as I do not know what to do with my life myself.',
                        style: Styles.normalText.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        'Type',
                        style: Styles.normalText.copyWith(fontSize: 14),
                      ),
                      Text(
                        'Public',
                        style: Styles.normalText.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        'Homepage',
                        style: Styles.normalText.copyWith(fontSize: 14),
                      ),
                      Text(
                        'https://thisisntasite.com/wasteyourlife',
                        style: Styles.normalText.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        'Members',
                        style: Styles.normalText.copyWith(fontSize: 14),
                      ),
                      Text(
                        'assume this is a motto, okay? If you don\'t think this is anything like a motto, then you are right, as I do not know what to do with my life myself.',
                        style: Styles.normalText.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        'Admin',
                        style: Styles.normalText.copyWith(fontSize: 14),
                      ),
                      Text(
                        'ritikTheGreat',
                        style: Styles.normalText.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: SizedBox(
                    width: 200,
                    child: DefaultButton(text: 'SHARE', action: () {})),
              ),
              Text(
                'LEADERBOARD',
                style: Styles.pageTitle.copyWith(fontSize: 24),
              ),
              // ScreenTypeLayout(
              //   desktop: DesktopLeaderboard(
              //     players: [],
              //   ),
              //   tablet: TabletLeaderboard(
              //     players: [],
              //   ),
              //   mobile: MobileLeaderboard(
              //     players: [],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
