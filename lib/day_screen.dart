import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:suncheck/util/styles.dart';
import 'package:suncheck/util/utils.dart';
import 'package:suncheck/widget/button.dart';

class DayScreen extends StatelessWidget {
  int energy;
  DateTime date;
  String location;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
    energy ??= arguments['energy'];
    date ??= arguments['date'];
    location ??= arguments['location'];

    return Container(
      color: scaffoldBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.085),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [roundButton("Close", () => Navigator.of(context, rootNavigator: true).pop())],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getCircleColor(energy),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.15),
                  child: DottedLine(
                    dashLength: 3,
                    dashGapLength: 5,
                    dashRadius: 30,
                  ),
                ),
                textArea(
                    energy,
                    DateFormat('EEEE').format(date),
                    monthToName[NumberFormat("00").format(date.month).toString()],
                    Jiffy([date.year, date.month, date.day]).format("do"),
                    date.year.toString()),
                SizedBox(height: MediaQuery.of(context).size.height * 0.033),
                funFact(energy)
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget textArea(int energy, String weekday, String month, String day, String year) {
    if (energy < 15) {
      return RichText(
        text: TextSpan(
          text: 'Wow!\nOn ',
          style: TextStyle(
            fontSize: 26,
            color: Colors.black,
            fontWeight: FontWeight.w300,
            height: 1.3,
          ),
          children: <TextSpan>[
            TextSpan(text: '$weekday\n$month $day', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ' $year,\nyou were enjoying the\n'),
            TextSpan(text: 'Sun ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: 'for '),
            TextSpan(text: '$energy', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ' mins in\n'),
            TextSpan(text: '$location.', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );
    } else if (energy < 30) {
      return RichText(
        text: TextSpan(
          text: 'Congratulations!\nOn ',
          style: TextStyle(
            fontSize: 26,
            color: Colors.black,
            fontWeight: FontWeight.w300,
            height: 1.3,
          ),
          children: <TextSpan>[
            TextSpan(text: '$weekday\n$month $day', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ' $year,\nyou were enjoying the'),
            TextSpan(text: ' \nSun ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: 'for '),
            TextSpan(text: '$energy', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ' mins in\n'),
            TextSpan(text: '$location.', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );
    } else if (energy < 45) {
      return RichText(
        text: TextSpan(
          text: 'Hooray!\nOn ',
          style: TextStyle(
            fontSize: 26,
            color: Colors.black,
            fontWeight: FontWeight.w300,
            height: 1.3,
          ),
          children: <TextSpan>[
            TextSpan(text: '$weekday\n$month $day', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ' $year,\nyou were enjoying the'),
            TextSpan(text: ' Sun ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: 'for '),
            TextSpan(text: '$energy', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ' mins in\n'),
            TextSpan(text: '$location.', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );
    } else {
      return RichText(
        text: TextSpan(
          text: 'Sun Lover!\nOn ',
          style: TextStyle(
            fontSize: 26,
            color: Colors.black,
            fontWeight: FontWeight.w300,
            height: 1.3,
          ),
          children: <TextSpan>[
            TextSpan(text: '$weekday\n$month $day', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ' $year,\nyou were enjoying the'),
            TextSpan(text: ' Sun ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: 'for '),
            TextSpan(text: '$energy', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ' mins in\n'),
            TextSpan(text: '$location.', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }
  }

  Widget funFact(int energy) {
    return RichText(
      text: TextSpan(
        text: 'You synthesized approx ',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.w300,
          height: 1.3,
        ),
        children: <TextSpan>[
          TextSpan(text: '\n${energy * 160}', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: ' IU Vitamin D.\n\n'),
          TextSpan(text: 'You can light up'),
          TextSpan(text: ' ${energy * 8} ', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'lightbulbs.'),
        ],
      ),
    );
  }
}
