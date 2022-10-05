import 'package:flutter/material.dart';

class NewUser extends StatefulWidget {
  final Function addUser;
  const NewUser(this.addUser, {super.key});

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  TextEditingController nameEditor = TextEditingController();
  TextEditingController genderEditor = TextEditingController();
  TextEditingController amountEditor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
      child: Column(
        children: [
          const Text("Add User",style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                 TextField(
                  controller: nameEditor,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(hintText: "enter the UserName.."),
                ),
                TextField(
                  controller: genderEditor,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(hintText: "enter the gender.."),
                ),
                TextField(
                  controller: amountEditor,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "enter the balance.."),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: (){  Navigator.pop(context); },

                  child: const Text("Cancel",style: TextStyle(color: Colors.red),)),
              TextButton(
                  onPressed: (){
                    String name = nameEditor.text.trim();
                    String gender = genderEditor.text;
                    String amount = amountEditor.text;
                    if(name == '' || gender == '' || amount == '' || int.parse(amount)<0){ return; }
                    widget.addUser(name,gender,int.parse(amount));
                    Navigator.pop(context);
                  },
                  child: const Text("Add",style: TextStyle(color: Colors.green),)),
            ],
          ),
        ],
      ),
    );
  }
}// class




