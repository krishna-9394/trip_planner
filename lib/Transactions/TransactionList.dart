import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../Models/models.dart';
import 'TransactionUI.dart';

class TransactionList extends StatelessWidget {
  final String tripName;
  final Function deleteTransaction;
  final Box list;
  const TransactionList(this.deleteTransaction, this.list, {super.key, required this.tripName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
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
                Transaction transaction = list.getAt(index);
                if (transaction.tripName.compareTo(tripName) == 0) {
                  return TransactionUI(deleteTransaction, list.getAt(index) as Transaction, index);
                }
                return const SizedBox(height: 0);
              },
            );
          }
        },
      ),
    );
  }
}
