import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:thebibleapp/pages/app/welcome_screen_page.dart';
import 'app_home_page.dart';

import '../../models_providers/user_provider.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 2000)).then((value) async {
      Provider.of<UserProvider>(context, listen: false).initState();
      Get.offAll(WelcomeScreenPage());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Center(child: LoadingFlipping.square(backgroundColor: Theme.of(context).accentColor))],
        ),
      ),
    );
  }
}
