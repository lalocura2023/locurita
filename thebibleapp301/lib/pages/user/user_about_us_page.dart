import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../environments.dart';
import '../../models_providers/theme_provider.dart';

class UserAboutUsPage extends StatefulWidget {
  UserAboutUsPage({Key key}) : super(key: key);

  @override
  _UserAboutUsPageState createState() => _UserAboutUsPageState();
}

class _UserAboutUsPageState extends State<UserAboutUsPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Color iconColor = themeProvider.isThemeModeLight ? Colors.black : Colors.white;
    Color textColor = themeProvider.isThemeModeLight ? Colors.black : Colors.grey[100];

    return Scaffold(
      appBar: AppBar(
        title: Text('About us', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Text('Change Theme'),
            trailing: RotatedBox(child: Icon(Icons.arrow_forward_ios, size: 18), quarterTurns: 1),
            onTap: () => _showGetDialogTheme(themeProvider),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                TextButton.icon(
                  onPressed: () => SocialShare.shareOptions(Environment.SHARE_APP_LABEL),
                  icon: Icon(Icons.share_sharp, color: iconColor),
                  label: Text("Share App", style: TextStyle(color: textColor))
                ),
              TextButton.icon(
                onPressed: () => SocialShare.shareWhatsapp(Environment.SHARE_APP_LABEL),
                icon: Icon(FontAwesome.whatsapp, color: iconColor),
                label: Text("Share App On Whatsapp", style: TextStyle(color: textColor))
              ),
              TextButton.icon(
                onPressed: () => launch(Environment.RATE_APP_URL),
                icon: Icon(Icons.star_border, color: iconColor),
                label: Text("Rate on Google Play", style: TextStyle(color: textColor))
              )
            ]
          ),
          if (Environment.MORE_APPS.length > 0)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(thickness: 1, indent: 15, endIndent: 15),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Text('More Apps', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: textColor))
              ),
              for (var APP in Environment.MORE_APPS)
                Container(
                  child: TextButton.icon(onPressed: () => launch(APP[2]), icon: Image.asset(APP[0], width: 35), label: Text(APP[1], style: TextStyle(color: textColor)))
                ),
            ]
          ),
          const Divider(
            thickness: 1,
            indent: 15,
            endIndent: 15,
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () => launch(Environment.ABOUT_TERMS_URL),
                  icon: Icon(Icons.notes_sharp, color: iconColor),
                  label: Text("Terms Conditions", style: TextStyle(color: textColor)),
                ),
                TextButton.icon(
                    onPressed: () => launch(Environment.ABOUT_PRIVACY_URL),
                    icon: Icon(Icons.privacy_tip_outlined, color: iconColor),
                    label: Text("Privacy Policy", style: TextStyle(color: textColor))
                )
              ]
          )
        ],
      ),
    );
  }

  void _showGetDialogTheme(ThemeProvider themeProvider) {
    Get.bottomSheet(Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              themeProvider.themeMode = ThemeMode.light;
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Text('Light Theme', style: TextStyle(color: Colors.black)),
                  Spacer(),
                  Icon(FontAwesome.sun_o, color: Colors.black),
                ],
              ),
            ),
          ),
          Divider(height: 0),
          GestureDetector(
            onTap: () {
              themeProvider.themeMode = ThemeMode.dark;
              Navigator.pop(context);
            },
            child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(children: [
                  Text(
                    'Dart Theme',
                    style: TextStyle(color: Colors.black),
                  ),
                  Spacer(),
                  Icon(FontAwesome5.moon, color: Colors.black)
                ])),
          ),
          Divider(height: 0),
          GestureDetector(
            onTap: () {
              themeProvider.themeMode = ThemeMode.system;
              Navigator.pop(context);
            },
            child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(children: [
                  Text(
                    'System Theme',
                    style: TextStyle(color: Colors.black),
                  ),
                  Spacer(),
                  Icon(AntDesign.setting, color: Colors.black)
                ])),
          ),
          if (Platform.isIOS) SizedBox(height: 10)
        ],
      ),
    ));
  }
}
