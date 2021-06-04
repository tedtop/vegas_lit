import 'package:flutter/material.dart';
import '../../../../../config/assets.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => SplashPage(),
      settings: const RouteSettings(name: 'SplashPage'),
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
