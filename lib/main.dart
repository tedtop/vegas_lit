import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/data/repositories/nascar_repository.dart';

import 'data/repositories/bet_repository.dart';
import 'data/repositories/device_repository.dart';
import 'data/repositories/group_repository.dart';
import 'data/repositories/sport_repository.dart';
import 'data/repositories/user_repository.dart';
import 'features/app.dart';
import 'observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;

  if (!kIsWeb) {
    await MobileAds.instance.initialize();
    if (kDebugMode) {
      Bloc.observer = SimpleBlocObserver();
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
      await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
    } else {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    }
  }

  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    const ScreenBreakpoints(
      desktop: 1000,
      tablet: 600,
      watch: 80,
    ),
  );

  final _deviceRepository = await DeviceRepository.create();

  runApp(
    App(
      userRepository: UserRepository(),
      sportRepository: SportRepository(),
      betRepository: BetRepository(),
      groupRepository: GroupRepository(),
      nascarRepository: NascarRepository(),
      deviceRepository: _deviceRepository,
    ),
  );
}
