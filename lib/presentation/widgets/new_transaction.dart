import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/transaction/transaction_bloc.dart';
import '../../business_logic/user/user_bloc.dart';
import '../../data/models/trips.dart';
import '../../data/models/users.dart';

class NewTransaction extends StatefulWidget {
  final Trip trip;
  final int tripIndex;
  const NewTransaction({super.key, required this.trip, required this.tripIndex});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  TextEditingController noteEditor = TextEditingController();
  TextEditingController amountEditor = TextEditingController();
  late int userIndex;
  var dropdownvalue;
  late List<User> users;

  void submit() {
    String name = dropdownvalue;
    String note = noteEditor.text;
    String amount = amountEditor.text;
    if (name == '-' || note == '' || amount == '' || int.parse(amount) < 0) {
      return;
    }
    for (int i = 0; i < users.length; i++) {
      if (users.elementAt(i).userName.compareTo(name) == 0) userIndex = i;
    }
    BlocProvider.of<TransactionBloc>(context).add(AddingTransactionEvent(
        amount: double.parse(amount),
        note: note,
        tripIndex: widget.tripIndex,
        tripName: widget.trip.tripName,
        userName: name,
        userIndex: userIndex));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: BlocProvider(
      create: (context) => UserBloc()..add(LoadingUsersEvent(tripIndex: widget.tripIndex)),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is LoadingUsersState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedUsersState) {
            users = state.users;
            return Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              padding: EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: (10 + MediaQuery.of(context).viewInsets.bottom)),
              child: Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Add Transaction", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: DropdownButton<String>(
                                elevation: 5,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                value: dropdownvalue,
                                items: state.users.map<DropdownMenuItem<String>>((User user) {
                                  return DropdownMenuItem<String>(
                                    value: user.userName,
                                    child: Text(
                                      user.userName,
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue;
                                  });
                                }),
                          ),
                          TextField(
                            controller: noteEditor,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(hintText: "enter the note.."),
                            textInputAction: TextInputAction.next,
                          ),
                          TextField(
                              controller: amountEditor,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(hintText: "enter the amount.."),
                              textInputAction: TextInputAction.done,
                              onSubmitted: (amount) => submit),
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
                            onPressed: submit,
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
          } else if (state is FailedToLoadUsersState) {
            return Center(
              child: Text("failed to the screen due to ${state.error.toString()}"),
            );
          } else {
            return const Center(
              child: Text("No States to load"),
            );
          }
        },
      ),
    ));
  }
}
