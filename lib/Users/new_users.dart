import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewUser extends StatefulWidget {
  final Function addUser;
  final Function compare;
  const NewUser(this.compare, this.addUser, {super.key});

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  bool _showError = false;
  final nameEditor = TextEditingController();
  void submit() {
    String name = nameEditor.text.trim();
    if (name == '') {
      return;
    }
    if (widget.compare(name)) {
      widget.addUser(name);
    } else {
      return;
    }
    Navigator.pop(context);
  }

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
                  TextField(
                    controller: nameEditor,
                    autofocus: true,
                    keyboardType: TextInputType.name,
                    onSubmitted: (name) => submit,
                    decoration: InputDecoration(
                        labelText: "enter the UserName..",
                        errorText: _showError ? "this user name already exist.." : null),
                  ),
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
  }
} // class
