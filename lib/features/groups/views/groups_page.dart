import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/features/groups/cubit/groups_cubit.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage._({Key key}) : super(key: key);

  static MaterialPageRoute route() {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (context) => GroupsCubit(),
        child: const GroupsPage._(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
