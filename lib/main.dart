import 'package:flutter/material.dart';
import 'package:myapp/frontend/home_page.dart';
import 'package:myapp/frontend/onboard_screen.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      initialRoute: '/intropage', 
      routes: {
        '/mainpage':(context) => const HomePage(),
        '/intropage':(context) => const OnBoardingPage(),
      },
    );
  }
}