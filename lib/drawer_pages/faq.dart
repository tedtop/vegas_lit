import 'package:flutter/material.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/styles.dart';

class FAQ extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => FAQ(),
      settings: const RouteSettings(name: 'FAQ'),
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
                'FAQ',
                style: Styles.pageTitle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
