import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Future.delayed(
    const Duration(seconds: 5),
    () {
      // ignore: avoid_print
      print('Launch screen stopped for 5 seconds');
    },
  );
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  runApp(
    App(
      userRepository: UserRepository(),
      sportsfeedRepository: SportsfeedRepository(),
      authenticationRepository: AuthenticationRepository(),
      betsRepository: BetsRepository(),
    ),
  );
}
