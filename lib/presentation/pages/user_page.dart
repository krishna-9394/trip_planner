import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/user/user_bloc.dart';
import '../../data/models/trips.dart';
import '../../data/models/users.dart';
import '../widgets/user_ui.dart';

class UserPage extends StatefulWidget {
  final Trip trip;
  final int tripIndex;
  const UserPage({Key? key, required this.trip, required this.tripIndex}) : super(key: key);
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(LoadingUsersEvent(tripIndex: widget.tripIndex)),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is LoadingUsersState || state is InitializingUsersState) {
            return Stack(children: const [
              Center(
                child: CircularProgressIndicator(),
              )
            ]);
          } else if (state is FailedToLoadUsersState) {
            return Stack(children: [
              Center(
                  child: Text(
                "Failed to Load Transaction List \n ${state.error.toString()}",
              ))
            ]);
          } else if (state is LoadedUsersState) {
            return Stack(children: [
              (state.users.isEmpty == true)
                  ? const Center(
                      child: Text(
                        "Users list is Empty",
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.all(5),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.size,
                        itemBuilder: (context, index) {
                          User user = state.users.elementAt(index);
                          if (user.tripName.compareTo(widget.trip.tripName) == 0) {
                            double divident = widget.trip.totalAmount / (state.size);
                            return UserUI(
                              user,
                              divident - widget.trip.totalAmount,
                              index,
                            );
                          } else
                            return const SizedBox(height: 0, width: 0);
                        },
                      ),
                    ),
              Container(
                alignment: AlignmentDirectional.bottomEnd,
                margin: const EdgeInsets.only(bottom: 10, right: 10),
                child: FloatingActionButton(
                    onPressed: () async {
                      TextEditingController editor = TextEditingController();
                      bool added = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Add User'),
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
                      if (added) {
                        BlocProvider.of<UserBloc>(context)
                            .add(AddingUserEvent(tripIndex: widget.tripIndex, userName: editor.text.trim()));
                      }
                    },
                    child: const Icon(Icons.add)),
              ),
            ]);
          } else {
            return Stack(children: const [
              Center(
                child: Text(
                  "There is no other state to load",
                ),
              )
            ]);
          }
        },
      ),
    );
  }
}
