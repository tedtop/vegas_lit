import 'package:flutter/material.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/styles.dart';

class TermsOfService extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => TermsOfService(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'drawerHeader',
          child: Image.asset(
            Images.topLogo,
            fit: BoxFit.fitWidth,
            height: 50,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TERMS OF SERVICE',
                style: Styles.pageTitle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
