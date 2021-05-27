import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/data/repositories/user_repository.dart';
import 'package:vegas_lit/features/authentication/bloc/authentication_bloc.dart';

import '../sign_up.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage._({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const SignUpPage._(),
      settings: const RouteSettings(name: 'SignUpPage'),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: BlocProvider<SignUpCubit>(
            create: (_) => SignUpCubit(
                  userRepository: context.read<UserRepository>(),
                  authenticationBloc: context.read<AuthenticationBloc>(),
                ),
            child: ScreenTypeLayout(
              desktop: Center(
                child: SizedBox(
                  width: 500,
                  child: SignUpForm(),
                ),
              ),
              mobile: SignUpForm(),
            )),
      ),
    );
  }
}
