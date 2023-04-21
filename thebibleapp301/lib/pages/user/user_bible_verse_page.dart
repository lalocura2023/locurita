import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:thebibleapp/components/z_bible_verse_details.dart';
import 'package:thebibleapp/models/bible.dart';
import 'package:thebibleapp/models_providers/ads_provider.dart';

import '../../models_providers/theme_provider.dart';

class UserBibleVersePage extends StatefulWidget {
  final BibleVerse verse;
  UserBibleVersePage({Key key, @required this.verse}) : super(key: key);

  @override
  _UserBibleVersePageState createState() => _UserBibleVersePageState();

}

class _UserBibleVersePageState extends State<UserBibleVersePage> {

  AdsProvider adsProvider;
  InterstitialAd _interstitialAd;
  bool _interstitialAdLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    adsProvider = Provider.of<AdsProvider>(context);

    if (adsProvider.interstitialAdLoader < adsProvider.interstitialAdLimit) {
      _interstitialAd = new InterstitialAd(
        adUnitId: adsProvider.interstitialAdUnitId,
        listener: AdListener(
          onAdLoaded: (_) => _interstitialAdLoaded = true,
        ),
        request: AdRequest(),
      );

      _interstitialAd..load();
    }
  }

  @override
  void dispose() {
    if (_interstitialAdLoaded) {
      _interstitialAd.show();
      adsProvider.interstitialAdLoader++;
      _interstitialAd.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.verse.book} — Ch. ${widget.verse.chapter}', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: ListView(
        children: <Widget>[
          ZBibleVerseDetails(verse: widget.verse),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            height: 50,
            child: AdWidget(
              ad:  BannerAd(
                size: AdSize.banner,
                adUnitId: adsProvider.bannerAdUnitId,
                listener: adsProvider.bannerAdListener,
                request: AdRequest(),
              )..load()),
            ),
        ],
      ),
    );
  }

}
