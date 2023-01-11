import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/trip/trip_bloc.dart';
import '../../data/models/trips.dart';
import 'home_page.dart';

class TripsListPage extends StatelessWidget {
  static const id = 'trip list page';
  const TripsListPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TripBloc()..add(LoadingTripsEvent()),
        child: BlocBuilder<TripBloc, TripState>(builder: (context, state) {
          if (state is InitializingTripsState || state is LoadingTripsState) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator(color: Colors.black)),
            );
          }
          if (state is LoadedTripState) {
            List<Trip> trips = state.trips;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Trips"),
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: trips.isEmpty
                  ? const Center(child: Text("No Trips to Display"))
                  : Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: trips.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onLongPress: () async {
                                  bool delete = await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                        title: const Text("delete?"),
                                        content: const Text("are you sure?"),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(true);
                                              },
                                              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                                              child: const Text("Yes")),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(false);
                                              },
                                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                              child: const Text("No"))
                                        ]),
                                  ) as bool;
                                  if (delete) BlocProvider.of<TripBloc>(context).add(DeletingTripEvent(index: index));
                                },
                                onTap: () {
                                  // TODO implement the next page using the bloc systems
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => HomePage(trip: trips.elementAt(index), tripIndex: index)));
                                },
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                        left: 30,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${index + 1})   ${trips.elementAt(index).tripName}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        right: 15,
                                      ),
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        onPressed: () async {
                                          TextEditingController editor = TextEditingController();
                                          bool update = await showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: const Text('update Trip'),
                                                    content: TextField(
                                                      controller: editor,
                                                      onSubmitted: (value) {
                                                        if (editor.text.trim().compareTo("") == 0) {
                                                          return;
                                                        } else {
                                                          Navigator.of(context).pop(true);
                                                        }
                                                      },
                                                    ),
                                                    actions: [
                                                      ElevatedButton(
                                                        style:
                                                            ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                                                        onPressed: () {
                                                          Navigator.of(context).pop(false);
                                                        },
                                                        child: const Text(
                                                          "Cancel",
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                                        onPressed: () {
                                                          if (editor.text.trim().compareTo("") == 0) {
                                                            return;
                                                          } else {
                                                            Navigator.of(context).pop(true);
                                                          }
                                                        },
                                                        child: const Text(
                                                          "Add",
                                                        ),
                                                      ),
                                                    ],
                                                  )) as bool;
                                          if (update) {
                                            BlocProvider.of<TripBloc>(context)
                                                .add(UpdatingTripEvent(tripName: editor.text.trim(), index: index));
                                          }
                                        },
                                        icon: const Icon(Icons.drive_file_rename_outline, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                            ),
                          ),
                        ),
                      ],
                    ),
              floatingActionButton: FloatingActionButton(
                  onPressed: () async {
                    TextEditingController editor = TextEditingController();
                    bool added = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text('Add Trip'),
                              content: TextField(
                                controller: editor,
                                onSubmitted: (value) {
                                  if (editor.text.trim().compareTo("") == 0) {
                                    return;
                                  } else {
                                    Navigator.of(context).pop(true);
                                  }
                                },
                              ),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text(
                                    "Cancel",
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                  onPressed: () {
                                    if (editor.text.trim().compareTo("") == 0) {
                                      return;
                                    } else {
                                      Navigator.of(context).pop(true);
                                    }
                                  },
                                  child: const Text(
                                    "Add",
                                  ),
                                ),
                              ],
                            )) as bool;
                    if (added) BlocProvider.of<TripBloc>(context).add(AddingTripEvent(tripName: editor.text.trim()));
                  },
                  child: const Icon(Icons.add)),
            );
          }
          if (state is FailedToLoadTripsState) {
            return Center(
              child: Text("No Trips to Display, an error has occurred ${state.error}"),
            );
          }
          return Scaffold(body: Container());
        }));
  }
}
