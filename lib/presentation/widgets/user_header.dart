import 'package:expense_tracker/business_logic/trip/trip_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/trips.dart';
import 'new_user.dart';

class UserHeader extends StatelessWidget {
  final Trip trip;
  final int tripIndex;
  const UserHeader({Key? key, required this.trip, required this.tripIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: ListTile(
              title: const Text(
                "Users List",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              trailing: Ink(
                  width: 40,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: const CircleBorder(),
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () async {
                        await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: ((builderContext) =>
                              NewUser(index: tripIndex)),
                        );
                      },
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                      iconSize: 25,
                    ),
                  )),
            )),
      ),
    );
  }
}
