import 'package:expense_tracker/presentation/pages/transaction_page.dart';
import 'package:expense_tracker/presentation/pages/user_page.dart';
import 'package:flutter/material.dart';

import '../../data/models/trips.dart';

class HomePage extends StatelessWidget {
  final Trip trip;
  final int index;
  const HomePage({super.key, required this.trip, required this.index});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(trip.tripName),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Icon(Icons.people_alt_sharp),
                Icon(Icons.currency_rupee_sharp),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              UserPage(trip: trip, tripIndex: index),
              TransactionPage(trip: trip, tripIndex: index),
            ],
          )),
    );
  }
}
