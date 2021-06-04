import 'package:flutter/material.dart';
import '../../config/assets.dart';

class TopLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'top_logo',
      child: Image.asset(
        Images.topLogo,
        height: 80,
      ),
    );
  }
}
