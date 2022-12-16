import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/models.dart';

class TransactionUI extends StatelessWidget {
  final Function deleteTransaction;
  final Transaction transaction;
  final int index;
  const TransactionUI(this.deleteTransaction, this.transaction, this.index, {super.key});
  @override
  Widget build(BuildContext context) {
    String date = DateFormat('dd/MM/yyyy').format(transaction.time);
    String time = DateFormat('HH:mm').format(transaction.time);
    return Card(
      elevation: 5,
      child: ListTile(
          leading: Container(
            margin: const EdgeInsets.only(right: 10),
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor, width: 2, style: BorderStyle.solid)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "\u{20B9}${transaction.amount}",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ),
          title: Text(
            transaction.userName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction.note),
                Text(DateFormat.yMMMd().format(transaction.time).toString()),
              ]),
          trailing: IconButton(
            onPressed: () => deleteTransaction(index),
            icon: const Icon(Icons.delete_rounded, color: Colors.red),
          )),
    );
  }
}
