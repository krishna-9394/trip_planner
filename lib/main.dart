import 'package:expense_tracker/business_logic/auth/auth_bloc.dart';
import 'package:expense_tracker/data/Models/user.dart';
import 'package:expense_tracker/presentation/screens/auth_pages/auth.dart';
import 'package:expense_tracker/presentation/screens/trips_pages/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'business_logic/transactions/transactions_bloc.dart';
import 'business_logic/trips/trip_bloc.dart';
import 'business_logic/users/users_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initializing the Hive into the app
  await Hive.initFlutter();
  // initializing the Firebase with the app
  await Firebase.initializeApp();
  // registering teh Adapters
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TripAdapter());
  // to lock the screen to portrait mode only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (context) => AuthBloc()..add(GoogleAuthenticationEvent())),
          BlocProvider<TripBloc>(create: (context) => TripBloc()),
          BlocProvider<UserBloc>(create: (context) => UserBloc()),
          BlocProvider<TransactionBloc>(create: (context) => TransactionBloc()),
        ],
        child: MaterialApp(
          // for hiding the debug banner
          debugShowCheckedModeBanner: false,
          title: 'Expense Tracker',
          // the list of routes in which user will traverse
          routes: {
            TripsListPage.id: (context) => const TripsListPage(),
            AuthenticationPage.id: (context) => AuthenticationPage(),
          },
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          // Animated Splash Screen
          home: AuthenticationPage(),
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
        ));
  }
}
