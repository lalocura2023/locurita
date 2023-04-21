import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:thebibleapp/models_providers/ads_provider.dart';

import '../../components/z_card.dart';
import '../../models_providers/user_provider.dart';
import 'user_bible_verses_page.dart';

class UserBibleChaptersPage extends StatefulWidget {
  final String book;
  UserBibleChaptersPage({Key key, @required this.book}) : super(key: key);

  @override
  _UserBibleChaptersPageState createState() => _UserBibleChaptersPageState();
}

class _UserBibleChaptersPageState extends State<UserBibleChaptersPage> {

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
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.book}', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: ListView(
        children: <Widget>[
          for (var chapter in userProvider.bibleChapters)
            ZCard(
              onTap: () {
                userProvider.getBibleBookVerses(book: chapter.book, chapter: chapter.chapter);
                Get.to(UserBibleVersesPage(title: '${chapter.book} — Ch. ${chapter.chapter}'), fullscreenDialog: true);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: <Widget>[
                    Text('${chapter.book} — Ch. ${chapter.chapter}'),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 14),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
