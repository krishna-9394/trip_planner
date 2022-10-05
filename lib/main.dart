import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:expense_tracker/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expense Tracker',
      // Animated Splash Screen
      home: AnimatedSplashScreen(
        duration: 2500,
        splash: const Text('Splash Screen...',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),),
        nextScreen: HomePage(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.yellowAccent,
      ),
    );
  }
}
// page 1