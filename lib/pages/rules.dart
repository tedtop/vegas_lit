import 'package:flutter/material.dart';

class Rules extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => Rules(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('RULES'),
    );
  }
}
