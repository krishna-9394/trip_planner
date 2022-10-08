import 'package:flutter/material.dart';
import 'MainPage.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  TextEditingController textEditor  = TextEditingController();
  String tripName = "";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      home: const Temp(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
    );
  }
}  //stateless Widget

class Temp extends StatefulWidget {
  const Temp({Key? key}) : super(key: key);

  @override
  State<Temp> createState() => _TempState();
}

class _TempState extends State<Temp> {
  TextEditingController editor = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Manager'),),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children:  <Widget>[
            Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
                child: TextField(
                  controller: editor,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 2.0,style: BorderStyle.solid,color: Colors.pink)),
                    hintText: 'Enter the Event name',
                  ),
                  autofocus: true,
                  textInputAction: TextInputAction.done,
                )
            ),
            InkWell(
              splashColor: Colors.black26,
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context)=>MainPage(editor.text)));
              },
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                child: Ink.image(
                  image:const AssetImage('Assets/Images/next_button.png'),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            )
          ]
      ),
    );
  }
}
// page 3

