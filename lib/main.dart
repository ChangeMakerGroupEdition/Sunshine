import 'package:flutter/material.dart';
import 'package:myapp/frontend/MainPage.dart';
import 'package:myapp/frontend/panel.dart';
import 'frontend/Graph.dart';



void main(){
  runApp(MaterialApp(
    initialRoute: '/mainpage',
    routes: {
      '/mainpage':(context) => const my_app(),
      '/panel':(context) => const ChangePanel(),
      '/graph':(context) => const PlotGraph(),

    },
  ),
  );
}
