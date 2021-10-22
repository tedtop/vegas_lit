

import 'package:flutter/material.dart';

import '../../../../../config/assets.dart';
import '../../../../../config/palette.dart';

AppBar tabletAppBar() {
  return AppBar(
    iconTheme: const IconThemeData(color: Palette.cream),
    toolbarHeight: 80.0,
    centerTitle: true,
    title: Image.asset(
      Images.topLogo,
      fit: BoxFit.contain,
      height: 80,
    ),
  );
}
