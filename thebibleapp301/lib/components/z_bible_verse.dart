import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:thebibleapp/pages/user/user_bible_verse_page.dart';
import 'z_card.dart';
import '../models/bible.dart';
import '../models_providers/theme_provider.dart';
import '../models_providers/user_provider.dart';

class ZBibleVerse extends StatelessWidget {
  const ZBibleVerse({Key key, @required this.verse, this.showBook = false}) : super(key: key);

  final BibleVerse verse;
  final showBook;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isThemeModeLight = themeProvider.isThemeModeLight;
    final String value = showBook ? '${verse.book} ch.${verse.chapter}  v.${verse.verse}' : 'Verse — ${verse.verse}';

    return ZCard(
      color: verse.isFavorite && verse.color != 0 ? Color(verse.color) : isThemeModeLight ? null : Color(0xFF1B2023),
      onTap: () => Get.to(UserBibleVersePage(verse: verse), fullscreenDialog: true),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    value,
                    style: TextStyle(color: isThemeModeLight ? null : Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  )),
              Spacer()
            ],
          ),
          Container(padding: EdgeInsets.symmetric(vertical: 10), child: Text('${verse.text}')),
          if (verse.isFavorite && verse.annotation != null && verse.annotation != "")
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Divider(height: 15),
                Text(verse.annotation, style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic))
              ],
            ),
        ],
      ),
    );
  }
}
