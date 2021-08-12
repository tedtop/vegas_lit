import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegas_lit/data/helpers/shared_pref_helper.dart';
import 'package:vegas_lit/data/repositories/device_repository.dart';
import 'package:vegas_lit/utils/route_aware_analytics.dart';
import 'package:vegas_lit/data/repositories/groups_repository.dart';
import '../config/themes.dart';
import '../data/repositories/bets_repository.dart';
import '../data/repositories/sports_repository.dart';
import '../data/repositories/user_repository.dart';

import 'authentication/bloc/authentication_bloc.dart';
import 'authentication/views/login/login.dart';
import 'authentication/views/sign_up/sign_up.dart';
import 'authentication/views/splash/splash.dart';
import 'authentication/views/verify/views/verify_page.dart';
import 'home/cubit/internet_cubit.dart';
import 'home/views/home_page.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.sportsRepository,
    @required this.userRepository,
    @required this.betsRepository,
    @required this.sharedPreferences,
    @required this.deviceRepository,
    @required this.groupsRepository,
  })  : assert(
          sportsRepository != null,
        ),
        super(key: key);

  final SportsRepository sportsRepository;
  final UserRepository userRepository;
  final BetsRepository betsRepository;
  final GroupsRepository groupsRepository;
  final SharedPreferences sharedPreferences;
  final DeviceRepository deviceRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: sportsRepository,
        ),
        RepositoryProvider.value(
          value: betsRepository,
        ),
        RepositoryProvider.value(
          value: userRepository,
        ),
        RepositoryProvider.value(
          value: groupsRepository,
        ),
        RepositoryProvider.value(
          value: sharedPreferences,
        ),
        RepositoryProvider.value(
          value: deviceRepository,
        ),
      ],
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          userRepository: userRepository,
        ),
        child: AppView(
          connectivity: Connectivity(),
        ),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key key, this.connectivity}) : super(key: key);
  final Connectivity connectivity;

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InternetCubit>(
      create: (context) => InternetCubit(
        connectivity: widget.connectivity,
      ),
      child: OverlaySupport(
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          title: 'Vegas Lit',
          theme: Themes.dark,
          navigatorObservers: [
            routeObserver,
          ],
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  switch (state.status) {
                    case AuthenticationStatus.authenticated:
                      _navigator.pushAndRemoveUntil<void>(
                        HomePage.route(
                          connectivity: Connectivity(),
                          uid: state.user.uid,
                        ),
                        (route) => false,
                      );
                      break;
                    case AuthenticationStatus.unauthenticated:
                      SharedPrefHelper.isFirstTime(
                        sharedPref: context.read<SharedPreferences>(),
                      ).then((value) {
                        if (value)
                          _navigator.pushAndRemoveUntil<void>(
                            SignUpPage.route(),
                            (route) => false,
                          );
                        else
                          _navigator.pushAndRemoveUntil<void>(
                            LoginPage.route(),
                            (route) => false,
                          );
                      });

                      break;
                    case AuthenticationStatus.notverified:
                      _navigator.pushAndRemoveUntil<void>(
                        VerifyPage.route(),
                        (route) => false,
                      );
                      break;
                    default:
                      break;
                  }
                },
                child: child,
              ),
            );
          },
          onGenerateRoute: (_) => SplashPage.route(),
        ),
      ),
    );
  }
}
