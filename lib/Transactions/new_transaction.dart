import 'package:flutter/material.dart';

import '../Models/User.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  final List<User> usersList;
  const NewTransaction(this.usersList,this.addTransaction, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  TextEditingController noteEditor = TextEditingController();
  TextEditingController amountEditor = TextEditingController();

  var dropdownvalue;
  void initialize(){
     widget.usersList.isEmpty? dropdownvalue = "" : dropdownvalue = widget.usersList[0].userName;
  }
  @override
  Widget build(BuildContext context) {
    initialize();
    return Container(
         margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
         padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
         child: Column(
           children: [
             const Text("Add Transaction",style: TextStyle(fontWeight: FontWeight.bold)),
             const SizedBox(height: 10),
             Container(
               width: double.infinity,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   DropdownButton<String>(
                       icon: const Icon(Icons.keyboard_arrow_down),
                       value: dropdownvalue,
                       items: widget.usersList.map<DropdownMenuItem<String>>((User user){
                          return DropdownMenuItem<String>  (value: user.userName,child: Text(user.userName),);
                       }).toList(),
                       onChanged: (newValue){
                         setState(() {
                           dropdownvalue = newValue!;
                         });
                       }),
                   TextField(
                     controller: noteEditor,
                     keyboardType: TextInputType.text,
                     decoration: const InputDecoration(hintText: "enter the note.."),
                   ),
                   TextField(
                     controller: amountEditor,
                     keyboardType: TextInputType.number,
                     decoration: const InputDecoration(hintText: "enter the amount.."),
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
                       String name = dropdownvalue;
                       String note = noteEditor.text;
                       String amount = amountEditor.text;
                       if(name == '' || note == '' || amount == '' || int.parse(amount)<0){ return; }
                       widget.addTransaction(name,note,int.parse(amount));
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




