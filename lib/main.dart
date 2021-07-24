import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suncheck/calendar_screen.dart';
import 'package:suncheck/day_screen.dart';
import 'package:suncheck/home_screen.dart';
import 'package:suncheck/model/home_model.dart';
import 'package:suncheck/util/utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        }
      },
      home: ChangeNotifierProvider<HomeModel>(create: (context) => HomeModel(), child: HomeScreen()),
    );
  }
}
