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
  @override
  void initState() {
    widget.usersList.isEmpty? dropdownvalue = "" : dropdownvalue = widget.usersList[0].userName;
    super.initState();
  }
  void submit(){
    String name = dropdownvalue;
    String note = noteEditor.text;
    String amount = amountEditor.text;
    if(name == '' || note == '' || amount == '' || int.parse(amount)<0){ return; }
    widget.addTransaction(name,note,int.parse(amount));
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
           margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
           padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: (10 + MediaQuery.of(context).viewInsets.bottom)),
           child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               const Text("Add Transaction",style: TextStyle(fontWeight: FontWeight.bold)),
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
                             items: widget.usersList.map<DropdownMenuItem<String>>((User user){
                               return DropdownMenuItem<String>  (value: user.userName,child: Text(user.userName),);
                             }).toList(),
                             onChanged: (String? newValue){
                               setState(() {
                                 dropdownvalue = newValue!;
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
                       onPressed: (){  Navigator.pop(context); },

                       child: const Text("Cancel",style: TextStyle(color: Colors.red),)),
                   TextButton(
                       onPressed: submit,
                       child: const Text("Add",style: TextStyle(color: Colors.green),)),
                 ],
               ),
             ],
           ),
      ),
    );
  }

}// class




