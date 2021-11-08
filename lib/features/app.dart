import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import '../config/themes.dart';
import '../data/repositories/bet_repository.dart';
import '../data/repositories/device_repository.dart';
import '../data/repositories/group_repository.dart';
import '../data/repositories/sport_repository.dart';
import '../data/repositories/user_repository.dart';
import '../utils/route_aware_analytics.dart';
import 'authentication/bloc/authentication_bloc.dart';
import 'authentication/views/login/login.dart';
import 'authentication/views/sign_up/sign_up.dart';
import 'authentication/views/splash/splash.dart';
import 'authentication/views/verify/views/verify_page.dart';
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
            create: (_) => AuthenticationBloc(
              userRepository: userRepository,
              deviceRepository: deviceRepository,
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
        // Device Preview Configs
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
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
            child: BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    _navigator!.pushAndRemoveUntil<void>(
                      HomePage.route(
                        connectivity: Connectivity(),
                        uid: state.user!.uid,
                      ),
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.unauthenticated:
                    _navigator!.pushAndRemoveUntil<void>(
                      LoginPage.route(),
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.firstTime:
                    _navigator!.pushAndRemoveUntil<void>(
                      SignUpPage.route(),
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.notverified:
                    _navigator!.pushAndRemoveUntil<void>(
                      VerifyPage.route(),
                      (route) => false,
                    );
                    break;
                  default:
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
