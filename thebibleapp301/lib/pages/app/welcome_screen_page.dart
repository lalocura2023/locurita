import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thebibleapp/environments.dart';
import 'package:thebibleapp/pages/app/app_home_page.dart';

class WelcomeScreenPage extends StatefulWidget {
  @override
  _WelcomeScreenPageState createState() => _WelcomeScreenPageState();
}

class _WelcomeScreenPageState extends State<WelcomeScreenPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: Environment.WELCOME_PAGE_COLORS)),
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0, top: 100.0),
                        child: Text(
                          Environment.APP_NAME,
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3.9,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0, top: 40.0),
                        child:
                        Image.asset("assets/icon/icon.jpg", height: 110.0),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0, top: 60.0),
                        child: Text(
                            Environment.WELCOME_PAGE_INFO_TEXT,
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(color: Colors.white, fontSize: 16.0)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0, top: 50.0),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AppHomePage()),
                            );
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.0),
                              side:
                              BorderSide(color: Colors.white, width: 2.0)),
                          child: Text(
                            Environment.WELCOME_PAGE_BUTTON_TEXT,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18.0),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
