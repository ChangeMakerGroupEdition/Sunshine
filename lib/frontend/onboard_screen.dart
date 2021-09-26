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
    return Image.asset(
      'assets/images/panel_sun.jpeg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/image/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: _buildImage('panel_sun.jpeg', 100),
          ),
        ),
      ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          child: const Text(
            'Let\s go right away!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Fractional shares",
          body:
              "Instead of having to buy an entire share, invest any amount you want.",
          image: _buildImage('panel_sun.jpeg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Learn as you go",
          body:
              "Download the Stockpile app and master the market with our mini-lesson.",
          image: _buildImage('panel_sun.jpeg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Kids and teens",
          body:
              "Kids and teens can track their stocks 24/7 and place trades that you approve.",
          image: _buildImage('panel_sun.jpeg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Full Screen Page",
          body:
              "Pages can be full screen as well.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
          image: _buildFullscrenImage(),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
          ),
        ),
        PageViewModel(
          title: "Another title page",
          body: "Another beautiful body text for this example onboarding",
          image: _buildImage('panel_sun.jpeg'),
          footer: ElevatedButton(
            onPressed: () {
              introKey.currentState?.animateScroll(0);
            },
            child: const Text(
              'FooButton',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Title of last page - reversed",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Click on ", style: bodyStyle),
              Icon(Icons.edit),
              Text(" to edit a post", style: bodyStyle),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 4,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('panel_sun.jpeg'),
          reverse: true,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
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
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_onboarding_ui/utilities/styles.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({Key? key}) : super(key: key);

//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final int _numPages = 3;
//   final PageController _pageController = PageController(initialPage: 0);
//   int _currentPage = 0;

//   List<Widget> _buildPageIndicator() {
//     List<Widget> list = [];
//     for (int i = 0; i < _numPages; i++) {
//       list.add(i == _currentPage ? _indicator(true) : _indicator(false));
//     }
//     return list;
//   }

//   Widget _indicator(bool isActive) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 150),
//       margin: const EdgeInsets.symmetric(horizontal: 8.0),
//       height: 8.0,
//       width: isActive ? 24.0 : 16.0,
//       decoration: BoxDecoration(
//         color: isActive ? Colors.white : const Color(0xFF7B51D3),
//         borderRadius: const BorderRadius.all(Radius.circular(12)),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle.light,
//         child: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               stops: [0.1, 0.4, 0.7, 0.9],
//               colors: [
//                 Color(0xFF3594DD),
//                 Color(0xFF4563DB),
//                 Color(0xFF5036D5),
//                 Color(0xFF5B16D0),
//               ],
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 40.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 Container(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () => print('Skip'),
//                     child: const Text(
//                       'Skip',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20.0,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 600.0,
//                   child: PageView(
//                     physics: const ClampingScrollPhysics(),
//                     controller: _pageController,
//                     onPageChanged: (int page) {
//                       setState(() {
//                         _currentPage = page;
//                       });
//                     },
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.all(40.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             const Center(
//                               child: Image(
//                                 image: AssetImage(
//                                   'assets/images/onboarding0.png',
//                                 ),
//                                 height: 300.0,
//                                 width: 300.0,
//                               ),
//                             ),
//                             const SizedBox(height: 30.0),
//                             Text(
//                               'Connect people\naround the world',
//                               style: kTitleStyle,
//                             ),
//                             const SizedBox(height: 15.0),
//                             Text(
//                               'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
//                               style: kSubtitleStyle,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(40.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             const Center(
//                               child: Image(
//                                 image: AssetImage(
//                                   'assets/images/onboarding1.png',
//                                 ),
//                                 height: 300.0,
//                                 width: 300.0,
//                               ),
//                             ),
//                             const SizedBox(height: 30.0),
//                             Text(
//                               'Live your life smarter\nwith us!',
//                               style: kTitleStyle,
//                             ),
//                             const SizedBox(height: 15.0),
//                             Text(
//                               'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
//                               style: kSubtitleStyle,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(40.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             const Center(
//                               child: Image(
//                                 image: AssetImage(
//                                   'assets/images/onboarding2.png',
//                                 ),
//                                 height: 300.0,
//                                 width: 300.0,
//                               ),
//                             ),
//                             SizedBox(height: 30.0),
//                             Text(
//                               'Get a new experience\nof imagination',
//                               style: kTitleStyle,
//                             ),
//                             SizedBox(height: 15.0),
//                             Text(
//                               'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
//                               style: kSubtitleStyle,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: _buildPageIndicator(),
//                 ),
//                 _currentPage != _numPages - 1
//                     ? Expanded(
//                         child: Align(
//                           alignment: FractionalOffset.bottomRight,
//                           child: FlatButton(
//                             onPressed: () {
//                               _pageController.nextPage(
//                                 duration: Duration(milliseconds: 500),
//                                 curve: Curves.ease,
//                               );
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               mainAxisSize: MainAxisSize.min,
//                               children: const <Widget>[
//                                 Text(
//                                   'Next',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 22.0,
//                                   ),
//                                 ),
//                                 SizedBox(width: 10.0),
//                                 Icon(
//                                   Icons.arrow_forward,
//                                   color: Colors.white,
//                                   size: 30.0,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//                     : const Text(''),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomSheet: _currentPage == _numPages - 1
//           ? Container(
//               height: 100.0,
//               width: double.infinity,
//               color: Colors.white,
//               child: GestureDetector(
//                 onTap: () => print('Get started'),
//                 child: const Center(
//                   child: Padding(
//                     padding: EdgeInsets.only(bottom: 30.0),
//                     child: Text(
//                       'Get started',
//                       style: TextStyle(
//                         color: Color(0xFF5B16D0),
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           : const Text(''),
//     );
//   }
// }
