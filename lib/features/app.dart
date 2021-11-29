import 'package:device_preview/device_preview.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:vegas_lit/data/repositories/nascar_repository.dart';
import 'package:vegas_lit/features/authentication/cubit/authentication_cubit.dart';

import '../config/themes.dart';
import '../data/repositories/bet_repository.dart';
import '../data/repositories/device_repository.dart';
import '../data/repositories/group_repository.dart';
import '../data/repositories/sport_repository.dart';
import '../data/repositories/user_repository.dart';
import '../utils/route_aware_analytics.dart';
import 'authentication/views/login/login.dart';
import 'authentication/views/splash/splash.dart';
import 'home/cubit/internet_cubit.dart';
import 'home/views/home_page.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.sportRepository,
    required this.userRepository,
    required this.betRepository,
    required this.deviceRepository,
    required this.groupRepository,
    required this.nascarRepository,
  }) : super(key: key);

  final NascarRepository nascarRepository;
  final SportRepository sportRepository;
  final UserRepository userRepository;
  final BetRepository betRepository;
  final GroupRepository groupRepository;
  final DeviceRepository deviceRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: sportRepository,
        ),
        RepositoryProvider.value(
          value: betRepository,
        ),
        RepositoryProvider.value(
          value: userRepository,
        ),
        RepositoryProvider.value(
          value: groupRepository,
        ),
        RepositoryProvider.value(
          value: deviceRepository,
        ),
        RepositoryProvider.value(
          value: nascarRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthenticationCubit(
              userRepository: userRepository,
            ),
          ),
          BlocProvider(
            create: (_) => InternetCubit(),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'Vegas Lit',
        theme: Themes.dark,
        navigatorObservers: [
          routeObserver,
        ],
        home: FlowBuilder<AuthenticationStatus>(
          state: context.select(
            (AuthenticationCubit cubit) => cubit.state.status,
          ),
          onGeneratePages: (
            AuthenticationStatus state,
            List<Page<dynamic>> pages,
          ) {
            switch (state) {
              case AuthenticationStatus.success:
                return [HomePage.page()];
              case AuthenticationStatus.failure:
                return [LoginPage.page()];
              default:
                return [SplashPage.page()];
            }
          },
        ),
      ),
    );
  }
}
