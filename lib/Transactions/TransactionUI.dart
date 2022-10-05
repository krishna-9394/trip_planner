import 'package:flutter/material.dart';
import '../Models/Transaction.dart';
import 'package:intl/intl.dart';


class TransactionUI extends StatelessWidget {
  final Transaction transaction;
  const TransactionUI(this.transaction, {super.key});
  @override
  Widget build(BuildContext context) {
    String date = DateFormat('dd/MM/yyyy').format(transaction.timming);
    String time = DateFormat('HH:mm').format(transaction.timming);
    return Card(
      elevation: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:<Widget> [
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(left: 15,top: 15,bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 10,right: 10,top: 5),
                  child: Text(transaction.userName,style: const TextStyle(fontWeight: FontWeight.bold),),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10,right: 10),
                  child: Text(transaction.note),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10,right: 10),
                  child: Text("$date  $time"),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(right: 25,top: 15,bottom: 15),
            decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor,width: 2,style: BorderStyle.solid)),
            child: Text("\u{20B9} ${transaction.amount}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor,),
          ),
          ),
        ],
      ),
    );
  }
}