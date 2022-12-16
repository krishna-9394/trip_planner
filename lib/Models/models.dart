import 'package:hive/hive.dart';

part 'models.g.dart';

@HiveType(typeId: 1)
class Transaction extends HiveObject {
  @HiveField(0)
  String tripName;
  @HiveField(1)
  int amount;
  @HiveField(2)
  String note;
  @HiveField(3)
  String userName;
  @HiveField(4)
  DateTime time;
  Transaction({
    required this.tripName,
    required this.amount,
    required this.note,
    required this.userName,
    required this.time,
  });
}

@HiveType(typeId: 0)
class Trip extends HiveObject {
  @HiveField(0)
  final String tripName;
  @HiveField(1)
  final DateTime time;
  Trip({required this.tripName, required this.time});
}

@HiveType(typeId: 2)
class User extends HiveObject {
  @HiveField(0)
  String tripName;
  @HiveField(1)
  double paid;
  @HiveField(2)
  String userName;

  User({required this.tripName, required this.paid, required this.userName});
// String imageResource;

}
