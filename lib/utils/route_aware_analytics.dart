import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import '../config/routes.dart';

final RouteObserver<PageRoute<dynamic>> routeObserver =
    RouteObserver<PageRoute>();

mixin RouteAwareAnalytics<T extends StatefulWidget> on State<T>
    implements RouteAware {
  Routes get route;
  Future<void> setThisScreenForAnalytics() => _setCurrentScreen(route);

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPop() {}

  @override
  void didPopNext() {
    // Called when the top route has been popped off,
    // and the current route shows up.
    _setCurrentScreen(route);
  }

  @override
  void didPush() {
    // Called when the current route has been pushed.
    _setCurrentScreen(route);
  }

  @override
  void didPushNext() {}

  Future<void> _setCurrentScreen(Routes analyticsRoute) {
    return FirebaseAnalytics.instance.setCurrentScreen(
      screenName: analyticsRoute.screenName,
      screenClassOverride: analyticsRoute.screenClass,
    );
  }
}
