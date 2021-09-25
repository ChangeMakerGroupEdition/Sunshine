// ignore_for_file: camel_case_types, file_names, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shine',
      theme: ThemeData(),
      home: const home_page(),
    );
  }
}

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_page();
}

class _home_page extends State<home_page> {
  final Duration animDuration = const Duration(milliseconds: 250);
  final Color barBackgroundColor = const Color(0xff72d8bf);
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(11, 19, 40, 100),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text("Your Dashboard",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold)
              ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: size.height * 0.35,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/solar_panel.png"))),
            ),
            Text("Bintulu, Sarawak",
            style: TextStyle(
              fontSize: 19,
              color: Colors.white,
              fontWeight: FontWeight.bold)
            ),
            SizedBox(height: 15),
            Container(
                // margin: EdgeInsets.only(top: size.height * 0.5),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color.fromRGBO(39, 45, 63, 100),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Row(children: const <Widget>[
                          Expanded(
                            child: Text(
                              'Solar Irradiance',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),                              
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            child: ExpansionTile(
                              title: Text('Time',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                              ),
                              children: <Widget>[
                                ListTile(title: Text('Year')),
                                ListTile(title: Text('Daily'))
                              ],
                            ),
                          ),
                        ]),
                        Container(
                          height: 144,
                          margin: EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 8),
                                    padding: EdgeInsets.only(left: 8),
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.white, width: 1
                                    ),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      // TO-DO: Continue the Widget for Humidity~
                                    ],
                                  ),
                                  )],
                              )
                            ]
                          ),
                        ),
                        

                        Container(
                           width: 350,
                          height: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xff81e5cd)),
                            child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                            color: const Color(0xff81e5cd),
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Text(
                                        'Solar Irradiance',
                                        style: TextStyle(
                                            color: const Color(0xff0f4a3c), fontSize: 24, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: BarChart(mainBarData(),
                                            swapAnimationDuration: animDuration,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ),
                          SizedBox(
                        height : 30,
                      ),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
                            BarChartGroupData makeGroupData(
                              int x,
                              double y, {
                              bool isTouched = false,
                              Color barColor = Colors.white,
                              double width = 22,
                              List<int> showTooltips = const [],
                            }) {
                              return BarChartGroupData(
                                x: x,
                                barRods: [
                                  BarChartRodData(
                                    y: isTouched ? y + 1 : y,
                                    colors: isTouched ? [Colors.yellow] : [barColor],
                                    width: width,
                                    borderSide: isTouched
                                        ? BorderSide(color: Colors.yellow, width: 1)
                                        : BorderSide(color: Colors.white, width: 0),
                                    backDrawRodData: BackgroundBarChartRodData(
                                      show: true,
                                      y: 20,
                                      colors: [barBackgroundColor],
                                    ),
                                  ),
                                ],
                                showingTooltipIndicators: showTooltips,
                              );
                            }

                            List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
                                  switch (i) {
                                    case 0:
                                      return makeGroupData(0, 5, isTouched: i == touchedIndex);
                                    case 1:
                                      return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
                                    case 2:
                                      return makeGroupData(2, 5, isTouched: i == touchedIndex);
                                    case 3:
                                      return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
                                    case 4:
                                      return makeGroupData(4, 9, isTouched: i == touchedIndex);
                                    case 5:
                                      return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
                                    case 6:
                                      return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
                                    default:
                                      return throw Error();
                                  }
                                });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Monday';
                  break;
                case 1:
                  weekDay = 'Tuesday';
                  break;
                case 2:
                  weekDay = 'Wednesday';
                  break;
                case 3:
                  weekDay = 'Thursday';
                  break;
                case 4:
                  weekDay = 'Friday';
                  break;
                case 5:
                  weekDay = 'Saturday';
                  break;
                case 6:
                  weekDay = 'Sunday';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) =>
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'S';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }
}




