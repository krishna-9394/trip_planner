// it is a wrapper layer which communicate with data providers and bloc
// class Repository {
//   final DataProviderA dataProviderA;
//   final DataProviderB dataProviderB;
//
//   Future<Data> getAllDataThatMeetsRequirements() async {
//     final RawDataA dataSetA = await dataProviderA.readData();
//     final RawDataB dataSetB = await dataProviderB.readData();
//
//     final Data filteredData = _filterData(dataSetA, dataSetB);
//     return filteredData;
//import 'package:hive/hive.dart';

// }

import 'package:hive/hive.dart';

import '../../presentation/Widgets/constants.dart';
import '../Models/trip.dart';
import '../Models/user.dart';

class TripsRepo {
  late Box<Trip> _listbox;
  Future<void> init() async {
    // registration of adapters and opening of the boxes
    Hive.registerAdapter(TripAdapter());
    _listbox = await Hive.openBox<Trip>(Constants.tripList);
  }

  Future<List<Trip>> getList() async {
    List<Trip> trips = _listbox.values.toList();
    trips.sort((a, b) => a.tripName.compareTo(b.tripName));
    return trips;
  }

  Future<int> tripListCount() async {
    return _listbox.length;
  }

  Future<Trip> getTripAt(int index) async {
    return _listbox.getAt(index) as Trip;
  }

  Future<void> addTrip(String name) async {
    final trips = _listbox.values.toList();
    for (var trip in trips) {
      if (trip.tripName.compareTo(name) == 0) return;
    }
    await _listbox.add(Trip(tripName: name, time: DateTime.now(), users: []));
  }

  Future<void> updateTrip(String name, int index) async {
    Trip trip = _listbox.values.elementAt(index);
    trip.tripName = name;
    await _listbox.putAt(index, trip);
  }

  Future<void> deleteTrip(int index) async {
    await _listbox.deleteAt(index);
  }

  Future<void> searchTrip(String name, DateTime time) async {
    // return true if the conditions is satisfied and element is the object stored in it
    _listbox.values.any((element) => element.tripName == name && element.time == DateTime.now());
    // _listbox.values.firstWhere((element) => )
  }

  Future<List<User>> usersList(int index) async {
    return _listbox.values.elementAt(index).users;
  }
}
