part of 'users_bloc.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final List<User> users;
  UserLoadedState({required this.users});
}

class FailedToLoadUserState extends UserState {
  final Error error;
  FailedToLoadUserState({required this.error});
}

class AddUserState extends UserState {
  final String note;
  final bool isAdded;
  AddUserState({required this.note, required this.isAdded});
}
