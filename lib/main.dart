import 'package:expense_tracker/HomePage.dart';
import 'package:expense_tracker/Models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Widgets/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(TripAdapter());
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<Trip>(Constants.tripList);
  await Hive.openBox<Transaction>(Constants.transactionList);
  await Hive.openBox<User>(Constants.userList);
  // to lock the screen to portrait mode only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  // for initializing the hive
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Tracker',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        // Animated Splash Screen
        home: const Scaffold(
          body: SafeArea(
            child: Temp(),
          ),
        )
        // AnimatedSplashScreen(
        //   duration: 2500,
        //   splash: const Text(
        //     'Splash Screen...',
        //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        //   ),
        //   nextScreen: const Temp(),
        //   splashTransition: SplashTransition.fadeTransition,
        //   backgroundColor: Colors.yellowAccent,
        // ),
        );
  }
}

// page 1
