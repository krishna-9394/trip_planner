import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'MainPage.dart';
import 'Models/models.dart';
import 'Widgets/constants.dart';

class Temp extends StatefulWidget {
  const Temp({Key? key}) : super(key: key);
  @override
  State<Temp> createState() => _TempState();
}

class _TempState extends State<Temp> {
  TextEditingController editor = TextEditingController();
  late Box listBox;

  @override
  void dispose() {
    super.dispose();
    Hive.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    listBox = Hive.box<Trip>(Constants.tripList);
    super.initState();
  }

  void addTrip(String name) {
    setState(() {
      listBox.add(Trip(tripName: name, time: DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: listBox.listenable(),
            builder: (BuildContext context, value, Widget? child) {
              if (listBox.isEmpty) {
                return const Center(
                  child: Text("No Trips to Display, start Creating.."),
                );
              } else {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: listBox.length,
                  itemBuilder: (context, index) {
                    Trip trip = listBox.getAt(index);
                    return ListTile(
                      leading: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainPage(trip.tripName)));
                        },
                        icon: const Icon(Icons.list, color: Colors.green),
                      ),
                      title: Text(
                        trip.tripName,
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          listBox.deleteAt(index);
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: editor,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    hintText: 'Type your message here...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  addTrip(editor.text);
                  editor.clear();
                },
                child: const Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
