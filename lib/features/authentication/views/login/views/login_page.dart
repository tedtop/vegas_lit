import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/repositories/user_repository.dart';
import '../../../authentication.dart';

import '../cubit/login_cubit.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage._({Key? key}) : super(key: key);

  static Page page() =>
      const MaterialPage<void>(name: 'LoginPage', child: LoginPage._());

  static Route route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: 'LoginPage'),
      builder: (_) => const LoginPage._(),
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
            authenticationBloc: context.watch<AuthenticationCubit>(),
          ),
          child: LoginForm(),
        ),
      ),
    );
  }
}
