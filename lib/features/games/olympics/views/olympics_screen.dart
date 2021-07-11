import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../olympics.dart';

class OlympicsScreen extends StatelessWidget {
  const OlympicsScreen._({Key key}) : super(key: key);

  static Builder route() {
    return Builder(
      builder: (context) {
        return BlocProvider(
          create: (context) => OlympicsCubit(),
          child: const OlympicsScreen._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
