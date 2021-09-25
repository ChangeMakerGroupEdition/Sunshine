import 'package:flutter/material.dart';
import 'package:myapp/frontend/MainPage.dart';



void main(){
  runApp(MaterialApp(
    initialRoute: '/mainpage',
    routes: {
      '/mainpage':(context) => const MyApp(),
    },
  ),
  );
}
