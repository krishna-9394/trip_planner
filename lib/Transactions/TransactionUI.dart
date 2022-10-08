import 'package:flutter/material.dart';
import '../Models/Transaction.dart';
import 'package:intl/intl.dart';


class TransactionUI extends StatelessWidget {
  final Function deleteTransaction;
  final Transaction transaction;
  const TransactionUI(this.deleteTransaction,this.transaction, {super.key});
  @override
  Widget build(BuildContext context) {
    String date = DateFormat('dd/MM/yyyy').format(transaction.timming);
    String time = DateFormat('HH:mm').format(transaction.timming);
    return
      Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          leading: Container(
            margin: const EdgeInsets.only(right: 10),
         height: 50,
          decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor,width: 2,style: BorderStyle.solid)),
          child: Padding(
          padding: const EdgeInsets.all(8.0),
    child: Text(
    "\u{20B9}${transaction.amount}",
    style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black),
    ),
    ),
    ),
    title: Text(transaction.userName,style: const TextStyle(fontWeight: FontWeight.bold),),
    subtitle: Column(
      mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(transaction.note),
    Text(DateFormat.yMMMd().format(transaction.timming).toString()),
    ]
    ),
    trailing: IconButton(onPressed: () =>deleteTransaction(transaction.id),
      icon: const Icon(Icons.delete_rounded,color: Colors.red),
    )
    ),
      ),
      );
  }
}