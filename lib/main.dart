import 'package:expense_tracker/business_logic/transaction/transaction_bloc.dart';
import 'package:expense_tracker/presentation/pages/auth.dart';
import 'package:expense_tracker/presentation/pages/trip_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'business_logic/trip/trip_bloc.dart';
import 'data/models/transactions.dart';
import 'data/models/trips.dart';
import 'data/models/users.dart';

void main() async {
  // TODO 1: how to initialize the hive and firebase while showing the splash screen
  WidgetsFlutterBinding.ensureInitialized();
  // initializing the Hive into the app
  await Hive.initFlutter();
  // initializing the Firebase with the app
  await Firebase.initializeApp();
  Hive.registerAdapter(TripAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TransactionAdapter());
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
        BlocProvider<TripBloc>(create: (context) => TripBloc()),
        BlocProvider<TransactionBloc>(create: (context) => TransactionBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Tracker',
        // the list of routes in which user will traverse
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        routes: {
          TripsListPage.id: (context) => const TripsListPage(),
          AuthenticationPage.id: (context) => AuthenticationPage(),
        },
        home: AuthenticationPage(),
      ),
    );
  }
}
