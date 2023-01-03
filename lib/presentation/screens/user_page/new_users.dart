import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business_logic/users/users_bloc.dart';
import '../data/Models/user.dart';

class NewUser extends StatelessWidget {
  final Trip trip;
  final int tripIndex;
  bool _showError = false;
  final nameEditor = TextEditingController();
  NewUser({Key? key, required this.trip, required this.tripIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: (10 + MediaQuery.of(context).viewInsets.bottom)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Add User", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  BlocConsumer<UserBloc, UserState>(
                    listener: (context, state) {
                      if (state is AddUserState) {
                        if (state.isAdded) {
                          showDialog(context: context, builder: (context) => SnackBar(content: Text(state.note)));
                        }
                      }
                    },
                    builder: (context, state) => TextField(
                      controller: nameEditor,
                      autofocus: true,
                      keyboardType: TextInputType.name,
                      onSubmitted: (name) {
                        BlocProvider.of<UserBloc>(context, listen: false)
                            .add(AddUserEvent(tripName: trip.tripName, userName: name, paid: 0, tripIndex: tripIndex));
                      },
                      decoration: InputDecoration(
                          labelText: "enter the UserName..",
                          errorText: _showError ? "this user name already exist.." : null),
                    ),
                  )
                  // TextField(
                  //   controller: genderEditor,
                  //   keyboardType: TextInputType.text,
                  //   decoration: const InputDecoration(hintText: "enter the gender.."),
                  // ),
                  // TextField(
                  //   controller: amountEditor,
                  //   keyboardType: TextInputType.number,
                  //   decoration: const InputDecoration(hintText: "enter the balance.."),
                  // ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    )),
                TextButton(
                    onPressed: null,
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
