import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication/bloc/authentication_bloc.dart';
import 'authentication/subfeature/login/login.dart';
import 'authentication/subfeature/splash/splash.dart';
import 'config/themes.dart';
import 'home/view/home_page.dart';

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
