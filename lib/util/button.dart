import 'package:flutter/material.dart';

Widget roundButton(String name, Function onPressed) {
  return TextButton(
      child: Text(
        name,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
      ),
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(25, 10, 25, 10)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(235, 228, 218, 1)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)))),
      onPressed: onPressed);
}
