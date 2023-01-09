import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../business_logic/transaction/transaction_bloc.dart';
import '../../data/models/transactions.dart';


class TransactionUI extends StatelessWidget {
  final int tripIndex;
  final int transactionIndex;
  // final int userIndex;
  final Transaction transaction;
  const TransactionUI(
      {super.key,
      required this.tripIndex,
      required this.transactionIndex,
      // required this.userIndex,
      required this.transaction});
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
            onPressed: () => BlocProvider.of<TransactionBloc>(context).add(
                DeleteTransactionEvent(tripIndex: tripIndex, transactionIndex: transactionIndex)),
            icon: const Icon(Icons.delete_rounded, color: Colors.red),
          )),
    );
  }
}