import 'package:flutter/material.dart';

const Color blueCircleColor = Colors.lightBlue;
const Color blueShadowColor = Color.fromRGBO(60, 183, 233, 120);
Color blueGlowColor = Colors.blueAccent[700];

const Color yellowCircleColor = Colors.yellow;
const Color yellowShadowColor = Color.fromRGBO(255, 212, 62, 120);
Color yellowGlowColor = Colors.amberAccent[700];

const Color orangeCircleColor = Colors.orange;
const Color orangeShadowColor = Color.fromRGBO(253, 92, 2, 120);
Color orangeGlowColor = Colors.orangeAccent[700];

const Color redCircleColor = Colors.red;
const Color redShadowColor = Color.fromRGBO(255, 6, 6, 120);
Color redGlowColor = Colors.redAccent[700];

Color getCircleColor(int energySoFar) {
  if (energySoFar < 15) {
    return blueCircleColor;
  } else if (energySoFar < 30) {
    return yellowCircleColor;
  } else if (energySoFar < 45) {
    return orangeCircleColor;
  } else {
    return redCircleColor;
  }
}

Color getShadowColor(int energySoFar) {
  if (energySoFar < 15) {
    return blueShadowColor;
  } else if (energySoFar < 30) {
    return yellowShadowColor;
  } else if (energySoFar < 45) {
    return orangeShadowColor;
  } else {
    return redShadowColor;
  }
}

Color getGlowColor(int energySoFar) {
  if (energySoFar < 15) {
    return blueGlowColor;
  } else if (energySoFar < 30) {
    return yellowGlowColor;
  } else if (energySoFar < 45) {
    return orangeGlowColor;
  } else {
    return redGlowColor;
  }
}

const Color productRowDivider = Color(0xFFD9D9D9);

const Color scaffoldBackground = Color(0xfff0f0f0);

const Color searchBackground = Color(0xffe0e0e0);

const Color searchCursorColor = Color.fromRGBO(0, 122, 255, 1);

const Color searchIconColor = Color.fromRGBO(128, 128, 128, 1);