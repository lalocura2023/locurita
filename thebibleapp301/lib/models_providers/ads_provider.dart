import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsProvider with ChangeNotifier {
  AdsProvider() {
    init();
  }

  int listBannerAdInterval = 4;
  int interstitialAdLimit = 3;
  int interstitialAdLoader = 0;

  InitializationStatus _initializationStatus;
  get initializationStatus => _initializationStatus;

  init() async {
    _initializationStatus = await MobileAds.instance.initialize();
    notifyListeners();
  }

  String get bannerAdUnitId {
    if (Platform.isAndroid) return 'ca-app-pub-3940256099942544/6300978111';
    if (Platform.isIOS) return 'ca-app-pub-3940256099942544/2934735716';
    throw new UnsupportedError("Unsupported platform");
  }

  String get interstitialAdUnitId {
    if (Platform.isAndroid) return 'ca-app-pub-3940256099942544/1033173712';
    if (Platform.isIOS) return 'ca-app-pub-3940256099942544/4411468910';
    throw new UnsupportedError("Unsupported platform");
  }

  String get nativeAdUnitId {
    if (Platform.isAndroid) return 'ca-app-pub-3940256099942544/2247696110';
    if (Platform.isIOS) return 'ca-app-pub-3940256099942544/3986624511';
    throw new UnsupportedError("Unsupported platform");
  }

  final AdListener bannerAdListener = AdListener(
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      print('Ad failed to load');
    },
    onAdOpened: (Ad ad) => print('Ad opened.'),
    onAdClosed: (Ad ad) => print('Ad closed.'),
    onApplicationExit: (Ad ad) => print('Left application.'),
  );
}
