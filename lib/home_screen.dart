import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:suncheck/calendar_screen.dart';
import 'package:suncheck/util/utils.dart';
import 'package:suncheck/model/record.dart';
import 'package:suncheck/util/database_helper.dart';
import 'package:suncheck/util/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  Database database;
  DateTime myTime;
  SharedPreferences prefs;
  Weather weather;
  Address address;
  DateTime initTime;

  String addressText;
  bool databaseInitialized = false;
  bool preferecedInitialized = false;
  bool isOn = false;

  Color circleColor = blueCircleColor;
  Color shadowColor = blueShadowColor;
  Color glowColor = blueGlowColor;

  int energySoFar = 0;

  Future<void> _initialization() async {
    DateTime now = DateTime.now();

    if (initTime == null || now.difference(initTime).inMinutes > 30) {
      // 1. position
      Position position = await determinePosition();
      print('${position.longitude} ${position.latitude}');

      // 2. weather
      WeatherFactory wf = new WeatherFactory(OPENWEATHER_API_KEY);
      weather = await wf.currentWeatherByLocation(position.latitude, position.longitude);
      print(weather);

      // 3. address
      List<Address> addresses =
          await Geocoder.local.findAddressesFromCoordinates(Coordinates(position.latitude, position.longitude));
      address = addresses.first;
      addressText = '${address.adminArea}, ${address.countryName}';

      if (!databaseInitialized) {
        await DatabaseHelper.initDatabase();
        databaseInitialized = true;
      }
      if (!preferecedInitialized) {
        prefs = await SharedPreferences.getInstance();
        preferecedInitialized = true;
      }

      try {
        Record prevRecord = await DatabaseHelper.findRecordByDate(DateTime.now());
        energySoFar = prevRecord.energy;
      } catch (exception) {}

      initTime = now;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization(),
      builder: (futureContext, snapshot) {
        if (snapshot.hasError) {
          return _errorScreen();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return _completeScreen();
        }
        if (initTime == null) {
          return _loadingScreen();
        }
        return _completeScreen();
      },
    );
  }

  tz.TZDateTime _setNotiTime() {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
    final now = tz.TZDateTime.now(tz.local);
    final after = now.add(Duration(minutes: 15));
    var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, after.hour, after.minute);

    return scheduledDate;
  }

  Widget _temp() {
    return Text(
      '${weather.temperature.celsius.toInt()}°C',
      style: TextStyle(fontSize: 50, fontWeight: FontWeight.w800),
    );
  }

  Widget _weatherDetail() {
    return Column(children: [
      Text(
        'Humidity ${weather.humidity.toInt()}%',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
      ),
      Text(
        '${weather.weatherMain}',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
      ),
    ]);
  }

  Widget _circle() {
    return AvatarGlow(
      glowColor: isOn ? getGlowColor(energySoFar) : Color.fromRGBO(253, 251, 247, 1),
      endRadius: MediaQuery.of(context).size.width * 0.68 - 110,
      duration: Duration(milliseconds: 2000),
      repeat: true,
      showTwoGlows: false,
      repeatPauseDuration: Duration(milliseconds: 100),
      child: GestureDetector(
        onTap: () async {
          if (isOn) {
            DateTime now = DateTime.now();
            Duration duration = now.difference(DateTime.parse(prefs.getString('start')));
            int newEnergy = duration.inMinutes;
            try {
              Record prevRecord = await DatabaseHelper.findRecordByDate(now);
              await DatabaseHelper.updateRecord(Record(
                  id: prevRecord.id,
                  energy: prevRecord.energy + newEnergy,
                  date: prevRecord.date,
                  location: prevRecord.location));
              energySoFar = prevRecord.energy + newEnergy;
            } catch (exception) {
              await DatabaseHelper.insertRecord(Record(date: DateTime.now(), energy: newEnergy, location: addressText));
              energySoFar = newEnergy;
            }
          } else {
            await prefs.setString('start', DateTime.now().toString());
            final notiTitle = "We see you chillin in the sun";
            final notiDesc = "It’s been 15 mins. Don’t forget to turn it off  when you’re back!";
            final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
            final result = await flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
                ?.requestPermissions(
                  alert: true,
                  badge: true,
                  sound: true,
                );

            var ios = IOSNotificationDetails();
            var detail = NotificationDetails(iOS: ios);

            if (result) {
              await flutterLocalNotificationsPlugin
                  .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
                  ?.deleteNotificationChannelGroup('id');

              await flutterLocalNotificationsPlugin.zonedSchedule(
                0,
                notiTitle,
                notiDesc,
                _setNotiTime(),
                detail,
                androidAllowWhileIdle: true,
                uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
                matchDateTimeComponents: DateTimeComponents.time,
              );
            }
          }
          setState(() {});
          isOn = !isOn;
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.68,
          height: MediaQuery.of(context).size.width * 0.68,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: getCircleColor(energySoFar),
            boxShadow: isOn ? [BoxShadow(color: getShadowColor(energySoFar), blurRadius: 40, spreadRadius: 27)] : null,
          ),
        ),
      ),
    );
  }

  Widget _completeScreen() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      color: Color.fromRGBO(253, 251, 247, 1),
      width: size.width,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(height: size.height * 0.08),
        _topBar(),
        SizedBox(height: size.height * 0.06),
        _temp(),
        SizedBox(height: size.height * 0.01),
        _weatherDetail(),
        SizedBox(height: size.height * 0.03),
        _circle(),
        SizedBox(height: size.height * 0.03),
        isOn
            ? Text(
                'Tap to Stop',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              )
            : Text(
                'Tap to Start',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              ),
        SizedBox(height: size.height * 0.05),
        RichText(
          text: TextSpan(
            text: 'In The Sun For ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: '$energySoFar', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: ' Mins Today'),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.01),
        RichText(
          text: TextSpan(
            text: 'Enough To Light Up ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: '${energySoFar * 8}', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: ' Lightbulbs'),
            ],
          ),
        ),
      ]),
    ));
  }

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${address.adminArea}, ${address.countryName}',
            style: TextStyle(fontSize: 14),
          ),
          TextButton(
              child: Text(
                "Calendar",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              ),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(25, 10, 25, 10)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(235, 228, 218, 1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)))),
              onPressed: () {
                Route route = MaterialPageRoute(builder: (_) => CalendarScreen());
                Navigator.of(context).push(route);
              }),
        ],
      ),
    );
  }

  Widget _errorScreen() {
    return Center(
      // you have to allow location ~~
      child: Text('Ooops Error!'),
    );
  }

  Widget _loadingScreen() {
    return Container(
      color: Color.fromRGBO(253, 251, 247, 1),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
