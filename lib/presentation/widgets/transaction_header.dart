import 'package:expense_tracker/business_logic/trip/trip_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/trips.dart';
import 'new_transaction.dart';

class TransactionHeader extends StatelessWidget {
  final Trip trip;
  final int tripIndex;
  const TransactionHeader(
      {Key? key, required this.trip, required this.tripIndex})
      : super(key: key);
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
                            builder: ((builderContext) {
                              BlocProvider.of<TripBloc>(context)
                                  .add(LoadingUsersEvent(tripIndex: tripIndex));
                              return NewTransaction(
                                  tripIndex: tripIndex,
                                  trip: trip);
                            }));
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
