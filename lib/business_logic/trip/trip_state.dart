part of 'trip_bloc.dart';

abstract class TripState extends Equatable {}

class InitializingTripsState extends TripState {
  @override
  List<Object?> get props => [];
}

class LoadingTripsState extends TripState {
  @override
  List<Object?> get props => [];
}

class LoadedTripState extends TripState {
  final List<Trip> trips;
  LoadedTripState({required this.trips});
  @override
  List<Object?> get props => [trips];
}

class FailedToLoadTripsState extends TripState {
  final Error error;
  FailedToLoadTripsState({required this.error});
  @override
  List<Object?> get props => [error];
}

class LoadingUsersState extends TripState {
  @override
  List<Object?> get props => [];
}

class LoadedUsersState extends TripState {
  final List<User> users;
  final int size;
  LoadedUsersState({required this.size,required this.users});
  @override
  List<Object?> get props => [users];
}

class FailedToLoadUsersState extends TripState {
  final Error error;
  FailedToLoadUsersState({required this.error});
  @override
  List<Object?> get props => [error];
}

class AddedTripsState extends TripState {
  AddedTripsState();
  @override
  List<Object?> get props => [];
}

class DeletedTripsState extends TripState {
  DeletedTripsState();

  @override
  List<Object?> get props => [];
}

class UpdatedTripsState extends TripState {
  UpdatedTripsState();
  @override
  List<Object?> get props => [];
}

class AddedUsersState extends TripState {
  @override
  List<Object?> get props => [];
}

class FailedToAddUser extends TripState {
  final String error;
  FailedToAddUser({required this.error});
  @override
  List<Object?> get props => [error];
}
