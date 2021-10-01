import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:location/location.dart';
import 'package:myapp/frontend/detail_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:myapp/service/data_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late LocationData _currentPosition;
  late Marker marker;
  late Location location = Location();
  late GoogleMapController _googleMapController;
  late GoogleMapController _controller;
  LatLng _initialcameraposition = const LatLng(0.5937, 0.9629);
  late List<bool> isSelected = [true, false];
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  final Duration animDuration = const Duration(milliseconds: 250);
  final Color barBackgroundColor = const Color(0xff72d8bf);
  int touchedIndex = -1;
  late LatLng _initialPosition;
  late LatLng _lastMapPosition = _initialPosition;
  String address = '';
  late Completer<GoogleMapController> controller1;
  String initialValue = 'Select Panel';
  String currentValue = "";
  int powerOutput = 0;
  double efficiency = 0;
  String initialTimeRange = "Week";
  int saving = 300;

  var itemList = [
    'Select Panel',
    'SunPower Maxeon 3',
    'LG Neon R',
    'RECT Alpha Pure',
    'Panasonic EverVolt',
    'Silfab Solar Elite BK',
    'Jinko Solar Tigert N-type 66TR',
    'FuturaSun FU M Zebra',
    'Hyundai HiE-S400UF',
    'Trina Solar Vertex S',
    'SPIC Solar Andromeda',
  ];

  var time_range = ["Week", "Month", "Year"];

  late Future<YearRangeDataset> yearDataset;
  late Future<HourlyDataset> hourDataset;

  void getDropDownItem() {
    setState(() {
      currentValue = initialValue;
    });
  }

  // AssetImage image1 = const AssetImage('assets/solarpanel/sunpower.jpg');
  // Image image2 = Image.network(
  //     'https://www.lg.com/global/images/business/Q1C-A6/1100-01.jpg');
  // AssetImage image3 = const AssetImage('assets/solarpanel/recalpha.png');
  // AssetImage image4 = const AssetImage('assets/solarpanel/panasonic.png');
  // AssetImage image5 = const AssetImage('assets/solarpanel/sil.jpg');
  // AssetImage image6 = const AssetImage('assets/solarpanel/Tiger.jpg');
  // AssetImage image7 = const AssetImage('assets/solarpanel/futuresun.png');
  // AssetImage image8 = const AssetImage('assets/solarpanel/Hyundai.jpg');
  // AssetImage image9 = const AssetImage('assets/solarpanel/trina.png');
  // AssetImage image10 = const AssetImage('assets/solarpanel/spic.jpg');

  downButtonFunction() async {
    getDropDownItem();
    switch (currentValue) {
      case 'Select Panel':
        break;
      case 'SunPower Maxeon 3':
        powerOutput = 400;
        efficiency = 22.8;
        break;
      case 'LG Neon R LG400Q1C-A6':
        powerOutput = 400;
        efficiency = 22.1;
        break;
      case 'REC Alpha Pure':
        powerOutput = 405;
        efficiency = 21.9;
        break;
      case 'Panasonic EverVolt':
        powerOutput = 380;
        efficiency = 21.7;
        break;
      case 'Silfab Solar Elite BK':
        powerOutput = 405;
        efficiency = 21.4;
        break;
      case 'Jinko Solar Tiger N-type 66TR':
        powerOutput = 410;
        efficiency = 21.4;
        break;
      case 'FuturaSun FU M Zebra':
        powerOutput = 360;
        efficiency = 21.3;
        break;
      case 'Hyundai HiE-S400UF':
        powerOutput = 400;
        efficiency = 21.3;
        break;
      case 'Trina Solar Vertex S':
        powerOutput = 405;
        efficiency = 21.1;
        break;
      case 'SPIC Solar Andromeda':
        powerOutput = 355;
        efficiency = 21.0;
        break;
      // default:
    }
  }

  @override
  void initState() {
    super.initState();
    getLoc();
    downButtonFunction();
    hourDataset = fetchHourlyDataset();
    yearDataset = fetchFiveYearDataset();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = _controller;
    location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
        ),
      );
    });
  }

  Future<void> getAddressFromLatLong(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark place = placemarks[0];
    address =
        '${place.subLocality} ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _initialcameraposition =
        LatLng(_currentPosition.latitude!, _currentPosition.longitude!);
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentPosition = currentLocation;
        _initialcameraposition =
            LatLng(_currentPosition.latitude!, _currentPosition.longitude!);
        getAddressFromLatLong(
                _currentPosition.latitude, _currentPosition.longitude)
            .then((value) {
          setState(() {});
        });
      });
    });
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

  LineChartData mainData(AsyncSnapshot snapshot, String type) {
    List<double> y = snapshot.data.dwn.getLastYearGraph();
    List<FlSpot> spots = List<FlSpot>.generate(y.length, (int index) {
      return FlSpot(index.toDouble(), y[index]);
    });
    FlTitlesData titles = FlTitlesData();

    if (type == '5years') {
      List<double> y = snapshot.data.dwn.getFiveYearGraph();
      List<FlSpot> spots = List<FlSpot>.generate(y.length, (int index) {
        return FlSpot(index.toDouble(), y[index]);
      });
      FlTitlesData titles = FlTitlesData(
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
              case 0:
                return '2016';
              case 1:
                return '2017';
              case 2:
                return '2018';
              case 3:
                return '2019';
              case 4:
                return '2020';
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
            if (value.toDouble() / 100 == 0) {
              return value.toString() + " kWh";
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      );
    } else if (type == '12months') {
      List<double> y = snapshot.data.dwn.getLastYearGraph();
      List<FlSpot> spots = List<FlSpot>.generate(y.length, (int index) {
        return FlSpot(index.toDouble(), y[index]);
      });
      FlTitlesData titles = FlTitlesData(
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
              case 0:
                return 'Jan';
              case 2:
                return 'Mac';
              case 5:
                return 'Jun';
              case 8:
                return 'Sep';
              case 11:
                return 'Dec';
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
            if (value.toDouble() / 100 == 0) {
              return value.toString() + " kWh";
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      );
    }

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
      titlesData: titles,
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: y.length.toDouble() - 1,
      minY: 0,
      maxY: y.reduce(max) + 50,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
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
                      const Text('Your Dashboard',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      RawMaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DetailsScreen()));
                          },
                          elevation: 2.0,
                          padding: const EdgeInsets.all(8),
                          shape: const CircleBorder(),
                          fillColor: Colors.white30,
                          child: const Icon(Icons.info_outline_rounded,
                              color: Colors.white))
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                    // margin: EdgeInsets.only(top: size.height * 0.5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color.fromRGBO(26, 57, 140, 100),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 20),
                            Row(children: <Widget>[
                              const Expanded(
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
                                                      !isSelected[buttonIndex];
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
                            const SizedBox(height: 15),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: AspectRatio(
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
                                    child: FutureBuilder(
                                        future: yearDataset,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            //return LineChart(mainData(snapshot, '5years'));
                                            return LineChart(
                                                mainData(snapshot, '12months'));
                                          } else if (snapshot.hasError) {
                                            return Text("${snapshot.error}");
                                          }
                                          return const CircularProgressIndicator();
                                        }),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Center(
                                    child: Wrap(
                                      spacing: 18.0,
                                      runSpacing: 18.0,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gradient: const LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: [0.1, 0.4, 0.7, 0.9],
                                              colors: [
                                                Color(0xFF3594DD),
                                                Color(0xFF4563DB),
                                                Color(0xFF5036D5),
                                                Color(0xFF5B16D0),
                                              ],
                                            ),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: 160.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "assets/images/wind.png",
                                                  width: 64.0,
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                const Text("Wind Speed",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.0)),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                const Text("69 mph",
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
                                            gradient: const LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: [0.1, 0.4, 0.7, 0.9],
                                              colors: [
                                                Color(0xFF3594DD),
                                                Color(0xFF4563DB),
                                                Color(0xFF5036D5),
                                                Color(0xFF5B16D0),
                                              ],
                                            ),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: 160.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "assets/images/temperature.png",
                                                  width: 64.0,
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                const Text("Temperature",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.0)),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                const Text("69°C",
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
                                            gradient: const LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: [0.1, 0.4, 0.7, 0.9],
                                              colors: [
                                                Color(0xFF3594DD),
                                                Color(0xFF4563DB),
                                                Color(0xFF5036D5),
                                                Color(0xFF5B16D0),
                                              ],
                                            ),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: 160.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "assets/images/water.png",
                                                  width: 64.0,
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                const Text("Humidity",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.0)),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                const Text("69 g/kg",
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
                                            gradient: const LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: [0.1, 0.4, 0.7, 0.9],
                                              colors: [
                                                Color(0xFF3594DD),
                                                Color(0xFF4563DB),
                                                Color(0xFF5036D5),
                                                Color(0xFF5B16D0),
                                              ],
                                            ),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: 160.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "assets/images/cloud.png",
                                                  width: 64.0,
                                                  height: 64.0,
                                                ),
                                                const SizedBox(
                                                  height: 10.0,
                                                ),
                                                const Text("Cloud Around",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.0)),
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                const Text("69 mW/cm2",
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
                            const SizedBox(height: 20),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color.fromRGBO(133, 138, 255, 100),
                                        Color.fromRGBO(176, 133, 255, 100),
                                        Color.fromRGBO(192, 133, 255, 100)
                                      ]),
                                  borderRadius: BorderRadius.circular(20)),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: DropdownButton(
                                underline: const SizedBox(),
                                isExpanded: true,
                                iconEnabledColor: Colors.white,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                                dropdownColor: const Color(0xFF5036D5),
                                focusColor: Colors.black,
                                value: initialValue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: itemList.map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    initialValue = newValue!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                      child: Center(
                                    child: Wrap(
                                      spacing: 15.0,
                                      runSpacing: 18.0,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color.fromRGBO(
                                                        133, 138, 255, 100),
                                                    Color.fromRGBO(
                                                        176, 133, 255, 100),
                                                    Color.fromRGBO(
                                                        192, 133, 255, 100)
                                                  ]),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: const Align(
                                            alignment: Alignment.center,
                                            child: TextField(
                                              style: TextStyle(
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                labelText: 'Time Range',
                                                labelStyle: TextStyle(
                                                    color: Colors.white),
                                                icon: Icon(Icons.event,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color.fromRGBO(
                                                        133, 138, 255, 100),
                                                    Color.fromRGBO(
                                                        176, 133, 255, 100),
                                                    Color.fromRGBO(
                                                        192, 133, 255, 100)
                                                  ]),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: DropdownButton(
                                              underline: const SizedBox(),
                                              isExpanded: true,
                                              iconEnabledColor: Colors.white,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17),
                                              dropdownColor:
                                                  const Color(0xFF5036D5),
                                              focusColor: Colors.white,
                                              value: initialTimeRange,
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.white),
                                              items: time_range
                                                  .map((String items) {
                                                return DropdownMenuItem(
                                                    value: items,
                                                    child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(items)));
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  initialTimeRange = newValue!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                                ]),
                            SizedBox(
                              width: double.infinity,
                              height: 475,
                              child: Stack(children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 130, 0, 0),
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.85,
                                          height: 300,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            gradient: const LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: [0.1, 0.4, 0.7, 0.9],
                                              colors: [
                                                Color(0xFF3594DD),
                                                Color(0xFF4563DB),
                                                Color(0xFF5036D5),
                                                Color(0xFF5B16D0),
                                              ],
                                            ),
                                          ),
                                          child: Column(children: [
                                            const SizedBox(height: 45),
                                            Wrap(
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                children: const [
                                                  Icon(Icons.paid,
                                                      color: Colors.yellow),
                                                  Text(" Estimated Savings:",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white))
                                                ]),
                                            const SizedBox(height: 5),
                                            Text("$saving USD",
                                                style: const TextStyle(
                                                  fontSize: 40,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            const SizedBox(height: 8),
                                            Wrap(
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                children: const [
                                                  Icon(Icons.bolt,
                                                      color: Colors.yellow),
                                                  Text(" Power Output",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white))
                                                ]),
                                            const SizedBox(height: 5),
                                            Align(
                                                alignment: Alignment.center,
                                                child: Text("$powerOutput W",
                                                    style: const TextStyle(
                                                      fontSize: 40,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ))),
                                            const SizedBox(height: 8),
                                            Wrap(
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                children: const [
                                                  Icon(Icons.gpp_good,
                                                      color: Colors.yellow),
                                                  Text(" Efficiency:",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white))
                                                ]),
                                            const SizedBox(height: 5),
                                            Align(
                                                alignment: Alignment.center,
                                                child: Text("$efficiency %",
                                                    style: const TextStyle(
                                                      fontSize: 40,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ))),
                                          ]))),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 270),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/intropic.png"))),
                                  ),
                                ),
                              ]),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 350,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "Address: $address",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Latitude: ${_currentPosition.latitude}, Longitude: ${_currentPosition.longitude}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              height: 400,
                              width: MediaQuery.of(context).size.width * 0.9,
                              // child: Stack(children: [
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                child: GoogleMap(
                                  onMapCreated: _onMapCreated,
                                  myLocationButtonEnabled: true,
                                  zoomGesturesEnabled: true,
                                  onCameraMove: _onCameraMove,
                                  compassEnabled: true,
                                  mapType: MapType.hybrid,
                                  initialCameraPosition: CameraPosition(
                                    target: _initialcameraposition,
                                    zoom: 17,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ))),
              ],
            ),
          ),
        ));
  }
}
