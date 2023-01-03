import 'package:expense_tracker/presentation/screens/transaction_page/transaction_main.dart';
import 'package:flutter/material.dart';

import '../../Users/user_list.dart';
import '../../data/Models/trip.dart';
import 'transaction_page/transaction_list.dart';
import '../components/appbar.dart';

class MainContent extends StatelessWidget {
  final Trip trip;
  final int index;
  const MainContent({super.key, required this.trip, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarBuild(context),
        body: TabBarView(
          children: [
            TransactionHeader(trip: trip, index: index),
            TransactionList(
              tripName: trip.tripName, tripIndex: ,
            ),
            UserHeader(trip: null, index: ,),
            UserList(tripName: '',)
          ],
        ));
  }

  PreferredSizeWidget? appBarBuild(BuildContext context) {
    return AppBar(
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
      actions: [
        // this displays the Widgets at the top right corner
        Container(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Switch(
                  onChanged: (val) {
                    // setState(() {
                    //   _showUsers = val;
                    // });
                  },
                  value: true),
            ],
          ),
        ),
      ],
    );
  }
}
