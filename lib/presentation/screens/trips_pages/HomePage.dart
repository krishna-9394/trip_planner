import 'package:expense_tracker/business_logic/trips/trip_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/Models/trip.dart';
import '../MainPage.dart';

class TripsListPage extends StatelessWidget {
  static const id = 'trip list page';
  const TripsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<TripBloc, TripState>(
              builder: (context, state) {
                if (state is TripLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FailedToLoadTripState) {
                  return Center(
                    child: Text("No Trips to Display, an error has occurred ${state.error}"),
                  );
                } else if (state is TripLoadedState) {
                  List<Trip> trips = state.trips;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: trips.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                title: const Text("delete?"),
                                content: const Text("are you sure?"),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        BlocProvider.of<TripBloc>(context).add(DeleteTripEvent(index: index));
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                                      child: const Text("Yes")),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                      child: const Text("No"))
                                ]),
                          );
                        },
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => mainPage(trip: trips.elementAt(index), index: index)));
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
                                onPressed: () {
                                  TextEditingController editor = TextEditingController();
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Text('update Trip'),
                                            content: TextField(
                                              controller: editor,
                                              onSubmitted: (value) {
                                                if (value.trim().compareTo("") == 0) {
                                                  return;
                                                } else {
                                                  BlocProvider.of<TripBloc>(context)
                                                      .add(AddTripEvent(tripName: value.trim()));
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
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
                                                    BlocProvider.of<TripBloc>(context).add(
                                                        UpdateTripEvent(tripName: editor.text.trim(), index: index));
                                                    Navigator.of(context).pop();
                                                  }
                                                },
                                                child: const Text(
                                                  "Add",
                                                ),
                                              ),
                                            ],
                                          ));
                                },
                                icon: const Icon(Icons.drive_file_rename_outline, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Container();
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            TextEditingController editor = TextEditingController();
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text('Add Trip'),
                      content: TextField(
                        controller: editor,
                        onSubmitted: (value) {
                          if (editor.text.trim().compareTo("") == 0) {
                            return;
                          } else {
                            BlocProvider.of<TripBloc>(context).add(AddTripEvent(tripName: editor.text.trim()));
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                          onPressed: () {
                            Navigator.of(context).pop();
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
                              BlocProvider.of<TripBloc>(context).add(AddTripEvent(tripName: editor.text.trim()));
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text(
                            "Add",
                          ),
                        ),
                      ],
                    ));
          },
          child: const Icon(Icons.add)),
    );
  }
}
