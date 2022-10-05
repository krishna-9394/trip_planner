import 'package:flutter/material.dart';

import '../Models/User.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  const NewTransaction(this.addTransaction, {super.key});

  get userNameList => null;
  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  TextEditingController nameEditor = TextEditingController();
  TextEditingController noteEditor = TextEditingController();
  TextEditingController amountEditor = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
         margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
         padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
         child: Column(
           children: [
             const Text("Add Transaction",style: TextStyle(fontWeight: FontWeight.bold)),
             const SizedBox(height: 10),
             SizedBox(
               width: double.infinity,
               child: Column(
                 children: [
                   TextField(
                     controller: nameEditor,
                     keyboardType: TextInputType.name,
                     decoration: const InputDecoration(hintText: "enter the note.."),
                   ),TextField(
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
                       String name = nameEditor.text.trim();
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




