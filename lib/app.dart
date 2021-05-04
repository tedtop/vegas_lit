import 'package:api_client/api_client.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication/bloc/authentication_bloc.dart';
import 'authentication/screens/login/login.dart';
import 'authentication/screens/splash/splash.dart';
import 'config/themes.dart';
import 'home/screens/home_page.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.sportsRepository,
    @required this.userRepository,
    @required this.betsRepository,
  })  : assert(
          sportsRepository != null,
        ),
        super(key: key);

  final SportsRepository sportsRepository;
  final UserRepository userRepository;
  final BetsRepository betsRepository;

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
      ],
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          userRepository: userRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                    HomePage.route(observer: observer),
                    (route) => false,
                  );
                  break;
                case AuthenticationStatus.unauthenticated:
                  _navigator.pushAndRemoveUntil<void>(
                    LoginPage.route(),
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
    );
  }
}
