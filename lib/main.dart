import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/data/repositories/device_repository.dart';
import 'package:vegas_lit/data/repositories/groups_repository.dart';
import 'data/repositories/bets_repository.dart';
import 'data/repositories/sports_repository.dart';
import 'data/repositories/user_repository.dart';
import 'features/app.dart';
import 'observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) await MobileAds.instance.initialize();
  await Firebase.initializeApp();

  if (!kIsWeb) {
    if (kDebugMode) {
      Bloc.observer = SimpleBlocObserver();
      EquatableConfig.stringify = kDebugMode;
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
      await FirebaseAnalytics().setAnalyticsCollectionEnabled(false);
    } else {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      await FirebaseAnalytics().setAnalyticsCollectionEnabled(true);
    }
  }
  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    const ScreenBreakpoints(
      desktop: 1000,
      tablet: 600,
      watch: 80,
    ),
  );
  runApp(
    App(
      userRepository: UserRepository(),
      sportsRepository: SportsRepository(),
      betsRepository: BetsRepository(),
      groupsRepository: GroupsRepository(),
      deviceRepository: DeviceRepository(),
    ),
  );
}
