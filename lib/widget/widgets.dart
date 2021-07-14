import 'package:flutter/material.dart';
import 'package:suncheck/util/styles.dart';

Widget locationErrorScreen(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child:
        Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Icon(
        Icons.location_on_rounded,
        size: 60,
        color: Colors.red,
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Oops',
          style: TextStyle(fontSize: 45, fontWeight: FontWeight.w800, color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              text: '...',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Colors.black),
            ),
          ],
        ),
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text:
              'We will need your location to give you better experience.\n\n Please go to Settings > Privacy, and click on Location Services to grant',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              text: ' Suncheck ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
            ),
            TextSpan(
              text: 'access your location.',
            )
          ],
        ),
      ),
    ]),
  );
}

Widget apiErrorScreen(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child:
        Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Icon(
        Icons.error_outline_rounded,
        size: 60,
        color: Colors.red,
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
      Text('Oh no!', style: TextStyle(fontSize: 45, fontWeight: FontWeight.w800)),
      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'An unexpected error occured.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.black),
          children: <TextSpan>[
            // TextSpan(
            //   text: ' Suncheck ',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
            // ),
            TextSpan(
              text: '\nPlease check your internet and restart the app.',
            )
          ],
        ),
      ),
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
