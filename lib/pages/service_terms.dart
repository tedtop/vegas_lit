import 'package:flutter/material.dart';

class TermsOfService extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => TermsOfService(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('TERMS OF SERVICE'),
      ),
    );
  }
}
