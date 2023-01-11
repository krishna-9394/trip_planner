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
