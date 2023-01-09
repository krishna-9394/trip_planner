import 'package:hive/hive.dart';

part 'transactions.g.dart';

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  String tripName;
  @HiveField(1)
  // TODO change int to double
  double amount;
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
// use this code to generate HiveAdapter
// flutter packages pub run build_runner build
