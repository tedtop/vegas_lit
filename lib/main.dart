import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'data/repositories/bets_repository.dart';
import 'data/repositories/sports_repository.dart';
import 'data/repositories/user_repository.dart';
import 'features/app.dart';
import 'observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) await MobileAds.instance.initialize();
  await Firebase.initializeApp();
  await Future.delayed(
    const Duration(seconds: 1),
    () {
      // ignore: avoid_print
      print('Launch screen stopped for 1 seconds');
    },
  );
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

  runApp(
    App(
      userRepository: UserRepository(),
      sportsRepository: SportsRepository(),
      betsRepository: BetsRepository(),
    ),
  );
}
