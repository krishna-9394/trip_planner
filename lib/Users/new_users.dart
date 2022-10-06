import 'package:flutter/material.dart';
import '../Models/User.dart';

class NewUser extends StatefulWidget {
  final Function addUser;
  final List<User> userList;
  const NewUser(this.userList,this.addUser, {super.key});

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  bool _showError = false;
  final nameEditor = TextEditingController();
  final genderEditor = TextEditingController();
  final amountEditor = TextEditingController();

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
              children:[
                 TextField(
                  controller: nameEditor,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: "enter the UserName..",
                      errorText: _showError? "this user name already exist.." : null),
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

  bool validator(String text) {
    String name = nameEditor.text.trim();
    if(name.isEmpty) return false;
    for (var element in widget.userList) {
    if(element.userName.compareTo(name)==0) return false;
    }
    return true;
  }
}// class




