import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/data/repositories/auth_repository.dart';
import 'package:vegas_lit/data/repositories/bets_repository.dart';
import 'package:vegas_lit/data/repositories/sportsfeed_repository.dart';

import 'config/themes.dart';
import 'feature/authentication/bloc/authentication_bloc.dart';
import 'feature/authentication/subfeature/login/view/login_page.dart';
import 'feature/authentication/subfeature/splash/view/splash_page.dart';
import 'feature/home/view/home_page.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
    @required this.sportsfeedRepository,
    @required this.betsRepository,
  })  : assert(
          authenticationRepository != null,
          sportsfeedRepository != null,
        ),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final SportsfeedRepository sportsfeedRepository;
  final BetsRepository betsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: authenticationRepository,
        ),
        RepositoryProvider.value(
          value: sportsfeedRepository,
        ),
        RepositoryProvider.value(
          value: betsRepository,
        ),
      ],
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Vegas Lit',
      theme: Themes.dark,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              // case AuthenticationStatus.halfauthenticated:
              //   _navigator.push<void>(
              //     LoginInfoPage.route(
              //       currentUser: state.user,
              //     ),
              //   );
              //   break;
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
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
