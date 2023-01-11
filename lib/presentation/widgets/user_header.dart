import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/user/user_bloc.dart';
import '../../data/models/trips.dart';

class UserHeader extends StatelessWidget {
  final Trip trip;
  final int tripIndex;
  const UserHeader({Key? key, required this.trip, required this.tripIndex}) : super(key: key);
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
                        TextEditingController editor = TextEditingController();
                        bool added = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Add User'),
                                  content: TextField(
                                    controller: editor,
                                    onSubmitted: (value) {
                                      if (editor.text.trim().compareTo("") == 0) {
                                        return;
                                      } else {
                                        Navigator.of(context).pop(true);
                                      }
                                    },
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: const Text(
                                        "Cancel",
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                      onPressed: () {
                                        if (editor.text.trim().compareTo("") == 0) {
                                          return;
                                        } else {
                                          Navigator.of(context).pop(true);
                                        }
                                      },
                                      child: const Text(
                                        "Add",
                                      ),
                                    ),
                                  ],
                                )) as bool;
                        if (added) {
                          BlocProvider.of<UserBloc>(context)
                              .add(AddingUserEvent(tripIndex: tripIndex, userName: editor.text.trim()));
                        }
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
