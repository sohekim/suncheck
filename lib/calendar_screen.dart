import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suncheck/model/record.dart';
import 'package:suncheck/util/utils.dart';
import 'package:suncheck/util/database_helper.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  String year = '2021', month = '07';
  List<Record> records;
  PageController _pageController;

  Future<void> recordsByYearAndMonth() async {
    records = await DatabaseHelper.recordsByYearAndMonth(year, month);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: DateTime.now().month);
  }

  Widget _tabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            child: Text(
              "Close",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(25, 10, 25, 10)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(235, 228, 218, 100)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)))),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop()),
      ],
    );
  }

  Widget _completeScreen() {
    NumberFormat formatter = NumberFormat("00");
    return Scaffold(
        backgroundColor: Color.fromRGBO(253, 251, 247, 1),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.085),
                _tabBar(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 150,
                    child: PageView.builder(
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        month = formatter.format(index).toString();
                        return FutureBuilder(
                          future: recordsByYearAndMonth(),
                          builder: (futureContext, snapshot) {
                            if (snapshot.hasError) {
                              return Center(child: Text('Ooops...'));
                            }
                            if (snapshot.connectionState == ConnectionState.done) {
                              return Column(
                                children: [
                                  Text(
                                    year,
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.navigate_before_rounded,
                                        size: 30,
                                        color: Colors.grey[350],
                                      ),
                                      Text(monthToName[month],
                                          style: TextStyle(fontSize: 38, fontWeight: FontWeight.w800)),
                                      Icon(
                                        Icons.navigate_next_rounded,
                                        size: 30,
                                        color: Colors.grey[350],
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: GridView.count(
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20,
                                      crossAxisCount: 5,
                                      children: List.generate(records.length, (index) => _dots(records[index])),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return Center(child: Text('loading...'));
                          },
                        );
                      },
                    ),
                  ),
                ),
                Text(
                  'Tab To Check!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2)
              ],
            )));
  }

  Widget _dots(Record record) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(kRouteDayScreen, arguments: <String, dynamic>{
        'energy': record.energy,
        'date': record.date,
        'location': record.location
      }),
      child: Container(
        width: (MediaQuery.of(context).size.width - 150) / 8,
        height: (MediaQuery.of(context).size.width - 150) / 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: getCircleColor(record.energy),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: recordsByYearAndMonth(),
      builder: (futureContext, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Ooops...'));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return _completeScreen();
        }
        return Center(child: Text('loading...'));
      },
    );
  }
}
