import 'package:hive/hive.dart';

part 'users.g.dart';

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
