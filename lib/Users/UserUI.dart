import 'package:flutter/material.dart';

import '../Models/models.dart';

class UserUI extends StatelessWidget {
  final User user;
  final double balance;
  const UserUI(this.user, this.balance, {super.key});
  @override
  Widget build(BuildContext context) {
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
              "\u{20B9}${balance.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: balance < 0 ? Colors.redAccent : Colors.green,
              ),
            ),
          ),
        ),
        title: Text(
          user.userName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("\u{20B9}${user.paid} is paid "),
      ),
    );
  }
}
