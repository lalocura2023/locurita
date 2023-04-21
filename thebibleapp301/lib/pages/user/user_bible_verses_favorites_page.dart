import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:thebibleapp/components/z_bible_verse_favorite.dart';
import 'package:thebibleapp/models/bible.dart';
import 'package:thebibleapp/models_providers/ads_provider.dart';
import '../../models_providers/user_provider.dart';

class UserBibleVersesFavoritesPage extends StatefulWidget {
  UserBibleVersesFavoritesPage({
    Key key,
  }) : super(key: key);

  @override
  _UserBibleVersesFavoritesPageState createState() => _UserBibleVersesFavoritesPageState();
}

class _UserBibleVersesFavoritesPageState extends State<UserBibleVersesFavoritesPage> {
  List<Object> itemList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adsProvider = Provider.of<AdsProvider>(context);
    itemList = List.from(Provider.of<UserProvider>(context).bibleVersesFavorites);

    if (adsProvider.initializationStatus != null) {
      for (int i = adsProvider.listBannerAdInterval; i <= itemList.length; i += adsProvider.listBannerAdInterval + 1) {
        itemList.insert(
            i,
            BannerAd(
              size: AdSize.banner,
              adUnitId: adsProvider.bannerAdUnitId,
              listener: adsProvider.bannerAdListener,
              request: AdRequest(),
            )..load());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite verses', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: ListView(children: <Widget>[for (var ob in itemList) getItem(ob)]),
    );
  }

  getItem(Object ob) {
    if (ob is BibleVerse) return ZBibleVerseFavorite(verse: ob, showBook: true);
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        height: 50,
        child: AdWidget(
          ad: ob,
        ));
  }
}
