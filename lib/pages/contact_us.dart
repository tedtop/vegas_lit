import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => ContactUs(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('CONTACT US'),
      ),
    );
  }
}
