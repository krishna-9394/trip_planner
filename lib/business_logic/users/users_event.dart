part of 'users_bloc.dart';

abstract class UserEvent {}

class LoadUserListEvent extends UserEvent {
  late List<User> userList;
  LoadUserListEvent({required this.userList});
}

class AddUserEvent extends UserEvent {
  final String tripName;
  final String userName;
  final double paid;
  final int tripIndex;
  AddUserEvent({
    required this.tripName,
    required this.userName,
    required this.paid,
    required this.tripIndex,
  });
}

class ReloadUserEvent extends UserEvent {
  late List<User> tripList;
  ReloadUserEvent({required this.tripList});
}
