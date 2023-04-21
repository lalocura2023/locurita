import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';

import '../../components/z_card.dart';
import '../../environments.dart';
import '../../models_providers/user_provider.dart';
import 'user_bible_chapters_page.dart';

class UserBiblePage extends StatefulWidget {
  UserBiblePage({Key key}) : super(key: key);

  @override
  _UserBiblePageState createState() => _UserBiblePageState();
}

class _UserBiblePageState extends State<UserBiblePage> {

  final _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: Environment.RATE_APP_MIN_DAYS,
    minLaunches: Environment.RATE_APP_MIN_LAUNCHES,
    remindDays: Environment.RATE_APP_REMIND_DAYS,
    remindLaunches: Environment.RATE_APP_REMIND_LAUNCHES,
    googlePlayIdentifier: Environment.APP_ANDROID_ID,
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await _rateMyApp.init();
      if (mounted && _rateMyApp.shouldOpenDialog)
        _rateMyApp.showRateDialog(context, message: Environment.RATE_APP_MESSAGE);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Bible', style: TextStyle(fontWeight: FontWeight.w600)),
        actions: <Widget>[],
      ),
      body: ListView(
        children: <Widget>[
          for (var book in userProvider.bibleBooks)
            ZCard(
              onTap: () {
                userProvider.getBibleBookChapters(book: book);
                Get.to(UserBibleChaptersPage(book: book), fullscreenDialog: true);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: <Widget>[
                    Text('$book'),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
