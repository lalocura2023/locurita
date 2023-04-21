import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';
import 'package:thebibleapp/environments.dart';

import 'models_providers/ads_provider.dart';
import 'models_providers/app_provider.dart';
import 'models_providers/theme_provider.dart';
import 'models_providers/user_provider.dart';
import 'pages/app/splash_screen_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final settings = await Hive.openBox('settings');
  settings.put('appVersion', packageInfo.version);
  settings.put('appBuildNumber', packageInfo.buildNumber);

  ThemeMode themeMode = await Themes.getThemeModeHive();

  runApp(ChangeNotifierProvider(create: (_) => ThemeProvider(themeMode), child: MyApp()));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    Themes.setStatusNavigationBarColor();
    super.didChangeDependencies();
  }

  @override
  void didChangePlatformBrightness() {
    Themes.setStatusNavigationBarColor();
    Provider.of<ThemeProvider>(context, listen: false).checkPlatformBrightness();
    super.didChangePlatformBrightness();
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    Themes.setStatusNavigationBarColor();
    Provider.of<ThemeProvider>(context, listen: false).checkPlatformBrightness();
    super.didChangeAppLifecycleState(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => AdsProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: Environment.APP_NAME,
        theme: Themes.light(),
        darkTheme: Themes.dark(),
        themeMode: themeProvider.themeMode,
        home: SplashScreenPage(),
      ),
    );
  }
}
