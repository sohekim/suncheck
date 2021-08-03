import 'package:flutter/material.dart';
import 'package:geocoder/model.dart';
import 'package:weather/weather.dart';

Widget lightbulbText(int energySoFar) {
  return RichText(
    text: TextSpan(
      text: 'Enough To Light Up ',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.black),
      children: <TextSpan>[
        TextSpan(text: '${energySoFar * 8}', style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: ' Lightbulbs'),
      ],
    ),
  );
}

Widget energyText(int energySoFar) {
  return RichText(
    text: TextSpan(
      text: 'In The Sun For ',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.black),
      children: <TextSpan>[
        TextSpan(text: '$energySoFar', style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: ' Mins Today'),
      ],
    ),
  );
}

Widget buttonText(bool isOn) {
  return isOn
      ? Text(
          'Tap to Stop',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
        )
      : Text(
          'Tap to Start',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
        );
}

Widget myAddress(Address address) {
  return Text(
    '${address.adminArea}, ${address.countryName}',
    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
  );
}

Widget weatherDetail(Weather weather) {
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

Widget temperature(Weather weather, bool isCelsius) {
  return Text(
    isCelsius ? '${weather.temperature.celsius.toInt()}°' : '${weather.temperature.fahrenheit.toInt()}°',
    style: TextStyle(fontSize: 50, fontWeight: FontWeight.w800),
  );
}
