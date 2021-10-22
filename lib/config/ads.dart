

import 'dart:io';

class AdsConfig {
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8972894064340370/8321701085';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-8972894064340370/9802303712';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'bannerAdUnitId';
    } else if (Platform.isIOS) {
      return 'bannerAdUnitId';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
