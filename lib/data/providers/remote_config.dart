import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class RemoteConfigClient {
  RemoteConfigClient({RemoteConfig? remoteConfig})
      : _remoteConfig = remoteConfig ?? RemoteConfig.instance;

  final RemoteConfig _remoteConfig;

  Future<void> setDefaultLeague({required String league}) async {
    await _remoteConfig.setDefaults(
      <String, dynamic>{
        'default_league': league,
      },
    );
  }

  Future<void> fetchAndActivateRemote() async {
    final updated = await _remoteConfig.fetchAndActivate();
    if (updated) {
      print('The config has been updated, new parameter values are available.');
    } else {
      print('The config values were previously updated.');
    }
  }

  String get fetchRemoteLeague {
    if (kIsWeb) return 'MLB';
    return _remoteConfig.getString('default_league');
  }
}
