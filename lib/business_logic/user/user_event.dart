part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {}

class LoadingUsersEvent extends UserEvent {
  final int tripIndex;
  LoadingUsersEvent({required this.tripIndex});
  @override
  List<Object?> get props => [tripIndex];
}

class AddingUserEvent extends UserEvent {
  final int tripIndex;
  final String userName;
  AddingUserEvent({required this.tripIndex, required this.userName});
  @override
  List<Object?> get props => [userName, tripIndex];
}
