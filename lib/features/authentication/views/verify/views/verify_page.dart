import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication.dart';

class VerifyPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => VerifyPage(),
      settings: const RouteSettings(name: 'VerifyPage'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  'Your Email isn\'t verified. Please check your inbox.'),
              ElevatedButton(
                child: const Text('Go Back'),
                onPressed: () {
                  context.read<AuthenticationBloc>().add(
                        AuthenticationLogoutRequested(),
                      );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
