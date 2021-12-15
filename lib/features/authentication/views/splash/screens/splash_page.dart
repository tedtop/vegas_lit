import 'package:flutter/material.dart';

import '../../../../../config/assets.dart';

class SplashPage extends StatelessWidget {
  const SplashPage._({Key? key}) : super(key: key);

  static Page page() =>
      const MaterialPage<void>(name: 'SplashPage', child: SplashPage._());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350),
          child: Image.asset(
            Images.topLogo,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
