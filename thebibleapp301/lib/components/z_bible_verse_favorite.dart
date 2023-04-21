import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:social_share/social_share.dart';
import 'package:thebibleapp/components/z_bible_verse_sheet.dart';
import 'package:thebibleapp/environments.dart';
import 'z_card.dart';
import '../models/bible.dart';
import '../models_providers/theme_provider.dart';
import '../models_providers/user_provider.dart';

class ZBibleVerseFavorite extends StatelessWidget {


  const ZBibleVerseFavorite({Key key, @required this.verse, this.showBook = false}) : super(key: key);

  final BibleVerse verse;
  final showBook;


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isThemeModeLight = themeProvider.isThemeModeLight;
    final String value = showBook ? '${verse.book} ch.${verse.chapter}  v.${verse.verse}' : 'Verse — ${verse.verse}';
    String shareString = """
${verse.book} ch.${verse.chapter}  v.${verse.verse}

${verse.text}

${Environment.SHARE_VERSE_LABEL}
""";

    return ZCard(
      color: verse.color != 0 ? Color(verse.color) : isThemeModeLight ? null : Color(0xFF1B2023),
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
              Spacer(),
              Wrap(
                spacing: -15,
                children: [
                  IconButton(onPressed: () => SocialShare.shareOptions(shareString), icon: Icon(Icons.share)),
                  IconButton(onPressed: () => SocialShare.shareWhatsapp(shareString) , icon: Icon(FontAwesome.whatsapp)),
                  IconButton(onPressed: () => BibleVerseSheet.buildShowDialog(context, userProvider, verse), icon: Icon(Icons.edit)),
                  IconButton(onPressed: () => userProvider.toggleFavoriteVerse(bibleVerse: verse), icon: Icon(Icons.delete)),
                ],
              ),
            ],
          ),
          Container(padding: EdgeInsets.symmetric(vertical: 10), child: Text('${verse.text}')),
          if (verse.annotation != null && verse.annotation != "")
            Column(
              children: [
                Divider(),
                Text(verse.annotation, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),)
              ],
            )
        ],
      ),
    );
  }


}
