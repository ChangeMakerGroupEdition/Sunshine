// ignore_for_file: camel_case_types, file_names, prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:myapp/frontend/DetailsScreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'onboard_screen.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: home_page(),
    );
  }
}

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_page();
}

class _home_page extends State<home_page> {
  static final _initialCameraPosition =
      CameraPosition(target: positionNow, zoom: 11.5);
  late GoogleMapController _googleMapController;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  // final LatLng _center = const LatLng(28.535517, 77.391029);

  // List<MapMarker> mapMarkers = [];
  // List<Marker> customMarkers = [];

  // List<Marker> mapBitmapsToMarkers(List<Uint8List> bitmaps) {
  //   bitmaps.asMap().forEach((mid, bmp) {
  //     customMarkers.add(Marker(
  //       markerId: MarkerId("$mid"),
  //       position: locations[mid].coordinates,
  //       icon: BitmapDescriptor.fromBytes(bmp),
  //     ));
  //   });
  // }

  // @override
  // void initState() {
  //   MarkerGenerator(markerWidgets(), (bitmaps) {
  //     setState(() {
  //       mapBitmapsToMarkers(bitmaps);
  //     });
  //   }).generate(context);
  // }

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  bool showAvg = false;
  late List<bool> isSelected;
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  final Duration animDuration = const Duration(milliseconds: 250);
  final Color barBackgroundColor = const Color(0xff72d8bf);
  int touchedIndex = -1;
  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromRGBO(15, 34, 97, 100),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 20, bottom: 5, top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Your Dashboard',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      RawMaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsScreen()));
                          },
                          elevation: 2.0,
                          padding: EdgeInsets.all(8),
                          shape: CircleBorder(),
                          fillColor: Colors.white30,
                          child: Icon(Icons.info_outline_rounded,
                              color: Colors.white))
                    ],
                  ),
                ),

                // SizedBox(height: 25),
                // Text("Your Dashboard",
                //     style: TextStyle(
                //         fontSize: 22,
                //         color: Colors.white,
                //         fontWeight: FontWeight.bold)),
                // SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: size.height * 0.35,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/intropic.png"))),
                ),
                // Text("Bintulu, Sarawak",
                //     style: TextStyle(
                //         fontSize: 19,
                //         color: Colors.white,
                //         fontWeight: FontWeight.bold)),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 100,
                  ),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Text(
                      'Bintulu, Sarawak',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 15),
                Container(
                    // margin: EdgeInsets.only(top: size.height * 0.5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color.fromRGBO(26, 57, 140, 100),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            Row(children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Solar Irradiance',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Expanded(
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: ToggleButtons(
                                          fillColor: Colors.lightBlue,
                                          selectedColor: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          isSelected: isSelected,
                                          onPressed: (int index) {
                                            setState(() {
                                              for (int buttonIndex = 0;
                                                  buttonIndex <
                                                      isSelected.length;
                                                  buttonIndex++) {
                                                if (buttonIndex == index) {
                                                  isSelected[buttonIndex] =
                                                      true;
                                                } else {
                                                  isSelected[buttonIndex] =
                                                      false;
                                                }
                                              }
                                            });
                                          },
                                          children: const <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Text(
                                                "Daily",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Text(
                                                "Yearly",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ]))),
                            ]),
                            SizedBox(height: 15),
                            AspectRatio(
                              aspectRatio: 1.20,
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color.fromRGBO(57, 19, 178, 100),
                                        Color.fromRGBO(52, 28, 255, 100)
                                      ]),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0,
                                      left: 10.0,
                                      top: 20,
                                      bottom: 12),
                                  child: LineChart(
                                    showAvg ? avgData() : mainData(),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              height: 34,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    showAvg = !showAvg;
                                  });
                                },
                                child: Text(
                                  'avg',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: showAvg
                                          ? Colors.white.withOpacity(0.5)
                                          : Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Center(
                                    child: Wrap(
                                      spacing: 20.0,
                                      runSpacing: 20.0,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: const [0.1, 0.4, 0.7, 0.9],
                                              colors: const [
                                                Color(0xFF3594DD),
                                                Color(0xFF4563DB),
                                                Color(0xFF5036D5),
                                                Color(0xFF5B16D0),
                                              ],
                                            ),
                                          ),
                                          width: 160.0,
                                          height: 160.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "assets/images/wind.png",
                                                  width: 64.0,
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Text("Wind Speed",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.0)),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text("69 mph",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400))
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: const [0.1, 0.4, 0.7, 0.9],
                                              colors: const [
                                                Color(0xFF3594DD),
                                                Color(0xFF4563DB),
                                                Color(0xFF5036D5),
                                                Color(0xFF5B16D0),
                                              ],
                                            ),
                                          ),
                                          width: 160.0,
                                          height: 160.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "assets/images/temperature.png",
                                                  width: 64.0,
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Text("Temperature",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.0)),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text("69°C",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400))
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: const [0.1, 0.4, 0.7, 0.9],
                                              colors: const [
                                                Color(0xFF3594DD),
                                                Color(0xFF4563DB),
                                                Color(0xFF5036D5),
                                                Color(0xFF5B16D0),
                                              ],
                                            ),
                                          ),
                                          width: 160.0,
                                          height: 160.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "assets/images/water.png",
                                                  width: 64.0,
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Text("Humidity",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.0)),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text("69 g/kg",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400))
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: const [0.1, 0.4, 0.7, 0.9],
                                              colors: const [
                                                Color(0xFF3594DD),
                                                Color(0xFF4563DB),
                                                Color(0xFF5036D5),
                                                Color(0xFF5B16D0),
                                              ],
                                            ),
                                          ),
                                          width: 160.0,
                                          height: 160.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "assets/images/uv.png",
                                                  width: 64.0,
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Text("UV Index",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.0)),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text("69 mW/cm2",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400))
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Container(
                                width: 350,
                                height: 350,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                  color: Color.fromRGBO(43, 28, 154, 100),
                                  child: Stack(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Text(
                                              'Estimated Savings',
                                              style: TextStyle(
                                                  color: Colors.yellow,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: BarChart(
                                                  mainBarData(),
                                                  swapAnimationDuration:
                                                      animDuration,
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
                                )),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                height: 500,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Stack(children: [
                                  GoogleMap(
                                    myLocationButtonEnabled: true,
                                    mapType: MapType.normal,
                                    initialCameraPosition:
                                        _initialCameraPosition,
                                  ),
                                  FloatingActionButton(
                                      onPressed: () =>
                                          _googleMapController.animateCamera(
                                              CameraUpdate.newCameraPosition(
                                                  _initialCameraPosition)))
                                ])),
                          ],
                        ))),
              ],
            ),
          ),
        ));
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
          getTextStyles: (context, value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
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

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10kWh';
              case 3:
                return '30kWh';
              case 5:
                return '50kWh';
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
          interval: 1,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '1k';
              case 3:
                return '3k';
              case 5:
                return '5k';
            }
            return '';
          },
          reservedSize: 32,
          interval: 1,
          margin: 12,
        ),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }
}
                            // child: ExpansionTile(
                            //   title: Text(
                            //     'Time',
                            //     style: TextStyle(
                            //         fontWeight: FontWeight.bold,
                            //         fontSize: 20,
                            //         color: Colors.white),
                            //   ),
                            //   children: <Widget>[
                            //     ListTile(title: Text('Year')),
                            //     ListTile(title: Text('Daily'))
                            //   ],
                            // ),