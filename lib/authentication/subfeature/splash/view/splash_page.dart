import 'package:flutter/material.dart';
import 'package:vegas_lit/config/assets.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => SplashPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(Images.topLogo),
      ),
    );
  }
}
