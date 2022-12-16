import 'package:expense_tracker/Users/UserUI.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Models/models.dart';

class UserList extends StatelessWidget {
  final String tripName;
  final Box list;
  final double totalAmount;
  const UserList(this.list, this.totalAmount, {super.key, required this.tripName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Expanded(
        child: ValueListenableBuilder(
          valueListenable: list.listenable(),
          builder: (BuildContext context, value, Widget? child) {
            if (list.isEmpty) {
              return const Center(
                child: Text("No Trips to Display, start Creating.."),
              );
            } else {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  User user = list.getAt(index);
                  if (user.tripName.compareTo(tripName) == 0) {
                    double divident = totalAmount / (list.length);
                    return UserUI(user, divident - totalAmount);
                  }
                  return const SizedBox(height: 0);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
