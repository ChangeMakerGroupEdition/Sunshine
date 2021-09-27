import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/service/data_model.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<YearRangeDataset> data;

  @override
  void initState() {
    super.initState();
    data = fetchFiveYearDataset();
  }

  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            FutureBuilder<YearRangeDataset>(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text("Downward Irradiance value of Last Five Years" + snapshot.data!.dwn.values.toString()),
                      Text("Cloud Amount of Last Five Years" + snapshot.data!.cloudAmount.values.toString()),
                      Text("Temperature of Last Five Years" + snapshot.data!.temperature.values.toString()),
                      Text("Wind Speed of Last Five Years" + snapshot.data!.windSpeed.values.toString()),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const CircularProgressIndicator();
              } 
            ),
            FutureBuilder<YearRangeDataset>(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text("Downward Irradiance Last Five Years" + snapshot.data!.getLastYearGraph("solar").toString()),
                      Text("Cloud Amount of Last Five Years" + snapshot.data!.getLastYearGraph("cloud").toString()),
                      Text("Temperature Last Five Years" + snapshot.data!.getLastYearGraph("temp").toString()),
                      Text("Wind Speed Last Five Years" + snapshot.data!.getLastYearGraph("wind").toString()),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const CircularProgressIndicator();
              } 
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
