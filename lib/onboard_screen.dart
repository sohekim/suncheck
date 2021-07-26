import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:suncheck/util/styles.dart';
import 'package:suncheck/util/utils.dart';

class OnboardScreen extends StatefulWidget {
  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300, height: 1.3),
      imagePadding: EdgeInsets.zero,
      contentMargin: EdgeInsets.fromLTRB(size.width * 0.1, size.height * 0.03, size.width * 0.1, 0),
      bodyFlex: 4,
      imageFlex: 5,
    );

    void _onIntroEnd(context) {
      Navigator.of(context).pushNamed(kRouteHomeScreen);
    }

    Widget _buildFullscrenImage() {
      return Image.asset(
        'assets/302.png',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      );
    }

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "Let's get started!",
          body: "Your Personal Sun Tracker",
          image: _buildFullscrenImage(),
          decoration: pageDecoration.copyWith(
            titleTextStyle: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w800),
            fullScreen: true,
            bodyFlex: 3,
            imageFlex: 4,
          ),
        ),
        PageViewModel(
            title: "Are you going out?",
            body:
                "Simply tap on the circle to start recording your sun intake.\n\nIf you are back indoors,\ntap on it again to turn it off.",
            image: Container(
              child: Image.asset('tap.png'),
            ),
            decoration: pageDecoration),
        PageViewModel(
            title: "Blue To Red",
            body: "The color changes every \n15 mintues of your sun intake.",
            image: Container(
              child: Image.asset('fifteen.png'),
            ),
            decoration: pageDecoration),
        PageViewModel(
            title: "Archive",
            body:
                "Each circle represents the day you recorded.\n\nClick on the circle to see how much sunlight you got that day.",
            image: Container(
              child: Image.asset('calendar.png'),
            ),
            decoration: pageDecoration),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skipColor: Colors.black,
      doneColor: Colors.black,
      nextColor: Colors.black,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: blueCircleColor,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
