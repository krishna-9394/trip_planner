import 'package:hive/hive.dart';

import 'user.dart';

part 'trip.g.dart';

@HiveType(typeId: 0)
class Trip extends HiveObject {
  @HiveField(0)
  String tripName;
  @HiveField(1)
  DateTime time;
  @HiveField(2)
  double totalAmount = 0;
  @HiveField(3)
  int usersCount = 0;
  @HiveField(4)
  int transactionsCount = 0;
  @HiveField(5)
  List<User> users;
  Trip({required this.tripName, required this.time, required this.users});
}
