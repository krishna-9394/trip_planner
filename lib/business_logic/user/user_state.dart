// TODO start from here
part of 'user_bloc.dart';

abstract class UserState extends Equatable {}

class InitializingUsersState extends UserState {
  @override
  List<Object?> get props => [];
}

class LoadingUsersState extends UserState {
  @override
  List<Object?> get props => [];
}

class LoadedUsersState extends UserState {
  final List<User> users;
  final int size;
  LoadedUsersState({required this.size, required this.users});
  @override
  List<Object?> get props => [users];
}

class FailedToLoadUsersState extends UserState {
  final Error error;
  FailedToLoadUsersState({required this.error});
  @override
  List<Object?> get props => [error];
}

class AddedUsersState extends UserState {
  @override
  List<Object?> get props => [];
}

class FailedToAddUser extends UserState {
  final String error;
  FailedToAddUser({required this.error});
  @override
  List<Object?> get props => [error];
}
