import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../Models/models.dart';

class NewTransaction extends StatefulWidget {
  final String tripName;
  final Function addTransaction;
  final Box list;
  const NewTransaction(this.list, this.addTransaction, {super.key, required this.tripName});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  TextEditingController noteEditor = TextEditingController();
  TextEditingController amountEditor = TextEditingController();
  var dropdownvalue;

  List<String> createList() {
    List<String> users = [];
    for (int i = 0; i < widget.list.length; i++) {
      User user = widget.list.getAt(i);
      if (user.tripName.compareTo(widget.tripName) == 0) {
        users.add(user.userName);
      }
    }
    return users;
  }

  @override
  void initState() {
    widget.list.isEmpty ? dropdownvalue = "-" : dropdownvalue = createList()[0];
    super.initState();
  }

  void submit() {
    String name = dropdownvalue;
    String note = noteEditor.text;
    String amount = amountEditor.text;
    if (name == '-' || note == '' || amount == '' || int.parse(amount) < 0) {
      return;
    }
    widget.addTransaction(name, note, int.parse(amount));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: (10 + MediaQuery.of(context).viewInsets.bottom)),
        child: Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Add Transaction", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Container(
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
                          items: createList().map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
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
                      onSubmitted: (amount) => submit,
                    ),
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
      ),
    );
  }
} // class
