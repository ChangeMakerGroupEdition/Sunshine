import 'package:flutter/material.dart';
import 'package:myapp/frontend/MainPage.dart';
import 'package:myapp/frontend/onboard_screen.dart';

void main(){
  runApp(
    MaterialApp(
      initialRoute: '/intropage', 
      routes: {
        '/mainpage':(context) => const MyApp(),
        '/intropage':(context) => const OnBoardingPage(),
      },
    ),
  );
}