import 'package:flutter/material.dart';

import '../Models/User.dart';

class UserUI extends StatelessWidget {
  final User user;
  const UserUI(this.user, {super.key});
  @override
  Widget build(BuildContext context) {
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
                  child: Text(user.userName,style: const TextStyle(fontWeight: FontWeight.bold),),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10,right: 10),
                  child: Text(user.gender),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10,right: 10),
                  child: Text(user.imageResource),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(right: 25,top: 15,bottom: 15),
            decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor,width: 2,style: BorderStyle.solid)),
            child: Text("\u{20B9} ${user.balance}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor,),
            ),
          ),
        ],
      ),
    );
  }
}