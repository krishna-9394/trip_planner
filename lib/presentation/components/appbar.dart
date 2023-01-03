import 'package:flutter/material.dart';

import '../../Users/new_users.dart';
import '../../data/Models/user.dart';

class UserHeader extends StatelessWidget {
  final Trip trip;
  final int index;
  const UserHeader({Key? key, required this.trip, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 7.5,
        margin: const EdgeInsets.only(top: 10),
        child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
            child: ListTile(
              title: const Text(
                "Users List",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ), // User List heading
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
                              return NewUser(trip: trip, tripIndex: index);
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
