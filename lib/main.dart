import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suncheck/calendar_screen.dart';
import 'package:suncheck/day_screen.dart';
import 'package:suncheck/home_screen.dart';
import 'package:suncheck/model/home_model.dart';
import 'package:suncheck/onboard_screen.dart';
import 'package:suncheck/util/utils.dart';

bool isViewed;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('onBoard') == null)
    isViewed = false;
  else
    isViewed = prefs.getBool('onBoard');
  runApp(MyApp());
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
        },
        kRouteCalendarScreen: (context) {
          return CalendarScreen();
        },
        kRouteHomeScreen: (context) {
          return ChangeNotifierProvider<HomeModel>(create: (context) => HomeModel(), child: HomeScreen());
        }
      },
      home: isViewed
          ? ChangeNotifierProvider<HomeModel>(create: (context) => HomeModel(), child: HomeScreen())
          : OnboardScreen(),
    );
  }
}
