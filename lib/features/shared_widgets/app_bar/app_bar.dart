import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'adaptive_app_bar/desktop_app_bar.dart';
import 'adaptive_app_bar/mobile_app_bar.dart';
import 'adaptive_app_bar/tablet_app_bar.dart';

AppBar adaptiveAppBar({double width, int balanceAmount, int pageIndex}) {
  final deviceSize = ResponsiveSizingConfig.instance.breakpoints;
  return width >= deviceSize.desktop
      ? desktopAppBar()
      : width >= deviceSize.tablet
          ? tabletAppBar()
          : mobileAppBar(balanceAmount: balanceAmount, pageIndex: pageIndex);
}
