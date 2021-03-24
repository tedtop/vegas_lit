import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => FAQ(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('FAQ'),
    );
  }
}
