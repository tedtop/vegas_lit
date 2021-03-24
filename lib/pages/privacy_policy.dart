import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => PrivacyPolicy(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('PRIVACY POLICY'),
    );
  }
}
