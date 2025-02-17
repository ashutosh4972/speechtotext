import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:speechtotext/speech_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        splash: Column(
          children: [
            Center(
              child: LottieBuilder.asset("assests/splash.json"),
            )
          ],
        ),
        nextScreen: const SpeechScreen(),
        splashIconSize: 300,
        backgroundColor: Colors.cyan.shade100,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Text to Speech Application',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
    );
  }
}
