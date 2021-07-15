import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:suncheck/calendar_screen.dart';
import 'package:suncheck/util/styles.dart';
import 'package:suncheck/util/utils.dart';
import 'package:suncheck/model/record.dart';
import 'package:suncheck/util/database_helper.dart';
import 'package:suncheck/util/geolocator.dart';
import 'package:suncheck/widget/button.dart';
import 'package:suncheck/widget/home_screen_widget.dart';
import 'package:suncheck/widget/widgets.dart';
import 'package:weather/weather.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  Database database;
  SharedPreferences prefs;
  Weather weather;
  Address address;
  DateTime initTime;
  String addressText;
  bool databaseInitialized = false;
  bool preferecedInitialized = false;
  bool isOn = false;
  int energySoFar = 0;
  bool isCelsius = true;
  Color circleColor = blueCircleColor;
  Color shadowColor = blueShadowColor;
  Color glowColor = blueGlowColor;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        setState(() {});
        break;
      case AppLifecycleState.paused:
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _initialization() async {
    DateTime now = DateTime.now();
    if (initTime == null || now.difference(initTime).inMinutes > interval) {
      Position position;
      try {
        position = await determinePosition();
        print('${position.longitude} ${position.latitude}');
      } catch (exception) {
        throw Exception('location error');
      }

      WeatherFactory wf = new WeatherFactory(OPENWEATHER_API_KEY);
      weather = await wf.currentWeatherByLocation(position.latitude, position.longitude);
      print(weather);

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
      } catch (exception) {
        // means there are no records found by date
      }

      initTime = now;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization(),
      builder: (futureContext, snapshot) {
        if (snapshot.hasError) {
          if (snapshot.error.toString() == 'Exception: location error') {
            return Scaffold(body: locationErrorScreen(context));
          } else {
            return Scaffold(body: apiErrorScreen(context));
          }
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return _completeScreen();
        }
        if (initTime == null) {
          return loadingScreen();
        }
        return _completeScreen();
      },
    );
  }

  Widget _completeScreen() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      color: scaffoldBackground,
      width: size.width,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(height: size.height * 0.07),
        topBar(_navigateToDay),
        SizedBox(height: size.height * 0.04),
        myAddress(address),
        SizedBox(height: size.height * 0.005),
        GestureDetector(
            onTap: () {
              setState(() {
                isCelsius = !isCelsius;
              });
            },
            child: temperature(weather, isCelsius)),
        SizedBox(height: size.height * 0.01),
        weatherDetail(weather),
        SizedBox(height: size.height * 0.03),
        _circle(),
        SizedBox(height: size.height * 0.03),
        buttonText(isOn),
        SizedBox(height: size.height * 0.05),
        energyText(energySoFar),
        SizedBox(height: size.height * 0.01),
        lightbulbText(energySoFar),
      ]),
    ));
  }

  Widget topBar(Function onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                setState(() {
                  isCelsius = !isCelsius;
                });
              },
              child: RichText(
                text: TextSpan(
                  text: '°C',
                  style: isCelsius ? midThinBlackText : midThinBlackText.copyWith(color: Colors.grey[400]),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' / °F',
                      style: isCelsius ? midThinBlackText.copyWith(color: Colors.grey[400]) : midThinBlackText,
                    )
                  ],
                ),
              )),
          roundButton("Calendar", onPressed),
        ],
      ),
    );
  }

  Widget _circle() {
    return AvatarGlow(
      glowColor: isOn ? getGlowColor(energySoFar) : scaffoldBackground,
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

  Future<void> _navigateToDay() async {
    await Navigator.of(context).pushNamed(kRouteCalendarScreen);
    setState(() {});
  }
}
