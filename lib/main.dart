import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Start.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main()=>runApp(splash());

class splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Image.asset('images/logo.png'),
        nextScreen: Start(),
        splashTransition: SplashTransition.rotationTransition,
        duration: 3000,
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}
