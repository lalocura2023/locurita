import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:social_share/social_share.dart';
import 'package:thebibleapp/components/z_bible_verse_sheet.dart';
import 'package:thebibleapp/environments.dart';
import 'z_card.dart';
import '../models/bible.dart';
import '../models_providers/theme_provider.dart';
import '../models_providers/user_provider.dart';

class ZBibleVerseDetails extends StatelessWidget {
  const ZBibleVerseDetails({Key key, @required this.verse, this.showBook = false}) : super(key: key);

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
      color: verse.isFavorite && verse.color != 0 ? Color(verse.color) : isThemeModeLight ? null : Color(0xFF1B2023),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (verse.isFavorite)
                IconButton(onPressed: () =>  BibleVerseSheet.buildShowDialog(context, userProvider, verse), icon: Icon(Icons.edit)),
              IconButton(onPressed: () { userProvider.toggleFavoriteVerse(bibleVerse: verse); if (verse.isFavorite) BibleVerseSheet.buildShowDialog(context, userProvider, verse); }, icon:  Icon((verse.isFavorite ? Icons.favorite : Icons.favorite_border))),
              IconButton(onPressed: () => SocialShare.shareOptions(shareString), icon: Icon(Icons.share)),
              IconButton(onPressed: () => SocialShare.shareWhatsapp(shareString) , icon: Icon(FontAwesome.whatsapp)),
            ],
          )
        ],
      ),
    );
  }
}
