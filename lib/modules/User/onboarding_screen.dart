import 'package:flutter/material.dart';
import 'package:grocery/main.dart';
import 'package:grocery/modules/User/Auth_Page.dart';
import 'package:introduction_screen/introduction_screen.dart';

// package that make the Onboarding

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        nextStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Color(0xff5EC401)),
        ),
        doneStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Color(0xff5EC401)),
        ),
        skipStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Color(0xff5EC401)),
        ),
        pages: [
          PageViewModel(
            title: 'Browse all the categories',
            body:
                'Discover endless possibilities with our grocery app. Effortlessly explore and shop across diverse categories for a seamless and personalized shopping experience.',
            image: Image.asset('assets/images/onboarding_screen1.png'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'Amazing Discounts & Offers',
            body:
                'Unlock incredible savings! Explore a world of amazing discounts and exclusive offers for a budget-friendly shopping spree.',
            image: Image.asset(
              'assets/images/onboarding_screen2.png',
            ),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'Delivery in 30 Min',
            body:
                'Experience swift deliveries! Get your essentials delivered to your doorstep within 30 minutes for ultimate convenience.',
            image: Image.asset('assets/images/onboarding_screen3.png'),
            decoration: getPageDecoration(),
          ),
        ],
        next: const Icon(Icons.arrow_forward),
        done: const Text(
          'Done',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onDone: () async {
          await prefs.setInt("initScreen", 1);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const AuthPage()));
        },
        showSkipButton: true,
        skip: const Text('Skip'),
        dotsDecorator: getDotDecoration(),
      ),
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 33, fontWeight: FontWeight.w600, color: Color(0xff5EC401)),
      bodyTextStyle: TextStyle(fontSize: 22),
      imagePadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(8),
      bodyPadding: EdgeInsets.all(20),
      pageColor: Colors.white,
    );
  }

  DotsDecorator getDotDecoration() {
    return DotsDecorator(
        color: const Color(0xFFBDBDBD),
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeColor: Color(0xff5EC401),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)));
  }
}
