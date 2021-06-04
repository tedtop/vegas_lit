import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/repositories/user_repository.dart';
import '../../../authentication.dart';

import '../cubit/login_cubit.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage._({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const LoginPage._(),
      settings: const RouteSettings(name: 'LoginPage'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: BlocProvider<LoginCubit>(
          create: (_) => LoginCubit(
            userRepository: context.read<UserRepository>(),
            authenticationBloc: context.watch<AuthenticationBloc>(),
          ),
          child: LoginForm(),
        ),
      ),
    );
  }
}
