import 'package:flutter/material.dart';

import '../Models/Transaction.dart';
import 'TransactionUI.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;
  const TransactionList(this.transactionList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: transactionList.isEmpty? Column(
        children: [
          const Text("There is no transaction to show"),
          const SizedBox(height: 20,),
          SizedBox(height: 300,child: Image.asset('Assets/Images/waiting.png',fit: BoxFit.cover)),
        ]
      ) : ListView.builder(

        // make the listview to take remaining portion
        // ------*-----
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        // -----*------


        itemBuilder: (context,index){
          return TransactionUI(transactionList[index]);
        },
        itemCount: transactionList.length,
      ),
    );
  }
}
