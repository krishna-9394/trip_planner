import 'package:flutter/material.dart';

import '../Models/User.dart';
import 'UserUI.dart';

class UserList extends StatelessWidget {
  final List<User> userList;
  const UserList(this.userList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: userList.isEmpty? Column(
          children: [
            const Text("There is no users to show"),
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
          return UserUI(userList[index]);
        },
        itemCount: userList.length,
      ),
    );
  }
}
