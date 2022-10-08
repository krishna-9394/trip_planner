import 'package:flutter/material.dart';

import '../Models/Transaction.dart';
import 'TransactionUI.dart';

class TransactionList extends StatelessWidget {
  final Function deleteTransaction;
  final List<Transaction> transactionList;
  const TransactionList(this.deleteTransaction,this.transactionList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: transactionList.isEmpty? const Text("There is no transaction to show") : ListView.builder(

        // make the listview to take remaining portion
        // ------*-----
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        // -----*------


        itemBuilder: (context,index){
          return TransactionUI(deleteTransaction,transactionList[index]);
        },
        itemCount: transactionList.length,
      ),
    );
  }
}
