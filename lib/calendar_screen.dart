import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suncheck/model/record.dart';
import 'package:suncheck/util/styles.dart';
import 'package:suncheck/util/utils.dart';
import 'package:suncheck/util/database_helper.dart';
import 'package:suncheck/widget/button.dart';
import 'package:suncheck/widget/widgets.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  NumberFormat formatter = NumberFormat("00");
  String year, month;
  List<Record> records;
  PageController _pageController;

  Future<void> recordsByYearAndMonth() async {
    records = await DatabaseHelper.recordsByYearAndMonth(year, month);
  }

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    year = now.year.toString();
    int adjustMonth = now.month - 1;
    _pageController = PageController(initialPage: adjustMonth);
    month = formatter.format(adjustMonth).toString();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: scaffoldBackground,
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.045),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.07),
                _tabBar(),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Expanded(
                  child: Container(
                    width: size.width * 0.68,
                    child: PageView.builder(
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        year = (DateTime.now().year + (index ~/ 12)).toString();
                        month = formatter.format((index % 12) + 1).toString();
                        return FutureBuilder(
                          future: recordsByYearAndMonth(),
                          builder: (futureContext, snapshot) {
                            if (snapshot.hasError) {
                              return apiErrorScreen(context);
                            }
                            if (snapshot.connectionState == ConnectionState.done) {
                              return Column(
                                children: [
                                  Text(
                                    year,
                                    style: TextStyle(fontSize: size.width * 0.042, fontWeight: FontWeight.w300),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () => _pageController.previousPage(
                                            duration: Duration(milliseconds: 400), curve: Curves.easeIn),
                                        child: Icon(
                                          Icons.navigate_before_rounded,
                                          size: 30,
                                          color: Colors.grey[350],
                                        ),
                                      ),
                                      Text(monthToName[month],
                                          style: TextStyle(fontSize: size.width * 0.088, fontWeight: FontWeight.w800)),
                                      GestureDetector(
                                        onTap: () => _pageController.nextPage(
                                            duration: Duration(milliseconds: 400), curve: Curves.easeIn),
                                        child: Icon(
                                          Icons.navigate_next_rounded,
                                          size: 30,
                                          color: Colors.grey[350],
                                        ),
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
                            return loadingScreen();
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
                SizedBox(height: size.height * 0.2)
              ],
            )));
  }

  Widget _tabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [roundButton("Close", () => Navigator.of(context, rootNavigator: true).pop())],
    );
  }

  Widget _dots(Record record) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(kRouteDayScreen,
          arguments: <String, dynamic>{'energy': record.energy, 'date': record.date, 'location': record.location}),
      child: Container(
        width: (size.width - 150) / 8,
        height: (size.width - 150) / 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: getCircleColor(record.energy),
        ),
      ),
    );
  }
}
