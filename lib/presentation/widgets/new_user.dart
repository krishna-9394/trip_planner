import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/trip/trip_bloc.dart';

class NewUser extends StatelessWidget {
  final int index;
  TextEditingController nameEditor = TextEditingController();

  NewUser({super.key, required this.index});
  void addNewUser(String name, BuildContext context) {
    BlocProvider.of<TripBloc>(context).add(AddingUserEvent(userName: name, index: index));
  }

  @override
  Widget build(BuildContext context) {
          return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
            padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
                bottom: (10 + MediaQuery.of(context).viewInsets.bottom)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Add User",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      TextField(
                        controller: nameEditor,
                        autofocus: true,
                        keyboardType: TextInputType.name,
                        onSubmitted: (name) {
                          Navigator.of(context).pop();
                        },
                        decoration: const InputDecoration(
                          labelText: "enter the UserName..",
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.red),
                        )),
                    TextButton(
                        onPressed: () {
                          addNewUser(nameEditor.text.trim(), context);
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Add",
                          style: TextStyle(color: Colors.green),
                        )),
                  ],
                ),
              ],
            ),
          ),
        );
      }
}
