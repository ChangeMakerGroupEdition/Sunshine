// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

void main() {
  runApp(const my_app());
}

class my_app extends StatelessWidget {
  const my_app({Key? key}) : super(key: key);

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
            Container(
              width: double.infinity,
              height: size.height * 0.35,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/solar_panel.png"))),
            ),
            Container(
                // margin: EdgeInsets.only(top: size.height * 0.5),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blueGrey,
                ),
                child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        Row(children: const <Widget>[
                          Expanded(
                            child: Text(
                              'Solar Irradiance',
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            child: ExpansionTile(
                              title: Text('Time'),
                              children: <Widget>[
                                ListTile(title: Text('Year')),
                                ListTile(title: Text('Daily'))
                              ],
                            ),
                          ),
                        ]),
                      ],
                    ))),
                    
          ],
        ),
      ),
    );
  }
}
