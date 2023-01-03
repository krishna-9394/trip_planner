import 'package:flutter/material.dart';

import '../../../data/Models/trip.dart';
import 'new_transaction.dart';

class TransactionHeader extends StatelessWidget {
  final Trip trip;
  final int index;
  const TransactionHeader({Key? key, required this.trip, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: ListTile(
              title: const Text(
                "Transactions List",
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
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: ((builderContext) => const NewTransaction()));
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
