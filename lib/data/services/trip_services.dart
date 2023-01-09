import 'package:hive/hive.dart';

import '../../presentation/constants.dart';
import '../models/trips.dart';
import '../models/users.dart';

class TripsRepo {
  late Box<Trip> _listBox;
  Future<void> init() async {
    // registration of adapters and opening of the boxes
    _listBox = await Hive.openBox<Trip>(Constants.tripList);
  }

  Future<List<Trip>> getList() async {
    List<Trip> trips = _listBox.values.toList();
    trips.sort((a, b) => a.tripName.compareTo(b.tripName));
    return trips;
  }

  Future<int> tripListCount() async {
    return _listBox.length;
  }

  Future<int> getUsersCountForCurrentTrip(int index) async {
    return _listBox.values.elementAt(index).users.length;
  }

  Future<Trip> getTripAt(int index) async {
    return _listBox.getAt(index) as Trip;
  }

  Future<void> addTrip(String name) async {
    final trips = _listBox.values.toList();
    for (var trip in trips) {
      if (trip.tripName.compareTo(name) == 0) return;
    }
    await _listBox.add(Trip(tripName: name, time: DateTime.now(), users: []));
  }

  Future<void> updateTrip(String name, int index) async {
    Trip trip = _listBox.values.elementAt(index);
    trip.tripName = name;
    await _listBox.putAt(index, trip);
  }

  Future<void> deleteTrip(int index) async {
    await _listBox.deleteAt(index);
  }

  Future<void> searchTrip(String name, DateTime time) async {
    // return true if the conditions is satisfied and element is the object stored in it
    _listBox.values.any((element) =>
        element.tripName == name && element.time == DateTime.now());
    // _listbox.values.firstWhere((element) => )
  }

  Future<List<User>> usersList(int index) async {
    return _listBox.values.elementAt(index).users;
  }

  Future<bool> searchUser(String name) async {
    return _listBox.values.any((element) {
      for (var user in element.users) {
        if (user.userName.compareTo(name) == 0) return true;
      }
      return false;
    });
  }

  Future<int> usersCount(int tripIndex) async {
    return _listBox.values.elementAt(tripIndex).usersCount;
  }

  Future<void> addUser(int index, String username) async {
    Trip trip = _listBox.values.elementAt(index);
    trip.users.add(User(paid: 0, tripName: trip.tripName, userName: username));
    _listBox.putAt(index, trip);
  }
}
