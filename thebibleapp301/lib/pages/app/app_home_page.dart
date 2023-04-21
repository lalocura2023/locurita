import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../user/user_bible_verses_favorites_page.dart';

import '../../models_providers/app_provider.dart';
import '../../models_providers/theme_provider.dart';
import '../user/user_about_us_page.dart';
import '../user/user_bible_page.dart';

class AppHomePage extends StatefulWidget {
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  int index = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
        body: appPages.elementAt(appProvider.selectedPageIndex),
        bottomNavigationBar: Container(
          height: 82,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "Bible"),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
              BottomNavigationBarItem(icon: Icon(Icons.explore), label: "About Us"),
            ],
            onTap: (index) {
              appProvider.setSelectedPageIndex = index;
              setState(() {});
            },
            currentIndex: appProvider.selectedPageIndex,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            selectedItemColor: themeProvider.isThemeModeLight ? Color(0XFF7D1EFF) : Colors.white,
            unselectedItemColor: themeProvider.isThemeModeLight ? Color(0XFF7B7E83) : Colors.white38,
          ),
        ));
  }

  /* ----------------------------- NOTE AppPages ----------------------------- */
  List<Widget> appPages = [
    UserBiblePage(),
    UserBibleVersesFavoritesPage(),
    UserAboutUsPage(),
  ];
}
