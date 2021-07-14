import 'package:flutter/material.dart';
import 'package:suncheck/util/colors.dart';

Widget roundButton(String name, Function onPressed) {
  return TextButton(
      child: Text(
        name,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
      ),
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(25, 10, 25, 10)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)))),
      onPressed: onPressed);
}
