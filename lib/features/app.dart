import 'package:connectivity/connectivity.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
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
  }) : super(key: key);

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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthenticationCubit(
              userRepository: userRepository,
            ),
          ),
          BlocProvider(
            create: (_) => InternetCubit(
              connectivity: Connectivity(),
            ),
          ),
        ],
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  AppView({
    Key? key,
  }) : super(key: key);

  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        navigatorKey: _navigatorKey,
        title: 'Vegas Lit',
        theme: Themes.dark,
        navigatorObservers: [
          routeObserver,
        ],
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: BlocListener<AuthenticationCubit, AuthenticationState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.success:
                    _navigator!.pushAndRemoveUntil<void>(
                      HomePage.route(
                        connectivity: Connectivity(),
                        uid: state.user!.uid,
                      ),
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.failure:
                    _navigator!.pushAndRemoveUntil<void>(
                      LoginPage.route(),
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.initial:
                    _navigator!.pushAndRemoveUntil<void>(
                      LoginPage.route(),
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.loading:
                    _navigator!.pushAndRemoveUntil<void>(
                      SplashPage.route(),
                      (route) => false,
                    );
                    break;
                }
              },
              child: child,
            ),
          );
        },
        onGenerateRoute: (_) => SplashPage.route(),
      ),
    );
  }
}
