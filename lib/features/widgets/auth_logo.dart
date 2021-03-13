import 'package:flutter/material.dart';
import 'package:vegas_lit/config/assets.dart';

class TopLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Hero(
          tag: 'top_logo',
          child: Image.asset(
            Images.topLogo,
            height: 80,
          ),
        ),
      ],
    );
  }
}
