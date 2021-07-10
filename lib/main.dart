import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:suncheck/day_screen.dart';
import 'package:suncheck/home_provider.dart';
import 'package:suncheck/home_screen.dart';
import 'package:suncheck/util/utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _initNotiSetting();
  runApp(MyApp());
}

void _initNotiSetting() async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final initSettingsIOS = IOSInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );
  final initSettings = InitializationSettings(
    iOS: initSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      theme: const CupertinoThemeData(brightness: Brightness.light),
      routes: {
        kRouteDayScreen: (context) {
          return DayScreen();
        }
      },
      home: ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider(), child: HomeScreen()),
    );
  }
}
