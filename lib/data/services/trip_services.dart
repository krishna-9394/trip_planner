import 'package:hive/hive.dart';

import '../../presentation/constants.dart';
import '../models/trips.dart';
import '../models/users.dart';

class TripsRepo {
  late Box<Trip> _listBox;
  TripRepo() async {}

  Future<void> init() async {
    _listBox = await Hive.openBox<Trip>(Constants.tripList);
  }

  Future<List<Trip>> getList() async {
    List<Trip> trips = _listBox.values.toList();
    // trips.sort((a, b) => a.tripName.compareTo(b.tripName));
    return trips;
  }

  Future<int> tripListCount() async {
    return _listBox.length;
  }

  Future<int> getUsersCountForCurrentTrip(int index) async {
    return (_listBox.get(index) as Trip).users.length;
  }

  Future<Trip> getTripAt(int index) async {
    return _listBox.get(index) as Trip;
  }

  Future<void> addTrip(String name) async {
    if (await searchTrip(name)) return;
    await _listBox.add(Trip(tripName: name, time: DateTime.now(), users: [], totalAmount: 0, usersCount: 0));
  }

  Future<bool> searchTrip(
    String name,
  ) async {
    final n = _listBox.length;
    for (int i = 0; i < n; i++) {
      if ((_listBox.get(i) as Trip).tripName.compareTo(name) == 0) return true;
    }
    return false;
  }

  Future<void> updateTrip(String name, int index) async {
    Trip trip = _listBox.get(index) as Trip;
    trip.tripName = name;
    await _listBox.put(index, trip);
  }

  Future<void> deleteTrip(int index) async {
    await _listBox.delete(index);
  }

  // Future<void> searchTrip(String name, DateTime time) async {
  //   // return true if the conditions is satisfied and element is the object stored in it
  //   _listBox.values.where((element) => element.tripName == name && element.time == DateTime.now());
  //   // _listbox.values.firstWhere((element) => )
  // }

  Future<List<User>> usersList(int index) async {
    return (_listBox.get(index) as Trip).users;
  }

  Future<bool> searchUser(String name, int tripIndex) async {
    Trip trip = _listBox.get(tripIndex) as Trip;
    final n = trip.usersCount;
    for (int i = 0; i < n; i++) {
      if (trip.users.elementAt(i).userName.compareTo(name) == 0) return true;
    }
    return false;
  }

  Future<int> usersCount(int tripIndex) async {
    return _listBox.get(tripIndex)!.users.length;
  }

  Future<void> addUser(int tripIndex, String username) async {
    Trip trip = _listBox.get(tripIndex)!;
    trip.users.add(User(paid: 0, tripName: trip.tripName, userName: username));
    trip.usersCount = trip.usersCount;
    _listBox.put(tripIndex, trip);
  }
}
