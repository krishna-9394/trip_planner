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
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
        child: Row(
            children:  <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: editor,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(style: BorderStyle.solid,color: Colors.pink)),
                    hintText: 'Enter the Event name',
                  ),
                  autofocus: true,
                  textInputAction: TextInputAction.done,
                ),
              ),
              SizedBox( width: MediaQuery.of(context).size.width * 0.05),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.20,
                child: IconButton(
                  iconSize: MediaQuery.of(context).size.width * 0.08,
                  icon: const Icon(Icons.arrow_circle_right_outlined),
                  onPressed: () => {
                  Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context)=>MainPage(editor.text))),
                  },
                ),
              )
            ]
        ),
      ),
    );
  }
}
// page 3

