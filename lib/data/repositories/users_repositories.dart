import 'package:hive/hive.dart';

import '../../presentation/Widgets/constants.dart';
import '../Models/trip.dart';
import '../Models/user.dart';

class UserRepo {
  late Box<User> _userBox;
  late Box<Trip> _tripBox;
  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(TripAdapter());
    _userBox = await Hive.openBox<User>(Constants.userList);
    _tripBox = await Hive.openBox<Trip>(Constants.tripList);
  }

  Future<List<User>> getList() async {
    List<User> users = _userBox.values.toList();
    return users;
  }

  Future<int> userListCount() async {
    return _userBox.length;
  }

  Future<User> getUserAt(int index) async {
    return _userBox.getAt(index) as User;
  }

  Future<bool> search(String name) async {
    List<User> users = _userBox.values.toList();
    for (User user in users) {
      if (user.tripName.compareTo(name) == 0) return false;
    }
    return true;
  }

  Future<bool> addUser(String tripName, String userName, double paid, int tripIndex) async {
    if (tripName.trim().compareTo('') == 0) return false;
    if (await search(tripName)) return false;
    User user = User(tripName: tripName, paid: paid, userName: userName);
    await _userBox.add(user);
    Trip trip = _tripBox.getAt(tripIndex) as Trip;
    trip.users.add(user);
    trip.usersCount++;
    await _tripBox.putAt(tripIndex, trip);
    return true;
  }
}
