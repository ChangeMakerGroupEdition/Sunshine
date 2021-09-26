import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:myapp/frontend/MainPage.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const home_page()),
    );
  }

  Widget _buildFullscrenImage() {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
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
        child: Padding(
            padding: const EdgeInsets.fromLTRB(50,100,50,200),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              height: 50,
              width: 50,
              child: Image.asset(
                'assets/images/logo.png',
                alignment: Alignment.center,
              ),
            )));
  }

  Widget _buildSecondPage() {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
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
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 150, 65, 0),
              child: Image.asset(
                'assets/images/solar_panel.png',
                alignment: Alignment.center,
              ),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 70, 10),
                child: Text("Live life smarter \nand cleaner",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white))),
            const Padding(
                padding: EdgeInsets.fromLTRB(50, 20, 50, 10),
                child: Text(
                    "Our sun is the source of all life on Earth, and solar energy is useful to us in many different ways. ",
                    style: TextStyle(fontSize: 18, color: Colors.white)))
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 60.0, fontWeight: FontWeight.w700, color: Colors.white),
      bodyTextStyle: TextStyle(fontSize: 18, color: Colors.white),
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.zero,
    );
    const secondpageDecoration = PageDecoration(
      titlePadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      titleTextStyle: TextStyle(
          fontSize: 35.0, fontWeight: FontWeight.w700, color: Colors.white),
      bodyTextStyle: TextStyle(fontSize: 18, color: Colors.white),
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 30.0),
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Shine",
          body: "The Only Way To Fly",
          image: _buildFullscrenImage(),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
          ),
        ),
        PageViewModel(
          title: "",
          body: "",
          image: _buildSecondPage(),
          decoration: secondpageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            // bodyFlex: 5,
            // imageFlex: 4,
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      skipFlex: 0,
      nextFlex: 0,
      next: Row(children: const <Widget>[
        Text("Next",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            )),
        Icon(Icons.arrow_forward),
      ]),
      done: const Text('Done',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      // dotsContainerDecorator: const ShapeDecoration(
      //   color: Colors.black87,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(15.0)),
      //   ),
      // ),
    );
  }
}
