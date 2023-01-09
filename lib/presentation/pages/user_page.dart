import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/transaction/transaction_bloc.dart';
import '../../business_logic/trip/trip_bloc.dart';
import '../../data/models/trips.dart';
import '../../data/models/users.dart';
import '../widgets/user_header.dart';
import '../widgets/user_ui.dart';

class UserPage extends StatelessWidget {
  final Trip trip;
  final int tripIndex;
  const UserPage({Key? key, required this.trip, required this.tripIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TripBloc>(context)
        .add(LoadingUsersEvent(tripIndex: tripIndex));
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      UserHeader(trip: trip, tripIndex: tripIndex),
      BlocBuilder<TripBloc, TripState>(builder: (context, state) {
        if (state is LoadingUsersState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FailedToLoadUsersState) {
          return Center(
              child: Text(
            "Failed to Load Users List \n ${state.error.toString()}",
          ));
        } else if (state is LoadedUsersState) {
          return Container(
            margin: const EdgeInsets.all(5),
            child: Expanded(
                child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: state.size,
              itemBuilder: (context, index) {
                User user = state.users.elementAt(index);
                if (user.tripName.compareTo(trip.tripName) == 0) {
                  double divident = trip.totalAmount / (state.size);
                  return UserUI(user, divident - trip.totalAmount);
                } else {
                  return const SizedBox(height: 0, width: 0);
                }
              },
            )),
          );
        } else {
          return const Center(
              child: Text(
            "There is no other state to load",
          ));
        }
      })
    ]);
  }
}
