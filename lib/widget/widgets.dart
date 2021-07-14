import 'package:flutter/material.dart';
import 'package:suncheck/util/colors.dart';

Widget locationErrorScreen(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child:
        Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Icon(
        Icons.location_on_rounded,
        size: 60,
        color: Colors.red,
      ),
      Text('Oops', style: TextStyle(fontSize: 45, fontWeight: FontWeight.w800)),
      Text('You have to allow Suncheck to access your location. Please go to Settings > blah blah blah',
          textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300))
    ]),
  );
}

Widget apiErrorScreen(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child:
        Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Icon(
        Icons.error_outline_rounded,
        size: 60,
        color: Colors.red,
      ),
      Text('Oh no!', style: TextStyle(fontSize: 45, fontWeight: FontWeight.w800)),
      Text('An unexpected error occured. Please check your internet and restart the app.',
          textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
    ]),
  );
}

Widget loadingScreen() {
  return Container(
    color: scaffoldBackground,
    child: Center(
      child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color.fromRGBO(235, 228, 218, 1))),
    ),
  );
}
