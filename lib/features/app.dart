import 'package:connectivity/connectivity.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  Future<bool> isFirstTime() async {
    final sharedPref = context.read<SharedPreferences>();
    final isFirstTime = sharedPref.getBool('first_time');
    if (isFirstTime != null && !isFirstTime) {
      await sharedPref.setBool('first_time', false);
      return false;
    } else {
      await sharedPref.setBool('first_time', false);
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InternetCubit>(
      create: (context) => InternetCubit(
        connectivity: widget.connectivity,
      ),
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        title: 'Vegas Lit',
        theme: Themes.dark,
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
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
                        observer: observer,
                        connectivity: Connectivity(),
                        uid: state.user.uid,
                      ),
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.unauthenticated:
                    isFirstTime().then((value) {
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
    );
  }
}
