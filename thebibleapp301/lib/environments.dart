import 'package:flutter/material.dart';

class Environment {

  static const String APP_NAME = "The Bible App";
  static const String APP_ANDROID_ID = "com.bible.gateway.verses";


  // --- Welcome page values ---
  static const List<Color> WELCOME_PAGE_COLORS = [
    Colors.lightBlue,
    Colors.white70
  ];
  static const String WELCOME_PAGE_INFO_TEXT = "We are a bible-teaching, bible-believing\n"
      "ministry dedicated to seeking the best\n"
      "God has for His people through excellence\n"
      "in ministry. Join us for Worship … your\n"
      "life will never, ever be the same.";
  static const String WELCOME_PAGE_BUTTON_TEXT = "Start Reading";

  // --- Share verse values ---
  static const String SHARE_VERSE_LABEL = 'Read this and more verses this great app: https://play.google.com/store/apps/details?id=$APP_ANDROID_ID';

  // --- Favorite verse values ---
  static const List<Color> FAVORITE_COLORS = [
    Colors.pinkAccent,
    Colors.orangeAccent,
    Colors.blueAccent,
    Colors.deepPurpleAccent,
    Colors.lightGreen
  ];

  // --- Share app values ---
  static const String SHARE_APP_LABEL = 'Great application to read The Bible: https://play.google.com/store/apps/details?id=$APP_ANDROID_ID';

  // --- About App values ---
  static const String RATE_APP_URL = 'https://play.google.com/store/apps/details?id=$APP_ANDROID_ID';
  static const String ABOUT_TERMS_URL = "https://youtube.com";
  static const String ABOUT_PRIVACY_URL = "https://google.com";

  static const List<List<String>> MORE_APPS = [
    // example: ['icon','name','url']
    /*
    ['assets/others/word.search.sopa.deletras.jpg', 'Word search puzzle', 'https://play.google.com/store/apps/details?id=word.search.sopa.deletras'],
    ['assets/others/com.play.tictactoe.game.jpg', 'Play tic tac toe', 'https://play.google.com/store/apps/details?id=com.play.tictactoe.game'],
    ['assets/others/com.bitcoin.free.jpg', 'Bitcoin Free - BTC graphics', 'https://play.google.com/store/apps/details?id=com.bitcoin.free'],
     */
  ];

  //  --- Rate app popup values ---

  //Minimum elapsed days since the first app launch.
  static const int RATE_APP_MIN_DAYS = 0;
  //Minimum app launches count.
  static const int RATE_APP_MIN_LAUNCHES = 0;

  static const int RATE_APP_REMIND_DAYS = 0;
  static const int RATE_APP_REMIND_LAUNCHES = 2;

  static const String RATE_APP_MESSAGE = "If you like this app, please take a little bit of your time to review it!";


}